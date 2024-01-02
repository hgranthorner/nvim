local kt = require('hgh.keys')
local tele = require('telescope.builtin')

kt.nkey('<leader>ff', tele.find_files, { desc = '[F]ind [f]iles' })
kt.nkey('<leader>fs', function () tele.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = '[F]ind [f]iles' })
kt.nkey('<leader>fg', tele.live_grep)
kt.nkey('<leader>fb', tele.buffers)
kt.nkey('<leader>fh', tele.help_tags)
kt.nkey('<leader>fk', tele.keymaps)
