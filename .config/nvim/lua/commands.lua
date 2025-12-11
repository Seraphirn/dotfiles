vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- vim.api.nvim_create_autocmd('VimEnter', {
--     callback = function()
--         if vim.fn.argc() == 0 then -- Only show if no files are opened
--             vim.defer_fn(function()
--                 vim.cmd ':NeovimProjectDiscover'
--             end, 10)
--         end
--     end,
-- })
-- vim.api.nvim_create_autocmd('BufWrite', {
--     pattern = { '*.py', '*.php', '*.html', '*.js', '*.txt', '*.ipynb', '*.md', '*.yaml', '*.yml', '*.sql' },
--     command = ':%s/\\s*$//ge',
--     desc = 'Delete space characters in end of line',
-- })
-- missclick w to W is ok
vim.api.nvim_create_user_command('W', 'write', { bang = true })

-- abreviations
vim.cmd { cmd = 'inoreabbrev', args = { 'pdb', 'breakpoint()' } }
