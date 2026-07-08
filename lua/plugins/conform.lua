return {
  "stevearc/conform.nvim",
  event = "BufWritePre", -- charge au premier save (c'est là qu'il sert)
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      python = { "ruff_format" },
      -- pour les langages absents d'ici, lsp_format = "fallback"
      -- laisse le LSP formater s'il sait le faire
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
