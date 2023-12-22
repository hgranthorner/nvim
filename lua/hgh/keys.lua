local funcs = require('hgh.functions')

-- Keys
local key = vim.keymap.set

local function nkey(keys, cmd, config)
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

-- Harpoon
local harpoon = require('harpoon')

harpoon:setup({})

nkey('<leader>ha', function() harpoon:list():append() end, { desc = '[H]arpoon [a]dd' })
nkey('<leader>hu', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon [u]i' })
nkey('<C-h>', function() harpoon:list():select(1) end)
nkey('<C-j>', function() harpoon:list():select(2) end)
nkey('<C-k>', function() harpoon:list():select(3) end)
nkey('<C-l>', function() harpoon:list():select(4) end)

-- Lsp
nkey('<leader>cf', vim.lsp.buf.format)
nkey('<leader>ca', vim.lsp.buf.code_action)
nkey('<leader>cr', vim.lsp.buf.rename)
nkey('<leader>gd', vim.lsp.buf.definition)
nkey('<leader>gr', vim.lsp.buf.references)
