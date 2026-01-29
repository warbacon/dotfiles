status is-interactive
or return

set -g fish_greeting
dircolors -c | string replace "setenv" "set -x" | source

abbr_if_exists ff fastfetch
abbr_if_exists lg lazygit

function __prompt_newline --on-event fish_prompt
    set -q __should_add_newline
    and test $__should_add_newline = true
    and echo
    or set -g __should_add_newline true
end

test "$TERM" != "linux"
and command -q starship
and starship init fish --print-full-init | source

if type -q skim_key_bindings
    set -x SKIM_DEFAULT_OPTIONS "--layout=reverse --algo=frizbee"
    set -x SKIM_CTRL_T_COMMAND "fd -H --color=never"
    set -x SKIM_ALT_C_COMMAND "fd -H --color=never --type d"
    set -x SKIM_ALT_C_OPTS '--preview="tree -C -L 3 {}"'
    skim_key_bindings
end
