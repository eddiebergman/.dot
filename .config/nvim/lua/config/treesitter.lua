local M = {}

function M.setup()
    local config = require("nvim-treesitter.configs")
    config.setup({
        ensure_installed = {
            "python",
            "lua",
            "markdown",
            "bash",
            "markdown_inline",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "vimdoc",
            "vim",
            "luadoc",
        },
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true, disable = { "zig" } },
        pyfold = { enable = false, custom_foldtext = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["p"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ic"] = "@class.inner",
                    ["ac"] = "@class.outer",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["as"] = "@statement.outer",
                    ["is"] = "@statement.inner",
                },
                selection_modes = {
                    ["@function.outer"] = "V",
                    ["@function.inner"] = "V",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["sp"] = "@parameter.inner",
                    ["sf"] = "@function.outer",
                    ["sc"] = "@class.outer",
                    -- ["ss"] = "@statement.outer",
                    -- ["sb"] = "@block.outer",
                },
                swap_previous = {
                    ["sP"] = "@parameter.inner",
                    ["sF"] = "@function.outer",
                    ["sC"] = "@class.outer",
                    -- ["sS"] = "@statement.outer",
                    -- ["sB"] = "@block.outer",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                    ["<A-p>"] = "@parameter.inner",
                    ["]#"] = "@comment.outer",
                    ["]]"] = "@block.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["<A-s-p>"] = "@parameter.inner",
                    ["[#"] = "@comment.outer",
                    ["[["] = "@block.outer",
                },
            },
        },
    })
    vim.treesitter.query.set(
        "python",
        "folds",
        [[
        ; class and function definitions
        [ (function_definition) (class_definition) ] @fold
        ; Class definition docstring
        (function_definition
            body: (block
            (expression_statement (string))? @fold)
        )
        ; Func definition docstring
        (class_definition
            body: (block
            (expression_statement (string))? @fold)
        )
        ; Module if __name__ == "__main__"
        (module
            (if_statement
                condition : (
                    comparison_operator (identifier) @id (#match? @id "^__name__")
                        [(string) (list)]
                    )
            ) @fold
        )
        ; Module docstring
        (module
            (expression_statement (string)? ) @fold
        )
        ; Fold multiline decorators
        (decorator
            (call) @fold
        )
        (module
            ((import_statement)+) @fold
        )
    ]]
    )
    require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 1, -- Maximum number of lines to collapse for a single context line
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        -- TODO Highligt the line its on
    })
    vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#2E3440" })
end

return M
