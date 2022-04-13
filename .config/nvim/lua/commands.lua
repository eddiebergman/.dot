local py = require("py")
local join = py.join

local self = {}

function self.register(cmd)
    opts = cmd.opts or {}

    parts = {"command!"}
    if opts.bang then
        table.insert(parts, "-bang")
    end

    if opts.complete ~= nil then
        table.insert(parts, "-complete="..opts.complete)
    end

    table.insert(parts, cmd.name)
    table.insert(parts, cmd.cmd)
    local def = join(parts)

    vim.cmd(def)
end

local strip_whitespace = {
    name = "StripTrailingWhitespace",
    cmd = [[exe ':%s@\s\+$@@e']],
    opts = { bang = true },
}

function self.setup()
    self.register(strip_whitespace)
end

return self
