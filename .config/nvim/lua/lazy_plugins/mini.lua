return {
    'echasnovski/mini.nvim',
    dependencies = {
        -- Required to use its queries
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            init = function()
                -- Disable the plugin's own RPT plugin logic, mini.ai handles this
                require('lazy.core.loader').disable_rtp_plugin 'nvim-treesitter-textobjects'
            end,
        },
    },
    opts = function()
        local ai = require 'mini.ai'
        return {
            n_lines = 500, -- Increase if text objects span many lines
            custom_textobjects = {
                l = ai.gen_spec.treesitter({
                    a = '@loop.outer',
                    i = '@loop.inner',
                }, {}),
                f = ai.gen_spec.treesitter({
                    a = '@function.outer',
                    i = '@function.inner',
                }, {}),
                c = ai.gen_spec.treesitter({
                    a = '@class.outer',
                    i = '@class.inner',
                }, {}),
                v = ai.gen_spec.treesitter({
                    a = '@parameter.outer',
                    i = '@parameter.inner',
                }, {}),
            },
        }
    end,
    config = function(_, opts)
        require('mini.ai').setup(opts)
        require('mini.surround').setup()
        require('mini.splitjoin').setup()
    end,
}
