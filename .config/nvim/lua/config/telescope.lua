local setkeys = require('util').setkeys

local M = {
    keymaps = {
       -- [s]earch [s]ymbol (search symbol from with the active language server)
        {'<leader>ss', ':Telescope lsp_workspace_symbols query='},

        -- [s]earch [f]or (use ripgrep to find matches of string in workspace)
        {'<leader>sf', '<cmd>Telescope live_grep<CR>'},

        -- [g]o [d]efinition (Goes to any found definition in the workspace)
        {'<leader>gd', '<cmd>Telescope lsp_definitions<CR>' },

        -- search files (ctrl-P plugin habit) (search for a file in the workspace)
        {'<c-p>', '<cmd>Telescope find_files<CR>'},

        -- search file history (search through previously access files)
        {'<c-h>', '<cmd>Telescope oldfiles<CR>'},
    }
}

-- Searches language server for the 'query' with a 'type'
-- Note: Not in use
function M.lsp_workspace_search(type, query)
    require('telescope.builtin').lsp_workspace_symbols({
        prompt_prefix="", -- needs to be explicitly set apparently
        default_text=string.format(":%s:%s", type, query),
        initial_mode='normal',
        query=query
    })
end

function M.find_files(opts)
    require('telescope.builtin').find_files({
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    })
end

function M.setup()
    local actions = require('telescope.actions')

    -- Set my specific keymaps
    setkeys('n', M.keymaps)

    -- default setup
    require('telescope').setup{
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
            file_ignore_patterns = {},
            generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
            path_display = {
                "shorten"
            },
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
end

M.setup()

return M
