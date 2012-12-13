#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## aliases
alias ec="emacsclient -a vim"
alias ecn="emacsclient -a vim -n"
alias ecnw="emacsclient -a vim -nw"
alias emacsclient="emacsclient -a vim"

alias gst="git status"

alias cscience="ssh cscience"
alias higgs="ssh higgs"
alias milkbox="ssh milkbox.net"

alias startpostgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias stoppostgres="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias startmysql="mysql.server start"
alias stopmysql="mysql.server stop"

alias startmongo="mongod run --logpath /usr/local/var/mongodb/mongodb.log --config /usr/local/etc/mongod.conf --fork"
alias stopmongo="killall mongod"

alias melpa="cd $HOME/src/melpa"
alias compepi="cd $HOME/src/compepi"
alias data="cd $HOME/data"

## umask
umask 0077
sudo() {
    local ORIGINAL_UMASK=$(umask)
    umask 0022
    command sudo "$@"
    umask $ORIGINAL_UMASK
}

## functions
realpath() {
    for FN in $@; do
        if [[ -e $FN ]]; then
            echo `pwd`/${FN}
        fi
    done
}

magit() {
    runmagit="(let ((default-directory \"$(pwd)\")) \
(call-interactively 'magit-status))"
    emacsclient --eval "$runmagit" && \
        [[ $(uname -s | tr '[A-Z]' '[a-z]') == "darwin" ]] && \
        osascript -e 'tell application "Emacs" to activate'
}

## rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

## virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

stonesoup() {
    activate stonesoup
    export DJANGO_SETTINGS_MODULE=stonesoup.development_settings
    cd $HOME/src/stonesoup
}

mulchn() {
    activate mulchn
    cd $HOME/src/mulchn
    export MULCHN_SETTINGS=devconfig.py
}

activate() {
    VIRTUALENV_BASE="${HOME}/.virtualenv"
    if [ $# -le 0 ]; then
        if [[ -s "./venv/bin/activate" ]]; then
            source "./venv/bin/activate"
            return
        fi
        set -- default
    fi
    . ${VIRTUALENV_BASE}/$1/bin/activate
}

## pip
export PIP_RESPECT_VIRTUALENV=true

## system-based
[[ -s "$HOME/.zshrc_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.zshrc_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.zshrc_local" ]] && source "$HOME/.zshrc_local"


if [[ $TERM == "dumb" ]]; then
    PS1='%F{blue}%n@%m%f %B%F{cyan}%~%F{white} > %b%f%k'
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    # unfunction precmd
    # unfunction preexec
fi

### For CoffeeScript
export PATH="/usr/local/share/npm/bin:$PATH"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.virtualenv/default/bin/activate" ]] && \
    source "$HOME/.virtualenv/default/bin/activate"
