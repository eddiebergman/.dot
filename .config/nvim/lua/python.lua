local M = {}
local commands = require("commands")
local util = require("util")

local venv_names = {".venv"}
local original_path = ""
local status = ""

function M.status()
    return status
end

function M.venvpath()
    local cwd = vim.fn.getcwd()

    local venvpath = nil
    for _, pattern in ipairs(venv_names) do
        venvpath = cwd.."/"..pattern

        if util.os_exists(venvpath) then
            return venvpath
        end

    end
    return nil

end

function M.venv()

    local venvpath = os.getenv("VIRTUAL_ENV")

    if venvpath == nil then
        local cwd = vim.fn.getcwd()
        for _, pattern in ipairs(venv_names) do
            local path = cwd.."/"..pattern
            if util.os_exists(path) then
                venvpath = path
                break
            end
        end
    end

    if venvpath ~= nil then
        return {
            path = venvpath,
            bin = venvpath.."/bin",
            source = venvpath .."/bin/activate"
        }
    end

    return nil

end

function M.exists()
    return M.venv() ~= nil
end

function M.active()
    return os.getenv("VIRTUAL_ENV") ~= nil
end

function M.activate()
    local venv = M.venv()
    if venv == nil then
        error("No .venv found at "..vim.fn.getcwd())
    end

    original_path = os.getenv("PATH") or ""
    vim.fn.setenv("VIRTUAL_ENV", venv.path)
    vim.fn.setenv("PATH", venv.bin .. ":" .. original_path)

    status = ".venv"

    print("Activated "..venv.path)
end

function M.deactivate()
    vim.fn.setenv("VIRTUAL_ENV", nil)

    if original_path ~= "" then
        vim.fn.setenv("PATH", original_path)
    end

    original_path = ""
    status = ""
end

function M.run(cmd)
    local venv = M.venv()
    if venv ~= nil then
        cmd = "!source " .. venv.source .. "; " .. cmd
        vim.cmd(cmd)
    return
    end

    error("Could not find a virtaul environment to run with")
end

function M.create()
    -- My own .zshenv command
    util.os_exec("pyvenv")
    M.activate()
end

local py = {
    name = "Py",
    cmd = function(e) M.run(e.args) end,
    opts = { nargs = "+", complete = "shellcmd" }
}

local activate = { name = "PyActivate", cmd = function() M.activate() end }

local deactivate = { name = "PyDeactivate", cmd = function() M.deactivate() end }

local pyvenv = { name = "Pyvenv", cmd = function() M.create() end }

function M.setup()
    commands.register(py)
    commands.register(activate)
    commands.register(deactivate)
    commands.register(pyvenv)
end

return M
