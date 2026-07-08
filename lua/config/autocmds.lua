-- autocmds.lua

-- Recharge automatiquement les fichiers modifiés hors de nvim
-- (agents IA, git checkout, scripts...)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("autoread-checktime", { clear = true }),
    callback = function()
        -- checktime compare le fichier sur disque avec le buffer
        if vim.fn.getcmdwintype() == "" then -- pas dans la fenêtre de cmdline
            vim.cmd("checktime")
        end
    end,
})

-- Notification quand un fichier a été rechargé
vim.api.nvim_create_autocmd("FileChangedShellPost", {
    group = vim.api.nvim_create_augroup("autoread-notify", { clear = true }),
    callback = function()
        vim.notify("Fichier modifié sur le disque, buffer rechargé", vim.log.levels.INFO)
    end,
})


-- Autosave : sauvegarde quand tu quittes un buffer ou que nvim perd le focus
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    group = vim.api.nvim_create_augroup("autosave", { clear = true }),
    callback = function(args)
        local buf = args.buf
        -- Seulement les vrais fichiers, modifiés, avec un nom
        if vim.bo[buf].modified
            and vim.bo[buf].buftype == ""
            and vim.fn.filereadable(vim.api.nvim_buf_get_name(buf)) == 1 then
            vim.api.nvim_buf_call(buf, function()
                vim.cmd("silent! write")
            end)
        end
    end,
})


-- Flash visuel sur le texte copié
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
