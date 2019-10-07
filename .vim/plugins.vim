set rtp+=~/.vim/bundle/Vundle.vim " Adds to runtime path

" {{{ S Plugin List
" List of plugins to install
"
filetype off " required for Vundle
call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'dyng/ctrlsf.vim'
    Plugin 'scrooloose/nerdtree'

    if ! empty($DESKTOP_ENV)
        Plugin 'ervandew/supertab'
        Plugin 'Valloric/YouCompleteMe'
        Plugin 'SirVer/ultisnips'
        " Plugin 'scrooloose/nerdtree'
        " Plugin 'lervag/vimtex'
    endif

call vundle#end()
filetype on
" }}}
" {{{ S Plugin Config
" For configuring plugins, see Desktop plugins for desktop specific
"
" {{{ +s Desktop plugins
if ! empty($DESKTOP_ENV)
" {{{ -i You Complete Me (Autocompletion)
let g:ycm_key_list_select_completion = ['<C-n>','<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>','<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>' " required for Ultsnips
"
" }}}
" {{{ -i vimtex (Toolds for Tex and Latex)
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
let g:Imap_UsePlaceHolders=0
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMisc=""
" }}}
endif
" }}}
" {{{ -i CtrlP (Fuzzy find files)
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] 
let g:ctrlp_working_path_mode = '' " Only search everything under current working directory
" }}}
" {{{ -i UltiSnips (Snippet Engine)
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir='~/.vim/snips'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'snips']
" }}}
" }}}
