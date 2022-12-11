local M = {}
local signs = require("signs")

function M.setup()
    require("notify").setup({
        background_colour = "#000000",

        -- Animation style (see below for details)
        stages = "fade_in_slide_out",

        -- Default timeout for notifications
        timeout = 4000,

        -- Icons for the default Neovim + notify.nvim style
        icons = {
            ERROR = signs.error,
            WARN = signs.wanr,
            INFO = signs.info,
            HINT = signs.hint,
        },
        top_down = false,
    })
    vim.notify = require("notify")
end

return M
