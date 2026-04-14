return {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "stevearc/oil.nvim",
    },
    config = function()
        require("telescope").load_extension("project")
        vim.keymap.set("n", "<leader>fp", function()
            require("telescope").extensions.project.project({ display_type = "full" })
        end, { desc = "Projects" })
    end,
}
