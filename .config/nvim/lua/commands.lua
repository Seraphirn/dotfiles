vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
-- missclick w to W is ok
vim.api.nvim_create_user_command('W', 'write', { bang = true })

-- abreviations
vim.cmd { cmd = 'inoreabbrev', args = { 'pdb', 'breakpoint()' } }
