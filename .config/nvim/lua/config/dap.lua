local dap = require('dap')
local values = require('py').values
local M = {}

dap.set_log_level('DEBUG')

local setups = {
    python = function ()
        local python_with_debugpy= '/home/skantify/.pyenv/versions/3.8.6/bin/python'

        local dap_python = require('dap-python')
        dap_python.setup(python_with_debugpy, { include_configs = false })
        dap_python.test_runner = 'pytest'

        dap.configurations.python = dap.configurations.python or {}
        table.insert(dap.configurations.python, {
            type = "python",
            request = "launch",
            name = "Launch file",
            justMyCode = false,
            program = "${file}",
            console = "internalConsole",
        })
        table.insert(dap.configurations.python, {
            type = "python",
            request = "attach",
            name = "Attach remote",
            justMyCode = false,
            host = function()
                local value = vim.fn.input("Host [127.0.0.1]: ")
                if value ~= "" then
                    return value
                end
                return "127.0.0.1"
            end,
            port = function()
                return tonumber(vim.fn.input("Port [5678]: ")) or 5678
            end,
        })
    end
}


function M.setup()
    require('dapui').setup()
    for setup in values(setups) do setup() end
end


return M
