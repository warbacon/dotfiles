function wpy -d "Run a renpy game using wayland"
    set -x SDL_VIDEODRIVER wayland
    set -x SDL_DYNAMIC_API /usr/lib64/libSDL2.so
    sh $argv
end
