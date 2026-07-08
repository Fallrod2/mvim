return {
    "saghen/blink.cmp",
    -- blink télécharge un binaire Rust précompilé pour son fuzzy matching :
    -- on épingle une version pour que le binaire corresponde toujours au code
    version = "1.*",
    event = "InsertEnter", -- lazy-load : charge à la première insertion
    dependencies = {
        "rafamadriz/friendly-snippets", -- collection de snippets prêts (rust, python...)
    },
    opts = {
        keymap = {
            -- "default" : navigation <C-n>/<C-p>, accepter <C-y>, doc <C-space>
            -- Les alternatives : "super-tab" (Tab pour accepter) ou "enter" (Entrée)
            preset = "default",
        },
        completion = {
            documentation = {
                auto_show = true, -- la doc du symbole s'affiche à côté du menu
                auto_show_delay_ms = 200,
            },
        },
        sources = {
            -- lazydev en source prioritaire dans les fichiers lua :
            -- c'est lui qui connaît l'API nvim
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100, -- priorité au-dessus du LSP
                },
            },
        },
        -- Le fuzzy matcher Rust précompilé (rapide) avec fallback Lua si souci
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
}
