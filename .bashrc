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

EDITOR=vim
PAGER=less


shopt -s histappend


# this is a bugfix for certain terminals so that all eamcs bindings
# work.
if [ -t 0 ]; then
    stty stop undef
    stty werase undef
fi


#-- aliases
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

umask 0077


#-- functions

# find file
ff () { find ./ -name '*'"$@"'*' ; }

# recursive grep
rgrep () { find ./ -exec grep -H "$@" {} \; ; }

## system-based
[[ -s "$HOME/.bashrc_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.bashrc_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.bashrc_local" ]] && source "$HOME/.bashrc_local"


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
