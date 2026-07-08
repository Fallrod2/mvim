return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- Parsers de base : installés au premier lancement
    ts.install({
      "lua", "vim", "vimdoc", "query",
      "rust", "python", "c", "c_sharp", "javascript", "ocaml",
      "markdown", "markdown_inline",
      "bash", "json", "toml", "yaml",
      "gitcommit", "diff",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter-setup", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        local function enable()
          if not pcall(vim.treesitter.start, buf, lang) then
            return
          end
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end

        if vim.treesitter.language.add(lang) then
          enable()
          return
        end

        if vim.tbl_contains(ts.get_available(), lang) then
          ts.install({ lang }):await(function()
            if vim.api.nvim_buf_is_valid(buf) then
              enable()
            end
          end)
        end
      end,
    })
  end,
}
