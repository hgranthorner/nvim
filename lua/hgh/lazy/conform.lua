return { -- Autoformat
	'stevearc/conform.nvim',
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { 'stylua' },
			-- Conform can also run multiple formatters sequentially
			python = { "ruff_format" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			javascript = { "brettier", "prettierd", "prettier", stop_after_first = true },
			typescript = { "brettier", "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "brettier", "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			brettier = {
				command = "bun",
				args = { "run", "prettier", "--stdin-filepath", "$FILENAME" }
			},
		}
	},
}
