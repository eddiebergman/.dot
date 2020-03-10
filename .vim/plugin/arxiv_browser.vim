
function! s:ArxivView()

python3 << ENDPY
import vim

def myf():
    vim.command("echom 'worked'")

myf()
ENDPY

" edit Arxiv
" setlocal bufhidden=hide buftype=nofile noswapfile buflisted
"exe "0r $HOME/temp"
"setlocal nomodifiable
"exe "python3 myf()"
endfunction

nnoremap <leader>ax :ArxivView<CR>

command! -nargs=0 ArxivView
    \  call s:ArxivView()


