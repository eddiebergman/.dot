" Made to be used as a menu, :setlocal foldmethod=marker
" You may have to do ':set foldmarker={{{,}}}' if you've changed it before
let configdir = stdpath('config')
lua require('plugins')

" {{{ Keymaps
let mapleader = ","
" {{{ Navigation
" Navigate location list for buffer
nnoremap _ :lprev<CR>
nnoremap + :lnext<CR>

" }}}
" {{{ Text

" Start/end of line
nnoremap H ^
nnoremap L $

" normal: Surround with ' or " quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" }}}
" {{{ Buffers
nnoremap Q :bp<bar>sp<bar>bn<bar>bd<CR>

nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprev<cr>

nnoremap <C-right> :tabnext<cr>
nnoremap <C-left> :tabprev<cr>
nnoremap TT :tab split<cr>
" }}}
" {{{ Yank Put

" Yank clipboard
nnoremap <leader>yc "+y
vnoremap <leader>yc "+y

" }}}
" {{{ Searching
" Automatically change to regular expression search
nnoremap / /\v
nnoremap <leader>sr :%s/
vnoremap <leader>sr :s/
" }}}
" {{{ Quick File
nnoremap <silent> <leader>esn :exe "vsp ".configdir."/UltiSnips"<cr>
nnoremap <silent> <leader>eft :exe "vsp ".configdir."/ftplugin"<cr>
nnoremap <silent> <leader>ev  :exe "vsp ".configdir."/.vimrc"<cr>
" For now syntax is just being done in after
nnoremap <silent> <leader>esy :exe "vsp ".configdir."/after"<cr>
nnoremap <leader>sv :exe "source ".configdir."/.vimrc"<cr>

nnoremap <silent> <leader>ez  :exe "vsp ".$ZDOTDIR."/.zshrc"<cr>
" }}}
" {{{ Fold

" Fold Toggle
nnoremap <space> za
nnoremap z<space> zA

" Set fold methods
nnoremap <leader>fmm :setlocal foldmethod=marker<cr>
nnoremap <leader>fmi :setlocal foldmethod=indent<cr>
nnoremap <leader>fme :setlocal foldmethod=expr<cr>
nnoremap <leader>fms :setlocal foldmethod=syntax<cr>
nnoremap <leader>ft :setlocal foldenable!<cr>

" Echo current fold level
nnoremap <leader>fl :echo foldlevel('.')<cr>
" }}}
" {{{ Extra
" Exit insert mode
inoremap jk <esc>
vnoremap jk <esc>
tnoremap jk <c-\><c-n>

nnoremap <leader>h :vert bo help 

" Toggle Highlighting
nnoremap <leader><space> :set hlsearch!<CR>

nnoremap <leader>sp :setlocal spell!<cr>
vnoremap <leader>ck y:r!cksum <<< "<C-r>"" <bar> cut -f 1 -d ' '<CR>

noremap <leader>qf :call asyncrun#quickfix_toggle(20)<cr>

" [z]oom [i]n/[o]ut using tabs
" https://stackoverflow.com/a/53670916/5332072
nmap <leader>zi :tabnew %<CR>
nmap <leader>zo :tabclose<CR>

" }}}
" {{{ Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" }}}

" {{{ Commands
" Silent <shellcmd> ~ Run <shellcmd> silently
command!-nargs=1 Silent
            \ exe ':silent !' . <q-args> 
            \| execute ':redraw!'

" R <shellcmd> ~ Read ouput of <shellcmd> to a temp buffer
" https://vim.fandom.com/wiki/Append_output_of_an_external_command
command! -nargs=* -complete=shellcmd R
            \ new
            \| setlocal buftype=nofile bufhidden=hide noswapfile
            \| r !<args>

" Preview (Not working)
" :command! -complete=file MDpreview
"            \ exe ':silent ! grip -b -silent ' . expand('%')

" }}}

" {{{ Settings
set autoindent
set nocp
filetype plugin indent on

set foldmethod=expr
set foldopen-=block
set completeopt=menuone,preview
set nolazyredraw
set nonumber cursorline
set hlsearch incsearch
set wrap
set ttyfast
set scrolloff=10
set autowrite
set modelines=0
set smartcase
set showmode
set colorcolumn=""
set showtabline=1
set list
set listchars=tab:>>,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars=eob:\ ,fold:\ ,foldsep:\ 
set conceallevel=2
set expandtab
set tabstop=4 softtabstop=2 shiftwidth=4 smarttab smartindent
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitright splitbelow
set diffopt+=vertical
set wildmode=longest,list,full
set wildmenu
set cul

set signcolumn=yes:1


let g:python3_host_prog='/home/skantify/.pyenv/versions/3.10.7/bin/python'

" }}}

" {{{ Insert Mode/ Normal mode identifier
augroup InsertCursor
    autocmd!
    autocmd InsertEnter * exec 'hi CursorLine'.' gui=bold,underline'
    autocmd InsertLeave * exec 'hi CursorLine'.' gui=underline'
augroup END
" }}}

" {{{ Paths, Globals
let g:shell = 'kitty'
let g:dotdir = expand('~/Desktop/.dot')
"let g:python3_host_prog= expand("~/.dot/venvs/vim_python_venv/bin")
let g:python_host_prog="~/.pyenv/versions/2.7.17/bin/python2.7"
" }}}

" {{{ Wildignore
" https://sanctum.geek.nz/arabesque/vim-filename-completion/
set wildignore+=*.a,*.o
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn,.venv
set wildignore+=*/__pycache__/*,*/.mypy_cache/*
set wildignore+=*~,*.swp,*.tmp
" }}}

" {{{ Color stuff
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" }}}

lua require('settings').setup()
lua require('lsp.config').setup()
lua require('debugging').setup()
lua require('statusline').setup()
lua require('git').setup()
lua require('testing').setup()
lua require('filetypes').setup()
lua require('search').setup()
lua require('nav').setup()
lua require('completion').setup()
lua require('tree').setup()
lua require("doc").setup()
lua require("commands").setup()
lua require("snippets").setup()
lua require("symbol_tree").setup()
lua require("terminal").setup()
lua require("run").setup()

" Last just to make sure it's king
lua require('colors').setup()
