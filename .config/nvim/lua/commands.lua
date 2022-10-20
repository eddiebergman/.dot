local py = require("py")
local util = require("util")
local isinstance = py.isinstance
local join = py.join
local setkey = util.setkey

local self = {}

function self.register(cmd)
    local opts = cmd.opts or {}

    if cmd.name:match("%W") and not cmd.name:match("^%l") then
        error("Command name must be alphanumeric and start with Captial letter\n"..vim.inspect(cmd))
        return
    end

    local parts = {"command!"}
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

    if cmd.key ~= nil then
        local action = "<cmd>"..cmd.name.."<cr>"

        local mode = "n"
        local key = cmd.key

        -- If key is a table then it includes the mode
        if isinstance(key, "dict") then
            mode = opts.key[0]
            key = opts.key[1]
        end

        setkey(mode, key, action)
    end
end

local strip_whitespace = {
    name = "StripTrailingWhitespace",
    cmd = [[exe ':%s@\s\+$@@e']],
    opts = { bang = true },
}

function self.setup()
    self.register(strip_whitespace)
    setkey("<C-f>", ":Telescope commands<cr>")
end

return self
