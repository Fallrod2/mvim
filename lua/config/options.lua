local opt = vim.opt

----------------------------------------------------------------------
-- affichage --
----------------------------------------------------------------------
opt.number = true               -- set the number of the line
opt.relativenumber = true       -- set the distance from the line
opt.termguicolors = true        -- set the colors to 24 bits
opt.signcolumn = "yes"          -- ??
opt.cursorline = true           -- set the current line in highlight
opt.cursorlineopt = "both"      -- (make sure the num + line is highlight)
opt.scrolloff = 10              -- let the number of line on top and botom during scroll
opt.sidescrolloff = 10          -- same horizontal
opt.winborder = "rounded"       


----------------------------------------------------------------------
-- indentation --
----------------------------------------------------------------------
opt.tabstop = 4                 -- set the "space" number
opt.shiftwidth = 4              -- set the size of "space"
opt.expandtab = true            -- ??
opt.smartindent = true          -- fallback indent


----------------------------------------------------------------------
-- recherche -- 
----------------------------------------------------------------------
opt.ignorecase = true           -- make the search not casesensitive
opt.smartcase = true            -- make the search not casesensitive
opt.incsearch = true         -- show the preview of the search
opt.inccommand = "split"        -- show the preview of the command


----------------------------------------------------------------------
-- comportement --
----------------------------------------------------------------------
opt.undofile = true             -- let the user undo after closing file
opt.swapfile = false            -- disable swapfiles
opt.clipboard = "unnamedplus"   -- combine clipboards
opt.splitright = true           -- let split to right
opt.splitbelow = true           -- let split to bottom
opt.mouse = "a"                 -- let the user uses his mouse
opt.updatetime = 250            -- ???
opt.timeoutlen = 300            -- ???
opt.confirm = true              -- ask before quit
opt.autoread = true             -- update le file auto
opt.virtualedit = "block"
opt.completeopt = { "menu", "menuone", "noselect" }


----------------------------------------------------------------------
-- Caractères invisibles (optionnel mais recommandé)
----------------------------------------------------------------------
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- rend visibles tabs, espaces de fin, nbsp


----------------------------------------------------------------------
-- Divers
----------------------------------------------------------------------
opt.shortmess:append("I")  -- supprime l'écran d'intro
opt.pumheight = 10         -- hauteur max du menu de complétion
opt.foldmethod = "expr"    -- folding basé sur une expression...
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- ...fournie par treesitter
opt.foldlevelstart = 99    -- tout déplié à l'ouverture


----------------------------------------------------------------------
-- treesitter
----------------------------------------------------------------------
vim.opt.foldlevel = 99      -- tout déplié à l'ouverture d'un fichier
vim.opt.foldlevelstart = 99
vim.opt.foldtext = ""       -- affiche la première ligne du pli telle quelle (avec sa coloration)
