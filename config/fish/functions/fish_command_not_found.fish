function fish_command_not_found
    printf "%sERROR:%s command %s%s%s not found.\n" \
        (set_color brred --bold) (set_color normal) \
        (set_color --italic) \e[4:3m\e[58:5:1m$argv[1] (set_color normal)
end
