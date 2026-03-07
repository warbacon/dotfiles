status is-interactive
or return

# OPTIONS
set -g fish_greeting

# ALIASES
abbr -a rm rm -v
abbr -a cp cp -iv
abbr -a mv mv -iv

abbr_if_exists ff fastfetch
abbr_if_exists lg lazygit

# APPEARANCE
dircolors -c | string replace setenv "set -x" | source
fish_config theme choose richer

# function __prompt_newline --on-event fish_prompt
#     set -q __should_add_newline
#     and test $__should_add_newline = true
#     and echo
#     or set -g __should_add_newline true
# end

if test "$TERM" != linux; and command -q starship
    starship init fish --print-full-init | source
else
    set __fish_git_prompt_showuntrackedfiles 1
    set __fish_git_prompt_show_informative_status 1
    fish_config prompt choose astronaut
end

# KEYBINDS
if type -q fzf_key_bindings
    fzf_key_bindings
end
