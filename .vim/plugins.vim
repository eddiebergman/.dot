set rtp+=~/.vim/bundle/Vundle.vim " Adds to runtime path
filetype off " required for Vundle

" =======
" Plugins
" =======

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'Townk/vim-autoclose' !Caused Issue with YouCompleteMe
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'dyng/ctrlsf.vim'

if ! empty($DESKTOP_ENV)
Plugin 'ervandew/supertab'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'

"Plugin 'lervag/vimtex'

"Plugin 'sainnhe/vim-color-forest-night'
endif

call vundle#end()

" =============
" Plugin Config
" =============

" Fuzzy find (CtrlP)
" Ignore anything it finds in a git ignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] 
let g:ctrlp_working_path_mode = '' " Only search everything under current working directory

if ! empty($DESKTOP_ENV)
" YouCompleteMe auto complete
let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>','<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>' " required for Ultsnips

" Ultisnips snippets
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
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
let g:Imap_UsePlaceHolders=0
" http://vim-latex.sourceforge.net/documentation/latex-suite.html#latex-folding
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
endif
