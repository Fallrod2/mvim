-- after/ftplugin/markdown.lua
-- Confort de lecture : scratchpads, specs, README

local opt = vim.opt_local

opt.wrap = true
opt.linebreak = true -- coupe aux espaces, plus en plein milieu des mots
opt.breakindent = true -- la continuation garde l'indent de la puce
opt.breakindentopt = "shift:2" -- +2 col : on la distingue d'une vraie ligne
opt.showbreak = "↳ "
opt.list = false -- pas de « · » de trailing space dans de la prose
opt.textwidth = 0 -- pas de hard-wrap auto : 1 puce = 1 ligne
opt.conceallevel = 2 -- requis par render-markdown
opt.concealcursor = "" -- markdown brut sur la ligne du curseur
-- opt.spell = true -- à activer si tu veux, mais tes scratchpads sont
-- opt.spelllang = { "fr", "en" } -- pleins d'identifiants → très bruyant

-- Déplacement par ligne VISUELLE (sinon j saute par-dessus tout le wrap)
local function map(lhs, rhs)
    vim.keymap.set(
        { "n", "x" },
        lhs,
        rhs,
        { expr = true, buffer = true, silent = true }
    )
end
map("j", "v:count == 0 ? 'gj' : 'j'")
map("k", "v:count == 0 ? 'gk' : 'k'")
map("0", "g0")
map("$", "g$")
