export EDITOR=vim
#export GIT_EDITOR="mvim -f"
export PATH=$HOME/bin:$PATH
export CLICOLOR=1

#export LSCOLORS=dxfxcxdxbxegedabagacad

# get configuration for this machine type
if [ -r $HOME/.profile_$(uname -s) ]; then source $HOME/.profile_$(uname -s); fi

# if this shell is interactive load the bashrc
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

