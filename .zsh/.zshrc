source $ZSH_DIR/alias.zsh

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' ''
zstyle :compinstall filename '/home/skantify/.zshrc'

# Enabling History
HISTFILE=~/.histfile
HISTSIZE=1000
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
prompt adam2

source $SHARE_DIR/powerlevel10k/powerlevel10k.zsh-theme

# Zsh extensions
#################
# Zgen plugin manager
# ZGEN_DIR="$HOME/.local/.zgen"
# [[ -f "$ZGEN_DIR/zgen.zsh" ]] || git clone https://github.com/tarjoilija/zgen.git "$ZGEN_DIR"
# source "$ZGEN_DIR/zgen.zsh"
#
# # Plugins (Zgen)
# #################
#
# # To update
# # zgen update
# if ! zgen saved; then
# 	zgen save	
# fi

# To customize prompt, run `p10k configure` or edit ~/.dot/.zsh/.p10k.zsh.
[[ -f ~/.dot/.zsh/.p10k.zsh ]] && source ~/.dot/.zsh/.p10k.zsh
