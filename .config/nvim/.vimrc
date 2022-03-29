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
nnoremap Q :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprev<cr>

nnoremap <C-right> :tabnext<cr>
nnoremap <C-left> :tabprev<cr>
nnoremap TT :tab split<cr>
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
set colorcolumn=""
set showtabline=1
set list
set listchars=tab:>>,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars=eob:\ ,fold:\ 
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
"
"{{{
 "if &term =~ 'kitty'
  " disable Background Color Erase (BCE)
  "set t_ut=
"endif
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
" }}}
" {{{ Color stuff
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" }}}
" }}}

lua require('settings').setup()
lua require('lsp.config').setup()
"lua require('tabs').setup()
lua require('debugging').setup()
lua require('statusline').setup()
lua require('git').setup()
lua require('testing').setup()
lua require('filetypes').setup()
lua require('search').setup()
lua require('nav').setup()
lua require('completion').setup()
lua require('tree').setup()
lua require("doc").setup()
lua require("term").setup()
" Last just to make sure it's king
lua require('colors').setup()
