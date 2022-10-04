-- Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "nvim-lua/plenary.nvim"
  use "nvim-telescope/telescope.nvim"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use "vim-scripts/CycleColor"
  use "EdenEast/nightfox.nvim"
  use "nvim-treesitter/nvim-treesitter"

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }

  use "TimUntersberger/neogit"
end)

vim.cmd("colorscheme nordfox")

-- Clipboard
vim.opt.clipboard = unnamedplus

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab goodness
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.expandtab   = true -- use spaces instead of tabs.
vim.opt.smarttab    = true -- let's tab key insert 'tab stops', and bksp deletes tabs.
vim.opt.shiftround  = true -- tab / shifting moves to closest tabstop.
vim.opt.autoindent  = true -- Match indents on new lines.
vim.opt.smartindent = true -- Intelligently dedent / indent new lines based on rules.

-- Make search more sane
vim.opt.ignorecase  = true -- case insensitive search
vim.opt.smartcase   = true -- If there are uppercase letters, become case-sensitive.
vim.opt.incsearch   = true -- live incremental searching
vim.opt.showmatch   = true -- live match highlighting
vim.opt.hlsearch    = false -- highlight matches

-- Let splitting make more sense
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local key = vim.keymap.set

-- Windows
key('n', '<leader>ws', '<C-w>s')
key('n', '<leader>wv', '<C-w>v')
key('n', '<leader>wh', '<C-w>h')
key('n', '<leader>wj', '<C-w>j')
key('n', '<leader>wk', '<C-w>k')
key('n', '<leader>wl', '<C-w>l')
key('n', '<leader>wd', ':close<CR>')

-- Config management
key('n', '<leader>rr', ':source $MYVIMRC<CR>', {desc = 'Refresh config'})
key('n', '<leader>re', ':edit $MYVIMRC<CR>')

-- Files
local tele = require('telescope.builtin')
key('n', '<leader>fs', ':w<CR>')
key('n', '<leader>ff', tele.find_files)
key('n', '<leader><space>', tele.find_files)
key('n', '<leader>fp', tele.git_files)
key('n', '<leader>fg', tele.live_grep)
key('n', '<leader>q', ':q<CR>')

-- Buffers
key('n', '<leader>bb', tele.buffers)
key('n', '<leader>bn', ':bn<CR>')
key('n', '<leader>bp', ':bp<CR>')

-- Packer
key('n', '<leader>Ps', ':PackerSync<CR>')
key('n', '<leader>Pc', ':PackerCompile<CR>')

-- Neotree
key('n', '<leader>nt', ':Neotree<CR>')

-- Lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>cr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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
  cmd = {"elixir-ls"}
}

-- Autocomplete
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      -- setting up snippet engine
      -- this is for vsnip, if you're using other
      -- snippet engine, please refer to the `nvim-cmp` guide
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    { name = 'buffer' }
  })
})

-- Treesitter highlighting
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"elixir", "heex", "eex"}, -- only install parsers for elixir and heex
  -- ensure_installed = "all", -- install parsers for all supported languages
  sync_install = false,
  ignore_install = { },
  highlight = {
    enable = true,
    disable = { },
  },
}

-- Neogit
local neogit = require('neogit')
neogit.setup {}
key('n', '<leader>gg', ':Neogit<CR>')
