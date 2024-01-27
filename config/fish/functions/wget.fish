function wget --wraps='wget --no-hsts' --description 'Non-interactive network downloader'
    command wget --no-hsts $argv
end
