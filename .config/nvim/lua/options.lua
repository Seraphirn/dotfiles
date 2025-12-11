-- replace all datetime
-- :s/\('[0-9- :.]\{16,}'\)/from_utc_timestamp(\1, 'UTC')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.fileformat = 'unix'
vim.o.fileformats = 'unix,dos'
vim.o.fileencoding = 'utf-8'
vim.o.hidden = true
vim.o.textwidth = 100
vim.o.colorcolumn = '+1'
vim.o.incsearch = true
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.gdefault = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.hlsearch = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '~', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
