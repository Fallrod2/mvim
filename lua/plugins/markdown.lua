return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        -- Rendu en normal/cmdline/terminal mais PAS en insert :
        -- dès que tu tapes, tu récupères le markdown brut.
        render_modes = { "n", "c", "t" },
        anti_conceal = { enabled = true }, -- ligne du curseur toujours brute
        heading = { width = "block", right_pad = 2 },
        code = {
            style = "full",
            border = "thin",
            width = "block",
            left_pad = 2,
        },
        bullet = { icons = { "●", "○", "◆", "◇" } },
        checkbox = {
            unchecked = { icon = "󰄱 " },
            checked = { icon = "󰱒 " },
        },
    },
}
