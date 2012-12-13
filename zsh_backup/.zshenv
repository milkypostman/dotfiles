export PATH=$HOME/.cabal/bin:$HOME/.lein/bin:$HOME/bin:/usr/local/bin:$PATH
export PYTHONPATH=$HOME/src/compepi:$HOME/src/word_cloud
export GNUTERM=x11
export ALTERNATE_EDITOR=vim

## system-based
[[ -s "$HOME/.zshenv_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.zshenv_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"

