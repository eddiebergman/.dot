local M = {}

function M.setup()
    local notify = require("notify")
    notify.setup({ render = "compact", top_down = false })
    vim.notify = notify
end

return M
