return { -- Easy_motion alternative. fast travel thought code
    'smoka7/hop.nvim',
    keys = {
        { '\\', ':HopWord<cr>', mode = '', desc = 'Hop' },
        { '<Tab>', ':HopChar2<cr>', mode = '', desc = 'Hop' },
        { '<Backspace>', ':HopCamelCase<cr>', mode = '', desc = 'Hop' },
    },
    -- config = function()
    --     vim.keymap.set('n', '<leader>lol', function()
    --         require('hop').hint_with_regex(require('hop').jump_regex.regex_by_camel_case())
    --     end)
    -- end,
    opts = {
        keys = 'etovxqpdygfblzhckisuran',
    },
}
