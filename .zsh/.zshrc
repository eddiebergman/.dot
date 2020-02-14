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
export ZSHDIR="$drzsh" # Required by <something>
# }}}
# {{{ Defaults - $VISUAL, $EDITOR, ...
export VISUAL="nvim"
export EDITOR="nvim"
eval "$(pyenv init -)"
# export PAGER="most"
# }}}
# }}}
# {{{ Modes
# TODO: Fix directory changing back to home
alias pymode='pymodetemp1="$(pwd)" && pipenv shell && cd $pymodetemp1'
# }}}
# {{{ Aliases
# {{{ Default Parameters
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
mapkeys () {
    echo "${!1[@]}"
}
mapvalues () {
    local -n rmap=$1
    echo "${rmap[@]}"
}
# mput <map> <key> <value>
mput () {
    local -n rmap=$1;
    rmap[$2]="$3"
    return $?
}

# mfind <map> <key>
function mfind {
    local -n rmap=$1;

    # key not found
    [[ -z "${rmap[$2]}" ]] && return 1;

    # key found
    echo "${rmap[$2]}" && return 0
}
# }}}
# {{{ doc <name> | docadd <name> <url>
typeset -A mapdoc=([k1]="v1")

# }}}
# {{{ template <dir> <template> {template params}

# template
# Creates a template of various descriptions in the current or optionally
# specified directory
#
# $1 - template name
# $2 - [optiona] destination
template () {
    if [[ -z $1 ]] || [[ -z $2 ]] || [[ $1 == "--help" ]] then
        echo "Usage: template <destination> <template> [template parameters]

            Example:

                \$ template . note mynotename

                Creates a template latex note in the current directory with
                the name 'mynotename'.

            Available templates:

            note [notename]
                A latex note, additionaly links a preamble and creates
                a folder 'build' for use with 'vimtex', a plugin for vim.
            "
    else
        if [[ ! -d "$1" ]] then echo "$1 is not a directory." 
        else
            case "$2" in
                note) template_note $* ;;
                *) echo "Unrecognized template $2, check --help" ;;
            esac
        fi
    fi
    return
}
# {{{ template_note <note name>
template_note() {
    local note_template=$drdot/latex/note_template.tex
    local note_preamble=$drdot/latex/note_preamble.tex

    local dest="$1"
    local name=$(echo "$(datestamp)$3.tex" | tr -d -)

    local note_uri=$dest/$name

    # Exit if note exists
    [[ -f "$note_uri" ]] && echo "$note_uri already exists" && return

    # Copy over template, create build and link preamble if neccessary
    [[ ! -d "$dest/build" ]] && mkdir $dest/build
    [[ ! -f "$dest/note_preamble.tex" ]] && ln -sn $note_preamble $dest/note_preamble.tex
    cp $note_template $note_uri

    # Replace text in file
    sed -i s/replacemeTitle/$name/g $note_uri

    # Open note
    cd $dest
    nvim $name
}
# }}}
# }}}
# {{{ dataset <name>
# TODO: Look into maps in bash
movie_lens_download="files.grouplens.org/datasets/movielens/ml-25m.zip"

dataset () {
    local link="",
    case "$1" in
        "movielens") link="$movie_lens_download";;
        *)
           echo "Whoops, $1 not recognized"
           echo "$dataset_help"
           return
    esac

    local prompt_string="Are you sure you want to download $1 from $link (y/n)?"
    read "response?$prompt_string?"
    if [[ "$response" =~ ^[Yy]$ ]] then
        wget $link
    fi
    return
}
# }}}
