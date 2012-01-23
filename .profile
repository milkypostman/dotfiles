export EDITOR=vim
export PATH=$HOME/.cabal/bin:$HOME/.lein/bin:$HOME/bin:$PATH
export CLICOLOR=1

#export LSCOLORS=dxfxcxdxbxegedabagacad

## system-based
[[ -s "$HOME/.profile_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.profile_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.profile_local" ]] && source "$HOME/.profile_local"

# if this shell is interactive load the bashrc
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

export PATH=$HOME/fun:$PATH
