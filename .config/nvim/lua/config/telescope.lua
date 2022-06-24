local self = {}

local actions = require('telescope.actions')

self.telescope_config = {
    defaults = {
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case'
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
        },
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = { "%.csv", "%.arff", "%.json" },
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = { "absolute" },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        use_less = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

        -- mappings (specifically in telescope contexts
        mappings = {
            i = {
                ['<esc>'] = actions.close,
            },
            n = {
                ['<s-j>'] = actions.preview_scrolling_down,
                ['<s-k>'] = actions.preview_scrolling_up,
                ['q'] = actions.close,
            }
        }
    }
}

function self.setup()
    require('telescope').setup(self.telescope_config)
end

return self
