local py = require("py")
local util = require("util")
local isinstance = py.isinstance
local setkey = util.setkey

local self = {}

function self.register(cmd)
    local opts = cmd.opts or {}

    if cmd.name:match("%W") and not cmd.name:match("^%l") then
        error("Command name must be alphanumeric and start with Captial letter\n"..vim.inspect(cmd))
        return
    end

    vim.api.nvim_create_user_command(cmd.name, cmd.cmd, opts)

    if cmd.key ~= nil then
        local action = "<cmd>"..cmd.name.."<cr>"

        local mode = "n"
        local key = cmd.key

        -- If key is a table then it includes the mode
        if isinstance(key, "dict") then
            mode = key[1]
            key = key[2]
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
