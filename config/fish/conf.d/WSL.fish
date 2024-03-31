test -f /proc/sys/fs/binfmt_misc/WSLInterop
and set is_wsl false
or return

set is_wsl true
set -x LANG es_ES.UTF-8
set -x BROWSER wslview
