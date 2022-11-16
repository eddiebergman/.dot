local M = {}
local commands = require("commands")

M.python_linters_erf = {
    '%f:%l: %trror: %m', -- mypy
    '%f:%l:%c: %t%n: %m', -- pylint
    '%I%f:%l %m,%C:,%Z%e%n: %m',
    '%-G%.%#' -- ignore everything else
}

function M.populate(cmd, opts)
    local _erf = vim.o.errorformat

    if opts.erf then
        vim.o.errorformat = table.concat(M.python_linters_erf, ",")
    end
    vim.cmd(":AsyncRun -silent -strip -post=Trouble\\ quickfix " .. cmd)
    vim.o.errorformat = _erf
end

local PreCommit = {
    name = "PreCommit",
    cmd = function(_)
        M.populate("pre-commit run --all-files", { erf = M.python_linters_erf })
    end
}

-- Technically this only works for my python stuff as is
local Make = {
    name = "Make",
    cmd = function(e)
        M.populate("make " .. (e.args), { erf = M.python_linters_erf })
    end,
    opts = { nargs="*", }
}

function M.setup()
    commands.register(PreCommit)
    commands.register(Make)
end

return M
