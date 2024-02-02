local M = {}

function M.setup()
    require("hardtime").setup(
        {
            disabled_filetypes = { "qf", "netrw", "NvimTree", "mason", "fugitive", "help" },
            max_time = 5,
        }
    )
end

return M
