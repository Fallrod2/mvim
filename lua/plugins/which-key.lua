return {
    "folke/which-key.nvim",
    event = "VeryLazy", -- charge après le démarrage (aucun impact startup)
    opts = {
        -- délai avant l'apparition du popup (ms)
        delay = 400,
        spec = {
            { "<leader>s", group = "search" },
            { "<leader>h", group = "git hunks" },
            { "<leader>a", group = "ai" },
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
