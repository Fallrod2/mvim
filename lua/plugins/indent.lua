return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- le module Lua s'appelle "ibl", pas "indent-blankline"
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        indent = { char = "▏" }, -- trait fin, discret
        scope = { enabled = true }, -- surligne le scope courant (utilise treesitter !)
    },
}
