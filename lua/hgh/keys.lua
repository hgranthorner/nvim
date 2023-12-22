local funcs = require('hgh.functions')
vim.print(funcs.bufferdir())

-- Keys
local key = vim.keymap.set

function nkey(keys, cmd, config)
  key('n', keys, cmd, config)
end

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
nkey('<leader>re', ':edit $MYVIMRC<CR>')
nkey('<leader>so', ':so<CR>', { desc = 'Source the current file' })

nkey('<leader>cwd', function() 
  local dirname = funcs.bufferdir()
  vim.cmd('cd ' .. dirname) 
end)

nkey('<leader>cgd', function() 
  local dirname = funcs.findgitdir(funcs.bufferdir())
  if dirname then
    vim.cmd('cd ' .. dirname) 
  end
end)


-- Netrw
nkey('<leader>rw', ':Ex<CR>', { desc = 'Open Netrw' })

-- Telescope
local tele = require('telescope.builtin')

nkey('<leader>ff', tele.find_files, { desc = '[F]ind [f]iles' })
nkey('<leader>fg', tele.live_grep)
nkey('<leader>fb', tele.buffers)
nkey('<leader>fh', tele.help_tags)
