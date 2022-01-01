local awful = require("awful")
local naughty = require("naughty")

local screenshot_taker = {}


local send_notification = function()
    naughty.notify({ title = "Screenshot Taken", text = "Click to open", 
    run = function() 
        awful.spawn.with_shell("alacritty --working-directory ~/Images/Screenshots") 
    end, 
    timeout = 10 })
end

function screenshot_taker.quick_shot()
    awful.spawn.with_shell("scrot -e 'mv $f ~/Images/Screenshots/'")
    send_notification()
end

function screenshot_taker.area_shot()
    awful.spawn.with_shell("scrot -s -e 'xclip -selection clipboard -t image/png -i $f'")
end

return screenshot_taker

