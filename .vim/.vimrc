" {{{ S Keymaps
" All the key maps for various things
"
" {{{ -i Leaders
" Leader
let mapleader = ","
let localleader = ","
" }}}
" {{{ +s Text Movement

" Go to first character of line
nnoremap H ^

" Go to end of line
nnoremap L $


" }}}
" {{{ +s Text Manipulation

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
" {{{ +s Surrounds
" visual: Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v

" visual: Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v
" }}}
" {{{ +s Quick File

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

" Edit todo
nnoremap <leader>et :vsplit $DOT_DIR/todo.vim<cr>

" Source vimrc
nnoremap <leader>sv :source $HOME/.vimrc<cr>

" }}}
" {{{ +s Fold

" Fold Toggle
nnoremap <space> za

" }}}
" {{{ +s Extra

" Exit insert mode
inoremap jk <esc>

" }}}
" {{{ +s Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" {{{ +s Git

" normal: Open Git Status
nnoremap <leader>Gs :Gstatus<cr>

" normal: 

" }}}
" }}}
" {{{ S Commands
" A selection of commands
"
" {{{ +s External

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
augroup vimcommand_group
        autocmd!
" {{{  -i General

" Automatically write an newely opened file
autocmd BufNewFile * :write

" }}}
" {{{ -i HTML
" Turn off file wrapping for opened HTML files
autocmd BufNewFile *.html setlocal nowrap

" }}}
" {{{  -i Markdown

" }}}
" {{{  -i Python
" Python comment line
autocmd FileType python nnoremap <buffer> <c-/> I#<esc>

" }}}
" {{{  -i Latex

" }}}
" {{{  -i C++

" }}}
" {{{ -i Javascript

" Javascript comment line
autocmd FileType javascript nnoremap <buffer> <c-/> I//<esc>

" }}}
" {{{ -i Vim
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
" {{{ +s Fold bar
" {{{ -f FoldBar - Text to display on fold bar
function! FoldBar()
    let foldline = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let output = strpart(foldline, 0, (winwidth(0)*2)/3)
    return output
endfunction
set foldtext=FoldBar()
" }}}
" }}}
" {{{ -i Status
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
