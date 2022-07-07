local commands = require("commands")
local util = require("util")

local self = {}

function self.run()
    local ft = vim.bo.filetype
    local filepath = vim.fn.expand("%")
    print(filepath)

    if ft == "python" then
        vim.cmd("!python "..filepath)
    end
end

commands.register({
    name = "Run",
    cmd = "lua require('run').run()",
})

function self.setup()

end

return self
