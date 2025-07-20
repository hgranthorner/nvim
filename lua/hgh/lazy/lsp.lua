return { 
	'neovim/nvim-lspconfig',
	dependencies = {
		{ 'j-hui/fidget.nvim', opts = {} },
	},
	config = function()
		vim.lsp.enable({ "basedpyright", "lua_ls" })
	end,
}
