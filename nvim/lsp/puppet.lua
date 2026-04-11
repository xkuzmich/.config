---@type vim.lsp.Config
return {
  cmd = { 'puppet-languageserver', '--stdio' },
  filetypes = { 'puppet' },
  root_markers = { 'manifests', '.puppet-lint.rc', 'Puppetfile', '.git' },
}
