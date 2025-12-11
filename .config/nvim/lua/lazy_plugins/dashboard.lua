return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            shortcut_type = 'number',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    -- { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    { desc = '󰊳 Empty', group = '@property', action = 'enew', key = 'e' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Projects',
                        group = 'Label',
                        action = 'NeovimProjectDiscover',
                        key = 'p',
                    },
                    {
                        desc = ' Config',
                        group = 'Number',
                        action = function()
                            require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
                        end,
                        key = 'c',
                    },
                },
            },
        }
        vim.keymap.set('n', '<leader>w', ':Dashboard<cr>', { desc = '[W]elcome screen' })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
