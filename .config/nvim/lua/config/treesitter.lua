local setkeys = require('util').setkeys

local M = {
    languages = { 'lua', 'python', 'query', 'rust', 'json', 'rst', 'markdown' },
    keymaps = {
        -- Relies on nvim-treesitter/playground
        { '<leader>sg', '<cmd>TSHighlightCapturesUnderCursor<CR>' }
    }
}

function M.setup()
    -- Set treesitter options
    local config = require('nvim-treesitter.configs')

    -- Annoyingly this plugin to fit into treesitters module defintion
    require 'treesitter-context'.setup { enable = true, }

    -- This is for indent_blankline plugin
    vim.g.indent_blankline_show_current_context = 1

    config.setup({
        ensure_installed = M.languages,
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },

        -- python folding
        pyfold = {
            enable = true,
            custom_foldtext = true
        },

        -- 'nvim-treesitter/playground'
        playground = {
            enable = true,
            updatetime = 25,
            persist_queries = false,
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
            },
        },

        query_linter = {
            enable = true,
            lint_events = { "BufWrite", "CursorHold" }
        },

        textsubjects = {
            enable = true,
            keymaps = { ['.'] = 'textsubjects-smart' }
        },

        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["p"] = "@parameter",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["sp"] = "@parameter.inner",
                    ["sf"] = "@function.outer",
                    ["sc"] = "@class.outer",
                    ["ss"] = "@statement.outer",
                    ["sb"] = "@block.outer",
                },
                swap_previous = {
                    ["sP"] = "@parameter.inner",
                    ["sF"] = "@function.outer",
                    ["sC"] = "@class.outer",
                    ["sS"] = "@statement.outer",
                    ["sB"] = "@block.outer",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["}"] = "@function.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["{"] = "@function.outer",
                    ["[f"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },

        pysitter = {
            enable = true
        }
    })

    -- Setup keys
    setkeys('n', M.keymaps)
end

-- Recommended to run this after setup but doesn't seem to have the command
-- registered at time of calling
--
-- cmd('TSUpdate')

return M
