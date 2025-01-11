# Oh My Zsh
ZSH_THEME="ys"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages colorize)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#fabd2f"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ENABLE_CORRECTION="true"
source $HOME/.oh-my-zsh/oh-my-zsh.sh

bindkey '^ ' autosuggest-accept
bindkey -v
bindkey 'jk' vi-cmd-mode # jk to exit insert mode

# PATH
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.gem/ruby/2.7.0/bin"
export PATH="${PATH}:/usr/local/cuda/bin"
export PATH="${PATH}:/${HOME}/npm/bin"
export PATH="${PATH}:${HOME}/software/neovide"
export PATH="${PATH}:${HOME}/software/tree-sitter"
export PATH="${HOME}/software/neovim/bin:${PATH}"  # Done in .zprofile
export PATH="${PATH}:${HOME}/software/thunderbird/thunderbird"
export PATH="${PATH}:${HOME}/software/lua-language-server/bin/lua-language-server"
export PATH="${PATH}:${HOME}/software/just"
export PATH="${PATH}:${HOME}/software/zig/zig-nightly"
export PATH="${PATH}:${HOME}/software/zls/zig-out/bin"
export PATH="${PATH}:${HOME}/software/godot"
export PATH="${PATH}:${HOME}/software/zig"
export PATH="${PATH}:${HOME}/.cargo/bin"

# fzf
export FZF_DEFAULT_OPTS="--bind=alt-j:down,alt-k:up --inline-info"

# alias
alias luamake=/home/skantify/software/lua-language-server/3rd/luamake/luamake
alias pyshell='source ./.venv/bin/activate'
alias ll='ls -lA --group-directories-first --color=auto'
alias xclip='xclip -selection clipboard'
alias ipython=ipy
alias vim="nvim"
alias neovide="neovide & disown; exit"
alias evimrc="cd ~/.config/nvim; $EDITOR"
alias ezshrc="$EDITOR ~/.config/zsh/.zshrc"
alias edot="cd $HOME/.dot && $EDITOR"
alias fonts="kitty +list-fonts --psnames"

eq () { [[ "$1" == "$2" ]]; return }
exists () { [[ -d "$1" ]] | [[ -f "$1" ]] | [[ -h "$1" ]]; return }
emptyvar() { [[ -z "$1" ]]; return }


screen () {

    local usage="Usage: screen {off, work, home, left, right}"

    if emptyvar $1; then
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
    local work_right="HDMI-1"

    # Home laptop and work laptop mark them reads them differently sometimes
    # This is for my personal laptop
    if xrandr | grep "eDP1"; then
        primary="eDP1"
        home_extern="HDMI2"
    fi

    # Disable all monitors
    if eq $1 "off"; then
        xrandr --output $home_center --off;
        xrandr --output $home_right --off;
        xrandr --output $work_middle --off;
        xrandr --output $work_right --off;

    elif eq $1 "work" ; then
      xrandr --output "HDMI-1" --right-of "eDP-1" --mode "2560x1440" --rotate inverted
      xrandr --output "DP-2-2" --right-of "HDMI-1" --mode "2560x1440"

    elif eq $1 "home"; then
        xrandr --output $home_center --right-of $primary --auto
        xrandr --output $home_right --right-of $home_center --mode 2560x1440

    elif eq $1 "right" ; then
        xrandr --output $hdmi --right-of $primary --auto

    elif eq $1 "left"; then
        xrandr --output $hdmi --left-of $primary --auto

    elif eq $1 "copy-right"; then
        xrandr --output $hdmi --same-as $primary --auto

    else
        echo $usage
        return 1

    fi

    feh --bg-scale /home/skantify/.config/background.jpg
}

decompress () {
    if ! eq $# 1; then
        echo "Usage: decompress <file_path>"
        return 1
    fi

    local filepath="$1"
    local filename=$filepath:t:r
    local ext=$filepath:t:e

    if eq $ext "gz"; then
        # If it's a tar.gz
        if eq $filename:e "tar"; then
            tar -zxvf $filepath
        else
            gzip -dvk $filepath
        fi
    elif eq $ext "xz"; then
        tar -xvf $filepath
    elif eq $ext "tar"; then
        tar -xvf $filepath
    elif eq $ext "zip"; then
        unzip -v $filepath
    else
        echo "Unrecognized extension '$ext', must be in ['tar', 'gz', 'zip', 'xz']"
    fi
}

branches () {
    git checkout "$(git branch | fzf | tr -d '[:space:]' | sed 's:^origin/::')"
}


# Hist
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
    if ! emptyvar $command; then
        echo "\033[1mRunning: $command\033[0m"
        eval $command
    fi
}

# Stop issues with me thinking I'm in a python session
import() {
    echo "disabled command"
}

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' ''
zstyle :compinstall filename '/home/skantify/.zshrc'

# Autoload and call
autoload -Uz compinit promptinit
compinit -i
promptinit


ff() {
  find . -name "$1"
}


# Set repeat rate for keys
fast_keys () {
  xset r rate 195 35
}
fast_keys

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
command -v pyenv >/dev/null || export PATH="$PATH:$PYENV_ROOT/bin"

pip () {
    if emptyvar $VIRTUAL_ENV
    then
        echo 'No VIRTUAL_ENV set, activate with `pyshell` first?'
    else
        uv pip "$@"
    fi
}

ipy () {
    if emptyvar $VIRTUAL_ENV
    then
        $(pyenv which ipython)
    else
        $VIRTUAL_ENV/bin/ipython
    fi
}

pyvenv () {
    if exists '.venv'
    then
        echo '.venv already exists'
        return 1
    fi

    if ! emptyvar $VIRTUAL_ENV
    then
        deactivate
    fi

    echo "Using $(python -V) located at $(which python)"
    uv venv --seed .venv
    source './.venv/bin/activate'
}


export NVM_DIR="$HOME/software/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
