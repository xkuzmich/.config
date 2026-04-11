require("config.lazy")

vim.lsp.enable({'lua', 'clangd', 'ty', 'ruff', 'ansiblels', 'yamlls', 'terraformls', 'puppet'})
vim.lsp.config("lua", {
  settings = {
    Lua = {
      workspace = {
        library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" }
      },
    },
  },
})
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab= true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 2
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
  })

vim.keymap.set({"n", "i", "v"}, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Run current Python file in a terminal split
vim.keymap.set("n", "<leader>rp", function()
  vim.cmd("split | terminal python3 " .. vim.fn.expand("%"))
end, { desc = "Run Python file" })

-- Run pytest on current file
vim.keymap.set("n", "<leader>rt", function()
  vim.cmd("split | terminal pytest " .. vim.fn.expand("%") .. " -v")
end, { desc = "Run pytest" })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ name = "ruff" })
  end,
})
