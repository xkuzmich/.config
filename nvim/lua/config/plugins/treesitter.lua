return { 
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require'nvim-treesitter'.install {
	'c', 'lua', 'vim', 'python', 'vimdoc', 'query', 'markdown', 'markdown_inline',
	'go', 'gomod', 'gosum', 'gowork', 'gotmpl', 'json', 'yaml', 'html', 'comment',
      }
    end,
  } 
}
