local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
    { import = 'lazy_plugins' },

    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-abolish', -- crc to make camelCase, crs to snake_case, etc
    'tpope/vim-repeat', -- repeat complicated comands with .
    -- 'nvim-treesitter/nvim-treesitter-context',

    { -- Colorscheme
        'folke/tokyonight.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require('tokyonight').setup {
                styles = {
                    comments = { italic = false }, -- Disable italics in comments
                },
                on_highlights = function(hl)
                    hl.LineNrAbove = {
                        fg = '#6ab8ff',
                    }
                    hl.LineNrBelow = {
                        -- fg = '#ff6188',
                        fg = '#6ab8ff',
                    }
                end,
            }
            -- 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'tokyonight-night'
        end,
    },

    { -- Highlight todo, notes, etc in comments
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },

    { -- Change worker directory when you open file
        'airblade/vim-rooter',
        config = function()
            -- vim.g.rooter_targets = { '~/projects' }
            vim.g.rooter_cd_cmd = 'lcd'
            vim.g.rooter_patterns = {'.git', 'Makefile'}
        end,
    },
})
