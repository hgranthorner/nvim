require("neodev").setup({})
local lspconfig = require('lspconfig')

local servers = {
  lua_ls = {},
  rust_analyzer = {},
  zls = {},
  gopls = {},
  hls = {},
  ocamllsp = {},
  asm_lsp = {},
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for lsp, setup_config in pairs(servers) do
  setup_config.capabilities = capabilities
  lspconfig[lsp].setup(setup_config)
end

local kt = require('hgh.keys')
kt.nkey('<leader>cf', vim.lsp.buf.format)
kt.nkey('<leader>ca', vim.lsp.buf.code_action)
kt.nkey('<leader>cr', vim.lsp.buf.rename)
kt.nkey('<leader>gd', vim.lsp.buf.definition)
kt.nkey('<leader>gr', vim.lsp.buf.references)
