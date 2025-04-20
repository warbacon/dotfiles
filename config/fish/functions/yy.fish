function yy
	if  command -q yazi
		printf "%syazi is not installed.%s\n" (set_color --bold red) (set_color normal)
		return 127
	end

	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
