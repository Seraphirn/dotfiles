return { -- Project manager
    'coffebar/neovim-project',
    opts = {
        last_session_on_startup = false,
        dashboard_mode = true,
        projects = { -- define project roots
            '~/projects/*',
            -- "~/.config/*",
        },
        picker = {
            type = 'telescope', -- one of "telescope", "fzf-lua", or "snacks"
        },
        forget_project_keys = {
            -- insert mode: Ctrl+d
            i = '<C-d>',
            -- normal mode: d
            n = 'd',
        },
    },
    keys = {
        { '<leader>sp', ':NeovimProjectDiscover<CR>', mode = 'n', desc = '[S]earch [P]roject' },
        { '<leader>ss', ':NeovimProjectHistory<CR>', mode = 'n', desc = '[S]earch [S]essions' },
    },
    init = function()
        vim.opt.sessionoptions = 'terminal,curdir,folds,tabpages,winsize,globals'
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            'Shatur/neovim-session-manager',
            config = function()
                require('session_manager').setup {}
            end,
        },
        { 'nvim-telescope/telescope.nvim' },
    },
    lazy = false,
    priority = 100,
}
