local isdir = require('util').isdir
local joinpath = require('util').joinpath
local os_exec = require('util').os_exec
local setkeys = require('util').setkeys

local M = {
    languages = { 'lua', 'python', 'query' },
    keymaps = {
        -- Relies on nvim-treesitter/playground
        {'<leader>sg', '<cmd>TSHighlightCapturesUnderCursor<CR>'}
    }
}

-- Overwrites treesitter-pythons folding to custom one
-- Only does so for Python folding for now, will need to
-- make this more functional if I am to overwrite more
function M.overwrite_with_custom_folding()

    local plugin_path = require('plugins').plugin_path
    local res = isdir(plugin_path)
    if not res then
        print('Plugin folder not found at '..plugin_path)
        return
    end

    local copy_to = joinpath(plugin_path, 'nvim-treesitter', 'queries', 'python')
    if not isdir(copy_to) then
        print('Treesitter does not seem to exists at '..copy_to)
        return
    end

    local extras_path = joinpath(vim.fn.stdpath('config'), 'extra')
    local folds_scm = joinpath(extras_path, 'folds.scm')

    os_exec('cp '..folds_scm..' '..copy_to)
    print('Copied '..folds_scm..'\n to '..copy_to)
end

function M.setup()
    -- Set treesitter options
    local config = require('nvim-treesitter.configs')
    config.setup({
        ensure_installed = M.languages,
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },

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
            lint_events = {"BufWrite", "CursorHold"}
        },

        refactor = {

            -- Too much
            highlight_definitions = { enable = false },
            highlight_current_scope = { enable = false },

            -- Doesn't work for children who use symbol
            smart_rename = {
                enable = false,
                keymaps = { smart_rename = "cf" }
            },

            navigation = {
                enable = true,
                keymaps = {
                    goto_definition_lsp_fallback = "gd",
                    list_definitions = "<leader>ld",
                    list_definitions_toc = "<leader>lD",
                    goto_next_usage = "gn",
                    goto_previous_usage = "gp",
                }
            }

        },

        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["il"] = "@loop.inner",
                    ["al"] = "@loop.outer",
                    ["ic"] = "@conditional.inner",
                    ["ac"] = "@conditional.outer",
                    ["p"] = "@parameter.outer",
                    ["c"] = "@comment.outer",
                }
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
                    ["sC"] = "@parameter.outer",
                    ["sS"] = "@statement.outer",
                    ["sB"] = "@block.outer",
                }
            },
            move = {
                enable = true,
                keymaps = {
                    goto_previous_start = {
                        ["[["] = "@block.outer",
                        ["[f"] = "@function.outer",
                    },
                    goto_next_start = {
                        ["]["] = "@block.outer",
                        ["]f"] = "@function.outer",
                    },
                    },
                    goto_previous_end = {
                        ["[]"] = "@block.outer",
                        ["[F"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["]]"] = "@block.outer",
                        ["]F"] = "@function.outer",
                }
            }

        }
    })

    -- Setup keys
    setkeys('n', M.keymaps)
end

M.setup()

-- Recommended to run this after setup but doesn't seem to have the command
-- registered at time of calling
--
-- cmd('TSUpdate')

return M
