local self = {}

function self.setup()
    vim.g.netrw_liststyle = 0

    vim.cmd([[
        nmap <C-h> <Plug>VinegarUp
        nnoremap <buffer> - -
        augroup Treehotkeys
            au!
            au FileType netrw nmap <buffer> <c-l> 
        augroup END
    ]])

end

return self
