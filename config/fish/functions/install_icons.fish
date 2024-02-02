function install_icons
    if not command -q wget 
        echo "wget is not available."
        return 1
    end
    
    test -d "$HOME/.local/share/fonts"
    or mkdir -p "$HOME/.local/share/fonts"

    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/NerdFontsSymbolsOnly/SymbolsNerdFont-Regular.ttf \
        -O "$HOME/.local/share/fonts/SymbolsNerdFont-Regular.ttf"
end
