return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
    },
    keys = {
        {
            "<C-h>",
            "<cmd>TmuxNavigateLeft<cr>",
            desc = "Focus gauche (nvim/tmux)",
        },
        {
            "<C-j>",
            "<cmd>TmuxNavigateDown<cr>",
            desc = "Focus bas (nvim/tmux)",
        },
        {
            "<C-k>",
            "<cmd>TmuxNavigateUp<cr>",
            desc = "Focus haut (nvim/tmux)",
        },
        {
            "<C-l>",
            "<cmd>TmuxNavigateRight<cr>",
            desc = "Focus droite (nvim/tmux)",
        },
    },
}
