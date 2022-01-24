local isdir = require('util').isdir
local joinpath = require('util').joinpath
local os_exec = require('util').os_exec
local setkeys = require('util').setkeys

function tree_docs_setup()
    return  {
        enable = true,
        keymaps = { doc_node_at_cursor = "<leader>d" },
        spec_config = {
            python = {
                slots = {
                    func = { helloworld = true }
                },
                templates = {
                    func = {
                        "%contents%",
                        "helloworld"
                    }
                },
                processors = {
                    helloworld = function() return "hello world" end
                }
            }
        }
    }
end

local M = {
    languages = { 'lua', 'python', 'query' },
    keymaps = {
        -- Relies on nvim-treesitter/playground
        {'<leader>sg', '<cmd>TSHighlightCapturesUnderCursor<CR>'}
    }
}

function M.setup()
    -- Set treesitter options
    local config = require('nvim-treesitter.configs')

    -- Annoyingly this plugin to fit into treesitters module defintion
    require'treesitter-context.config'.setup{ enable = true, }

    -- This is for indent_blankline plugin
    vim.g.indent_blankline_show_current_context = 1

    config.setup({
        ensure_installed = M.languages,
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },

        --nvim-tree-docs


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
            lint_events = {"BufWrite", "CursorHold"}
        },

        textsubjects = {
            enable = true,
            keymaps = {
                ['.'] = 'textsubjects-smart',
                [';'] = 'textsubjects-container-outer',
            }
        },

        textobjects = {
            enable = true,
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
