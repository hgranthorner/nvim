-- Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[ packadd packer.nvim ]]
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
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use "vim-scripts/CycleColor"
  use "EdenEast/nightfox.nvim"
  use("nvim-treesitter/nvim-treesitter", { run = ':TSUpdate' })

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "mbbill/undotree"
  use "mattn/emmet-vim"

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }
end)

vim.cmd("colorscheme nordfox")
vim.opt.termguicolors = true

-- Keep cursor as a block
vim.opt.guicursor = ""

-- Clipboard
vim.opt.clipboard = unnamedplus

-- History
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab goodness
vim.opt.tabstop     = 2
vim.opt.shiftwidth  = 2
vim.opt.softtabstop = 2
vim.opt.expandtab   = true -- use spaces instead of tabs.
vim.opt.smarttab    = true -- let's tab key insert 'tab stops', and bksp deletes tabs.
vim.opt.shiftround  = true -- tab / shifting moves to closest tabstop.
vim.opt.autoindent  = true -- Match indents on new lines.
vim.opt.smartindent = true -- Intelligently dedent / indent new lines based on rules.

-- Make search more sane
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase  = true -- If there are uppercase letters, become case-sensitive.
vim.opt.incsearch  = true -- live incremental searching
vim.opt.showmatch  = true -- live match highlighting
vim.opt.hlsearch   = false -- highlight matches

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
key('n', '<leader>rr', ':source $MYVIMRC<CR>', { desc = 'Refresh config' })
key('n', '<leader>re', ':edit $MYVIMRC<CR>')

-- Files
local tele = require('telescope.builtin')
key('n', '<leader>fs', ':w<CR>')
key('n', '<leader>ff', tele.git_files)
key('n', '<leader><space>', tele.find_files)
key('n', '<leader>fp', tele.git_files)
key('n', '<leader>ss', tele.live_grep)
key('n', '<leader>si', tele.lsp_document_symbols)
key('n', '<leader>sw', tele.lsp_workspace_symbols)
key('n', '<leader>q', ':q<CR>')
key('n', 'gu', tele.lsp_references)
key('n', 'gs', tele.lsp_document_symbols)
key('n', '<leader>cp', tele.diagnostics)

-- Buffers
key('n', '<leader>bb', tele.buffers)
key('n', '<leader>bn', ':bn<CR>')
key('n', '<leader>bp', ':bp<CR>')
key('n', '<leader>bk', ':bd<CR>')
key('n', '<leader>bd', ':bd<CR>')

-- Packer
key('n', '<leader>Ps', ':PackerSync<CR>')
key('n', '<leader>Pc', ':PackerCompile<CR>')

-- Neotree
key('n', '<leader>nt', ':Neotree toggle<CR>')

-- Terminal
key('t', '<Esc>', '<C-\\><C-n>')


-- Primeagen move lines
key('v', "J", ":m '>+1<CR>gv=gv")
key('v', "K", ":m '<-2<CR>gv=gv")
