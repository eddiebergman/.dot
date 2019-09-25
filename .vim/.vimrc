"=====================
" Plugin Management
"=====================
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim " Adds to runtime path
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Git
Plugin 'tpope/vim-fugitive'

" Snippets
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Colour Schemes
Plugin 'sainnhe/vim-color-forest-night'

" Gui
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'

" Latex
Plugin 'lervag/vimtex'

" Navigation
Plugin 'ctrlpvim/ctrlp.vim'

" Text manipulation
Plugin 'Townk/vim-autoclose'

call vundle#end()            " required
filetype plugin indent on    " required

"=====================
" Vim Settings
"=====================
syntax on " Turn on Syntax highlighting

set number " Line Numbers

set autowrite " Autowrite file when leaving modified buffer
set wrap " Forces line wrap wrap on end of screen
set modelines=0 " Turns off modelines (vim per file variables)
set scrolloff=10 " Shows X lines before or after cursour (thank god this is a feature)
set backspace=indent,eol,start " Apparently fixes general issues with backspaces on different systems
set smartcase " Search is case-insensitive if is_lowercase(word), else case-sensitive
set showmode " Shows what mode you're in at the end
set showtabline=1 " Shows tab stops in files
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set conceallevel=1
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

setf tex

set termguicolors
colorscheme forest-night

"=====================
" Plugin Config
"=====================
" Snippets
let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>','<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir='~/.vim/snips'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']

" airline gui
let g:airline_theme = 'forest_night'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" vimtex
let g:tex_flavor = 'latex'
" let g:vimtex_view_method = 'evince'
" let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

" Fuzzy find (CtrlP)
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] " Ignore anything it finds in a git ignore
let g:ctrlp_working_path_mode = '' " Only search everything under current working directory

"=====================
" Key maps
"=====================
" Using Kitty Terminal, it mostly uses ctrl+shift+key for its shortcuts
" ---
" Normal
" ---

" Text manip.
nnoremap <leader><space> i<space><esc>          " insert space
nnoremap <leader>o o<esc>                       " Insert line below
nnoremap <leader>O O<esc>                       " Insert line above

" ---
" Command
" ---

" Reload vimrc source (Airline Tabline seems to dissapear after reloading source)
cnoremap <C-l> source ~/.vimrc <bar> AirlineToggle <bar> AirlineToggle

" ---
" Visual
" ---

vnoremap // y/<C-R>"<CR>                        " Search Selected text

" ---
" Unmap
" ---
if mapcheck("<esc>", "n") != ""
    nunmap <esc>
endif
