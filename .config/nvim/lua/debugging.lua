local dap = require('dap')
local M = {}

local _config = {
    mappings = {

        -- Navigating
        {'<F5>', ":lua require('debugging').continue()"},
        {'<F9>', ":lua require'dap'.step_out()<CR>"},
        {'<F10>', ":lua require'dap'.step_back()<CR>"},
        {'<F11>', ":lua require'dap'.step_into()<CR>"},
        {'<F12>', ":lua require'dap'.step_over()<CR>"},

        -- [d]ebug [s]idebar
        {'<leader>dv', ":lua require('debugging').toggle_view()<CR>"},

        -- [d]ebug [b]reakpoint
        {'<leader>db', ":lua require('debugging').toggle_breakpoint()<CR>"},

        -- [d]ebug [r]un
        {'<leader>dc', ":lua require('debugging').continue()<CR>"},

        -- [d]ebug [c]ontinue
        {'<leader>dc', ":lua require('debugging').continue()<CR>"},

        -- [d]ebug [e]expression
        {'<leader>de', ":lua require('debugging').view_value()<CR>"},

        -- [d]ap [r]epl
        {'<leader>dr', ":lua require('debugging').repl()<CR>"},
    },

    -- see :help dap-widgets
    sidebar = {
        winopts = { width = 100 }
    }
}

M.state = {}

function M.setup(config)
    -- setup hotkeys
    require('config/dap').setup()
    config = config or _config
    M.config = config

    if config.mappings then
        require('util').setkeys('n', config.mappings)
    end
end

function M.view_value()
    require('dap.ui.widgets').hover()
end

function M.continue()
    dap.continue()
end

function M.debug()
    M.continue()
    if not M.state.value_window_open then
        M.view()
    end
end

function M.toggle_breakpoint()
    dap.toggle_breakpoint()
end

function M.toggle_view()
    require('dapui').toggle()
end

return M
