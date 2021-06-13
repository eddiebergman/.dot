local dap = require('dap')
local util = require('util')
local setkeys = util.setkeys

dap.set_log_level('TRACE')

dap.adapters.python = {
  type = 'executable',
  command = '/home/skantify/.pyenv/versions/3.8.6/bin/python',
  args = { '-m', 'debugpy.adapter' }
}

dap.configurations.python = {
    {
    type = 'python',
    request = 'launch',
    name = 'Launch File',

    program = "${file}",
    pythonPath = function()
        local path, status = util.os_exec('which python')
        if status == 0 then
            return path
        else
            print('No "python" in path, exit status: '..tostring(status))
        end
    end
    }
}

mappings = {
    {'<F5>', ":lua require'dap'.continue()<CR>"},

    {'<F9>', ":lua require'dap'.step_out()<CR>"},
    {'<F10>', ":lua require'dap'.step_into()<CR>"},

    {'<F11>', ":lua require'dap'.step_back()<CR>"},
    {'<F12>', ":lua require'dap'.step_over()<CR>"},

    {'<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>"},
    {'<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"},
    {'<leader>lp', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"},

    {'<leader>dr', ":lua require'dap'.repl.open()<CR>"},
    --{'<leader>dl', ":lua require'dap'.run_last()<CR>"},
}
setkeys('n', mappings)
