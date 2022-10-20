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

    -- https://github.com/nvim-treesitter/nvim-treesitter/commit/42ab95d5e11f247c6f0c8f5181b02e816caa4a4f#commitcomment-87014462
    M.register_highlights()

end

function M.register_highlights()
    local hl = function(group, opts)
        opts.default = true
        vim.api.nvim_set_hl(0, group, opts)
    end

    -- Misc {{{
    hl('@comment', { link = 'Comment' })
    -- hl('@error', {link = 'Error'})
    hl('@none', { bg = 'NONE', fg = 'NONE' })
    hl('@preproc', { link = 'PreProc' })
    hl('@define', { link = 'Define' })
    hl('@operator', { link = 'Operator' })
    -- }}}

    -- Punctuation {{{
    hl('@punctuation.delimiter', { link = 'Delimiter' })
    hl('@punctuation.bracket', { link = 'Delimiter' })
    hl('@punctuation.special', { link = 'Delimiter' })
    -- }}}

    -- Literals {{{
    hl('@string', { link = 'String' })
    hl('@string.regex', { link = 'String' })
    hl('@string.escape', { link = 'SpecialChar' })
    hl('@string.special', { link = 'SpecialChar' })

    hl('@character', { link = 'Character' })
    hl('@character.special', { link = 'SpecialChar' })

    hl('@boolean', { link = 'Boolean' })
    hl('@number', { link = 'Number' })
    hl('@float', { link = 'Float' })
    -- }}}

    -- Functions {{{
    hl('@function', { link = 'Function' })
    hl('@function.call', { link = 'Function' })
    hl('@function.builtin', { link = 'Special' })
    hl('@function.macro', { link = 'Macro' })

    hl('@method', { link = 'Function' })
    hl('@method.call', { link = 'Function' })

    hl('@constructor', { link = 'Special' })
    hl('@parameter', { link = 'Identifier' })
    -- }}}

    -- Keywords {{{
    hl('@keyword', { link = 'Keyword' })
    hl('@keyword.function', { link = 'Keyword' })
    hl('@keyword.operator', { link = 'Keyword' })
    hl('@keyword.return', { link = 'Keyword' })

    hl('@conditional', { link = 'Conditional' })
    hl('@repeat', { link = 'Repeat' })
    hl('@debug', { link = 'Debug' })
    hl('@label', { link = 'Label' })
    hl('@include', { link = 'Include' })
    hl('@exception', { link = 'Exception' })
    -- }}}

    -- Types {{{
    hl('@type', { link = 'Type' })
    hl('@type.builtin', { link = 'Type' })
    hl('@type.qualifier', { link = 'Type' })
    hl('@type.definition', { link = 'Typedef' })

    hl('@storageclass', { link = 'StorageClass' })
    hl('@attribute', { link = 'PreProc' })
    hl('@field', { link = 'Identifier' })
    hl('@property', { link = 'Identifier' })
    -- }}}

    -- Identifiers {{{
    hl('@variable', { link = 'Normal' })
    hl('@variable.builtin', { link = 'Special' })

    hl('@constant', { link = 'Constant' })
    hl('@constant.builtin', { link = 'Special' })
    hl('@constant.macro', { link = 'Define' })

    hl('@namespace', { link = 'Include' })
    hl('@symbol', { link = 'Identifier' })
    -- }}}

    -- Text {{{
    hl('@text', { link = 'Normal' })
    hl('@text.strong', { bold = true })
    hl('@text.emphasis', { italic = true })
    hl('@text.underline', { underline = true })
    hl('@text.strike', { strikethrough = true })
    hl('@text.title', { link = 'Title' })
    hl('@text.literal', { link = 'String' })
    hl('@text.uri', { link = 'Underlined' })
    hl('@text.math', { link = 'Special' })
    hl('@text.environment', { link = 'Macro' })
    hl('@text.environment.name', { link = 'Type' })
    hl('@text.reference', { link = 'Constant' })

    hl('@text.todo', { link = 'Todo' })
    hl('@text.note', { link = 'SpecialComment' })
    hl('@text.warning', { link = 'WarningMsg' })
    hl('@text.danger', { link = 'ErrorMsg' })
    -- }}}

    -- Tags {{{
    hl('@tag', { link = 'Tag' })
    hl('@tag.attribute', { link = 'Identifier' })
    hl('@tag.delimiter', { link = 'Delimiter' })
    -- }}}
end

-- Recommended to run this after setup but doesn't seem to have the command
-- registered at time of calling
--
-- cmd('TSUpdate')

return M
