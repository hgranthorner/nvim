local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'rust_analyzer',
  'elixirls',
  'tsserver',
  'sumneko_lua',
  'eslint',
  'gopls',
  'clangd',
  'pyright'
})

local cmp = require'cmp'
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select)
})

lsp.set_preferences({
  sign_icons = {}
})


lsp.on_attach(function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { remap = false, silent=true, buffer=bufnr }
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
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format { async = true } end, bufopts)
end)

lsp.setup()
