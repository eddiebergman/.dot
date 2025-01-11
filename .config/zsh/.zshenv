export ZDOTDIR="$HOME/.config/zsh"
export VISUAL="nvim"
export EDITOR="nvim"

export NPM_PACKAGES="${HOME}/.npm_packages"
export PATH="${PATH}:${NPM_PACKAGES}/bin"
export PATH="${PATH}:${HOME}/usr/bin"
export PATH="$HOME/.just:$PATH"

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

. "$HOME/.cargo/env"
