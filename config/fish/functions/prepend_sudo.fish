function prepend_sudo
    set -l buffer (commandline -o)
    
    # Feillo pero funciona.
    if test "$buffer[1]" = "$EDITOR"
        commandline -r "sudo -e $buffer[2..]"
    else if test "$buffer[1..2]" = "sudo -e"
        commandline -r "$EDITOR $buffer[3..]"
    else if test -z "$buffer"
        set -l nose (string split ' ' $history[1])
        if test "$nose[1]" = "$EDITOR"
            commandline -r "sudo -e $nose[2..]"
        else if test "$nose[1..2]" = "sudo -e"
            commandline -r "$EDITOR $nose[3..]"
        else
            fish_commandline_prepend "sudo"
        end
    else
        fish_commandline_prepend "sudo"
    end
end
