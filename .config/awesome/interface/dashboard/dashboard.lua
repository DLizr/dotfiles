local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")

local status = require("interface.dashboard.system_status")
local base_widgets = require("interface.base_widgets")


local visible = false
local dashboard = {}
local todo = base_widgets.command_output {
    x = beautiful.dpi(350),
    y = beautiful.dpi(50),
    width = beautiful.dpi(900),
    height = beautiful.dpi(600),
    command = "print_todo",
    update_interval = 60,
}

local weather = base_widgets.command_output {
    x = beautiful.dpi(1300),
    y = beautiful.dpi(50),
    width = beautiful.dpi(450),
    height = beautiful.dpi(180),
    command = "curl 'wttr.in?QT0'", 
    update_interval = 300,
}

local widgets = {todo, status, weather}

local grabber = awful.keygrabber {
    keybindings = {
        {{          }, "h", 
            function()
                utils.spawn_terminal({command = "htop"})
                dashboard.toggle()
            end },
        {{          }, "w", 
            function()
                utils.spawn_terminal({command = "/home/user/.scripts/weather_report"})
                dashboard.toggle()
            end },
        {{ modkey   }, "d", function() dashboard.toggle() end }
    },
    stop_key = "Escape"
}


function dashboard.toggle()
    visible = not visible
    for ind, widget in pairs(widgets) do
        widget:toggle()
    end
    if (visible) then
        grabber:start()
    else
        grabber:stop()
    end
end

return dashboard
