return { -- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Useful status updates for LSP.
		-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
		{ 'j-hui/fidget.nvim', opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup('hgh-lsp-codelens-refresh', { clear = true }),
			callback = function(event)
				local bufnr = event.buf
				for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
					if client and client.server_capabilities.codeLensProvider then
						vim.lsp.codelens.refresh()
					end
				end
			end
		})
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				end

				map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
				map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

				map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

				map('<leader>ds', require('telescope.builtin').lsp_document_symbols,
					'[D]ocument [S]ymbols')
				map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
					'[W]orkspace [S]ymbols')
				map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
				map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
				map('K', vim.lsp.buf.hover, 'Hover Documentation')

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header
				map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client and client.server_capabilities.codeLensProvider then
					map('<leader>clr', function()
							vim.lsp.codelens.refresh()
						end,
						'[C]ode [L]ens [R]efresh'
					)
					map('<leader>clR', function()
							vim.lsp.codelens.run()
						end,
						'[C]ode [L]ens [R]un'
					)
					map('<leader>cld', function()
							local lenses = vim.lsp.codelens.get(event.buf)
							vim.lsp.codelens.display(lenses, event.buf, event.data.client_id)
						end,
						'[C]ode [L]ens [D]isplay'
					)
					map('<leader>clc', function() vim.lsp.codelens.clear(event.data.client_id, event.buf) end,
						'[C]ode [L]ens [C]lear')
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP Specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			elixirls = { cmd = { vim.loop.os_homedir() .. "/.local/bin/language_server.sh" } },
			-- lexical = { cmd = { vim.loop.os_homedir() .. "/repos/lexical/_build/dev/package/lexical/bin/start_lexical.sh" } },
			tailwindcss = {
				root_dir = require('lspconfig.util').root_pattern(
					'tailwind.config.js',
					'tailwind.config.cjs',
					'tailwind.config.mjs',
					'tailwind.config.ts',
					'postcss.config.js',
					'postcss.config.cjs',
					'postcss.config.mjs',
					'postcss.config.ts',
					'package.json',
					'node_modules',
					'.git',
					'mix.exs'
				),
				init_options = {
					userLanguages = {
						elixir = "phoenix-heex",
						eelixir = "phoenix-heex",
						heex = "phoenix-heex",
						["phoenix-heex"] = "phoenix-heex",
					},
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								'class[:]\\s*"([^"]*)"',
							},
						},
					},
				},
			},
			cmake = {},
			ols = {},
			terraformls = {},
			-- sourcekit = {},
			-- rubocop = {},
			ruby_lsp = {},
			svelte = {},
			-- clangd = {},
			gopls = {},
			pyright = {},
			-- rust_analyzer = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- Some languages (like typescript) have entire language plugins that can be useful:
			--    https://github.com/pmizio/typescript-tools.nvim
			--
			-- But for many setups, the LSP (`tsserver`) will work just fine
			ts_ls = {},
			--
			intelephense = {},
			kotlin_language_server = {},
			-- csharp_ls = {
			-- 	filetypes = { "cs", "razor" },
			-- },
			html = {
				filetypes = { "html", "heex" },
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true
					},
				},
			},

			clangd = {},

			gleam = {},
			hls = {},
			zls = {},
			ocamllsp = {},
			lua_ls = {
				-- cmd = {...},
				-- filetypes { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						workspace = {
							checkThirdParty = false,
							-- Tells lua_ls where to find all the Lua files that you have loaded
							-- for your neovim configuration.
							library = {
								'${3rd}/luv/library',
								unpack(vim.api.nvim_get_runtime_file('', true)),
							},
							-- If lua_ls is really slow on your computer, you can try this instead:
							-- library = { vim.env.VIMRUNTIME },
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		--  You can press `g?` for help in this menu
		local lspconfig = require 'lspconfig'
		for lsp, setup_config in pairs(servers) do
			setup_config.capabilities = capabilities
			lspconfig[lsp].setup(setup_config)
		end


		local configs = require 'lspconfig.configs'
		if not configs.roc_language_server then
			configs.roc_language_server = {
				default_config = {
					cmd = { "roc_language_server" },
					filetypes = { "roc" },
					root_dir = require('lspconfig.util').root_pattern("main.roc")
				},
			}
		end

		lspconfig.roc_language_server.setup {
			capabilities = capabilities
		}
	end,
}
