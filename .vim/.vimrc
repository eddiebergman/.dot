" Made to be used as a menu, :setlocal foldmethod=marker, zM
" BUG: If not appearing as menu, re-source file to load folding

" {{{ Plugins
set runtimepath+=~/.vim/bundle/Vundle.vim " Required by Vundle
filetype off " required for Vundle
call vundle#begin()
" {{{ Vundle (Package manager)
    Plugin 'VundleVim/Vundle.vim'
" }}}
" {{{ You Complete Me (Autocompletion)
"    Plugin 'Valloric/YouCompleteMe'
    let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>','<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>' " required for Ultsnips
"
" }}}
" {{{ vimtex (Tools for Tex and Latex)
    Plugin 'lervag/vimtex'
    let g:tex_flavor = 'latex'
    let g:vimtex_quickfix_mode=0
    let g:vimtex_view_method='zathura'
    let g:Tex_FoldedEnvironments='definition'
    let g:tex_conceal='abdmg'
    let g:Imap_UsePlaceHolders=0
    let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : 'build'
        \}
" }}}
" {{{ CtrlP (Fuzzy find files)
    Plugin 'ctrlpvim/ctrlp.vim'

    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] 
    let g:ctrlp_working_path_mode = '' " Only search everything under current working directory
" }}}
" {{{ UltiSnips (Snippet Engine)
    Plugin 'SirVer/ultisnips'

    let g:UltiSnipsEditSplit = 'vertical'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    "let g:UltiSnipsSnippetsDir='~/.vim/snips'
    let g:UltiSnipsSnippetDirectories=['UltiSnips']
" }}}
" {{{ Syntastic (syntax and linter)
    Plugin 'vim-syntastic/syntastic'

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_python_checkers=['python', 'pylint']
" }}}
" {{{ Vim fugitive (git integration)
    Plugin 'tpope/vim-fugitive'
" }}}
" {{{ Vim Skeleton (File Skeleton)
    Plugin 'noahfrederick/vim-skeleton'
" }}}
" {{{ Vim Surround (surround selections)
" {{{ CtrlSF (search files)
    Plugin 'dyng/ctrlsf.vim'
" }}}
" {{{ NERDTree (file tree)
    Plugin 'scrooloose/nerdtree'
" }}}
" {{{ Supertab (tab completion
    Plugin 'ervandew/supertab'
" }}}
" {{{ Solarized (Colour Theme)
    Plugin 'lifepillar/vim-solarized8'
" }}}
    Plugin 'tpope/vim-surround'
" }}}
" {{{ Vim Repeat (enables some repeat)
    Plugin 'tpope/vim-repeat'
" }}}
" {{{ Vim Autoclose (closes delimeters automatically)
    Plugin 'townk/vim-autoclose'
" }}}
" {{{ Vim Local rc (allows project specific vim stuff)
"    Plugin 'embear/vim-localvimrc'
" }}}
" {{{ Gutentags (tag management)
"    Plugin 'ludovicchabant/vim-gutentags'
" }}}
" {{{ vimpyter (Jupyter Notebook)
    Plugin 'szymonmaszke/vimpyter'
" }}}
" {{{ jedi-vim (Python useful things)
    Plugin 'davidhalter/jedi-vim'
    let g:jedi#auto_initialization = 0
    let g:python3_host_prog="~/.pyenv/versions/3.6.2/bin/python3.6"
" }}}
" {{{ vim-python-pep8-indent (fixes weird python indenting)
    Plugin 'Vimjas/vim-python-pep8-indent'
" }}}
call vundle#end()
filetype plugin indent on    " re-enable
" }}}

" {{{ Keymaps
let mapleader = ","
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
" {{{ Searching
" normal: Automatically change to regular expression search
nnoremap / /\v
nnoremap <leader>sr :%s/
nnoremap <leader>sg :call SynGroup()<cr>
" }}}
" {{{ Quick File
nnoremap <leader>esn :vert bo $drconfig/nvim/UltiSnips<cr>
nnoremap <leader>eft :vert bo $drvim/ftplugin<cr>

nnoremap <leader>ev :vert bo $drvim/.vimrc<cr>
nnoremap <leader>sv :source $HOME/.vimrc<cr>

nnoremap <leader>eip :vert bo $HOME/.ipython/profile_default/startup<cr>

nnoremap <leader>ez :vert bo $drzsh/.zshrc<cr>
" }}}
" {{{ Fold

" Fold Toggle
nnoremap <space> za

" Set fold methods
nnoremap <leader>fmm :setlocal foldmethod=marker<cr>
nnoremap <leader>fmi :setlocal foldmethod=indent<cr>
nnoremap <leader>fms :setlocal foldmethod=syntax<cr>

" }}}
" {{{ Extra
" Exit insert mode
inoremap jk <esc>
tnoremap jk <c-\><c-n>

cnoremap H vert bo help

" Toggle Highlighting
nnoremap <leader><space> :set hlsearch!<CR>

nnoremap <leader>sc :setlocal spell!<cr>
" }}}
" {{{ Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" {{{ Git
nnoremap <leader>gs :vertical bo Gstatus<cr>
nnoremap <leader>gc :split Gcommit<cr>i
nnoremap <leader>gd :Gdiff<cr>
" }}}
" {{{ NERDTree
nnoremap <leader>nt :NERDTreeToggle<cr>
" }}}
" {{{ Yank And Put
nnoremap y "yy
nnoremap P "yp
inoremap <C-p> <esc>"ypa
" }}}
" }}}

" {{{ Commands

" Silent <shellcmd> ~ Run <shellcmd> silently
command!-nargs=1 Silent
            \ exe ':silent !' . <q-args> 
            \| execute ':redraw!'

" R <shellcmd> ~ Read ouput of <shellcmd> to a temp buffer
" https://vim.fandom.com/wiki/Append_output_of_an_external_command
:command! -nargs=* -complete=shellcmd R
            \ new
            \| setlocal buftype=nofile bufhidden=hide noswapfile
            \| r !<args>

" Hist ~ Shows contents of histfile in a temp buffer
:command! -complete=shellcmd Hist
            \ new
            \| setlocal buftype=nofile bufhidden=hide noswapfile
            \| r !cat ~/.histfile

" Preview (Not working)
" :command! -complete=file MDpreview
"            \ exe ':silent ! grip -b -silent ' . expand('%')

" }}}

" {{{ Functions
" Return the syntax group that the current word is using
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction
" {{{ Quickfix          - <leader>q
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

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
" }}}

" {{{ Settings
" All globalsettings. Use h: <setting> to find out more
" {{{ Main
set nocompatible
filetype plugin indent on
set autoindent

set number
set hlsearch incsearch
set wrap
set scrolloff=10
set autowrite
set modelines=0
set smartcase
set showmode
set showtabline=1
set list
set listchars=tab:>>,extends:›,precedes:‹,nbsp:·,trail:·
set conceallevel=1
set expandtab
set tabstop=4 softtabstop=2 shiftwidth=4 smarttab smartindent
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitright splitbelow
set diffopt+=vertical
" }}}
" {{{ Paths, Globals
let g:shell = 'kitty'
let g:dotdir = expand('~/Desktop/.dot')
" }}}
" {{{ View
" {{{ Status
set statusline=%f " path to file
set statusline+=\|\|
set statusline+=FileType
set statusline+=%y " Filetype"

set statusline+=%=
set statusline+=%l " Current Line
set statusline+=/
set statusline+=%L " Total Lines
" }}}
" }}}
" {{{ Colour
syntax on

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

set background=dark
colorscheme solarized8
" }}}
" {{{ Wildignore
" https://sanctum.geek.nz/arabesque/vim-filename-completion/

set wildignore+=*.a,*.o
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" }}}
" }}}

