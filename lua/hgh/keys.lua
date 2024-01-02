local funcs = require('hgh.functions')

local M = {}

local function nkey(keys, cmd, config)
  vim.keymap.set('n', keys, cmd, config)
end

M.nkey = nkey

-- Windows
nkey('<leader>ws', '<C-w>s')
nkey('<leader>wv', '<C-w>v')
nkey('<leader>wh', '<C-w>h')
nkey('<leader>wj', '<C-w>j')
nkey('<leader>wk', '<C-w>k')
nkey('<leader>wl', '<C-w>l')
nkey('<leader>wd', ':close<CR>')

-- Config management
nkey('<leader>rr', ':source $MYVIMRC<CR>', { desc = 'Refresh config' })
nkey('<leader>re', ':edit $MYVIMRC<CR>', { desc = 'Edit config' })
nkey('<leader>so', ':so<CR>', { desc = 'Source the current file' })

nkey('<leader>cwd', function()
  local dirname = funcs.bufferdir()
  vim.cmd('cd ' .. dirname)
end, { desc = 'Cd to the current directory' })

nkey('<leader>cgd', function()
  local dirname = funcs.findgitdir(funcs.bufferdir())
  if dirname then
    vim.cmd('cd ' .. dirname)
  end
end, { desc = 'Cd to the nearest git directory' })

-- Netrw
nkey('<leader>rw', ':Ex<CR>', { desc = 'Open Netrw' })

-- Trouble
nkey('<leader>tt', function() require('trouble').toggle() end, { desc = '[T]oggle [T]rouble' })

return M
