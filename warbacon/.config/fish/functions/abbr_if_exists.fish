function abbr_if_exists -a abbr program
    argparse --min-args=2 --max-args=2 -- $argv
    or return 1

    command -q $program
    and abbr --add -- $abbr $program
end
