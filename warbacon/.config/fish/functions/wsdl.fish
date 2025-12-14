function wsdl --description "Run SDL applications with Wayland video driver"
    set -x SDL_VIDEODRIVER wayland
    command $argv[1]
end
