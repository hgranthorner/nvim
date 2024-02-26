local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'nvim-lua/plenary.nvim',
  -- Sets up lua-ls for neovim
  "folke/neodev.nvim",
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-repeat',
  'neovim/nvim-lspconfig',
  'nvim-treesitter/nvim-treesitter',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    }
  },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*'
  },
  'saadparwaiz1/cmp_luasnip',
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function (_)
      vim.cmd [[colorscheme rose-pine]]
    end
  },
})
