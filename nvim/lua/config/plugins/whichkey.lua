return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({
            delay = 300,
        })
        wk.add({
            { "<leader>d", group = "diagnostics/debug" },
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>h", group = "git hunks" },
            { "<leader>r", group = "run/rename" },
            { "<leader>c", group = "code" },
            { "<leader>x", group = "trouble" },
        })
    end,
}
