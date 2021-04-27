# {{{ oh-my-zsh
# oh-my-zsh should be enabled towards the end
# {{{ Theme
ZSH_THEME="robbyrussell"
eval `dircolors ~/.dir_colors`
stellarized_dark_shell="${HOME}/.vim/bundle/stellarized/shell/stellarized_dark.sh"
if [[ -f "$stellarized_dark_shell" ]]; then
    [ -n "$PS1" ] && sh "$stellarized_dark_shell"
fi

# }}}
# {{{ Plugins
plugins=(git zsh-autosuggestions colored-man-pages colorize)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fabd2f"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# }}}
# {{{ Setup
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
# }}}
# }}}
# {{{ Functions
# {{{ Comparison
equal () { [[ "$1" == "$2" ]]; return }
eq () { equal $1 $2; return }

less () { [[ "$1" -lt "$2" ]]; return }
lt () { less $1 $2; return } 

greater () { ! less $1 $2 && ! equal $1 $2; return } 
gt () { greater $1 $2; return }

lessequal () { less $1 $2 || equal $1 $2; return}
lte () { lessequal $1 $2; return }

greaterequal () { greater $1 $2 || equal $1 $2; return }
gte () { greaterequal $1 $2; return }
# }}}
# {{{ Predicates
# Check if variable, directory, file or symbolic link
isdir () { [[ -d "$1" ]]; return }
isfile () { [[ -f "$1" ]]; return }
issymlink () { [[ -h "$1" ]]; return }

exists () { isdir $1 || isfile $1 || issymlink $1; return }

emptyvar() { [[ -z "$1" ]]; return }
isset () { ! emptyvar $1; return }

emptydir () { [[ ! "$(ls -A $1)" ]]; return }
hasfile () { ! emptydir $1; return }

uniquefile() { ! emptyvar $1 && equal 0 $(printf $1 | wc -l); return }

empty () { emptyvar $1 || (isdir $1 && emptydir $1); return }

readable () { [[ -r "$1" ]]; return }
writable () { [[ -w "$1" ]]; return }
# }}}
# {{{ Arrays
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
array () { declare -a $1 }

map() { local f="$1"; shift; for item in "$@"; do "$f" "$item"; done; return }
# }}}
# {{{ Arg parsing
arg () { elem "$@"; return }
helparg() { elem $1 "help" "-h" "--help"; return }
# }}}
# {{{ Util
datestamp () { echo "$(date -Idate)" }

getline () { printf "$1" | sed -n "${2}p"; return }

countlines () { printf "$1" | wc -l; return }
countchars () { printf "$1" | wc -l; return }
countwords () { printf "$1" | wc -l; return }
# }}}
# }}}
# {{{ Utility
# {{{ Screen
# Assumes two monitors
screen () {
    # Usage: screen [left|right|off]
    #
    # Due to changing names of monitors, we manually their names
    # instead of hardcoding them (changed from HDMI-2 -> HDMI-1)
    # Note: This might have an issue if the order of the monitors is not
    #       consistent, a workaround would be to choose the one beginning with
    #       eDPI as primary
    xrandr --auto # Sets the monitors to show up

    # Get last words of output (names of monitors)
    local monitors=$(xrandr --listmonitors | tail -n 2 | grep -oE "\w+$") 
    local primary=$(getline $monitors 1)
    local secondary=$(getline $monitors 2)
    echo "Primary: ${primary} , Secondary: ${secondary}"

    if equal $1 "left"; then
        xrandr --output $secondary --left-of $primary;
    elif equal $1 "right"; then
        xrandr --output $secondary --right-of $primary;
    elif equal $1 "off"; then
        xrandr --output $secondary --off;
    else
        printf "Usage: screen [left|right|off]"
        exit 0;
    fi

    return;
}
# }}}
# {{{ Decompress
decompress () {
    if ! equal $# 1; then
        echo "Usage: decompress <file_path>"
        return 1
    fi

    local filepath="$1"
    local filename=$filepath:t:r
    local ext=$filepath:t:e

    if equal $ext "gz"; then
        # If it's a tar.gz
        if equal $filename:e "tar"; then
            tar -zxvf $filepath
        else
            gzip -dvk $filepath
        fi
    elif equal $ext "tar"; then
        tar -xvf $filepath
    elif equal $ext "zip"; then
        unzip -v $filepath
    else
        echo "Unrecognized extension '$ext', must be in ['tar', 'gz', 'zip']"
    fi
}
# }}}
# {{{ Env
# {{{ Aliases
# {{{ Default Commands
alias ls='ls -a --group-directories-first --sort=extension --color=auto'
alias xclip='xclip -selection clipboard'
# }}}
# {{{ Quick files
alias evimrc='cd $drdot && vim .vim/.vimrc'
alias ezshrc='cd $drdot && vim .zsh/.zshrc'
alias edot='cd $drdot && vim'
alias ebib='cd $drlib/bibs && vim mybib.bib'
# }}}
# {{{ Work setups
alias notebook='cd ~/Desktop/phd/notebook && vim'
alias nbconvert='jupyter nbconvert'
#alias viewblog='cd ~/Desktop/blog && firefox http://127.0.0.1:8080 && python manage.py runserver 8080'
chk () { echo "$(cksum <<< $1)" | cut -f 1 -d ' ' }

# TODO: Fix directory changing back to home
# }}}
# {{{ Pdf Merge
alias mergepdfs='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150 -sOutputFile=output.pdf'
# }}}
# {{{ Network
alias networkrefresh='nmcli network off; nmcli network on'
# }}}
# {{{ File management
alias clearswaps='rm ~/.cache/vim/swap/*'
# }}}
# }}}
# {{{ Exports
# {{{ Path
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.gem/ruby/2.7.0/bin"
export PATH="${PATH}:${HOME}/usr/bin"
export PATH="${PATH}:/usr/local/cuda/bin"

# For lutris gaming on linux, required for "import dbus"
export PATH="${PATH}:/usr/lib/python3/dist-packages"
# }}}
# {{{ Locations
export drdot="$HOME/.dot"
export drzsh="$drdot/.zsh"
export drvim="$drdot/.vim"
export drconfig="$drdot/.config"
export drshare="$HOME/.local/share"
export drtemplate="$drdot/templates"
#export ZSHDIR="$drzsh" # Required by <something>
# }}}
# {{{ Defaults - $VISUAL, $EDITOR, ...
export VISUAL="vim"
export EDITOR="vim"
export VIEWER="zathura"
# export PAGER="most"
# }}}
# {{{ Sources
source "$drzsh/colours.zsh"
source "$drdot/.secret/zotero_envs.zsh"
source "$drzsh/template.zsh"
# }}}
# }}}
# }}}
# {{{ Settings
setopt extendedglob     # Enables wildcards
setopt notify           # Enables report of status of background jobs
setopt complete_aliases # Enables completion of aliases

set H+ # Stops history expansion
# https://serverfault.com/questions/208265/what-is-bash-event-not-found?newreg=dfc433ccbc3146eeba6ae7f4e31681dd

# Enables command auto-correction
ENABLE_CORRECTION="true"

# Allows vi like navigation in shell input
bindkey -v
bindkey 'jk' vi-cmd-mode # jk to exit insert mode

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' ''
zstyle :compinstall filename '/home/skantify/.zshrc'

# Autoload and call
autoload -Uz compinit promptinit
compinit
promptinit

# Autosuggestion complete
bindkey '^ ' autosuggest-accept

# {{{ History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=1000
# }}}

# }}}
# {{{ Python

# Enable pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PATH}:$PYENV_ROOT/bin"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


alias pyshell='source ./.venv/bin/activate'

pip () {
    if emptyvar $VIRTUAL_ENV
    then
        echo 'No VIRTUAL_ENV set, activate with `pyshell` first?'
    else
        python -m pip "$@"
    fi
}

ipy () {
    if emptyvar $VIRTUAL_ENV
    then
        ipython
    else
        $VIRTUAL_ENV/bin/ipython
    fi
}

py_make_venv () {
    if exists '.venv'; then echo '.venv already exists'; exit 1; fi

    echo "Using $(python -V) located at $(which python)"
    python -m venv .venv && source './.venv/bin/activate'
}


alias django='python manage.py'
alias ctagpython="find -iname '*.py' > tagged_files ; ctags -L tagged_files; rm tagged_files"
# }}}
# {{{ Misc
import() {
    echo "disabled command"
}
# }}}
# {{{ Wacom
wacomscreen () { 
    xsetwacom --set "Wacom Intuos S Pen stylus" MapToOutput HEAD-"$1" 
}
# }}}
# {{{ For GPU-cuda
# This is needed by the cuda install script found
# at ~/cuda/cuda11.1
alias xterm-kitty="kitty"

# }}}
# {{{ Remotes
alias horus="ssh -t -i ~/.ssh/horus_rsa eb130475@hpc.zimt.uni-siegen.de" 
# }}}
