function abbr_if_exists
    if command -q $argv[2]
        abbr --add $argv[1] $argv[2]
    end
end
