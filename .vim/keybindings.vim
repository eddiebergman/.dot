" Leader
let mapleader = ","

" ===========================
" Normal
" ===========================

" -----
" Text Manipulation
" -----
" Line up
nnoremap <leader>_ dd2kp
" Line down
nnoremap <leader>- ddp
" Fold/ [unfold]?
nnoremap <space> za
" Uppercase current word
nnoremap <c-u> viwU<esc>

" -----
" Edit Settings
nnoremap <leader>es :vsplit $VIM_DIR/settings.vim<CR>
" Edit Keybindings
nnoremap <leader>ek :vsplit $VIM_DIR/keybindings.vim<CR>
" Edit Commands
nnoremap <leader>ec :vsplit $VIM_DIR/commands.vim<CR>
" Edit Plugins
nnoremap <leader>ep :vsplit $VIM_DIR/plugins.vim<CR>
" Edit Filetype specific
nnoremap <leader>eft :vsplit $VIM_DIR/ftplugin<CR>
" Edit Scratch (for quick testing)
nnoremap <leader>eS :vsplit $VIM_DIR/scratch.vim<CR>
" Edit vimrc
nnoremap <leader>ev :vsplit $VIM_DIR/.vimrc<CR>
" Source vimrc
nnoremap <leader>sv :source $HOME/.vimrc<CR>

" ======
" Insert
" ======

" Uppercase current word
inoremap <c-u> <esc>viwU<esc>i

" ======
" Visual
" ======

