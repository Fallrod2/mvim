return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- chargé au démarrage : nécessaire pour intercepter "mvim ."
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" },
    },
    opts = {
        -- Décommente si tu veux que les COULEURS git se rafraîchissent aussi
        -- quand un agent commit hors de nvim. Attention : scan git synchrone.
        -- git_status_async = false,
        filesystem = {
            -- ★ LA ligne qui manquait. Watchers OS-level (libuv fs_event) sur
            -- les dossiers actuellement ouverts dans l'arbre. Détecte
            -- create/delete/rename faits HORS de nvim (agents, git checkout,
            -- terminal). Sans ça, neo-tree ne réagit qu'à TES BufWritePost.
            use_libuv_file_watcher = true,

            hijack_netrw_behavior = "open_default",
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = true,
            },
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true, -- évite que l'arbre se replie sans arrêt
            },
        },
        window = {
            width = 34,
        },
    },
}
