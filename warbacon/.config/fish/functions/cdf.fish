function cdf
    set preview_cmd
    if test $COLUMNS -gt 80
        set preview_cmd "eza --tree --color=always --level=3 --icons=always {}"
    end

    set dir (fd --type directory -H \
        --exclude .git \
        --exclude node_modules \
        --exclude .cache \
        --exclude .local/share/Trash \
        --exclude .vscode \
        --exclude .npm \
        --exclude .docker \
        --exclude .mozilla \
        --exclude vendor \
        | fzf --height=50% \
            --prompt="Go to> " \
            --scheme=path \
            --layout=reverse \
            --border \
            --cycle \
            --preview=$preview_cmd
    )

    if test -n "$dir"
        cd "$dir"
    end

    commandline -f repaint
end
