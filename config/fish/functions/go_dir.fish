function go_dir
    not command -q fzf
    and return

    test -z $argv[1]
    and return

    set -l prompt (string replace "$HOME" '~' $argv[1])

    set dir "$argv[1]/"(find "$argv[1]/"* -maxdepth 0 -type d -printf "%f\n" | fzf --prompt "$prompt/")
    
    if test -z "$dir"
        return
    end

    cd $dir 

    commandline -f repaint
end
