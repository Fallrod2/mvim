return {
    "folke/sidekick.nvim",
    -- Gate au démarrage : le plugin n'existe même pas en contexte bloqué
    enabled = function()
        return require("config.ai").allowed()
    end,
    opts = {
        nes = { enabled = false },
        cli = {
            watch = true,
            tools = {
                claude = {},
                codex = {},
            },
        },
    },
    keys = {
        {
            "<leader>ac",
            function()
                require("config.ai").guard(function()
                    require("sidekick.cli").toggle({ name = "claude", focus = true })
                end)()
            end,
            mode = { "n", "v" },
            desc = "Sidekick: Claude",
        },
        {
            "<leader>ax",
            function()
                require("config.ai").guard(function()
                    require("sidekick.cli").toggle({ name = "codex", focus = true })
                end)()
            end,
            mode = { "n", "v" },
            desc = "Sidekick: Codex",
        },
        {
            "<leader>ap",
            function()
                require("config.ai").guard(function()
                    require("sidekick.cli").prompt()
                end)()
            end,
            mode = { "n", "v" },
            desc = "Sidekick: prompt library",
        },
    },
}
