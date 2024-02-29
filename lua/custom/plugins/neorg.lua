return {
	"nvim-neorg/neorg",
	lazy = false,
	run = ":Neorg sync-parsers", -- This is the important bit!
	opts = {
		load = {
			["core.defaults"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/notes",
					},
					default_workspace = "notes",
				},
			},
		}
	}
}
