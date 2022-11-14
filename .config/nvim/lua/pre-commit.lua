local commands = require("commands")
local M = {}

-- https://github.com/Mike325/nvim/blob/62e5196a1eee36ada7915be183fccf09513e06c8/lua/mappings.lua#L17-L36
M.precommit_efm = {
    '%f:%l: %trror: %m', -- mypy
    '%f:%l:%c: %t%n: %m', -- pylint
    '%-G%.%#' -- ignore everything else
}

function M.precommit()
    local _erf = vim.o.errorformat
    vim.o.errorformat = table.concat(M.precommit_efm, ",")
    vim.cmd(":AsyncRun -silent -strip -post=Trouble\\ quickfix pre-commit run --all-files ")
    vim.o.errorformat = _erf
end

local PreCommit = {
    name = "PreCommit",
    cmd = M.precommit,
}

function M.setup()
    commands.register(PreCommit)
end

return M

