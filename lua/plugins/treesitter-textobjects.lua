return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main", -- même rewrite que treesitter : on reste cohérent
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true, -- ex: "daf" plus loin dans le fichier saute à la prochaine fonction
      },
    })

    local select = require("nvim-treesitter-textobjects.select").select_textobject
    local map = function(keys, capture, desc)
      vim.keymap.set({ "x", "o" }, keys, function()
        select(capture, "textobjects")
      end, { desc = desc })
    end

    map("af", "@function.outer", "around function")
    map("if", "@function.inner", "inner function")
    map("ac", "@class.outer", "around class")
    map("ic", "@class.inner", "inner class")
    map("aa", "@parameter.outer", "around argument")
    map("ia", "@parameter.inner", "inner argument")

    -- Navigation : sauter de fonction en fonction
    local move = require("nvim-treesitter-textobjects.move")
    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      move.goto_next_start("@function.outer", "textobjects")
    end, { desc = "Next function" })
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      move.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Previous function" })
  end,
}
