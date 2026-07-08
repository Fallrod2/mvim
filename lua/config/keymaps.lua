-- Toggle des outils IA
vim.keymap.set("n", "<leader>aT", function()
  require("config.ai").toggle()
end, { desc = "Toggle AI tools" })
