" {{{ S Keymaps
" All the key maps for various things
"
" {{{ i Leaders
" Leader
let mapleader = ","
let localleader = ","
" }}}
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
"
" insert: Uppercase current word
inoremap <c-u> <esc>viwU<esc>ei

" }}}
" {{{ L Surrounds
" visual: Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v

" visual: Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v
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

" Exit insert mode
inoremap jk <esc>

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
nnoremap <leader>Gs :Gstatus<cr>

" normal: Create Git Commit
nnoremap <leader>Gc :Gcommit<cr>

" normal: Open Git Diff
nnoremap <leader>Gd :Gdiff<cr>

" }}}
" }}}
" {{{ S Commands
" A selection of commands
"
" {{{ L External

" Runs a command silently
command!-nargs=1 Silent execute ':silent !' . <q-args> | execute ':redraw!'

" }}}
" }}}
" {{{ S Settings
" All globalsettings
"
set nocompatible
syntax on " Turn on Syntax highlighting
set number relativenumber "Hybrid Line Numbers
set wrap " Forces line wrap wrap on end of screen
set scrolloff=10 " Shows X lines before or after cursour (thank god this is a feature)
set autowrite " Autowrite file when leaving modified buffer
set modelines=0 " Turns off modelines (vim per file variables)
set smartcase " Search is case-insensitive if is_lowercase(word), else case-sensitive
set showmode " Shows what mode you're in the bar
set showtabline=1 " Shows tabs at the top
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set conceallevel=1  " Determines how concealed text should be shown
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitbelow splitright
" setf tex " Causes the tex filetype to trigger
filetype plugin indent on


" }}}
" {{{ S Autocommands
" All the autocommands for different files
"
augroup vimcommand_group
        autocmd!
" {{{ L General

" Automatically write an newely opened file
autocmd BufNewFile * :write

" }}}
" {{{ L HTML
" Turn off file wrapping for opened HTML files
autocmd BufNewFile *.html setlocal nowrap

" }}}
" {{{ L Markdown

" }}}
" {{{ L Python
" Python comment line
autocmd FileType python nnoremap <buffer> <c-/> I#<esc>

" }}}
" {{{ L Latex

" }}}
" {{{ L C++

" }}}
" {{{ L Javascript

" Javascript comment line
autocmd FileType javascript nnoremap <buffer> <c-/> I//<esc>

" }}}
" {{{ L Vim
augroup filetype_vim
    autocmd!
    " Set the fold method
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
augroup END
" }}}
" {{{ S View
" Anything related to how things are presented
"
" {{{ s Fold bar
" {{{ f FoldBar - Text to display on fold bar
function! FoldBar()
    let foldline = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let output = strpart(foldline, 0, (winwidth(0)*2)/3)
    return output
endfunction
set foldtext=FoldBar()
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
" }}}
" {{{ S Vimscript Helpers
" A collection of things to help with vimscript
"

" }}}
" {{{ S Runtime
" Anything to be loaded
"
source $VIM_DIR/plugins.vim
" }}}
" {{{  S Extra
" When you're tired of using the word misc
"
" }}}
