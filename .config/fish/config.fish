function maybe_prepend_paths
    for p in $argv[-1..1]
        if not contains -- $p $PATH
            set PATH $p $PATH
        end
    end
end

maybe_prepend_paths $HOME/bin /usr/local/homebrew/bin
set -gx GOPATH $HOME

abbr --add s ssh
abbr --add rza exec fish
