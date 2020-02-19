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
export ZSHDIR="$drzsh" # Required by <something>
# }}}
# {{{ Defaults - $VISUAL, $EDITOR, ...
export VISUAL="nvim"
export EDITOR="nvim"
# export PAGER="most"
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
# }}}
# {{{ Screen
alias screenright='xrandr --auto && xrandr --output HDMI-2 --right-of eDP-1'
alias screenleft='xrandr --auto && xrandr --output HDMI-2 --left-of eDP-1'
alias screenoff='xrandr --auto && xrandr --output HDMI-2 --off'
# }}}
# {{{ Work setups
alias dhaskell='cd ~/Desktop/haskell && stack ghci'
alias dpython='cd ~/Desktop/python && pipenv shell'
alias notebook='cd ~/Desktop/phd/notebook && nvim'
alias nbconvert='jupyter nbconvert'
alias viewblog='cd ~/Desktop/blog && firefox http://127.0.0.1:8080 && python manage.py runserver 8080'
alias django='python manage.py'
# TODO: Fix directory changing back to home
alias pymode='pymodetemp1="$(pwd)" && pipenv shell && cd $pymodetemp1'
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

# Equality between strings, change to strequal if equal is an issue
equal () { [[ "$1" == "$2" ]]; return }

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
isarg () { elem "$@" }
contained () { elem "$@" }

# Strips prepended path, Example: /home/skantify/Desktop -> Desktop
strippath () { stripped=${1##*/}; echo "$stripped" }

# Check if var set or if dir, file, symlink exists
isset () { [[ -z "$1" ]]; return }
isdir () { [[ -d "$1" ]]; return }
isfile () { [[ -f "$1" ]]; return }
issymlink () { [[ -h "$1" ]]; return }

# Check if variable, directory, file or symbolic link
exists () { isset $1 && isdir $1 && isfile $1 && issymlink $1; return }

# Check if exists and can read, write
readable () { exists $1 && [[ -r "$1" ]];  return }
writable () { exists $1 && [[ -w "$2" ]]; return }



# }}}
# {{{ My plugins
source "$drzsh/template.zsh"
# }}}
# {{{ On Startup
eval "$(pyenv init -)"
# pipenv shell
# clear
# }}}
