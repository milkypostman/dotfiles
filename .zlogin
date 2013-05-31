### .zlogin

#
# Executes commands at login post-zshrc.
#

# Execute code that does not affect the current session in the background.
{
    # Compile the completion dump to increase startup speed.
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
    if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
        zcompile "$zcompdump"
    fi

    # Set environment variables for launchd processes.
    if [[ "$OSTYPE" == darwin* ]]; then
        for env_var in PATH MANPATH; do
            launchctl setenv "$env_var" "${(P)env_var}"
        done
    fi
} &!

# Print a random, hopefully interesting, adage.
if (( $+commands[fortune] )); then
    COWDIR=/usr/local/share/cows/; COWNUM=$(($RANDOM%$(ls $COWDIR | wc -l))); COWFILE=$(ls $COWDIR | sed -n ''${COWNUM}'p'); fortune  | fmt -80 -s | cowsay -n -f $COWFILE
    #fortune -a
    print
fi
