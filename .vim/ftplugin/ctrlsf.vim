setlocal foldmethod=expr

" from 'help folding;
setlocal foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1

function! Ctrlsf_foldtext()
    let line = getline(v:foldstart)
    return line
endfunction
setlocal foldtext=g:Ctrlsf_foldtext()


