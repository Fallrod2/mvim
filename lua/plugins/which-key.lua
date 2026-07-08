return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- charge après le démarrage (aucun impact startup)
  opts = {
    -- délai avant l'apparition du popup (ms)
    delay = 400,
    spec = {
      -- Nomme tes groupes de préfixes : purement cosmétique,
      -- ça affiche "+search" au lieu d'une liste anonyme
      { "<leader>s", group = "search" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Keymaps du buffer courant",
    },
  },
}
