local naughty = require("naughty")

terminal = "alacritty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
terminal_cmd = terminal .. " -e "
terminal_in_directory = terminal .. " --working-directory "


modkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

naughty.config.defaults.timeout = -1
