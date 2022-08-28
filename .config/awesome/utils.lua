local awful = require("awful")
local utils = {}

utils.set_color = function(text, color)
    return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end


utils.spawn_terminal = function(args)
    local cmd = "alacritty"
    if args.name then
        cmd = cmd .. " -t " .. args.name
    end
    if args.command then
        cmd = cmd .. " -e " .. args.command
    end
    awful.spawn(cmd)
end


return utils
