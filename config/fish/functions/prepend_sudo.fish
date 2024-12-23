function prepend_sudo
    # Get current command line buffer
    set -l buffer (commandline -o)

    # Helper function to handle editor commands
    function toggle_editor_sudo
        set -l cmd $argv
        if test "$cmd[1]" = "$EDITOR"
            echo "sudo -e $cmd[2..]"
        else if test "$cmd[1..2]" = "sudo -e"
            echo "$EDITOR $cmd[3..]"
        else
            return 1
        end
    end

    # If buffer is empty, try with last command from history
    if test -z "$buffer"
        set buffer (string split ' ' $history[1])
    end

    # Try to toggle editor command
    set -l result (toggle_editor_sudo $buffer)
    if test $status -eq 0
        commandline -r $result
        return
    end

    # If not an editor command, toggle regular sudo
    if test "$buffer[1]" = sudo
        commandline -r "$buffer[2..]"
    else
        commandline -r "sudo $buffer"
    end
end
