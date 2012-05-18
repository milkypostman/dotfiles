#--
# bashrc
#
# include all commands that are important for an interactive bash session.
#
# sourced by all interactive shells
# host/system specific stuff should go into .bashrc_*
#--

#-- shell setup
case "$TERM" in
    xterm*|rxvt|rxvt-unicode|rxvt-256color)
		PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%.*}: ${PWD/$HOME/~}\007"'
		#PROMPT_COMMAND='echo -ne "\e]0;${HOSTNAME%%.*}: ${PWD/$HOME/~}\a"'
		;;
	*)
		;;
esac

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
HISTSIZE=1000

PAGER=less


shopt -s histappend


# this is a bugfix for certain terminals so that all eamcs bindings
# work.
if [ -t 0 ]; then
    stty stop undef
    stty werase undef
fi


#-- aliases
alias kablamo="lsq | cut -f6 | cut -d\  -f3-4 | cut -d_ -f1 | sort | uniq"
alias l='ls -la'
alias la='ls -A'
alias ll='ls -l'
alias ls='ls -G'
alias lsa='ls -lah'
alias sl=ls
alias rm='rm -v'
alias cp='cp -v'
alias less='less -R'
alias more=less

alias ec="emacsclient"
alias ecn="emacsclient -n"
alias ecnw="emacsclient -nw"

alias d='dirs'
alias p='pushd'
alias o='popd'

# ssh enabling x11 support
alias sshx11="ssh -o ForwardX11=yes"

alias milano="cdssh milano"
alias vinci="cdssh vinci"

for i in {1..17}; do
    alias m${i}="cdssh m${i}"
done

umask 0077

sudo() {
    local ORIGINAL_UMASK=$(umask)
    umask 0022
    command sudo "$@"
    umask $ORIGINAL_UMASK
}



#-- functions

# ssh to current
cdssh () {
    if [ -n ${1} ]; then
        CWD=$(pwd|sed "s#$HOME#~#")
        ssh -t $1 -- "cd ${CWD} ; bash -l"
    fi
}

# find file
ff () { find ./ -name '*'"$@"'*' ; }

# recursive grep
rgrep () { find ./ -exec grep -H "$@" {} \; ; }

## enable rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## pythonz
[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc

## enable virtual python environment
[[ -s $HOME/.virtualenv/default/bin/activate ]] && source $HOME/.virtualenv/default/bin/activate

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
[[ -s "$HOME/.bashrc_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.bashrc_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.bashrc_local" ]] && source "$HOME/.bashrc_local"

