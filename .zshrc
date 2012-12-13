### milkypostman .zshrc

## aliases
alias cp='cp -v'
alias ec="emacsclient -avim"
alias ecn="emacsclient -a vim -n"
alias ecnw="emacsclient -a vim -nw"
alias g="git"
alias gst="git status"
alias la="ls -A"
alias ls="ls -G"
alias o='popd'
alias rm='rm -v'
alias u='pushd'

alias emacsclient="emacsclient -a vim"

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

umask 0077

sudo() {
    local ORIGINAL_UMASK=$(umask)
    umask 0022
    command sudo "$@"
    umask $ORIGINAL_UMASK
}


## utility functions
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


## virtualenv
VIRTUALENV_BASE="${HOME}/.virtualenv"
activate() {
    if [ $# -le 0 ]; then
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


## disable fancy prompt for emacs
if [[ $TERM == "dumb" ]]; then
    PS1='%F{blue}%n@%m%f %B%F{cyan}%~%F{white} > %b%f%k'
fi

## For CoffeeScript
export PATH="/usr/local/share/npm/bin:$PATH"

## Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

[[ -s "$HOME/.virtualenv/default/bin/activate" ]] && \
    source "$HOME/.virtualenv/default/bin/activate"
