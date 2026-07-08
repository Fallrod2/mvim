return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false, -- chargé au démarrage : nécessaire pour intercepter "mvim ."
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
  },
  opts = {
    filesystem = {
      -- Comment neo-tree réagit quand un buffer "dossier" s'ouvre :
      -- "open_default" = s'ouvre dans la sidebar (comportement IDE)
      -- "open_current" = s'ouvre dans la fenêtre courante (comme netrw)
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      follow_current_file = {
        enabled = true,
      },
    },
    window = {
      width = 34,
    },
  },
}
