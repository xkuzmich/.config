return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "leoluz/nvim-dap-go",
        },
        ft = { "go" },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("dap-go").setup()
            require("nvim-dap-virtual-text").setup()
            dapui.setup()

            -- Auto open/close UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Keymaps
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Conditional breakpoint" })
            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug continue" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug step over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug step into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug step out" })
            vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug REPL" })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug terminate" })
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle debug UI" })
        end,
    },
}
