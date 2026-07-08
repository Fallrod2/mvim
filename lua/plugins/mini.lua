return {
    {
        "nvim-mini/mini.pairs",
        event = "InsertEnter", -- ne sert qu'en insertion
        opts = {},
    },
    {
        "nvim-mini/mini.surround",
        event = "VeryLazy",
        opts = {}, -- keymaps par défaut : sa / sd / sr
    },
}
