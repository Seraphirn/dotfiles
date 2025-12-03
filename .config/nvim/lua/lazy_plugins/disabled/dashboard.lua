return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope neovim-project history' },
            },
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
