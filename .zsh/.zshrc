source $ZSH_DIR/alias.zsh

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' ''
zstyle :compinstall filename '/home/skantify/.zshrc'

# Enabling History
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
