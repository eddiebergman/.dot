# {{{ Env
# {{{ Path
export PATH="${PATH}:${HOME}/.local/bin"
# }}}
# {{{ Directory Aliases
export DOT="$HOME/.dot"
export ZSH_DIR="$DOT/.zsh"
export VIM_DIR="$DOT/.vim"
export CONFIG_DIR="$DOT/.config"
export INSTALLER_DIR="$DOT/installers"
export SHARE_DIR="$HOME/.local/share"
export ZDOTDIR="$ZSH_DIR"
# }}}
# {{{ Default applications
export VISUAL="nvim"
export EDITOR="nvim"
# export PAGER="most"
# }}}
# }}}
# {{{ Aliases
# {{{ Default Parameters
alias ls='ls -a --group-directories-first --sort=extension --color=auto'
alias xclip='xclip -selection clipboard'
# }}}
# {{{ Quick files
alias evimrc='cd $DOT && nvim .vim/.vimrc'
alias ezshrc='cd $DOT && nvim .zsh/.zshrc'
# }}}
# {{{ Screen
alias screenright='xrandr --auto && xrandr --output HDMI-2 --right-of eDP-1'
alias screenleft='xrandr --auto && xrandr --output HDMI-2 --left-of eDP-1'
alias screenoff='xrandr --auto && xrandr --output HDMI-2 --off'
# }}}
# {{{ Work setups
alias dhaskell='cd ~/Desktop/haskell && stack ghci'
alias dpython='cd ~/Desktop/python && pipenv shell'
# }}}
# {{{ Pdf Merge
alias mergepdfs='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf'
# }}}
# {{{ Network
alias networkrefresh='nmcli network off && nmcli network on'
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
source $SHARE_DIR/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.dot/.zsh/.p10k.zsh ]] && source ~/.dot/.zsh/.p10k.zsh

# }}}
# {{{ Dir Colors
eval `dircolors ~/.dir_colors`
# }}}
# }}}
# {{{ Functions
datestamp () { echo "$(date -Idate)" }
# }}}
# {{{ Commands
# {{{ template

# template
# Creates a template of various descriptions in the current or optionally
# specified directory
#
# $1 - templatename
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
# {{{ template_note()
template_note() {
    local note_template=$DOT/latex/note_template.tex
    local note_preamble=$DOT/latex/note_preamble.tex

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
