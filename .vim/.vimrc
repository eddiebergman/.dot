" Made to be used as a menu, :setlocal foldmethod=marker
" {{{ Plugins
" {{{ Local
" source $drvim/plugin/arxiv_browser.vim
" }}}
" {{{ Vundle
set runtimepath+=~/.vim/bundle/Vundle.vim " Required by Vundle
filetype off " required for Vundle
call vundle#begin()
" {{{ Vundle (Package manager)
    Plugin 'VundleVim/Vundle.vim'
" }}}
" {{{ vimtex (Tools for Tex and Latex)
    Plugin 'lervag/vimtex'
    let g:tex_flavor = 'latex'
    let g:vimtex_quickfix_mode=0
    let g:vimtex_view_method='zathura'
    " let g:Tex_FoldedEnvironments='definition'
    let g:tex_conceal='abdmg'
    let g:Imap_UsePlaceHolders=0
    let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : 'build'
        \}
    let g:vimtex_fold_enabled=1
    let g:vimtex_format_enabled=1
    let g:vimtex_view_forward_search_on_start=0
" }}}
" {{{ tex-conceal (Extra conceal for latex)
    Plugin 'KeitaNakamura/tex-conceal.vim'
" }}}
" {{{ supertab (for help with UltiSnips+ You Complete me
    Plugin 'ervandew/supertab'
" }}}
" {{{ CtrlP (Fuzzy find files)
    Plugin 'ctrlpvim/ctrlp.vim'

    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] 
    let g:ctrlp_working_path_mode = '' " Only search everything under current working directory
" }}}
" {{{ YouCompleteMe (Auto Completion)
    Plugin 'ycm-core/YouCompleteMe'
    " make YCM compatible with UltiSnips (using supertab)
    let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
    let g:SuperTabDefaultCompletionType = '<C-n>'

    let g:ycm_autoclose_preview_window_after_insertion = 1

    "let g:ycm_server_python_interpreter = ''


" }}}
" {{{ UltiSnips (Snippet Engine)
    Plugin 'SirVer/ultisnips'
    let g:UltiSnipsEditSplit = 'vertical'
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsSnippetDirectories=['UltiSnips']
" }}}
" {{{ Syntastic (syntax and linter)
    Plugin 'vim-syntastic/syntastic'

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_mode_map = {
        \ 'mode': 'passive',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': []
    \}
    let g:syntastic_python_checkers=['pylint', 'mypy']
    let g:syntastic_auto_jump = 0
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_aggregate_errors = 1
" }}}
" {{{ Vim fugitive (git integration)
    Plugin 'tpope/vim-fugitive'
" }}}
" {{{ Vim Skeleton (File Skeleton)
"    Plugin 'noahfrederick/vim-skeleton'
" }}}
" {{{ Vim Surround (surround selections)
    Plugin 'tpope/vim-surround'
" }}}
" {{{ CtrlSF (search files)
    Plugin 'dyng/ctrlsf.vim'
    let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
    let g:ctrlsf_auto_preview = 0
    let g:ctrlsf_default_view_mode = 'normal' " normal , compact
    let g:ctrlsf_search_mode = 'async'
    let g:ctrlsf_position = 'left'
    let g:ctrlsf_winsize = '35%'
    let g:ctrlsf_ackprg = 'ack'
" }}}
" {{{ NERDTree (file tree)
    Plugin 'scrooloose/nerdtree'
    let g:NERDTreeWinSize = &columns / 5
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeShowHidden = 1
" }}}
" {{{ Solarized (Colour Theme)
    Plugin 'lifepillar/vim-solarized8'
" }}}
" {{{ tender (Color Theme)
    Plugin 'jacoborus/tender.vim'
" }}}
" {{{ darcula (Color Theme)
    Plugin 'doums/darcula'
" }}}
" {{{ cryslominsa/dark (Color Theme)
    Plugin 'sainnhe/archived-colors'
" }}}
" {{{ Nord (Color Theme)
    Plugin 'arcticicestudio/nord-vim'
" }}}
" {{{ vim-polyglot
    Plugin 'sheerun/vim-polyglot'
" }}}
" {{{ Vim Repeat (enables some repeat)
    Plugin 'tpope/vim-repeat'
" }}}
" {{{ Vim Autoclose (closes delimeters automatically)
    Plugin 'townk/vim-autoclose'
" }}}
" {{{ Vim Local rc (allows project specific vim stuff)
"    Plugin 'embear/vim-localvimrc'
" }}}
" {{{ Gutentags (tag management)
"    Plugin 'ludovicchabant/vim-gutentags'
" }}}
" {{{ vimpyter (Jupyter Notebook)
   " Plugin 'szymonmaszke/vimpyter'
" }}}
" {{{ Python indenting Pep8
    Plugin 'vim-scripts/indentpython.vim'
" }}}
" {{{ Autopep8
    Plugin 'tell-k/vim-autopep8'
    let g:autopep8_max_line_length=80
    let g:autopep8_diff_type='vertical'
    let g:autopep8_aggressive=1
    let g:autopep8_disable_show_diff=1
" }}}
" {{{ fzf
    Plugin 'junegunn/fzf.vim'
" }}}
" {{{ Folding
    Plugin 'tmhedberg/SimpylFold'
    let g:SimpylFold_docstring_preview = 1
" }}}
" {{{ vim-airline (bottom bar)
    Plugin 'vim-airline/vim-airline'
" }}}

call vundle#end()
filetype plugin indent on    " re-enable
" }}}
" }}}
" {{{ Keymaps
let mapleader = ","
" {{{ Text

" Start/end of line
nnoremap H ^
nnoremap L $

" Move line up/down
nnoremap <A-k> dd2kp
nnoremap <A-j> ddp

" normal: Surround with ' or " quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" }}}
" {{{ Buffers
nnoremap <leader>bb :buffers<cr>
nnoremap <leader>bq  :bp<bar>sp<bar>bn<bar>bd<CR>
" Maps <leader>x to :bx where x is a buffer number (limit 0-999 , need to see
" if I can restrict buffer numbers used)
for i in range(0, 999)
    exe "nnoremap <leader>b" . i . ' :b' . i . '<cr>' | endfor

nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprev<cr>
" }}}
" {{{ Yank Put

" Yank clipboard
nnoremap <leader>yc "+y

" }}}
" {{{ Tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tt :tabnew<cr>:terminal<cr>a
" }}}
" {{{ Searching
" normal: Automatically change to regular expression search
nnoremap / /\v
nnoremap <leader>sr :%s/
vnoremap <leader>sr :s/
nnoremap <leader>sg :call SynGroup()<cr>
nnoremap <leader>sf :CtrlSF 
vmap <leader>sfk <Plug>CtrlSFVwordPath
nnoremap <leader>gt :YcmComplete GoTo<cr>
" }}}
" {{{ Quick File
nnoremap <leader>esn  :vsp $drvim/UltiSnips<cr>
nnoremap <leader>eft  :vsp $drvim/ftplugin<cr>
nnoremap <leader>ez   :vsp $drzsh/.zshrc<cr>
nnoremap <leader>ev   :vsp $drvim/.vimrc<cr>
nnoremap <leader>eip  :vsp $HOME/.ipython/profile_default/startup<cr>
nnoremap <leader>esy  :vsp $drvim/syntax/<cr>

nnoremap <leader>sv :source $HOME/.vimrc<cr>

nnoremap <leader>cs :vsp $drdot/cheatsheets/<cr>
" }}}
" {{{ Fold

" Fold Toggle
nnoremap <space> za

" Fold Movement
nnoremap <C-j> zj
nnoremap <C-k> zk

" Set fold methods
nnoremap <leader>fmm :setlocal foldmethod=marker<cr>
nnoremap <leader>fmi :setlocal foldmethod=indent<cr>
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


" }}}
" {{{ Syntastic

nnoremap <leader>sc :SyntasticCheck<CR>
" Stop  the auto error window opening when switching
nnoremap <leader>sx :SyntasticReset<CR> 
" }}}
" {{{ Unmappings
inoremap <esc> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
" }}}
" {{{ Git
nnoremap <leader>gs :vertical bo Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>i
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gl :GcLog!<cr>
vnoremap <leader>gc y:Gwrite<cr>:Gcommit -m "<C-r>"
" }}}
" {{{ NERDTree
nnoremap <leader>nt :NERDTreeToggle<cr>
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

" Hist ~ Shows contents of histfile in a temp buffer
command! -complete=shellcmd Hist
            \ new
            \| setlocal buftype=nofile bufhidden=hide noswapfile
            \| r !cat ~/.histfile

" Preview (Not working)
" :command! -complete=file MDpreview
"            \ exe ':silent ! grip -b -silent ' . expand('%')

" }}}
" {{{ Functions
" Return the syntax group that the current word is using
"
" {{{ Quickfix          - <leader>q
" nnoremap <leader>q :call <SID>QuickfixToggle()<cr>

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
function! CloseBuffIfOpen(bufname)
    if bufwinnr(a:bufname) > 0
      bd a:bufname
    endif
endfunction

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

function! Substr(s1, s2)
    return (stridx(a:s2, a:s1) != -1)
endfunction

" https://stackoverflow.com/questions/4964772/string-formatting-padding-in-vim
function! Pad(s, amt)
    return a:s . repeat(' ',a:amt - len(a:s))
endfunction

function! PrePad(s,amt,...)
    if a:0 > 0
        let char = a:1
    else
        let char = ' '
    endif
    return repeat(char,a:amt - len(a:s)) . a:s
endfunction

" Finds the previous occurence of a regex string
" lnum - current line number
" reg - The regex string to match
function! PrevOccurence(lnum, reg)
    let n = a:lnum - 1
    let last_line = 0
    while n >= last_line
        let n -= 1
        if getline(n) =~? a:reg
            return n
        endif
    endwhile

    return -2
endfunction

" Finds the next occurence of a regex string
" lnum - current line number
" reg - The regex string to match
function! NextOccurence(lnum, reg)
    let n = a:lnum + 1
    let last_line = line('$')
    while n <= last_line
        let n += 1
        if getline(n) =~? a:reg
            return n
        endif
    endwhile

    return -2
endfunction

" }}}
" {{{ Settings
" All globalsettings. Use h: <setting> to find out more
" {{{ Main
set nocompatible
filetype plugin indent on
set autoindent

set nolazyredraw
set number cursorline
set hlsearch incsearch
set wrap
set ttyfast
set scrolloff=10
set autowrite
set modelines=0
set smartcase
set showmode
set colorcolumn=80
set showtabline=1
set list
set listchars=tab:>>,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars=fold:\ 
set conceallevel=2
set expandtab
set tabstop=4 softtabstop=2 shiftwidth=4 smarttab smartindent
set backspace=indent,eol,start " Fixes general issues with backspaces on different systems
set splitright splitbelow
set diffopt+=vertical
set wildmode=longest,list,full
set wildmenu
set cul

" }}}
" {{{ Insert Mode/ Normal mode identifier
"
augroup InsertCursor
    autocmd!
    autocmd InsertEnter * exec 'hi CursorLine'.' cterm=bold'
    autocmd InsertLeave * exec 'hi CursorLine'.' cterm=NONE'
augroup END
" }}}
" {{{ Redraw fix for kitty terminal
if &term =~ 'kitty'
  " disable Background Color Erase (BCE)
  set t_ut=
endif
" }}}
" {{{ Paths, Globals
let g:shell = 'kitty'
let g:dotdir = expand('~/Desktop/.dot')
"let g:python3_host_prog= expand("~/.dot/venvs/vim_python_venv/bin")
let g:python_host_prog="~/.pyenv/versions/2.7.17/bin/python2.7"
" }}}
" {{{ Look and Feel
" Should technically make a user defined syntax for this
" {{{ Colour

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif

"set background=dark
syntax on
colorscheme nord

let s:orange = "%#Special#"
let s:purple = "%#Underlined#"
let s:green = "%#Keyword#"
let s:yellow = "%#Type#"
let s:blue = "%#Identifier#"
let s:cyan = "%#Constant#"
" }}} 
" {{{ Status
set laststatus=2

"set statusline=%!StatusLineFormat()
function! StatusLineFormat()
    "let l:s .= s:orange." | "
    let l:s = "%*"
    let l:s .= s:yellow."ft ".s:orange."%y"
    let l:s .= s:cyan." | "
    let l:s .= s:yellow."branch ".s:orange."%{FugitiveHead()}"
    let l:s .= s:cyan." | "
    let l:s .= s:yellow."Path ".s:orange."%F ".s:orange
    let l:s .= "%*"
    return l:s
endfunction
" }}}
" {{{ Titlebar
set showtabline=2
set tabline=%!TabLineFormat()

" If this is running slowly, maybe preformat string instead of constant
"   concatenation
function! TabLineFormat()
    " Tabs
    " {{{ Tabs
    redir => l:tablist | silent exe ":tabs" | redir end
    let l:tablines = split(l:tablist, "\n")

    let l:tabstrings = []
    let l:activetab= 0
    let l:tabnr = 0
    let l:tabstr = ""
    for line in l:tablines
        if Substr("Tab page", line)
            if l:tabnr != 0 | let l:tabstrings += [l:tabstr] | endif
            let l:tabnr += 1
            let l:tabstr = ""
        else
            " Might have issues with files with a space in it
            let l:fullname = split(l:line, "  ")[-1]
            let l:isterm = Substr("term://", l:fullname)
            let l:modified = (l:line[2] == "+")
            let l:current = (l:line[0] == ">")

            if l:current | let l:activetab = l:tabnr | endif

            let l:flags = join([l:line[2], l:line[0]], "")
            let l:flags = substitute(l:flags, "+", (s:green."+"), "")
            let l:flags = substitute(l:flags, ">", (s:orange.">"), "")
            let l:fname = fnamemodify(l:fullname, ":t")

            if l:current      | let l:tabstr .= l:flags.s:orange.l:fname."  "
            elseif l:modified | let l:tabstr .= l:flags.s:green.l:fname."  "
            else              | let l:tabstr .= l:flags.s:purple.l:fname."  "
            endif
        endif
    endfor

    let l:tabstrings += [l:tabstr]

    let l:tstr = ""
    for i in range(len(l:tabstrings))
        if i + 1 == l:activetab
            let l:tstr .= s:yellow."Tab ".(i+1).s:yellow."|".l:tabstrings[i].s:yellow."| "
        else
            let l:tstr .= s:cyan."Tab ".(i+1)." "
        endif
    endfor
    " }}}
    " {{{ Buffers
    redir => l:buflist | silent exe ":buffers" | redir end

    let l:bstr = s:yellow."Buffers: "
    let l:buffers = split(l:buflist, "\n")
    for line in l:buffers
         let l:bnum = line[0:2]
         let l:flags = line[3:8]
         let l:fpath = split(line[9:-1])[0]
         " May cause issues with file names with spaces
         let l:fname = substitute(fnamemodify(l:fpath, ":t"), '"', '', 'g')
         let l:isterm = Substr("term://", l:fpath)
         let l:current = Substr("%", l:flags)
         let l:active = Substr("a", l:flags)
         let l:modified = Substr("+", l:flags)
         let l:hidden = Substr("h", l:flags)

        if l:current
            let l:bstr .= s:orange." > ".l:fname." ".s:yellow."|"
        "elseif l:active
        "    let l:bstr .= s:yellow."".s:yellow.l:bnum."  ".l:fname." "
        else
            let l:bstr .= s:cyan.l:bnum." ".l:fname." ".s:yellow."|"
        endif

    endfor
    " }}}
    let l:rbstr = substitute(l:bstr, "%#[A-Za-z]*#", "", "g")
    let l:rtstr = substitute(l:tstr, "%#[A-Za-z]*#", "", "g")

    if strchars(l:rbstr) + strchars(l:rtstr) >= &columns
        return l:tstr
    else
        let l:padlength = &columns - strchars(l:rbstr) - strchars(l:rtstr)
        let l:padding = repeat(" ", l:padlength)
        return l:tstr.l:padding.l:bstr
    endif
endfunction

" }}}
" {{{ Wildignore
" https://sanctum.geek.nz/arabesque/vim-filename-completion/

set wildignore+=*.a,*.o
"set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp

" }}}
" {{{ Syntax Highlight groups (Must be at end)
" {{{ Numbering
exec 'hi CursorLineNr cterm=bold ctermbg=NONE'
exec 'hi LineNr cterm=NONE ctermbg=NONE guibg=NONE'
" }}}
" {{{ Fold
exec 'hi Folded cterm=NONE'.
        \' ctermbg=NONE guibg=NONE ctermfg=8'.
        \' guifg=SlateBlue'
" }}}
" {{{ NERDTree
exec 'hi NERDTreeDir gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
exec 'hi NERDTreeFile cterm=italic, gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi NERDTreeLinkFile gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi NERDTreeLinkTarget gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi NERDTreeExecFile gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Constant')), 'fg', 'gui')
exec 'hi NERDTreeBookmarksLeader gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Identifier')), 'fg', 'gui')
exec 'hi NERDTreeBookmarkName gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
exec 'hi NERDTreeBookmarksHeader gui=italic' .
        \' guifg=' . synIDattr(synIDtrans(hlID('Type')), 'fg', 'gui')
exec 'hi NERDTreeBookmark cterm=italic, gui=italic' .
        \' guifg=SlateBlue'
exec 'hi link NERDTreeCWD NERDTreeBookmark'
" }}}
" {{{ Other
exec 'hi VertSplit gui=bold cterm=bold'
        \.' guifg=' . synIDattr(synIDtrans(hlID('Special')), 'fg', 'gui')
        \.' guibg=NONE'
exec 'hi StatusLine '
        \.' guifg=' . synIDattr(synIDtrans(hlID('Special')), 'fg', 'gui')
        \.' guibg=' . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
exec 'hi StatusLineNC '
        \.' guifg=' . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
        \.' guibg=' . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
" . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
exec 'hi SignColumn gui=bold'
        \.' guifg=' . synIDattr(synIDtrans(hlID('Underlined')), 'fg', 'gui')
        \.' guibg=NONE'
exec 'hi Pmenu cterm=NONE'
        \.' ctermbg='.synIDattr(synIDtrans(hlID('Comment')), 'fg', 'cterm') 

" }}}
" }}}
" }}}
" }}}
