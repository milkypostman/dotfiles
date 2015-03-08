#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#


export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export ALTERNATE_EDITOR=vim

export PYTHONPATH=$HOME/src/compepi:$HOME/src/word_cloud
export GNUTERM=x11


### Go
export GOPATH=$HOME


#
# Language
#

if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#
# Paths
#

typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
    $HOME/bin
    $HOME/{.cabal,.lein}/bin
    $GOPATH/bin
    /usr/local/haskell/ghc-7.8.3-x86_64/bin
    /usr/local/go/bin
    /usr/local/{bin,sbin}
    /usr/{bin,sbin}
    /{bin,sbin}
    $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#
# Temporary Files
#

if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi



## system-based
[[ -s "$HOME/.zshenv_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.zshenv_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.zshenv_local" ]] && source "$HOME/.zshenv_local"
