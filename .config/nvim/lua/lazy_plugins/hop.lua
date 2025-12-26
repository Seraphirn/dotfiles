return { -- Easy_motion alternative. fast travel thought code
    'smoka7/hop.nvim',
    keys = {
        { '\\', '<cmd>HopWord<cr>', mode = '', desc = 'Hop' },
        --
        -- { '<Ta.b>', '<cmd>HopWord<cr>', mode = '', desc = 'Hop' },
        { '<C-i>', '<Tab>', mode = '', desc = 'Hop', noremap=true },
        { '<Tab>', '<cmd>HopWord<cr>', mode = '', desc = 'Hop', noremap=true },
        { '<Backspace>', '<cmd>HopWord<cr>', mode = '', desc = 'Hop', noremap=true },
    },
    opts = {
        keys = 'etovxqpdygfblzhckisuran',
    },
}
