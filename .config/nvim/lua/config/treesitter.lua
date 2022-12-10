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
                goto_next_start = {},
                goto_next_end = {},
                goto_previous_start = {},
                goto_previous_end = { },
            },
        },
    })
end

return M
