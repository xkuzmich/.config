return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        { "<leader>gvo", "<cmd>DiffviewOpen<cr>", desc = "Git diff open" },
        { "<leader>gvh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
        { "<leader>gvq", "<cmd>DiffviewClose<cr>", desc = "Close diff" },
    },
    config = function()
        require("diffview").setup()
    end,
}
