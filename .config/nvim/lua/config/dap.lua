local M = {}

local command = require("util").command

function M.setup()
    vim.cmd("PackerLoad nvim-dap")
    local dap = require("dap")
    local penv = require("util").python_env({
        patterns = { ".venv", ".eddie-venv" }
    })

    local python_path = nil
    if penv ~= nil and penv.python ~= nil then
        python_path = penv.python
    end

    dap.adapters.python = {
        type = "executable",
        command = python_path,
        args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = python_path,
        },
    }
    vim.cmd("au FileType dap-repl lua require('dap.ext.autocompl').attach()")
    require("dapui").setup(

        {
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "",
                    step_back = "",
                    step_into = "",
                    step_out = "",
                    step_over = "",
                    terminate = ""
                }
            },
            element_mappings = {},
            expand_lines = true,
            floating = {
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" }
                }
            },
            force_buffers = true,
            icons = {
                collapsed = "",
                current_frame = "",
                expanded = ""
            },
            layouts = {
                {
                    position = "right",
                    size = 80,
                    elements = {
                        {
                            id = "scopes",
                            size = 0.70
                        },
                        {
                          id = "stacks",
                          size = 0.15
                        },
                        {
                            id = "breakpoints",
                            size = 0.15
                        },
                        -- {
                        --  id = "watches",
                        --  size = 0.25
                        -- }
                    },
                },
                {
                    position = "bottom",
                    size = 9,
                    elements = {
                        {
                            id = "repl",
                            size = 1
                        },
                    },
                },
            },
            mappings = {
                edit = "e",
                expand = { "l", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                repl = "r",
                toggle = "t"
            },
            render = {
                indent = 1,
                max_value_lines = 100
            }
        }
    )

    command({ key = "<leader>b", name = "Breakpoint", cmd = function() require('dap').toggle_breakpoint() end })
    command({ key = "<leader>d", name = "DebugUI", cmd = function() require('dapui').toggle() end })
    command({ key = "<leader>dr", name = "DebugRun", cmd = function() require('dap').continue() end })
    command({ key = "<left>", name = "DebugToHere", cmd = function() require('dap').run_to_cursor() end })
    command({ key = "<right>", name = "DebugNextLine", cmd = function() require('dap').step_over() end })
    command({ key = "<up>", name = "DebugStepOut", cmd = function() require('dap').step_out() end })
    command({ key = "<down>", name = "DebugStepIn", cmd = function() require('dap').step_into() end })
end

return M
