# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using lazy.nvim as the plugin manager and the modern Neovim 0.10+ LSP API (`vim.lsp.enable()` / `vim.lsp.config()`).

## Architecture

### Entry Point
- `init.lua` - Loads lazy.nvim, enables LSP servers, sets editor options, and defines keymaps

### Plugin Management
- `lua/config/lazy.lua` - Bootstrap and setup for lazy.nvim
- `lua/config/plugins/` - Individual plugin configurations (one file per plugin)
- `lazy-lock.json` - Version lock file

### LSP Configuration
- `lsp/` - Individual LSP server configs (lua, clangd, go, ruff, ty, ansiblels, yamlls)
- Each file returns a `vim.lsp.Config` table with cmd, filetypes, root_markers, settings
- Servers are enabled in `init.lua` via `vim.lsp.enable({'lua', 'clangd', ...})`

### Custom Modules
- `lua/config/telescope/multigrep.lua` - Custom async grep picker with pattern + glob filtering

### Filetype Overrides
- `after/ftplugin/` - Language-specific settings (e.g., Lua uses 2-space indent)

## Key Patterns

- Leader key is Space, local leader is Backslash
- Uses `vim.uv` (built-in libuv) instead of `vim.loop`
- Type annotations via `---@type`, `---@param` comments
- Plugin specs use lazy-loading by filetype/event

## Keymaps

| Keymap | Mode | Action |
|--------|------|--------|
| `<space><space>x` | n | Source current file |
| `<space>x` | n/v | Execute Lua (current line or selection) |
| `<space>fd` | n | Telescope find files |
| `<space>fh` | n | Telescope help tags |
| `<space>en` | n | Find files in nvim config |
| `<leader>fg` | n | Multi-grep (pattern + glob with `  ` separator) |

## Multi-Grep Usage

The custom multi-grep picker (`<leader>fg`) supports filtering by both search pattern and glob:
- Type a search pattern
- Add two spaces (`  `) then a glob pattern to filter files
- Example: `function  *.lua` searches for "function" only in Lua files

## Clangd Commands

For C/C++ files with clangd attached:
- `:LspClangdSwitchSourceHeader` - Toggle between .c/.cpp and .h files
- `:LspClangdShowSymbolInfo` - Display symbol info in floating window
