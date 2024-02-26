require("neodev").setup({})
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local servers = {
  lua_ls = {},
  rust_analyzer = {},
  zls = {},
  gopls = {},
  hls = {},
  ocamllsp = {},
  asm_lsp = {},
  elixirls = { cmd = { "elixir-ls" } },
  tailwindcss = {
    root_dir = util.root_pattern(
      'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts',
      'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts', 'package.json',
      'node_modules', '.git', 'mix.exs')
  },
}

local on_attach = function(_, _)
  local kt = require('hgh.keys')
  kt.nkey('<leader>cf', vim.lsp.buf.format)
  kt.nkey('<leader>ca', vim.lsp.buf.code_action)
  kt.nkey('<leader>cr', vim.lsp.buf.rename)
  kt.nkey('gd', vim.lsp.buf.definition)
  kt.nkey('gr', vim.lsp.buf.references)
  kt.nkey('K', vim.lsp.buf.hover)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for lsp, setup_config in pairs(servers) do
  setup_config.capabilities = capabilities
  setup_config.on_attach = on_attach
  lspconfig[lsp].setup(setup_config)
end
