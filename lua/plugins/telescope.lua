return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x", -- branche stable
  dependencies = {
    "nvim-lua/plenary.nvim", -- lib de fonctions utilitaires, requise par telescope
    {
      -- Trieur natif en C : rend le fuzzy matching beaucoup plus rapide
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- compile à l'installation
    },
  },
  keys = {
    -- <leader>s comme "search"
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>",  desc = "Search by grep" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search word under cursor" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",  desc = "Search help" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",    desc = "Search keymaps" },
    { "<leader>sr", "<cmd>Telescope resume<cr>",     desc = "Resume last search" },
    { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Open buffers" },
  },
  config = function()
    require("telescope").setup({
      -- les défauts sont très bien pour commencer
    })
    -- Active le trieur fzf compilé (doit venir APRÈS le setup)
    pcall(require("telescope").load_extension, "fzf")
  end,
}
