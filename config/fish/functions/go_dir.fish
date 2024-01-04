function go_dir
    test -z $argv[1]
    and return

    set dir "$argv[1]/"(eza -D "$argv[1]" | fzf)
    
    if test -z "$dir"
        return
    end

    cd "$dir"

    commandline -f repaint
end
