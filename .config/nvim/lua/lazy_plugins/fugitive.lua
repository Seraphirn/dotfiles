return {
    'tpope/vim-fugitive',
    lazy = false,
    -- cmd = { 'Git', 'Gdiff', 'Gblame', 'Glog', 'Gread', 'Gwrite', 'Ggrep' },
    keys = {
        { '<leader>gs', '<cmd>Git<cr>', desc = 'Open Git status' },
        { '<leader>gd', '<cmd>Gdiff<cr>', desc = 'Open Git diff' },
        { '<leader>gb', '<cmd>G blame<cr>', desc = 'Open Git blame' },
        { '<leader>gp', ':G push origin ', desc = 'Open Git push' },
    },
    config = function()
    end,
}
