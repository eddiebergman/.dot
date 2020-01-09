" Made to be used as a menu, :setlocal foldmethod=marker, zM
" {{{ Runtime
" Anything to be loaded, Has to be done first for plugins
"
set runtimepath+=$VIM_DIR/plugin
set runtimepath+=$VIM_DIR/ftplugin
set runtimepath+=$VIM_DIR/after
set runtimepath+=$HOME/.vim/bundle/Vundle.vim " Adds to runtime path
" }}}
" {{{ Plugins
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
    Plugin 'embear/vim-localvimrc'
" }}}
" {{{ Gutentags (tag management)
    Plugin 'ludovicchabant/vim-gutentags'
" }}}
" {{{ Off | ZoomWin (zooms in the current window <Ctrl-w>o)
"    Plugin 'vim-scripts/ZoomWin'
" }}}
" {{{ Vim IPython (Ipython integration)
    Plugin 'ivanov/vim-ipython'
" }}}

call vundle#end()
" }}}
" {{{ Keymaps
" All the key maps for various things
"
let mapleader = ","
" {{{ L Text Movement

" normal: Go to first character of line
nnoremap H ^

" normal: Go to end of line
nnoremap L $

" Move line up
nnoremap <A-k> dd2kp

" Move line down
nnoremap <A-j> ddp

" }}}
" {{{ Text Manipulation

" normal: Move Line up
nnoremap <leader>_ dd2kp

" normal: Line down
nnoremap <leader>- ddp

" normal: Uppercase current word
" nnoremap <c-u> viwU<esc>

" normal: Surround with " " double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" normal: Surround with ' ' single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" normal: Uppercase first letter
nnoremap <leader>uf bvU<esc>

" normal: Lowercase first letter
nnoremap <leader>lf bvu<esc>

" insert: Uppercase current word
inoremap <c-u> <esc>viwU<esc>ei

" }}}
" {{{ Searching

" normal: Automatically change to regular expression search
nnoremap / /\v

nnoremap <leader>sr :%s/

" }}}
" {{{ Commenting
" normal: Comment Single line
nnoremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
" normal: Uncomment Single line
nnoremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
" normal: Delete comment on line
" nnoremap <silent> <localleader>cd mc0f=escape(b:comment_leader, '\/')d$`c
" }}}
" {{{ Line Endings
nnoremap <silent> <leader>ll mvA<C-r>=b:line_ending<cr><esc>`w
" }}}
" {{{ Buffers
" normal: Opens the previous buffer in a vertical split
nnoremap <leader>bp :execute "rightbelow vsplit " . bufname("#")<cr>

" }}}
" {{{ Surrounds
" visual: Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v

" visual: Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v

" normal: Surround with " " double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" normal: Surround with ' ' single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" }}}
" {{{ Quick File

" normal: Edit Settings
nnoremap <leader>es :vsplit $VIM_DIR/settings.vim<cr>

" normal: Edit Command
nnoremap <leader>ec :vsplit $VIM_DIR/commands.vim<cr>

" normal: Edit Plugins
nnoremap <leader>ep :vsplit $VIM_DIR/plugins.vim<cr>

" normal: Edit Filetype specific
nnoremap <leader>eft :vsplit $VIM_DIR/ftplugin<cr>

" normal: Edit Snippet for filetype
nnoremap <leader>esn :UltiSnipsEdit<cr>

" normal: Edit vimrc
nnoremap <leader>ev :vsplit $VIM_DIR/.vimrc<cr>

" normal: Edit todo
nnoremap <leader>et :vsplit $DOT_DIR/todo.vim<cr>

" normal: Source vimrc
nnoremap <leader>sv :source $HOME/.vimrc<cr>

nnoremap <leader>eip :vsplit $HOME/.ipython/profile_default/startup<cr>

" }}}
" {{{ Fold

" Fold Toggle
nnoremap <space> za

" }}}
" {{{ Extra
" Exit insert mode
inoremap jk <esc>
tnoremap jk <c-\><c-n>

" Toggle Highlighting
nnoremap <leader><space> :set hlsearch!<CR>
" }}}
" {{{ Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" {{{ Git

" normal: Open Git Status
nnoremap <leader>gs :Gstatus<cr>

" normal: Create Git Commit
nnoremap <leader>gc :Gcommit<cr>i

" normal: Open Git Diff
nnoremap <leader>gd :Gdiff<cr>

" }}}
" {{{ NERDTree

" normal: Toggle NERDTree
nnoremap <leader>nt :NERDTreeToggle<cr>

" }}}
" {{{ Syntastic
nnoremap <F5> :SyntasticCheck<cr>
" }}}
" {{{ Yank And Put
nnoremap y "yy
nnoremap P "yp
inoremap <C-p> <esc>"ypa
" }}}bottom_levbottom_levelbottom_levebottom_level

" }}}
" {{{ Commands
" A selection of commands
"
" {{{ :Silent <shellcmd> " Runs a command silently

command!-nargs=1 Silent execute ':silent !' . <q-args> | execute ':redraw!'

" }}}
" {{{ :R <shellcmd> " Reads the output of a command to a temp buffer
" https://vim.fandom.com/wiki/Append_output_of_an_external_command

:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" }}}
" {{{ :Hist <shellcmd> " Puts the command history into a temp buffer
"       - use / to start searching easily, no more grep piping
:command! -complete=shellcmd Hist new | setlocal buftype=nofile bufhidden=hide noswapfile | r !cat ~/.histfile

" }}}
" }}}
" {{{ Settings
" All globalsettings. Use h: <setting> to find out more
"
set nocompatible
filetype on

set number relativenumber
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
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitbelow splitright
filetype plugin indent on

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

syntax on
set background=dark
colorscheme solarized8

" {{{ Wildignore " Control how file autocompletion works in command mode
" https://sanctum.geek.nz/arabesque/vim-filename-completion/

set wildignore+=*.a,*.o
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" }}}
" }}}
" {{{ View
" Anything related to how things are presented
"
" {{{ Fold bar
set foldtext=FoldBar()
" {{{ FoldBar - Text to display on fold bar
function! FoldBar()
    let output = strpart(getline(v:foldstart), 0, (winwidth(0)*2)/3)
    return output
endfunction
" }}}
" }}}
" {{{ Status
" The status line displayed at the bottom of the screen
"
set statusline=%f " path to file
set statusline+=\|\|
set statusline+=FileType
set statusline+=%y " Filetype"

set statusline+=%=
set statusline+=%l " Current Line
set statusline+=/
set statusline+=%L " Total Lines
" }}}
" {{{ Quickfix
" normal: Toggle quickfix window
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
" {{{ Extra
" When you're tired of using the word misc
"
" {{{ L Vimscript Helpers
" A collection of things to help with vimscript
"

" }}}
" {{{ L Autocommands
" All the autocommands for different files
"
augroup general_group
    autocmd!

    " Automatically write an newely opened file
    " autocmd BufNewFile * :write

augroup END
" }}}
" }}}
