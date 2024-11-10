local starship_config = os.getenv("HOME") .. "/.config/yazi/starship.toml"

require("starship"):setup({ config_file = starship_config })
require("full-border"):setup()
