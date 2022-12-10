local M = {}

function M.setup()
    require("indent_blankline").setup({
        space_char_blankline = " ",
        indent_blankline_char = "⎸",
        show_current_context = true,
        show_current_context_start = false,
    })
end

return M
