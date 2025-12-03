vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected part down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected part up' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Less disoriented look down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Less disoriented look up' })
vim.keymap.set('n', '<n>', 'nzzzv', { desc = 'Less disoriented search next' })
vim.keymap.set('n', '<N>', 'Nzzzv', { desc = 'Less disoriented search next' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>t', ':horizontal term<CR>:resize 15<CR>i', { desc = 'Open [T]erminal in window' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<Leader>H', ':tabmove -1<CR>', { desc = 'Move current tab left' })
vim.keymap.set('n', '<Leader>L', ':tabmove +1<CR>', { desc = 'Move current tab right' })
--

vim.keymap.set('n', '<leader><leader>v', function()
  vim.cmd('tabedit ' .. vim.fn.stdpath 'config' .. '/init.lua')
end, { desc = 'Edit init.lua' })

vim.keymap.set('', 'Q', 'gq', { desc = 'Replace ex mode with gq' })

vim.keymap.set('i', '<C-v>', '<C-r>"', { desc = 'Paste from clipboard' })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argc() == 0 then -- Only show if no files are opened
      vim.defer_fn(function()
        vim.cmd ':Telescope repo list'
        -- vim.cmd ':NeovimProjectDiscover'
      end, 10)
    end
  end,
})
-- missclick w to W is ok
vim.api.nvim_create_user_command('W', 'write', { bang = true })

-- abreviations
-- vim.cmd({ cmd = "inoreabbrev", args = { "pdb", "import pdb; pdb.set_trace()" } })
vim.cmd { cmd = 'inoreabbrev', args = { 'pdb', 'breakpoint()' } }
