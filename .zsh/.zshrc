# Directories
export DOT_DIR="$HOME/.dot"
export ZSH_DIR="$DOT_DIR/.zsh"
export VIM_DIR="$DOT_DIR/.vim"
export CONFIG_DIR="$DOT_DIR/.config"
export INSTALLER_DIR="$DOT_DIR/installers"
export SHARE_DIR="$HOME/.local/share"
export ZDOTDIR="$ZSH_DIR"

# General environemnt variables
export VISUAL="nvim"
export EDITOR="nvim"
export PAGER="most"

# For Desktop Enviroment set to true
# setup.desktop.sh should uncomment this
# It can be used to know what environment we are in for zsh/nvim/git etc..
export DESKTOP_ENV=true

source $ZSH_DIR/alias.zsh

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' ''
zstyle :compinstall filename '/home/skantify/.zshrc'

#l Enabling History
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=1000

# Opts
setopt extendedglob 	# Enables wildcards
setopt notify		# Enables report of status of background jobs
setopt complete_aliases # Enables completion of aliases

# Allows vi like navigation in shell input
bindkey -v

# Autoload and call
autoload -Uz compinit promptinit
compinit
promptinit

# Theme
source $SHARE_DIR/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.dot/.zsh/.p10k.zsh ]] && source ~/.dot/.zsh/.p10k.zsh

# GNU dir colours
eval `dircolors ~/.dir_colors`

