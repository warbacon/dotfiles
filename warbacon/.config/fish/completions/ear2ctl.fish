set -l commands anc ear-tip-fit-test help in-ear-detection
set -l anc_subcommands high mid low adaptive transparency off

complete -c ear2ctl -f

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a ear-tip-fit-test -d "Start or stop the ear tip fit test"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a help -d "Print the help of the given subcommand(s)"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a in-ear-detection -d "Turn in-ear detection on or off"
complete -c ear2ctl -n "__fish_seen_subcommand_from in-ear-detection" -ra "on off"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a info -d "Device information"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a low-latency-mode -d "Turn low latency mode on or off"
complete -c ear2ctl -n "__fish_seen_subcommand_from low-latency-mode" -ra "on off"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a shortcuts -d "View and set pinch gestures"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -a anc -d "Control active noise cancellation"
complete -c ear2ctl -n "__fish_seen_subcommand_from anc" -ra "$anc_subcommands"

complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands -h --help" -s v -l version -d "Print version"
complete -c ear2ctl -n "not __fish_seen_subcommand_from -h --help" -s h -l help -d "Print help"
