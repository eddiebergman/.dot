local commands = require("commands")

local self = {}

local open_term = {
    name = "Terminal",
    cmd = "bo 10sp | term",
    key = "<C-u>"
}

function self.setup()
    vim.cmd("autocmd TermOpen * startinsert")
    vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")
    commands.register(open_term)
end

return self
