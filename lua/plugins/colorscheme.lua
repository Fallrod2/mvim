return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      theme = "dragon", -- la variante sombre "noire"
      background = {
        dark = "dragon", -- thème utilisé quand background=dark (ton cas)
        light = "lotus",
      },
      transparent = false, -- true si tu veux le fond du terminal à la place
    })
    vim.cmd.colorscheme("kanagawa")
  end,
}
