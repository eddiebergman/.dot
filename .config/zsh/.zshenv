export ZDOTDIR="$HOME/.config/zsh"

export VISUAL="nvim"
export EDITOR="nvim"
export VIEWER="zathura"

export NPM_PACKAGES="${HOME}/.npm_packages"

export PATH="${PATH}:${NPM_PACKAGES}/bin"
export PATH="${PATH}:${HOME}/usr/bin"
export PATH="$HOME/.just:$PATH"

# {{{ Python
# This is put in here so that spawning neovide should know about this
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


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
    python -m venv .venv
    source './.venv/bin/activate'

    pip install --upgrade pip
    pip install wheel
}

alias pyshell='source ./.venv/bin/activate'
# }}}
alias luamake=/home/skantify/software/lua-language-server/3rd/luamake/luamake

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi
