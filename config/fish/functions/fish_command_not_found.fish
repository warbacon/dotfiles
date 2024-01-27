function fish_command_not_found
    printf "%sERROR:%s command %s%s%s not found.\n" \
        (set_color brred --bold) (set_color normal) \
        (set_color blue --underline) $argv[1] (set_color normal)
end
