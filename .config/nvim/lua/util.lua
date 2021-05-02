local M = {}

function M.system_name()
    if vim.fn.has("mac") == 1 then
        return "macOS"
    elseif vim.fn.has("unix") == 1 then
        return "Linux"
    elseif vim.fn.has("win32") then
        return "Windows"
    else
        print("system_name(): Unknown System")
        return -1
    end
end

function M.get(a, b)
    if not a == nil then return a else return b end
end

function M.os_exec(cmd)
    local handle = io.popen(cmd .. "; echo $?")
    local os_result = handle:read("*all")
    local cmd_result = os_result:gsub("\n[^\n]*(\n?)$", "%1")
    local exit_status = os_result:match("(%d+)\n?$")
    handle:close()
    return cmd_result, exit_status
end

function M.executable(cmd)
    return vim.call("executable", cmd)
end

return M
