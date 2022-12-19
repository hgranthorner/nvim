-- local lsp = require('lsp-zero')
-- 
-- lsp.preset('recommended')
-- 
-- lsp.ensure_installed({
--   'rust_analyzer',
--   'elixirls',
--   'tsserver',
--   'sumneko_lua',
--   'eslint',
--   'gopls',
--   'clangd',
--   'pyright'
-- })
-- 
-- lsp.setup()

-- Lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>hk', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>c[', vim.diagnostic.setqflist, bufopts)
  vim.keymap.set('n', '<leader>ce', function() vim.diagnostic.open_float({scope="line"}) end, bufopts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp = require('lspconfig')
lsp['rust_analyzer'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['elixirls'].setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"language_server.sh"}
}
lsp['tsserver'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['gopls'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['clangd'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['svelte'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['csharp_ls'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['ruby_ls'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}
lsp['pyright'].setup{
  on_attach = on_attach,
  capabilities = capabilities
}

