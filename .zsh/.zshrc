#!/bin/bash
# {{{ Env
# {{{ Path
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.gem/ruby/2.7.0/bin"
# }}}
# {{{ Locations
export drdot="$HOME/.dot"
export drzsh="$drdot/.zsh"
export drvim="$drdot/.vim"
export drconfig="$drdot/.config"
export drinstaller="$drdot/installers"
export drshare="$HOME/.local/share"
export drtemplate="$drdot/templates"
export drlib="$HOME/mylibrary"
export ZSHDIR="$drzsh" # Required by <something>
# }}}
# {{{ Defaults - $VISUAL, $EDITOR, ...
export VISUAL="nvim"
export EDITOR="nvim"
export VIEWER="zathura"
# export PAGER="most"
# }}}
# {{{ External
source "$drdot/.secret/zotero_envs.zsh"
# }}}
# }}}
# {{{ Aliases
# {{{ Default Commands
alias ls='ls -a --group-directories-first --sort=extension --color=auto'
alias xclip='xclip -selection clipboard'
# }}}
# {{{ Quick files
alias evimrc='cd $drdot && nvim .vim/.vimrc'
alias ezshrc='cd $drdot && nvim .zsh/.zshrc'
alias edot='cd $drdot && nvim'
alias ebib='cd $drlib/bibs && nvim mybib.bib'
# }}}
# {{{ Screen
alias screenright='xrandr --auto && xrandr --output HDMI-2 --right-of eDP-1'
alias screenleft='xrandr --auto && xrandr --output HDMI-2 --left-of eDP-1'
alias screenoff='xrandr --auto && xrandr --output HDMI-2 --off'
# }}}
# {{{ Work setups
alias notebook='cd ~/Desktop/phd/notebook && nvim'
alias nbconvert='jupyter nbconvert'
alias viewblog='cd ~/Desktop/blog && firefox http://127.0.0.1:8080 && python manage.py runserver 8080'
alias ctagpython="find -iname '*.py' -print0 | xargs -0 ctags"

# TODO: Fix directory changing back to home
# }}}
# {{{ Pdf Merge
alias mergepdfs='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf'
# }}}
# {{{ Network
alias networkrefresh='nmcli network off && nmcli network on'
# }}}
# {{{ File management
alias clearswaps='rm ~/.local/share/nvim/swap/*'
# }}}
# }}}
# {{{ History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=1000
# }}}
# {{{ Shell Customization
# {{{ Options
setopt extendedglob     # Enables wildcards
setopt notify           # Enables report of status of background jobs
setopt complete_aliases # Enables completion of aliases

set H+ # Stops history expansion
# https://serverfault.com/questions/208265/what-is-bash-event-not-found?newreg=dfc433ccbc3146eeba6ae7f4e31681dd

# Allows vi like navigation in shell input
bindkey -v
# }}}
# {{{ Zstyle
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' ''
zstyle :compinstall filename '/home/skantify/.zshrc'
# }}}
# {{{ Compinit
# Autoload and call
autoload -Uz compinit promptinit
compinit
promptinit
# }}}
# {{{ Theme
source $drshare/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.dot/.zsh/.p10k.zsh ]] && source ~/.dot/.zsh/.p10k.zsh

# }}}
# {{{ Dir Colors
eval `dircolors ~/.dir_colors`
# }}}
# }}}
# {{{ Functions
datestamp () { echo "$(date -Idate)" }

# Comparisons
equal () { [[ "$1" == "$2" ]]; return }
eq () { equal $1 $2; return }
argc () { equal $1 $2; return }

less () { [[ "$1" -lt "$2" ]]; return }
lt () { less $1 $2; return }

greater () { ! less $1 $2 && ! equal $1 $2; return }
gt () { greater $1 $2; return }

lessequal () { less $1 $2 || equal $1 $2; return}
lte () { lessequal $1 $2; return }

greaterequal () { greater $1 $2 || equal $1 $2; return }
gte () { greaterequal $1 $2; return }

# https://unix.stackexchange.com/questions/411304/how-do-i-check-whether-a-zsh-array-contains-a-given-value
elem () {
    local item=$1
    shift
    for str in "$@"
    do
        equal "$item" "$str" && return 0
    done
    false
}
contained () { elem "$@"; return }
arg () { elem "$@"; return }
helparg() { elem $1 "help" "-h" "--help"; return }
zero () { equal $1 0; return }
one () { equal $1 1; return }
two () { equal $1 2; return }

countlines() { printf "$1" | wc -l; return }
countchars() { printf "$1" | wc -l; return }
countwords() { printf "$1" | wc -l; return }

map() { local f="$1"; shift; for item in "$@"; do "$f" "$item"; done; return }

readable () { [[ -r "$1" ]]; return }
writable () { [[ -w "$1" ]]; return }

# Check if variable, directory, file or symbolic link
isdir () { [[ -d "$1" ]]; return }
isfile () { [[ -f "$1" ]]; return }
issymlink () { [[ -h "$1" ]]; return }

exists () { isdir $1 || isfile $1 || issymlink $1; return }

emptyvar() { [[ -z "$1" ]]; return }
isset () { ! emptyvar $1; return }

emptydir () { [[ ! "$(ls -A $1)" ]]; return }
hasfile () { ! emptydir $1; return }

emptystring() { [[ k ]] }

uniquefile() { ! emptyvar $1 && equal 0 $(printf $1 | wc -l); return }

empty () { emptyvar $1 || (isdir $1 && emptydir $1); return }

array () { declare -a $1 }

# }}}
# {{{ Local Plugins
source "$drzsh/template.zsh"
# }}}
# {{{ Colours
source "$drzsh/colours.zsh"
# }}}
# {{{ Python

# Enable pyenv
eval "$(pyenv init -)"

#https://stackoverflow.com/questions/52540121/make-pipenv-create-the-virtualenv-in-the-same-folder
export PIPENV_VENV_IN_PROJECT="enabled"

alias django='python manage.py'
alias pymode='pymodetemp1="$(pwd)"; pipenv shell; cd $pymodetemp1'
# }}}
