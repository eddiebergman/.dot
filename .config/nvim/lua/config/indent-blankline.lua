local M = {}

function M.setup()
    require("indent_blankline").setup({
        space_char_blankline = " ",
        char = " ",
        show_current_context = true,
        show_current_context_start = false,
        show_first_indent_level = false,
        context_char = "│",
    })
end

return M
