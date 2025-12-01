return { -- Project manager
	"coffebar/neovim-project",
	opts = {
		last_session_on_startup = false,
		dashboard_mode = true,
		projects = { -- define project roots
			"~/projects/*",
			-- "~/.config/*",
		},
		picker = {
			type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"
		},
	},
	keys = {
		{ "<leader>sp", ":NeovimProjectDiscover<CR>", mode = "n", desc = "[S]earch [P]roject" },
	},
	init = function()
		-- enable saving the state of plugins in the session
		-- vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "Shatur/neovim-session-manager" },
		{ "nvim-telescope/telescope.nvim" },
	},
	lazy = false,
	priority = 100,
}
