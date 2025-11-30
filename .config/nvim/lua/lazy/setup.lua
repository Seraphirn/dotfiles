-- [[ Configure and install plugins ]]
--  To check the current status of your plugins, run :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run :Lazy update
require("lazy").setup({
	-- Plugins with large configs or with strict order of load
	{ import = "lazy.plugins" },

	-- [[ Plugins with small configs ]]

	"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically

	"tpope/vim-repeat", -- repeat complicated comands with .

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{ -- Colorscheme
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})
			-- 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},

	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Easy_motion alternative. fast travel thought code
		"smoka7/hop.nvim",
		keys = {
			{ "\\", ":HopWord<cr>", mode = "", desc = "Hop to word" },
		},
		opts = {
			keys = "etovxqpdygfblzhckisuran",
		},
	},

	{ -- ads text object like class and method for python
		"jeetsukumaran/vim-pythonsense",
		keys = {
			{ "]f", "<Plug>(PythonsenseStartOfNextPythonFunction)", mode = "n", desc = "Start of Next method" },
			{ "]F", "<Plug>(PythonsenseEndOfPythonFunction)", mode = "n", desc = "End of method" },
			{ "[f", "<Plug>(PythonsenseStartOfPythonFunction)", mode = "n", desc = "Start of method" },
			{ "[F", "<Plug>(PythonsenseEndOfPreviousPythonFunction)", mode = "n", desc = "End of previous method" },
		},
	},
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
