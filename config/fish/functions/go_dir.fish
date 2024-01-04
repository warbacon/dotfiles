function go_dir
    if not command -q eza
        echo "eza is not installed."
        return
    end

    if not command -q fzf
        echo "fzf is not installed."
        return
    end

    test -z $argv[1]
    and return

    set dir "$argv[1]/"(eza -D "$argv[1]" | fzf)
    
    if test -z "$dir"
        return
    end

    cd "$dir"

    commandline -f repaint
end
