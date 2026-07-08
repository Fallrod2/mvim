-- Politique d'activation des outils IA
local M = {}

-- Dossiers où l'IA est TOUJOURS coupée (adapte à ton arborescence)
local blocked_paths = {
    "/epita/",
    "/EPITA/",
}

-- L'IA est-elle autorisée dans le contexte actuel ?
function M.allowed()
    local cwd = vim.fn.getcwd()

    -- 1. Fichier marqueur .noai à la racine du projet ?
    if vim.uv.fs_stat(cwd .. "/.noai") then
        return false
    end

    -- 2. Chemin blacklisté ?
    for _, path in ipairs(blocked_paths) do
        if cwd:find(path, 1, true) then
            return false
        end
    end

    return true
end

-- État courant de la session (initialisé selon le contexte)
vim.g.ai_enabled = M.allowed()

-- Wrapper : n'exécute une action IA que si autorisé
function M.guard(fn)
    return function()
        if not vim.g.ai_enabled then
            vim.notify(
                "Outils IA désactivés (mode EPITA)",
                vim.log.levels.WARN
            )
            return
        end
        fn()
    end
end

-- Toggle manuel
function M.toggle()
    -- Refus de réactiver dans un contexte bloqué
    if not vim.g.ai_enabled and not M.allowed() then
        vim.notify(
            "IA bloquée dans ce projet (.noai ou dossier EPITA)",
            vim.log.levels.ERROR
        )
        return
    end
    vim.g.ai_enabled = not vim.g.ai_enabled
    if not vim.g.ai_enabled then
        -- Ferme les sessions sidekick ouvertes
        pcall(function()
            require("sidekick.cli").hide()
        end)
    end
    vim.notify(
        "Outils IA : "
            .. (vim.g.ai_enabled and "activés ✓" or "désactivés ✗")
    )
end

return M
