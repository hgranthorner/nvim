return
{
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields
		require('nvim-treesitter.configs').setup {
			ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		}

		local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
		parser_config.gotmpl = {
			install_info = {
				url = "https://github.com/ngalaiko/tree-sitter-go-template",
				files = { "src/parser.c" }
			},
			filetype = "gotmpl",
			used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" }
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = { "*.razor" },
			command = "set filetype=razor",
		})
		vim.treesitter.language.register('c_sharp', { 'razor' })


		-- make .roc files have the correct filetype
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
			pattern = { "*.roc" },
			command = "set filetype=roc",
		})

		-- vim.api.nvim_create_augroup("filetype_roc_indent", { clear = true })
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "roc",
		-- 	group = "filetype_roc_indent",
		-- 	command = "setlocal shiftwidth=4 tabstop=4 expandtab autoindent",
		-- })

		parser_config.roc = {
			install_info = {
				url = "https://github.com/faldor20/tree-sitter-roc",
				files = { "src/parser.c", "src/scanner.c" },
			},
		}

		-- Tell Tree-sitter to use the C parser for Metal files.
		vim.treesitter.language.register('c', { 'metal', 'c' })

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}
