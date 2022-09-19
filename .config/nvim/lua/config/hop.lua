local self = {}
local util = require("util")

function self.setup()
    require("hop").setup({ })

    for _, mode in ipairs({"n", "v"}) do
        util.setkey(mode, "U", "<cmd>HopLineStartBC<cr>")
        util.setkey(mode, "D", "<cmd>HopLineStartAC<cr>")
        util.setkey(mode, "sw", "<cmd>HopPattern<cr>")
        util.setkey(mode, "W", "<cmd>HopPatternCurrentLine<cr>")
    end

    for _, char in ipairs({"c", "y", "d"}) do
        util.setkey(char..'U', char..":HopLineBC<cr>")
        util.setkey(char..'D', char..":HopLineAC<cr>")
        util.setkey(char.."sw", char..":HopPattern<cr>")
        util.setkey(char.."W", char..":HopPatternCurrentLine<cr>")
    end


end

return self
