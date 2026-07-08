-- init.lua

-- Leaders : à définir AVANT tout le reste (plugins et keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.lazy")
