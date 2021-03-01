### .zshrc

fpath=(${HOME}/.zsh_functions /usr/local/share/zsh/site-functions $fpath)

path=(/usr/local/brew/bin $path)

WHICH_FISH=$(which fish)
if [[ -n "$WHICH_FISH" && "$SHELL" != "$WHICH_FISH" ]]; then
    exec env SHELL="$WHICH_FISH" $WHICH_FISH
fi

## aliases
alias e='emacsclient -a vim -n'
alias s="ssh"
alias c="cd"
alias e="emacsclient -n -a ''"
alias et="emacsclient -t -a ''"
alias ec="emacsclient -n -c -a ''"

alias openscad="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

## umask
umask 0077
autoload -U sudo


## functions

# autoload all function except prompts
for FN in $HOME/.zsh_functions/* ; do
    BFN=`basename ${FN}`
    [[ ${BFN} != prompt_*_setup ]] && autoload -Uz ${BFN}
done


## system-based
[[ -s "$HOME/.zshrc_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.zshrc_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.zshrc_local" ]] && source "$HOME/.zshrc_local"
