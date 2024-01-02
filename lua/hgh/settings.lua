vim.opt.termguicolors = true

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Clipboard
---@diagnostic disable-next-line: undefined-global
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
vim.opt.shiftround  = true -- tab / shifting moves to closest tabstop.
vim.opt.smartindent = true -- Intelligently dedent / indent new lines based on rules.
vim.opt.cursorline  = true

-- Make search more sane
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase  = true -- If there are uppercase letters, become case-sensitive.
vim.opt.showmatch  = true -- live match highlighting
vim.opt.hlsearch   = false -- highlight matches

-- Let splitting make more sense
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.signcolumn = 'yes'

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.cmd [[colorscheme default]]
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank()]]
