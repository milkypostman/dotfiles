export PATH=$HOME/.cabal/bin:$HOME/.lein/bin:$HOME/bin:$PATH

## system-based
[[ -s "$HOME/.zshenv_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.zshenv_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"

