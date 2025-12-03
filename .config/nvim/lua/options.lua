-- TODO:
-- clear useless spaces
-- autocmd BufWrite *.py,*.php,*.html,*.js,*.txt,*.ipynb,*.md,*.yaml,*.yml,*.sql :%s/\s\+$//ge
-- before tab too
-- autocmd BufWrite *.py,*.php,*.html,*.js,*.txt,*.ipynb,*.md,*.yaml,*.yml,*.sql :%s/\ \+\t/\t/ge
--
-- replace all datetime
-- :s/\('[0-9- :.]\{16,}'\)/from_utc_timestamp(\1, 'UTC')
-- Perform dot commands over visual blocks:
-- vnoremap . :normal .<CR>
--
-- ---------Command line mode remaps---------
-- " paste from +register with ctrl-p
-- cnoremap <c-v> <c-r>+

-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- vim.keymap.set("", "<space>", ";", { noremap = true, desc = "space as repeat" })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- buffer hundle
vim.o.fileformat = 'unix'
vim.o.fileformats = 'unix,dos'
vim.o.fileencoding = 'utf-8'
vim.o.hidden = true

-- Set textwitdh options and visible indicators
vim.o.textwidth = 100
vim.o.colorcolumn = '+1'

-- While typing a search command, show where the pattern
vim.o.incsearch = true
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- When on, the ':substitute' flag 'g' is default on.
vim.o.gdefault = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Disable search hilighting
vim.o.hlsearch = false

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '~', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
