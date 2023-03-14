local M = {}


function M.setup()
    require("nvim-spotify").setup({
        status = {
            update_interval = 10000,
            format = "  | %s | %t - %a",

        }
    })
end

return M
