local self = {}

local util = require('util')

function self.setup()
    util.setkeys('n', {
        {'tt', ':UltestNearest<cr>:UltestSummaryOpen<cr>'},
        {'T', ':Ultest<cr>:UltestSummaryOpen<cr>'},
        {'to', ':call ultest#output#jumpto()<cr>'},
    })
    vim.g.icons = true
    vim.g.ultest_max_threads = 2
    vim.g.ultest_output_on_run = true
    vim.g.ultest_output_on_line = false
    vim.g.ultest_use_pty = true
    vim.g.ultest_virtual_text = false
    vim.g.ultest_pass_sign = "●"
    vim.g.ultest_running_sign = "●"
    vim.g.ultest_fail_sign = "●"
    vim.g.ultest_pass_text = "| ● Passed |"
    vim.g.ultest_running_text = "| ● Running |"
    vim.g.ultest_fail_text = " | ● Failed |"
    vim.g.ultest_show_in_file = true

    -- x
    vim.g.ultest_output_min_height = 2

    vim.cmd([[let test#python#pytest#options = "--no-header --disable-warnings --code-highlight=yes -q"]])

    vim.cmd([[
    augroup UltestRunner
        au!
        au BufWritePost * UltestNearest
    augroup END
    ]])
end

return self

