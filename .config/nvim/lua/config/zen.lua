local M = {}

function M.setup()
    require("zen-mode").setup({
        options = {
            number = false,
            relativenumber = false,
        },
        plugins = {
            kitty = {
                enabled = true,
                font = "+3",
            }
        }
    })
end

return M
