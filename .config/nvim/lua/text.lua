local M = {}
local util = require("util")

local setkey = util.setkey


function M.setup()
    setkey("v", "r", ":s//g<left><left>")
end

return M
