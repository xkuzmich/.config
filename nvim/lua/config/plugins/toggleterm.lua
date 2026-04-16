return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal", mode = { "n", "t" } },
        { "<leader>rp", function()
            local file = vim.fn.expand("%")
            require("toggleterm.terminal").Terminal:new({
                cmd = "python3 " .. file,
                direction = "horizontal",
                close_on_exit = false,
            }):toggle()
        end, desc = "Run Python file" },
        { "<leader>rt", function()
            local file = vim.fn.expand("%")
            require("toggleterm.terminal").Terminal:new({
                cmd = "pytest " .. file .. " -v",
                direction = "horizontal",
                close_on_exit = false,
            }):toggle()
        end, desc = "Run pytest" },
    },
    config = function()
        require("toggleterm").setup({
            size = 15,
            direction = "horizontal",
            shade_terminals = true,
        })
    end,
}
