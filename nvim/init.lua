require("config.lazy")

vim.lsp.enable({'lua', 'clangd', 'ty', 'ruff', 'ansiblels', 'yamlls', 'terraformls', 'puppet', 'helm_ls'})

-- Detect Helm templates as filetype "helm"
vim.filetype.add({
  pattern = {
    ['.*/templates/.*%.yaml'] = 'helm',
    ['.*/templates/.*%.yml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
    ['helmfile.*%.yaml'] = 'helm',
    ['helmfile.*%.yml'] = 'helm',
  },
})
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
vim.opt.showtabline = 2

function _G.custom_tabline()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local cwd = vim.fn.getcwd(winnr, i)
    local project = vim.fn.fnamemodify(cwd, ":t")
    local bufnr = vim.fn.tabpagebuflist(i)[winnr]
    local fname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":t")
    if fname == "" then fname = "[No Name]" end

    if i == vim.fn.tabpagenr() then
      s = s .. "%#TabLineSel#"
    else
      s = s .. "%#TabLine#"
    end
    s = s .. " " .. i .. ": " .. project .. " | " .. fname .. " "
  end
  s = s .. "%#TabLineFill#"
  return s
end
vim.o.tabline = "%!v:lua.custom_tabline()"
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "File explorer (Oil)" })

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

-- Auto-detect Python venv from cwd
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local venv = vim.fn.getcwd() .. "/.venv"
    if vim.fn.isdirectory(venv) == 1 then
      vim.env.VIRTUAL_ENV = venv
      vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
    end
  end,
})
-- Also check on startup
local venv = vim.fn.getcwd() .. "/.venv"
if vim.fn.isdirectory(venv) == 1 then
  vim.env.VIRTUAL_ENV = venv
  vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    vim.lsp.buf.format({ name = "ruff" })
  end,
})
