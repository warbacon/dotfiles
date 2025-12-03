function fish_command_not_found
    set -l cmd (string escape -- $argv[1])
    printf "%sERROR:%s command %s%s%s not found.\n" \
        (set_color red --bold) \
        (set_color normal) \
        (set_color --underline=curly --underline-color=red) \
        $cmd \
        (set_color normal)
end
