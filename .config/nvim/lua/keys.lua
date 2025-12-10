vim.keymap.set('', 'Q', 'gq', { desc = 'Replace ex mode with gq' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('c', '<c-n>', '<Down>', { desc = 'Next in history' })
vim.keymap.set('c', '<c-p>', '<Up>', { desc = 'Prev in history' })

vim.keymap.set({ 'i', 'c' }, '<A-v>', '<C-r>+', { desc = 'Paste from clipboard' })
vim.keymap.set('i', '<c-l>', '<Right>', { desc = 'Move right in insert mode' })
vim.keymap.set('i', '<c-h>', '<Left>', { desc = 'Move left in insert mode' })
vim.keymap.set('i', '<c-w>', '<C-o>w', { desc = 'Move forward word in insert mode' })
vim.keymap.set('i', '<c-e>', '<C-o>e', { desc = 'Move forward end of word in insert mode' })
vim.keymap.set('i', '<c-b>', '<C-o>b', { desc = 'Move backward in insert mode' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected part down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected part up' })
vim.keymap.set('v', '.', ':normal .<CR>', { desc = 'Perform dot commands over visual blocks' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'J but cursor stays inplace' })
vim.keymap.set('n', '<leader>p', ':pu<CR>', { desc = 'Paste in new line' })
vim.keymap.set('n', '<leader>P', ':pu!<CR>', { desc = 'Paste in new line before' })
vim.keymap.set('n', '<leader>t', ':horizontal term<CR>:resize 15<CR>i', { desc = 'Open [T]erminal in window' })
-- vim.keymap.set('n', '<leader>rk', ':lua term<CR>:resize 15<CR>i', { desc = 'Open [T]erminal in window' })

vim.keymap.set('n', '<leader>rb', ':%bd|e#|bd#', { desc = 'Remove all buffer but current' })

local function reload_config()
    return function()
        local cfg_path = vim.fn.stdpath 'config'
        vim.cmd('luafile ' .. cfg_path .. '/lua/keys.lua')
        vim.cmd('luafile ' .. cfg_path .. '/lua/options.lua')
        vim.cmd('luafile ' .. cfg_path .. '/lua/commands.lua')
        vim.cmd 'echo "config reloaded"'
    end
end

vim.keymap.set('n', '<leader>rc', reload_config(), { desc = 'Reload config' })
vim.keymap.set('n', '<leader>rp', ':Lazy reload ', { desc = 'Reload plugin' })

vim.keymap.set('n', '<leader><leader>v', function()
    vim.cmd('tabedit ' .. vim.fn.stdpath 'config' .. '/init.lua')
end, { desc = 'Edit init.lua' })
-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>=', '<C-w>+', { desc = 'Add height to window' })
vim.keymap.set('n', '<leader>-', '<C-w>-', { desc = 'Dec height to window' })
vim.keymap.set('n', '<leader>,', '<C-w><lt>', { desc = 'Add height to window' })
vim.keymap.set('n', '<leader>.', '<C-w>>', { desc = 'Add height to window' })
vim.keymap.set('n', '<Leader>H', ':tabmove -1<CR>', { desc = 'Move current tab left' })
vim.keymap.set('n', '<Leader>L', ':tabmove +1<CR>', { desc = 'Move current tab right' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Less disoriented look up' })
vim.keymap.set('n', '<n>', 'nzzzv', { desc = 'Less disoriented search next' })
vim.keymap.set('n', '<N>', 'Nzzzv', { desc = 'Less disoriented search next' })
