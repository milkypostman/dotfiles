### .zshrc

fpath=(${HOME}/.zsh_functions /usr/local/share/zsh/site-functions $fpath)

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## aliases
alias e='emacsclient -a vim -n'
alias s="ssh"
alias c="cd"
alias e="emacsclient -n -a ''"
alias et="emacsclient -t -a ''"
alias ec="emacsclient -n -c -a ''"

alias openscad="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

alias t='tmux'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'
alias tmux_send_all='tmux list-windows | cut -d: -f1 | xargs -I\{\} tmux send-keys -t {} '
function ta() {
    tmux start-server

    # Create a 'prezto' session if no session has been defined in tmux.conf.
    if ! tmux has-session 2> /dev/null; then
        tmux \
            new-session -d -s prezto \; \
            set-option -t prezto destroy-unattached off &> /dev/null
    fi

    tmux_session=`tmux list-sessions -F '#S' | head -n 1`
    exec tmux new-session -t "$tmux_session"\; set-option destroy-unattached on
}

alias rza='source ~/.zshrc && rehash'
alias gst="git status"

alias startpostgres="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias stoppostgres="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

alias startmysql="mysql.server start"
alias stopmysql="mysql.server stop"

alias startmongo="mongod run --logpath /usr/local/var/mongodb/mongodb.log --config /usr/local/etc/mongod.conf --fork"
alias stopmongo="killall mongod"


## umask
umask 0077
autoload -U sudo


## functions

# autoload all function except prompts
for FN in $HOME/.zsh_functions/* ; do
    BFN=`basename ${FN}`
    [[ ${BFN} != prompt_*_setup ]] && autoload -Uz ${BFN}
done


## rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

### For CoffeeScript
export PATH="/usr/local/share/npm/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


## pip
export PIP_RESPECT_VIRTUALENV=true

## virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1
VIRTUALENV_BASE="${HOME}/.virtualenvs"
activate() {
    if [ $# -le 0 ]; then
        set -- default
    fi
    [[ -s ${VIRTUALENV_BASE}/$1/bin/activate ]] && . ${VIRTUALENV_BASE}/$1/bin/activate
}
activate

## perl5 (requires local::lib installed)
# [[ -s "$HOME/.perl5" ]] && eval $(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)

## system-based
[[ -s "$HOME/.zshrc_$(uname -s | tr '[A-Z]' '[a-z]')" ]] && \
    source "$HOME/.zshrc_$(uname -s | tr '[A-Z]' '[a-z]')"

## local config
[[ -s "$HOME/.zshrc_local" ]] && source "$HOME/.zshrc_local"


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
