-- lua/config/lazy.lua

-- Bootstrap : clone lazy.nvim s'il n'est pas déjà installé
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup : lazy scanne lua/plugins/ pour trouver les specs
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    -- Thème utilisé pendant l'installation des plugins au premier démarrage
    install = { colorscheme = { "kanagawa" } },
    -- Vérification des mises à jour en arrière-plan, sans popup
    checker = { enabled = true, notify = false },
})
