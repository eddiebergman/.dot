local M = {}
require("nvim-treesitter.install")

function M.setup()
    local config = require("nvim-treesitter.configs")

    config.setup({
        highlight = { enable = true },

        indent = { enable = true },

        incremental_selection = {
            enable = true,
            keymaps = { init_selection = "<A-l>", node_incremental = "<A-l>", node_decremental = "<A-h>" }
        },

        pyfold = {
            enable = true,
            custom_foldtext = true,
        },

        playground = { enable = true },


        textsubjects = {
            enable = true,
            keymaps = { ["."] = "textsubjects-smart" }
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["p"] = "@parameter.outer",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ic"] = "@class.inner",
                    ["ac"] = "@class.outer",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
                selection_modes = {
                    ["@function.outer"] = "V",
                    ["@function.inner"] = "V"
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
                    ["sC"] = "@class.outer",
                    ["sS"] = "@statement.outer",
                    ["sB"] = "@block.outer",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]f"] = "@function.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                },
            },
        },
    })
end

return M
