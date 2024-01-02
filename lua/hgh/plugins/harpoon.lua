local kt = require('hgh.keys')
local harpoon = require('harpoon')

harpoon:setup({})

kt.nkey('<leader>ha', function() harpoon:list():append() end, { desc = '[H]arpoon [a]dd' })
kt.nkey('<leader>hu', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon [u]i' })
kt.nkey('<C-h>', function() harpoon:list():select(1) end)
kt.nkey('<C-j>', function() harpoon:list():select(2) end)
kt.nkey('<C-k>', function() harpoon:list():select(3) end)
kt.nkey('<C-l>', function() harpoon:list():select(4) end)
