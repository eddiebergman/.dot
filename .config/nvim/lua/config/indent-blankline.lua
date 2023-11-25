local M = {}

function M.setup()
    require("ibl").setup(
        {
            enabled = false,
            indent = {
                char = "│",
                smart_indent_cap = true,
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            }
        }
    )
end

return M
