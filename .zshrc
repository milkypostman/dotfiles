# clone oh-my-zsh to initialize.
# git clone https://github.com/robbyrussell/oh-my-zsh.git

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="milk"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plungins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git zsh-syntax-highlighting lein)

case $(uname -s) in
Darwin)
plugins+=(brew rvm)
;;
esac

source $ZSH/oh-my-zsh.sh

# Customize to your needs...


## aliases
alias d='dirs'
alias p='pushd'
alias o='popd'
alias la="ls -A"
alias rm='rm -v'
alias cp='cp -v'
alias ec="emacsclient"
alias ecn="emacsclient -n"
alias ecnw="emacsclient -nw"

alias cscience="ssh cscience"
alias higgs="ssh higgs"
alias milkbox="ssh milkbox.net"

alias activatestonesoup="activate stonesoup"


magit() {
    runmagit="(let ((default-directory \"$(pwd)\")) \
(call-interactively 'magit-status))"
    emacsclient --eval "$runmagit"
}

umask 0077

sudo() {
    local ORIGINAL_UMASK=$(umask)
    umask 0022
    command sudo "$@"
    umask $ORIGINAL_UMASK
}

## rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

## virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
[[ -s "$HOME/.virtualenv/default/bin/activate" ]] && \
    source "$HOME/.virtualenv/default/bin/activate"

activate() {
    VIRTUALENV_BASE="${HOME}/.virtualenv"
    if [ $# -le 0 ]; then
        set -- default
    fi
    echo ${VIRTUALENV_BASE}/$1
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
    PS1='%(?..[%?])%!:%~%# '
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
fi
