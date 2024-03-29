# Viewed as menu with Vim, set foldmethod=marker foldmarker={{{,}}}
# {{{ oh-my-zsh
# oh-my-zsh should be enabled towards the end
# {{{ Theme
ZSH_THEME="ys"
# stellarized_dark_shell="${ZDOTDIR}/stellarized_dark.sh"
# if [[ -f "$stellarized_dark_shell" ]]; then
#    [ -n "$PS1" ] && sh "$stellarized_dark_shell"
#else
#    eval `dircolors $ZDOTDIR/dircolors.256dark`
#fi

# }}}
# {{{ Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages colorize)

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

chk () { echo "$(cksum <<< $1)" | cut -f 1 -d ' ' }
# }}}
# }}}
# {{{ Exports
# {{{ Path
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.gem/ruby/2.7.0/bin"
export PATH="${PATH}:/usr/local/cuda/bin"
export PATH="${PATH}:/${HOME}/npm/bin"
export PATH="${PATH}:${HOME}/software/neovide"
export PATH="${HOME}/software/neovim/bin:${PATH}"
export PATH="${PATH}:${HOME}/software/thunderbird/thunderbird"
export PATH="${PATH}:${HOME}/software/lua-language-server/bin/lua-language-server"
export PATH="${PATH}:${HOME}/software/just"
# }}}
# }}}
# {{{ Aliases
# {{{ Default Commands
alias ll='ls -lA --group-directories-first --color=auto'
alias xclip='xclip -selection clipboard'
alias ipython=ipy
alias vim="nvim"
alias neovide="neovide & disown; exit"
# }}}
# {{{ Quick files
alias evimrc="cd ~/.config/nvim; $EDITOR"
alias ezshrc="$EDITOR ~/.config/zsh/.zshrc"
alias edot="cd $HOME/.dot && $EDITOR"
alias todo="$EDITOR ~/.todo.md"
alias org="nvim -c \"Neorg workspace gtd\""
# }}}
# {{{ Python
alias pytesth="pytest --cov-report html; firefox htmlcov/index.html"
# }}}
# }}}
# {{{ Utility
# {{{ Screen
# Assumes two monitors

screen () {

    local usage="Usage: screen {off, work, home, left, right}"

    if empty $1; then
        echo $usage
        return 1
    fi
    #
    # Sets the monitors to show up
    xrandr --auto
    local primary="eDP-1"
    local hdmi="HDMI-1"
    local home_center="DP-2-9"
    local home_right="HDMI-1"
    local work_middle="DP-2-2"
    local work_right="DP-2-3"

    # Home laptop and work laptop mark them reads them differently sometimes
    # This is for my personal laptop
    if xrandr | grep "eDP1"; then
        primary="eDP1"
        home_extern="HDMI2"
    fi

    # Disable all monitors
    if equal $1 "off"; then
        xrandr --output $home_center --off;
        xrandr --output $home_right --off;
        xrandr --output $work_middle --off;
        xrandr --output $work_right --off;

    elif equal $1 "work" ; then
        xrandr --output $work_middle --right-of $primary --auto
        xrandr --output $work_right --right-of $work_middle --auto

    elif equal $1 "home"; then
        xrandr --output $home_center --right-of $primary --auto
        xrandr --output $home_right --right-of $home_center --mode 2560x1440

    elif equal $1 "right" ; then
        xrandr --output $hdmi --right-of $primary --auto

    elif equal $1 "left"; then
        xrandr --output $hdmi --left-of $primary --auto

    elif equal $1 "copy-right"; then
        xrandr --output $hdmi --same-as $primary --auto

    else
        echo $usage
        return 1

    fi

    feh --bg-scale /home/skantify/.config/background.jpg
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
    elif equal $ext "xz"; then
        tar -xvf $filepath
    elif equal $ext "tar"; then
        tar -xvf $filepath
    elif equal $ext "zip"; then
        unzip -v $filepath
    else
        echo "Unrecognized extension '$ext', must be in ['tar', 'gz', 'zip', 'xz']"
    fi
}
# }}}
# {{{ Wacom
wacomscreen () { 
    xsetwacom --set "Wacom Intuos S Pen stylus" MapToOutput HEAD-"$1" 
}
# }}}
# {{{ Git
# Extends some simple functionality to git
gclone () {
    local repo=$1
    local places=()

    # If there's a `--` in the argument then we just exit
    # Could handle this but meh, use `git clone` with the args and repo
    if [[ $repo =~ "--" ]]
    then
        echo "Use 'git clone' instead, doesn't handle arguments"
        return 1
    fi

    # If there's a '/' in the passed arugment e.g. gclone eddiebergman/myrepo
    # then we know the org, otherwise, we try automl, automl_private and finally username
    if [[ $repo =~ \/ ]]
    then
        places+=("${repo}.git")
    else
        # Re-order however
        places+=("automl/$1.git")
        places+=("automl-private/$1.git")

        local username=""
        username="$(git config --global user.name)"

        places+=("${username}/$1.git")
    fi

    # Try all the places it could be
    for place in "${places[@]}"
    do
        local link="git@github.com:${place}"
        echo "Trying ${link}"

        # Exit if successful
        if git clone "$link"
        then
            return 0
        fi
    done

    return 1
}

branches () {
    git checkout "$(git branch | fzf | tr -d '[:space:]' | sed 's:^origin/::')"
}


# }}}
# {{{ Update
update() {
    local dir="$HOME/software/neovim"
    if equal $1 "nvim" || equal $1 "neovim"; then
        cd $dir
        git stash
        git fetch
        git checkout tags/v0.8.0
        git pull
        make clean
        make distclean
        make CMAKE_BUILD_TYPE=Release
        sudo make install
    else
        echo "Update [nvim]"
        return 1
    fi
}
# }}}
# {{{ Template
source "$ZDOTDIR/template.zsh"
# }}}
# {{{ Clone
# Create environments I normally need
clone () {
    repo=$1
    name=$2

    if empty $name; then
        name=$repo
    fi

    # Validate the name if it exists
    if exists $name; then
        echo "${name} already exists"
        return 1
    fi

    # Validate and get org for repo
    case $repo in

        'autosklearn')
            org="automl"
            install_cmd='pip install -e .[test,examples,docs]'
            ;;

        'meta_remote')
            org="automl-private"
            install_cmd='pip install -e .[test]'
            ;;

        'automlbenchmark_remote')
            org="automl-private"
            install_cmd='pip install -e .'
            ;;

        'automlbenchmark_analysis')
            org="automl-private"
            install_cmd='pip install -e .'
            ;;

        'automlbenchmark')
            org='openml'
            install_cmd='pip install -r requirements.txt'
            ;;

        *)
            supported=('autosklearn', 'meta_remote', 'automlbenchmark_remote', 'automlbenchmark_analysis')
            echo "Supported:"
            echo $supported
            return 1
    esac

    mkdir $name
    cd $name
    git clone "git@github.com:${org}/${repo}" "."
    pyvenv
    eval $install_cmd
    mypy --install-types
}
# }}}
# {{{ Editors
local neovide_cmd="neovide; disown; exit"
local vim=$neovide_cmd
# }}}
# {{{ History
set H+ # Stops history expansion
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

hist () {
    command=$(history | tac | fzf | sed -r "s/^\s+[0-9]+\s+//g")
    if ! empty $command; then
        echo "\033[1mRunning: $command\033[0m"
        eval $command
    fi
}
# }}}
# }}}
# {{{ Misc
import() {
    echo "disabled command"
}
# {{{ For GPU-cuda
# This is needed by the cuda install script found
# at ~/cuda/cuda11.1
alias xterm-kitty="kitty"

# }}}

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
compinit -i
promptinit

# Autosuggestion complete
bindkey '^ ' autosuggest-accept

# Find file
# Usage: ff (file)
ff() {
  find . -name "$1"
}
# }}}


code () {
    local location="$HOME/code"
    local selection="$(/bin/ls -1 $location | fzf)"

    local chosen="${location}/${selection}"
    cd "$chosen"

    local main="${chosen}/main";
    if exists $main; then
      cd "$main"
      chosen="$main"
    fi

    local venv="${chosen}/.venv"
    if exists $venv; then
        pyshell
    fi
}

wt () {
    # If we're in one of the branches of the worktree, we can use things as expected
    if exists "$PWD/.git"; then
        local selection=$(git worktree list --porcelain | grep worktree | awk '{print $2}' | fzf)
        if ! empty "$selection"; then
          cd "$selection"
        fi
    # Otherwise, we just select one of the local directores
    else
        local selection=$(ls -1A | fzf)
        if ! empty "$selection"; then
          cd "$selection"
        fi
    fi

    if exists "$PWD/.venv"; then
        pyshell
    fi
}

unalias -m gb
gb () {
    git worktree add ../$1
    cd ../$1
}

alias fonts="kitty +list-fonts --psnames"
eval "$(hub alias -s)"

# Set repeat rate for keys
xset r rate 195 35

export FZF_DEFAULT_OPTS="--bind=alt-j:down,alt-k:up --inline-info"

export NVM_DIR="$HOME/software/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
