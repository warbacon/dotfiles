function fish_command_not_found
    printf "%sERROR:%s command %s%s%s not found.\n" \
        (set_color brred --bold) (set_color normal) \
        (set_color --italic) \e[4:3m\e[58:5:1m$argv[1] (set_color normal)


    test -z $ENABLE_MEMES; and return

    echo

    set meme (random 1 5)

    switch $meme
        case 1
            printf "%sJosefi:%s\n" (set_color --bold --italic) (set_color normal)
            kitten icat --align left ~/Imágenes/mads-mikkelsen-smoking.gif
        case 2
            printf "%sAlfredo:%s\n" (set_color --bold --italic) (set_color normal)
            kitten icat --align left ~/Imágenes/bee-movie-meme-roblox-53521200.webp
        case 3
            printf "%sDLH cuando me cago en su pecho:%s\n" (set_color --bold --italic) (set_color normal)
            kitten icat --align left ~/Imágenes/nowaying.gif
        case 4
            printf "%sAlexelcaso:%s\n" (set_color --bold --italic) (set_color normal)
            kitten icat --align left ~/Imágenes/alexelcaso.jpg
        case 5
            printf "%sLa pizarra de Elena:%s\n" (set_color --bold --italic) (set_color normal)
            kitten icat --align left ~/Imágenes/jeroglifico.jpg
    end
end
