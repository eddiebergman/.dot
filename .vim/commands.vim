" Leader
let mapleader = ","

"
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" O=o=
" O=o=          Normal Mode
" O=o=
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
"

" +=+=          Text
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+

" ==    Movement
" -------------------------
" Go to first character of line
nnoremap H ^
" Go to end of line
nnoremap L $

" == Manipulation
" -------------------------
" Move Line up
nnoremap <leader>_ dd2kp
" Line down
nnoremap <leader>- ddp
" Uppercase current word
nnoremap <c-u> viwU<esc>
" Surround with " " double quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" Surround with ' ' single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
" Uppercase first letter
nnoremap <leader>uf bvU<esc>
" Lowercase first letter
nnoremap <leader>lf bvu<esc>



" +=+=          Quick Files
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Edit Settings
nnoremap <leader>es :vsplit $VIM_DIR/settings.vim<cr>
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

" +=+=          Misc
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Fold/ [unfold]?
nnoremap <space> za

"
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" O=o=
" O=o=          Insert Mode
" O=o=
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
"
" +=+=          Text
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Uppercase current word
inoremap <c-u> <esc>viwU<esc>i

" +=+=          Misc
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Exit insert mode
inoremap jk <esc>

"
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" O=o=
" O=o=          Visual Mode
" O=o=
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
"
" +=+=          Text
" +=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
" Surround selected in " " quotes
vnoremap <leader>" `<i"v'>a"<esc>v
" Surround selected in ' ' quotes
vnoremap <leader>' `<i'v'>a'<esc>v

"
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
" O=o=
" O=o=          Command Mode
" O=o=
" O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=o=O=
"
" Runs a command silently
command!-nargs=1 Silent execute ':silent !' . <q-args> | execute ':redraw!'
