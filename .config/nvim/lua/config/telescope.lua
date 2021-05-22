local setkeys = require('util').setkeys
local M = {
    keymaps = {
       -- [s]earch [l]sp (search symbol from with the active language server)
        {'<leader>sl', ':Telescope lsp_workspace_symbols query='},

        -- [s]earch [s]tring (use ripgrep to find matches of string in workspace)
        {'<leader>ss', '<cmd>Telescope live_grep<CR>'},

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

function M.setup()
    local actions = require('telescope.actions')
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
        prompt_position = "bottom",
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_defaults = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
        },
        file_sorter =  require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
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

    setkeys('n', M.keymaps)
end

M.setup()

return M
