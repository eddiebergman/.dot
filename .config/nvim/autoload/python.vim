" {{{ Format Diff
" There was a problem in that this file is reloaded for the new buffer
" before the current function call returns, have to add a recursive
" gaurd

function! python#StyleDiff(style)
    " Check yapf is installed, exit if not
    exec 'silent !pip list | grep yapf'
    if v:shell_error
        echo 'yapf python module not available, are you in virtual env?'
        return
    endif

    " Set diff on current buffer
    diffthis
    let l:current_file_path = expand('%:p')

    " Open new vspilt with the formatted code diffed
    vnew
    setlocal buftype=nofile bufhidden=wipe noswapfile
    exec 'r !python3 -m yapf '.l:current_file_path.' --style '.a:style
    setlocal filetype=python
    diffthis
endfunction
" }}}

