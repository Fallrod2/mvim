return {
    "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "lua_ls",        -- Lua (ta config)
          "rust_analyzer", -- Rust
          "basedpyright",  -- Python
        },
        automatic_enable = true,
      },
    },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    -- Keymaps LSP : buffer-local, créés quand un serveur s'attache
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("gr", vim.lsp.buf.references, "Goto references")
        map("gI", vim.lsp.buf.implementation, "Goto implementation")
        map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("K", vim.lsp.buf.hover, "Hover documentation")
      end,
    })

    vim.diagnostic.config({
      severity_sort = true,
      virtual_text = true,
      float = { border = "rounded" },
    })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
        },
      },
    })
  end,
}
