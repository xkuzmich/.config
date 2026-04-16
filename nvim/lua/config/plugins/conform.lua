return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "ruff_format", "ruff_organize_imports" },
                go = { "goimports", "gofumpt" },
                terraform = { "terraform_fmt" },
                yaml = { "prettier" },
                json = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_format = "fallback",
            },
        })
    end,
}
