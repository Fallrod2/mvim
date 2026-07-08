local opt = vim.opt

----------------------------------------------------------------------
-- affichage --
----------------------------------------------------------------------
opt.number = true -- set the number of the line
opt.relativenumber = true -- set the distance from the line
opt.termguicolors = true -- set the colors to 24 bits
opt.signcolumn = "yes" -- réserve en permanence la colonne à gauche des numéros où s'affichent les signes (diagnostics LSP ●, marques gitsigns +/~).
opt.cursorline = true -- set the current line in highlight
opt.cursorlineopt = "both" -- (make sure the num + line is highlight)
opt.scrolloff = 10 -- let the number of line on top and botom during scroll
opt.sidescrolloff = 10 -- same horizontal
opt.winborder = "rounded"

----------------------------------------------------------------------
-- indentation --
----------------------------------------------------------------------
opt.tabstop = 4 -- set the "space" number
opt.shiftwidth = 4 -- set the size of "space"
opt.expandtab = true -- quand tu appuies sur Tab, insère des espaces au lieu d'un caractère tabulation.
opt.smartindent = true -- fallback indent

----------------------------------------------------------------------
-- recherche --
----------------------------------------------------------------------
opt.ignorecase = true -- make the search not casesensitive
opt.smartcase = true -- make the search not casesensitive
opt.incsearch = true -- show the preview of the search
opt.inccommand = "split" -- show the preview of the command

----------------------------------------------------------------------
-- comportement --
----------------------------------------------------------------------
opt.undofile = true -- let the user undo after closing file
opt.swapfile = false -- disable swapfiles
opt.clipboard = "unnamedplus" -- combine clipboards
opt.splitright = true -- let split to right
opt.splitbelow = true -- let split to bottom
opt.mouse = "a" -- let the user uses his mouse
opt.updatetime = 250 -- délai d'inactivité (ms) avant que nvim déclenche l'événement
opt.timeoutlen = 300 -- temps d'attente maximum entre deux touches d'une séquence
opt.confirm = true -- ask before quit
opt.autoread = true -- update le file auto
opt.virtualedit = "block"
opt.completeopt = { "menu", "menuone", "noselect" }

----------------------------------------------------------------------
-- Caractères invisibles (optionnel mais recommandé)
----------------------------------------------------------------------
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- rend visibles tabs, espaces de fin, nbsp

----------------------------------------------------------------------
-- Divers --
----------------------------------------------------------------------
opt.shortmess:append("I") -- supprime l'écran d'intro
opt.pumheight = 10 -- hauteur max du menu de complétion

----------------------------------------------------------------------
-- Folding (alimenté par treesitter) --
----------------------------------------------------------------------
opt.foldmethod = "expr" -- folding basé sur une expression...
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- ...fournie par treesitter
opt.foldlevel = 99 -- tout déplié à l'ouverture
opt.foldlevelstart = 99
opt.foldtext = "" -- première ligne du pli affichée telle quelle
