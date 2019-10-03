" Leader
let mapleader = ","

" ===========================
" Normal Mode
" ===========================
" Text Navigation
" ---------------------------
" Go to first character of line
nnoremap H ^
" Go to end of line
nnoremap L $

" Text Manipulaton
" ----------------------------
" Line up
nnoremap <leader>_ dd2kp
" Line down
nnoremap <leader>- ddp
" Uppercase current word
nnoremap <c-u> viwU<esc>
" Surround with " " double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" Surround with ' ' single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel



" Quick vimrc editting
" ----------------------------
" Edit Settings
nnoremap <leader>es :vsplit $VIM_DIR/settings.vim<cr>
" Edit Keybindings
nnoremap <leader>ek :vsplit $VIM_DIR/keybindings.vim<cr>
" Edit Commands
nnoremap <leader>ec :vsplit $VIM_DIR/commands.vim<cr>
" Edit Plugins
nnoremap <leader>ep :vsplit $VIM_DIR/plugins.vim<cr>
" Edit Filetype specific
nnoremap <leader>eft :vsplit $VIM_DIR/ftplugin<cr>
" Edit Snippet for filetype
nnoremap <leader>esn :UltiSnipsEdit<cr>
" Edit vimrc
nnoremap <leader>ev :vsplit $VIM_DIR/.vimrc<cr>
" Source vimrc
nnoremap <leader>sv :source $HOME/.vimrc<cr>

" Folding
" ---------------------------
" Fold/ [unfold]?
nnoremap <space> za


" ===========================
" Insert Mode
" ===========================
" Text Manipulation
" ----------------------------
" Uppercase current word
inoremap <c-u> <esc>viwU<esc>i

" Misc
" ---------------------------
" Exit insert mode
inoremap jk <esc>
" ===========================
" Visual Mode
" ===========================
" Text Manipulation
" ---------------------------
" Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v
" Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v
