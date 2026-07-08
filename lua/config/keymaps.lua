-- Keymaps globaux (les keymaps de plugins vivent dans leurs specs,
-- les keymaps LSP/gitsigns sont buffer-local via leurs attach)

local map = vim.keymap.set

----------------------------------------------------------------------
-- Navigation entre splits --
----------------------------------------------------------------------
map("n", "<C-h>", "<C-w>h", { desc = "Focus split gauche" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus split bas" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus split haut" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus split droite" })

-- Depuis un terminal intégré (sidekick, :term) : sortir + naviguer
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Focus split gauche (terminal)" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Focus split bas (terminal)" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Focus split haut (terminal)" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Focus split droite (terminal)" })

----------------------------------------------------------------------
-- Recherche --
----------------------------------------------------------------------
-- Esc efface le surlignage de recherche (et garde son rôle normal)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Effacer le highlight de recherche" })

-- n/N centrent le résultat à l'écran
map("n", "n", "nzzzv", { desc = "Résultat suivant (centré)" })
map("n", "N", "Nzzzv", { desc = "Résultat précédent (centré)" })

----------------------------------------------------------------------
-- Édition --
----------------------------------------------------------------------
-- Déplacer la sélection visuelle (avec ré-indentation)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Descendre la sélection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Monter la sélection" })

-- Indenter en visuel sans perdre la sélection
map("v", "<", "<gv", { desc = "Désindenter (garde la sélection)" })
map("v", ">", ">gv", { desc = "Indenter (garde la sélection)" })

-- Coller sur une sélection sans écraser le registre
map("x", "p", "P", { desc = "Coller sans écraser le registre" })

----------------------------------------------------------------------
-- Scroll --
----------------------------------------------------------------------
-- Demi-page avec curseur centré
map("n", "<C-d>", "<C-d>zz", { desc = "Demi-page bas (centré)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Demi-page haut (centré)" })

----------------------------------------------------------------------
-- Outils IA --
----------------------------------------------------------------------
map("n", "<leader>aT", function()
    require("config.ai").toggle()
end, { desc = "Toggle AI tools" })
