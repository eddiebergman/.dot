local M = {}

function M.setup()
    require("Comment").setup({mappings = { baisc = false, extra = false, }})
end

return M
