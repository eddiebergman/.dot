local M = {}

function M.setup()
    local notify = require("notify")
    notify.setup({ render = "compact", })
    vim.notify = notify
end

return M
