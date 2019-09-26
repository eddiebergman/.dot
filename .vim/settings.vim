syntax on " Turn on Syntax highlighting
set number " Line Numbers
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
set backspace=indent,eol,start " Apparently fixes general issues with backspaces on different systems

set splitbelow
set splitright

set termguicolors

setf tex " Causes the tex filetype to trigger
filetype plugin indent on

if ! empty($DESKTOP_ENV)
    colorscheme forest-night
else
    colorscheme darkblue
endif
