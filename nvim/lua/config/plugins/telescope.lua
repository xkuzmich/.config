return {
  'nvim-telescope/telescope.nvim', tag = 'v0.2.2',
  dependencies = { 'nvim-lua/plenary.nvim',
	{ 'nvim-telescope/telescope-fzf-native.nvim', build='make' }
},
  config = function()
    require('telescope').setup {
      pickers = {
	find_files = {
	  theme = "ivy"
	}
      },
      extensions = {
	fzf = {},
	project = {
	  base_dirs = {
	    { "~/Projects", max_depth = 2 },
	    { "~/.config", max_depth = 1 },
	  },
	  on_project_selected = function(prompt_bufnr)
	    local actions = require("telescope.actions")
	    local state = require("telescope.actions.state")
	    local selected = state.get_selected_entry(prompt_bufnr)
	    actions.close(prompt_bufnr)
	    local project_path = selected.value
	    vim.cmd("tabnew")
	    vim.cmd("tcd " .. vim.fn.fnameescape(project_path))
	    require("oil").open(vim.fn.getcwd())
	  end,
	},
      }
    }

    require('telescope').load_extension('fzf')
    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
    vim.keymap.set("n", "<space>en", function()
    require('telescope.builtin').find_files {
      cwd = vim.fn.stdpath('config')
    }
    end)

    vim.keymap.set("n", "<space>fb", require('telescope.builtin').buffers)
    vim.keymap.set("n", "<space>fo", require('telescope.builtin').oldfiles)

    require "config.telescope.multigrep".setup()
  end
}

