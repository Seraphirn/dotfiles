return {
    'otavioschwanck/arrow.nvim',
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        -- or if using `mini.icons`
        -- { "echasnovski/mini.icons" },
    },
    opts = {
        show_icons = true,
        leader_key = ';', -- Recommended to be a single key
        buffer_leader_key = 'm', -- Per Buffer Mappings
        global_bookmarks = false,
        separate_save_and_remove = true,
        index_keys = 'jklfds123456789zxcbnmZXVBNM,agAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
        mappings = {
            edit = 'e',
            delete_mode = 'r',
            clear_all_items = 'C',
            toggle = 'a', -- used as save if separate_save_and_remove is true
            open_vertical = 'v',
            open_horizontal = '-',
            quit = 'q',
            remove = 'x', -- only used if separate_save_and_remove is true
            next_item = ']',
            prev_item = '[',
        },
    },
}
