" Made to be used as a menu, :setlocal foldmethod=marker, zM
" {{{ S Keymaps
" All the key maps for various things
"
let mapleader = ","
" {{{ L Text Movement

" normal: Go to first character of line
nnoremap H ^

" normal: Go to end of line
nnoremap L $

" }}}
" {{{ L Text Manipulation

" normal: Move Line up
nnoremap <leader>_ dd2kp

" normal: Line down
nnoremap <leader>- ddp

" normal: Uppercase current word
nnoremap <c-u> viwU<esc>

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
" {{{ L Searching

" normal: Automatically change to regular expression search
nnoremap / /\v

" }}}
" {{{ L Commenting
" normal: Comment Single line
nnoremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
" normal: Uncomment Single line
nnoremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
" normal: Delete comment on line
" nnoremap <silent> <localleader>cd mc0f=escape(b:comment_leader, '\/')d$`c
" }}}
" {{{ L Buffers
" normal: Opens the previous buffer in a vertical split
nnoremap <leader>bp :execute "rightbelow vsplit " . bufname("#")<cr>

" }}}
" {{{ L Surrounds
" visual: Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v

" visual: Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v

" normal: Surround with " " double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

" normal: Surround with ' ' single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" }}}
" {{{ L Quick File

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

" }}}
" {{{ L Fold

" Fold Toggle
nnoremap <space> za

" }}}
" {{{ L Extra
" insert: Exit insert mode
inoremap jk <esc>
" normal: Toggle Highlighting
nnoremap <leader><space> :set hlsearch!<CR>
" }}}
" {{{ L Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" {{{ L Git

" normal: Open Git Status
nnoremap <leader>gs :Gstatus<cr>

" normal: Create Git Commit
nnoremap <leader>gc :Gcommit<cr>i

" normal: Open Git Diff
nnoremap <leader>gd :Gdiff<cr>

" }}}
" }}}
" {{{ S Commands
" A selection of commands
"
" {{{ Silent :Silent <shellcmd> " Runs a command silently

command!-nargs=1 Silent execute ':silent !' . <q-args> | execute ':redraw!'

" }}}
" {{{ Read - :R <shellcmd> " Reads the output of a command to a temp buffer
" https://vim.fandom.com/wiki/Append_output_of_an_external_command

:command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" }}}
" {{{ Hist - :Hist <shellcmd> " Puts the command history into a temp buffer
" Some pointers 
"       - use / to start searching easily, no more grep piping
:command! -complete=shellcmd Hist new | setlocal buftype=nofile bufhidden=hide noswapfile | r !cat ~/.histfile

" }}}
" }}}
" {{{ L Settings
" All globalsettings. Use h: <setting> to find out more
"
set nocompatible
syntax on
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
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set conceallevel=1
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitbelow splitright
filetype plugin indent on
" {{{ Wildignore " Control how file autocompletion works in command mode
" https://sanctum.geek.nz/arabesque/vim-filename-completion/

set wildignore+=*.a,*.o
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" }}}
" }}}
" {{{ S View
" Anything related to how things are presented
"
" {{{ s Fold bar
set foldtext=FoldBar()
" {{{ FoldBar - Text to display on fold bar
function! FoldBar()
    let foldline = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let output = strpart(foldline, 0, (winwidth(0)*2)/3)
    return output
endfunction
" }}}
" }}}
" {{{ s Status
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
" {{{ s Quickfix
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
" {{{  S Extra
" When you're tired of using the word misc
"
" {{{ L Runtime
" Anything to be loaded
"
source $VIM_DIR/plugins.vim
set runtimepath+=$VIM_DIR/ftplugin
set runtimepath+=$VIM_DIR/plugin
" }}}
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
    autocmd BufNewFile * :write

augroup END
" }}}
" }}}
