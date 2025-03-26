return {

	{
		'folke/tokyonight.nvim',
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
	},

	{
		'dasupradyumna/midnight.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme 'midnight'
			vim.cmd [[highlight DiffAdd    guibg=#004400]]
			vim.cmd [[highlight DiffDelete guibg=#440000]]
			vim.cmd [[highlight DiffChange guibg=#000044]]
		end
	},

	"rebelot/kanagawa.nvim",

}
