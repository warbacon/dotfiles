function fzf-history
    builtin history merge

    set -l cmd (
        builtin history --null |
        fzf --read0 --print0 \
            --scheme=history \
            --query=(commandline) \
            --prompt="History> " \
            --layout=reverse \
            --height=50% \
            --cycle \
            --border \
            --no-sort |
        string split0
    )
    if test -n "$cmd"
        commandline --replace $cmd
    end

    commandline --function repaint
end
