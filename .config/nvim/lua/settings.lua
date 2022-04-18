local self = {}
local util = require("util")
local setkey = util.setkey

function self.set_indent_blankline()

    vim.g.indent_blankline_enabled = true

    -- Use treesitter
    vim.g.indent_blankline_use_treesitter = true

    -- Character to use │
    vim.g.indent_blankline_char = ''
    vim.g.indent_blankline_context_char = '│'

    -- highlights current indent
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_show_current_context_start = false
    vim.g.indent_blankline_show_current_conext_only = true
    vim.g.indent_blankline_context_patterns = {
        "class",
        "^func",
        "method",
        "^if",
        "while",
        "for",
        "with",
        "try",
        "except",
        "arguments",
        --"argument_list",
        "object",
        "dictionary",
        "element",
        "table",
        "tuple"
    }

    -- Only show indent guides for first n indents
    vim.g.indent_blankline_indent_level = 10

    -- Disable the indentation on the first indent
    vim.g.indent_blankline_show_first_indent_level = false
    vim.g.indent_blankline_show_end_of_line = true
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_foldtext = false
end

function self.setup()
    vim.cmd [[ syntax on ]]

    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

    vim.o.showtabline = 2
    vim.o.mouse = "a"

    vim.opt.autowrite = true
    vim.o.number = true
    vim.o.relativenumber = true
    vim.numberwidth = 2

    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_assume_mapped = true
    -- vim.g.copilot_tab_fallback = ""

    -- Start a search/replace
    util.setkey("sr", ":%s/")

    -- Close/open all folds
    util.setkey("FF", ":%foldclose!<cr>")
    util.setkey("F<space>", ":%foldopen!<cr>")

    self.set_indent_blankline()

    -- Somehow not updating properly from plugins file
    require("config/treesitter").setup()
end

return self
