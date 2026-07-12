-- autocmds.lua

----------------------------------------------------------------------
-- Rechargement des fichiers modifiés hors de nvim (agents, git, scripts)
----------------------------------------------------------------------
local reload = vim.api.nvim_create_augroup("live-reload", { clear = true })

local function safe_checktime()
    -- jamais pendant une saisie de cmdline ni en insert : reload brutal
    if vim.fn.getcmdwintype() ~= "" or vim.fn.mode() ~= "n" then
        return
    end
    vim.cmd("silent! checktime")
end

-- 1) Checks "gratuits", déclenchés par des événements
vim.api.nvim_create_autocmd(
    { "FocusGained", "BufEnter", "CursorHold", "TermLeave" },
    { group = reload, callback = safe_checktime }
)

-- 2) ★ Le vrai "instant". CursorHold ne tire QU'UNE FOIS après updatetime,
--    puis plus jamais tant que le curseur ne bouge pas : si tu lis sans
--    toucher au clavier, rien ne se recharge. Ce timer libuv poll toutes
--    les 400 ms, indépendamment du focus et de l'activité.
--    (Pourquoi un poll et pas un fs_event par fichier ? Parce que git
--    checkout, prettier, esbuild & co écrivent en atomic rename : le rename
--    détruit l'inode surveillé et le handle devient sourd. checktime
--    compare mtime+size SUR LE CHEMIN → immunisé.)
local timer = assert(vim.uv.new_timer())
timer:start(400, 400, vim.schedule_wrap(safe_checktime))
vim.api.nvim_create_autocmd("VimLeavePre", {
    group = reload,
    callback = function()
        if not timer:is_closing() then
            timer:stop()
            timer:close()
        end
    end,
})

-- 3) On mémorise le mtime disque connu de chaque buffer (sert au garde autosave)
vim.api.nvim_create_autocmd(
    { "BufReadPost", "BufWritePost", "FileChangedShellPost" },
    {
        group = reload,
        callback = function(args)
            local name = vim.api.nvim_buf_get_name(args.buf)
            if name ~= "" then
                vim.b[args.buf].disk_mtime = vim.fn.getftime(name)
            end
        end,
    }
)

-- 4) Feedback quand un buffer est rechargé
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = reload,
    callback = function(args)
        vim.notify(
            "↻ " .. vim.fn.fnamemodify(args.file, ":.") .. " rechargé",
            vim.log.levels.INFO
        )
    end,
})

----------------------------------------------------------------------
-- Autosave — AVEC garde anti-écrasement
----------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    group = vim.api.nvim_create_augroup("autosave", { clear = true }),
    callback = function(args)
        local buf = args.buf
        local name = vim.api.nvim_buf_get_name(buf)

        if
            not vim.bo[buf].modified
            or vim.bo[buf].buftype ~= ""
            or vim.fn.filereadable(name) ~= 1
        then
            return
        end

        -- ★ GARDE. Si le fichier a bougé sur le disque depuis notre dernière
        -- lecture, un `write` silencieux écraserait le travail de l'agent.
        -- C'est le seul cas que checktime ne peut PAS résoudre tout seul
        -- (buffer modifié ET fichier modifié) → on refuse et on te le dit.
        local known = vim.b[buf].disk_mtime
        if known and vim.fn.getftime(name) > known then
            vim.notify(
                "⚠ Autosave annulé : "
                    .. vim.fn.fnamemodify(name, ":.")
                    .. " a changé sur le disque. Arbitre à la main (:e! ou :w!).",
                vim.log.levels.WARN
            )
            return
        end

        vim.api.nvim_buf_call(buf, function()
            vim.cmd("silent! write")
        end)
    end,
})

-- Flash visuel sur le texte copié
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
