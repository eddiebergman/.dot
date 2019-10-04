set nocompatible
en
" {{{ Section: Runtime
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
source $VIM_DIR/plugins.vim
source $VIM_DIR/settings.vim
source $VIM_DIR/commands.vim
" }}}

" Leader
let mapleader = ","
let localleader = ","
" {{{  Functions
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" {{{ VimNeatFoldTex - Controls how our fold text looks
function! VimNeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart
    ". repeat(foldchar, v:foldlevel*2)
    ". repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" }}}
" {{{  NextClosedFold - Navigates to the next fold in either the 'j' or 'k'direction
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
" }}}
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" }}} end Functions
" {{{  Autocommands
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
augroup vimcommand_group
        autocmd!
" {{{  General
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Automatically write an newely opened file
autocmd BufNewFile * :write

" }}}
" {{{  HTML
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Turn off file wrapping for opened HTML files
autocmd BufNewFile *.html setlocal nowrap

" }}}
" {{{  Markdown
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" }}}
" {{{  Python
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Python comment line
autocmd FileType python nnoremap <buffer> <c-/> I#<esc>

" }}}
" {{{  Latex
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" }}}
" {{{  C++
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" }}}
" {{{  Javascript
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Javascript comment line
autocmd FileType javascript nnoremap <buffer> <c-/> I//<esc>

" }}}
" {{{  Vim
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
augroup filetype_vim
    autocmd!
    " Set the fold method
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
augroup END
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" }}} end Autocommands
" {{{  Normal Mode
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" {{{  Text
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" {{{  Movement
" -------------------------

" Go to first character of line
nnoremap H ^

" Go to end of line
nnoremap L $

" Got to the above fold
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>

" Got to the below fold
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>

" }}}
" {{{  Manipulation
" -------------------------

" Move Line up
nnoremap <leader>_ dd2kp

" Line down
nnoremap <leader>- ddp

" Uppercase current word
nnoremap <c-u> viwU<esc>

" Surround with " " double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" Surround with ' ' single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" Uppercase first letter
nnoremap <leader>uf bvU<esc>

" Lowercase first letter
nnoremap <leader>lf bvu<esc>

" }}}
" }}}
" {{{  Quick Edit
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" Edit Settings
nnoremap <leader>es :vsplit $VIM_DIR/settings.vim<cr>

" Edit Command
nnoremap <leader>ec :vsplit $VIM_DIR/commands.vim<cr>

" Edit Plugins
nnoremap <leader>ep :vsplit $VIM_DIR/plugins.vim<cr>

" Edit Filetype specific
nnoremap <leader>eft :vsplit $VIM_DIR/ftplugin<cr>

" Edit Snippet for filetype
nnoremap <leader>esn :UltiSnipsEdit<cr>

" Edit vimrc
nnoremap <leader>ev :vsplit $VIM_DIR/.vimrc<cr>

" Source vimrc
nnoremap <leader>sv :source $HOME/.vimrc<cr>

" }}}
" {{{  Misc
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" Fold Toggle
nnoremap <space> za

" }}}
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" }}} end Normal Mode
" {{{  Insert Mode
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" {{{  Text
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" Uppercase current word
inoremap <c-u> <esc>viwU<esc>ei

" }}}
" {{{  Misc
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" Exit insert mode
inoremap jk <esc>

" }}}
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" }}} end Insert Mode
" {{{  Visual Mode
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" {{{  Text
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v

" Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v

" }}}
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" }}} end Visual Mode
" {{{  Command Mode
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=

" Runs a command silently
command!-nargs=1 Silent execute ':silent !' . <q-args> | execute ':redraw!'

" }}} end Command Mode
" {{{  Operator Mapsk
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=

" Some text with ( and (some more)
onoremap in( :<c-u>normal! f( vi( <cr>

" }}} end Operator Mapsk
" {{{  Extra
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" {{{  Unmappings
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" }}} end Extra"
