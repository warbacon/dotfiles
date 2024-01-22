function go_dir
    if not command -q fzf
        echo "fzf is not installed."
        return
    end

    test -z $argv[1]
    and return

    set dir "$argv[1]/"(find "$argv[1]/"* -maxdepth 0 -type d -printf "%f\n" | fzf)
    
    if test -z "$dir"
        return
    end

    cd "$dir"

    commandline -f repaint
end
