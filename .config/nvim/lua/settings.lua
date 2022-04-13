local self = {}
local util = require("util")

function self.set_indent_blankline()

    vim.g.indent_blankline_enabled = false
    -- Use treesitter
    vim.g.indent_blankline_use_treesitter = true

    -- highlights current indent
    vim.g.indent_blankline_show_current_context = false

    -- Only show indent guides for first 2 indents
    vim.g.indent_blankline_indent_level = 2

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

    vim.opt.autowrite = true

    -- vim.g.copilot_no_tab_map = true
    -- vim.g.copilot_assume_mapped = true
    -- vim.g.copilot_tab_fallback = ""

    util.setkeys("n", {{"sr", ":%s/"}})

    self.set_indent_blankline()
end

return self
