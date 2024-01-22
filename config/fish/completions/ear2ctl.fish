set -l commands anc ear-tip-fit-test help in-ear-detection info low-latency-mode shortcuts anc

complete -c ear2ctl -f
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a ear-tip-fit-test -d "Start or stop the ear tip fit test"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a help -d "Print the help of the given subcommand(s)"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a in-ear-detection -d "Turn in-ear detection on or off"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a info -d "Device information"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a low-latency-mode -d "Turn low latency mode on or off"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a shortcuts -d "View and set pinch gestures"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -a anc -d "Control active noise cancellation"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -s v -l version -d "Print version"
complete -c ear2ctl -n "not __fish_seen_subcommand_from $commands" -s h -l help -d "Print help"
