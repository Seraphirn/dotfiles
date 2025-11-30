-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "<Tab>", ":Neotree toggle reveal_force_cwd<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["<Tab>"] = "close_window",
				},
			},
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_ignored = false, -- hide files that are ignored by other gitignore-like files
				hide_hidden = false, -- only works on Windows for hidden files/directories
			},
		},
		event_handlers = {
			{
				event = "file_open_requested",
				handler = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			},
		},
	},
}
