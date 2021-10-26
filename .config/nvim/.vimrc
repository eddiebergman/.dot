" Made to be used as a menu, :setlocal foldmethod=marker
" You may have to do ':set foldmarker={{{,}}}' if you've changed it before
let configdir = stdpath('config')
lua require('plugins')
" {{{ Keymaps
let mapleader = ","
" {{{ Navigation
" Navigate location list for buffer
nnoremap _ :lprev<CR>
nnoremap + :lnext<CR>

" }}}
" {{{ Text

" Start/end of line
nnoremap H ^
nnoremap L $

" Move line up/down
nnoremap <A-k> dd2kp
nnoremap <A-j> ddp

" normal: Surround with ' or " quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" }}}
" {{{ Buffers
nnoremap <leader>bb :buffers<cr>
nnoremap <leader>bq  :bp<bar>sp<bar>bn<bar>bd<CR>
" Maps <leader>x to :bx where x is a buffer number (limit 0-999 , need to see
" if I can restrict buffer numbers used)
for i in range(0, 999)
    exe "nnoremap <leader>b" . i . ' :b' . i . '<cr>' | endfor

nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprev<cr>
" }}}
" {{{ Yank Put

" Yank clipboard
nnoremap <leader>yc "+y

" }}}
" {{{ Searching
" Automatically change to regular expression search
nnoremap / /\v
nnoremap <leader>sr :%s/
vnoremap <leader>sr :s/
" }}}
" {{{ Quick File
nnoremap <silent> <leader>esn :exe "vsp ".configdir."/UltiSnips"<cr>
nnoremap <silent> <leader>eft :exe "vsp ".configdir."/ftplugin"<cr>
nnoremap <silent> <leader>ev  :exe "vsp ".configdir."/.vimrc"<cr>
" For now syntax is just being done in after
nnoremap <silent> <leader>esy :exe "vsp ".configdir."/after"<cr>
nnoremap <leader>sv :exe "source ".configdir."/.vimrc"<cr>

nnoremap <silent> <leader>ez  :exe "vsp ".$ZDOTDIR."/.zshrc"<cr>
" }}}
" {{{ Fold

" Fold Toggle
nnoremap <space> za
nnoremap z<space> zA

" Set fold methods
nnoremap <leader>fmm :setlocal foldmethod=marker<cr>
nnoremap <leader>fmi :setlocal foldmethod=indent<cr>
nnoremap <leader>fme :setlocal foldmethod=expr<cr>
nnoremap <leader>fms :setlocal foldmethod=syntax<cr>
nnoremap <leader>ft :setlocal foldenable!<cr>

" Echo current fold level
nnoremap <leader>fl :echo foldlevel('.')<cr>
" }}}
" {{{ Extra
" Exit insert mode
inoremap jk <esc>
vnoremap jk <esc>
tnoremap jk <c-\><c-n>

nnoremap <leader>h :vert bo help 

" Toggle Highlighting
nnoremap <leader><space> :set hlsearch!<CR>

nnoremap <leader>sp :setlocal spell!<cr>
vnoremap <leader>ck y:r!cksum <<< "<C-r>"" <bar> cut -f 1 -d ' '<CR>

noremap <leader>qf :call asyncrun#quickfix_toggle(20)<cr>

" [z]oom [i]n/[o]ut using tabs
" https://stackoverflow.com/a/53670916/5332072
nmap <leader>zi :tabnew %<CR>
nmap <leader>zo :tabclose<CR>

" }}}
" {{{ Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" }}}
" {{{ Commands
" Silent <shellcmd> ~ Run <shellcmd> silently
command!-nargs=1 Silent
            \ exe ':silent !' . <q-args> 
            \| execute ':redraw!'

" R <shellcmd> ~ Read ouput of <shellcmd> to a temp buffer
" https://vim.fandom.com/wiki/Append_output_of_an_external_command
command! -nargs=* -complete=shellcmd R
            \ new
            \| setlocal buftype=nofile bufhidden=hide noswapfile
            \| r !<args>

" Preview (Not working)
" :command! -complete=file MDpreview
"            \ exe ':silent ! grip -b -silent ' . expand('%')

" }}}
" {{{ Functions
" Return the syntax group that the current word is using
"
" {{{ Quickfix          - <leader>q
" nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_ia_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

augroup filetype_qf
    autocmd!
    " normal: Quickfix next
    autocmd FileType qf :nnoremap <leader>qn :cnext<CR>
    " normal: Quickfix previous
    autocmd FileType qf :nnoremap <leader>qp :cprevious<CR>
augroup END
" }}}
function! CloseBuffIfOpen(bufname)
    if bufwinnr(a:bufname) > 0
      bd a:bufname
    endif
endfunction

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

function! Substr(s1, s2)
    return (stridx(a:s2, a:s1) != -1)
endfunction

" https://stackoverflow.com/questions/4964772/string-formatting-padding-in-vim
function! Pad(s, amt)
    return a:s . repeat(' ',a:amt - len(a:s))
endfunction

function! PrePad(s,amt,...)
    if a:0 > 0
        let char = a:1
    else
        let char = ' '
    endif
    return repeat(char,a:amt - len(a:s)) . a:s
endfunction

" Finds the previous occurence of a regex string
" lnum - current line number
" reg - The regex string to match
function! PrevOccurence(lnum, reg)
    let n = a:lnum - 1
    let last_line = 0
    while n >= last_line
        let n -= 1
        if getline(n) =~? a:reg
            return n
        endif
    endwhile

    return -2
endfunction

" Finds the next occurence of a regex string
" lnum - current line number
" reg - The regex string to match
function! NextOccurence(lnum, reg)
    let n = a:lnum + 1
    let last_line = line('$')
    while n <= last_line
        let n += 1
        if getline(n) =~? a:reg
            return n
        endif
    endwhile

    return -2
endfunction

" }}}
" {{{ Settings
" All globalsettings. Use h: <setting> to find out more
" {{{ Main
set autoindent
set nocp
filetype plugin indent on

set foldmethod=expr
set foldopen-=block
set completeopt=menuone,preview
set nolazyredraw
set nonumber cursorline
set hlsearch incsearch
set wrap
set ttyfast
set scrolloff=10
set autowrite
set modelines=0
set smartcase
set showmode
set colorcolumn=88
set showtabline=1
set list
set listchars=tab:>>,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars=fold:\ ,eob:~
set conceallevel=2
set expandtab
set tabstop=4 softtabstop=2 shiftwidth=4 smarttab smartindent
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitright splitbelow
set diffopt+=vertical
set wildmode=longest,list,full
set wildmenu
set cul

set signcolumn=yes:1


let g:python3_host_prog='/home/skantify/.pyenv/versions/3.8.5/bin/python'

" }}}
" {{{ Folding
set foldtext=MyFoldText()
function! MyFoldText()
    let foldstr = getline(v:foldstart)
    let foldstr = substitute(foldstr, "\s*{{{\s*$", "", "")
    let i = match(foldstr, '\S')
    if i < 3
        return foldstr
    else
        return foldstr[0:i-1]."▶ ".foldstr[i:]
    endif

endfunction

" }}}
" {{{ Insert Mode/ Normal mode identifier
augroup InsertCursor
    autocmd!
    autocmd InsertEnter * exec 'hi CursorLine'.' gui=bold'
    autocmd InsertLeave * exec 'hi CursorLine'.' gui=underline'
augroup END

" }}}
" {{{ Redraw fix for kitty terminal
if &term =~ 'kitty'
  " disable Background Color Erase (BCE)
  set t_ut=
endif
" }}}
" {{{ Paths, Globals
let g:shell = 'kitty'
let g:dotdir = expand('~/Desktop/.dot')
"let g:python3_host_prog= expand("~/.dot/venvs/vim_python_venv/bin")
let g:python_host_prog="~/.pyenv/versions/2.7.17/bin/python2.7"
" }}}
" }}}
" {{{ netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
" }}}
" {{{ Look and Feel
" Should technically make a user defined syntax for this
" {{{ Colour
let s:orange = "%#Special#"
let s:purple = "%#Underlined#"
let s:green = "%#Keyword#"
let s:yellow = "%#Type#"
let s:blue = "%#Identifier#"
let s:cyan = "%#Constant#"
" }}} 
" {{{ Wildignore
" https://sanctum.geek.nz/arabesque/vim-filename-completion/

set wildignore+=*.a,*.o
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn,.venv
set wildignore+=*/__pycache__/*,*/.mypy_cache/*
set wildignore+=*~,*.swp,*.tmp


" }}}
" }}}
lua require('settings').setup()
lua require('colors').setup()
lua require('lsp').setup()
"lua require('tabs').setup()
lua require('debugging').setup()
lua require('statusline').setup()
lua require('git').setup()
lua require('testing').setup()
lua require('filetypes').setup()
lua require('search').setup()
lua require('nav').setup()
lua require('completion').setup()
