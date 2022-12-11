local M = {}

function M.setup()
    require("toggleterm").setup({
        direction = "float"
    })
end

return M
