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

PATH=$PATH:$HOME/src/compepi/uihc/generators
PATH=$PATH:$HOME/src/compepi/uihc/scripts
PATH=$PATH:$HOME/src/compepi/wescrub/contactgraph

suihc=$HOME/src/compepi/uihc
duihc=$HOME/uihc
graphs=$HOME/uihc/graphs
scripts=$HOME/src/compepi/uihc/scripts
generators=$HOME/src/compepi/uihc/generators


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

alias d='dirs'
alias p='pushd'
alias o='popd'

# ssh enabling x11 support
alias sshx11="ssh -o ForwardX11=yes"


# too much hitting tab
alias spol="cd ~/src/compepi/uihc/policy/"
alias seval="cd ~/src/compepi/uihc/policy/evaluation/"
alias upol="cd ~/uihc/policy/"


alias milano="cdssh milano"
alias vinci="cdssh vinci"

for i in {1..17}; do
    alias m${i}="cdssh m${i}"
done


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

# get configuration for this machine type
if [ -r $HOME/.bashrc_$(uname -s) ]; then source $HOME/.bashrc_$(uname -s); fi

# get local configuration
if [ -r $HOME/.bashrc_local ]; then source $HOME/.bashrc_local; fi
