require("neodev").setup({})
local lspconfig = require('lspconfig')

local servers = {
  lua_ls = {},
  rust_analyzer = {}
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for lsp, setup_config in pairs(servers) do
  setup_config.capabilities = capabilities
  lspconfig[lsp].setup(setup_config)
end
