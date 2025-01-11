local M = {}

local command = require("util").command

M.last = nil

local function dap_keymap()
    command({
        key = "<leader>b",
        name = "Breakpoint",
        cmd = function()
            require("dap").toggle_breakpoint()
        end,
    })
    command({
        key = "<leader>D",
        name = "DebugUI",
        cmd = function()
            require("dapui").toggle()
        end,
    })
    command({
        key = "<leader>dr",
        name = "DebugRun",
        cmd = function()
            require("dap").continue()
        end,
    })
    command({
        key = "<leader>dl",
        name = "DebugLast",
        cmd = function()
            require("dap").run_last()
        end,
    })
    command({
        key = "<leader>ds",
        name = "DebugShowHover",
        cmd = function()
            require("dap.ui.widgets").hover()
        end,
    })
    command({
        key = "<leader>dt",
        name = "DebugTerminate",
        cmd = function()
            require("dap").terminate()
        end,
    })
    command({
        key = "<leader>dR",
        name = "DebugRestart",
        cmd = function()
            require("dap").restart()
        end,
    })
    command({
        key = "<left>",
        name = "DebugToHere",
        cmd = function()
            require("dap").run_to_cursor()
        end,
    })
    command({
        key = "<right>",
        name = "DebugNextLine",
        cmd = function()
            require("dap").step_over()
        end,
    })
    command({
        key = "<up>",
        name = "DebugStepOut",
        cmd = function()
            require("dap").step_out()
        end,
    })
    command({
        key = "<down>",
        name = "DebugStepIn",
        cmd = function()
            require("dap").step_into({
                steppingGranularity = "instruction",
                askForTargets = true,
            })
        end,
    })
end

function M.setup()
    vim.cmd("PackerLoad nvim-dap")
    local dap = require("dap")
    local penv = require("util").python_env({
        patterns = { ".venv", ".eddie-venv" },
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
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = {
                "--port",
                "${port}",
                -- "--liblldb", "/usr/lib/liblldb.so",
                "--settings",
                vim.json.encode({
                    showDisassembly = "auto",
                    dereferencePointers = false,
                    suppressMissingSourceFiles = false,
                    sourceLanguages = { "rust", "zig" },
                }),
            },
        },
    }

    dap.configurations.zig = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = "${workspaceFolder}/zig-out/bin/${workspaceFolderBasename}",
            stopOnEntry = false,
            args = {},
        },
    }

    dap.adapters.rust = dap.adapters.codelldb
    dap.configurations.rust = {
        {
            type = "rust",
            request = "launch",
            name = "main",
            program = function()
                local metadata_json =
                    vim.fn.system("cargo metadata --format-version 1 --no-deps")
                local metadata = vim.fn.json_decode(metadata_json)
                local target_name = metadata.packages[1].targets[1].name
                local target_dir = metadata.target_directory
                return target_dir .. "/debug/" .. target_name
            end,
            stopOnEntry = false,
            showDisassembly = "never",
            dereferencePointers = false,
            suppressMissingSourceFiles = false,
            sourceLanguages = { "rust" },
            -- https://github.com/vadimcn/codelldb/issues/204#issuecomment-1113981923
            preRunCommands = {
                [[script lldb.debugger.HandleCommand('settings set target.source-map /rustc/{} "{}/lib/rustlib/src/rust"'.format(os.popen('rustc --version --verbose').read().split('commit-hash: ')[1].split('\n')[0].strip(), os.popen('rustc --print sysroot').readline().strip()))]],
            },
        },
        {
            type = "rust",
            request = "launch",
            name = "cli",
            console = "integratedTerminal",
            cwd = "${workspaceFolder}",
            args = function()
                local metadata_json =
                    vim.fn.system("cargo metadata --format-version 1 --no-deps")
                local metadata = vim.fn.json_decode(metadata_json)
                local target_name = metadata.packages[1].targets[1].name
                local args = nil
                vim.ui.input(
                    { prompt = target_name .. " ", completion = "file" },
                    function(input)
                        print(input)
                        args = vim.split(input, " ")
                    end
                )
                print(vim.inspect(args))
                return args
            end,
            program = function()
                local metadata_json =
                    vim.fn.system("cargo metadata --format-version 1 --no-deps")
                local metadata = vim.fn.json_decode(metadata_json)
                local target_name = metadata.packages[1].targets[1].name
                local target_dir = metadata.target_directory
                return target_dir .. "/debug/" .. target_name
            end,
            stopOnEntry = false,
            showDisassembly = "never",
            dereferencePointers = false,
            suppressMissingSourceFiles = false,
            sourceLanguages = { "rust" },
            -- https://github.com/vadimcn/codelldb/issues/204#issuecomment-1113981923
            preRunCommands = {
                [[script lldb.debugger.HandleCommand('settings set target.source-map /rustc/{} "{}/lib/rustlib/src/rust"'.format(os.popen('rustc --version --verbose').read().split('commit-hash: ')[1].split('\n')[0].strip(), os.popen('rustc --print sysroot').readline().strip()))]],
            },
        },
    }
    vim.cmd("au FileType dap-repl lua require('dap.ext.autocompl').attach()")
    require("dapui").setup({
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
                terminate = "",
            },
        },
        element_mappings = {},
        expand_lines = true,
        floating = {
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        force_buffers = true,
        icons = {
            collapsed = "|",
            current_frame = "*",
            expanded = ">",
        },
        layouts = {
            {
                position = "right",
                size = 80,
                elements = {
                    {
                        id = "scopes",
                        size = 0.70,
                    },
                    {
                        id = "stacks",
                        size = 0.15,
                    },
                    {
                        id = "breakpoints",
                        size = 0.15,
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
                        size = 1,
                    },
                },
            },
        },
        render = {
            indent = 1,
            max_value_lines = 100,
        },
    })

    vim.api.nvim_set_hl(0, "DapStoppedLinehl", { bg = "#555530" })
    vim.fn.sign_define(
        "DapStopped",
        { text = ">", texthl = "Error", linehl = "DapStoppedLinehl", numhl = "" }
    )

    require("nvim-dap-virtual-text").setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, buf, stackframe, node, options)
            if options.virt_text_pos == "inline" then
                return " = " .. variable.value
            else
                return variable.name .. " = " .. variable.value
            end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        virt_text_pos = "eol", -- vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

        -- experimental features:
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    })
    dap_keymap()
end

return M
