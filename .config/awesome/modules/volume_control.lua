local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local widget = wibox({visible = false, ontop = true, type = "popup_menu", screen = screen.primary})
widget.width = beautiful.dpi(150)
widget.height = beautiful.dpi(150)
widget.x = (screen.primary.geometry.width - beautiful.dpi(150)) / 2
widget.y = (screen.primary.geometry.height - beautiful.dpi(180)) / 2
widget.border_width = 2
widget.border_color = beautiful.border_focus


widget:setup {
    {
        {
            id = "icon",
            text = "󰕾",
            font = beautiful.icon_font_name .. beautiful.dpi(65),
            widget = wibox.widget.textbox,
            align = "center",
            valign = "top",
        },
        layout = wibox.container.margin,
        top = -beautiful.dpi(15),
        left = -beautiful.dpi(12),
        bottom = -beautiful.dpi(18),
    },
    {
        id = "percentage",
        text = "100%",
        font = "Fira Mono Regular " .. beautiful.dpi(35),
        widget = wibox.widget.textbox,
        align = "center",
        valign = "bottom",
    },
    layout = wibox.layout.fixed.vertical
}

local volume_control = {}

function volume_control.change_volume(delta)
    awful.spawn.with_shell("pactl set-sink-volume 0 " .. delta)
    volume_control.update()
end

function volume_control.toggle_mute()
    awful.spawn.with_shell("pactl set-sink-mute 0 toggle")
    volume_control.update()
end

local last_update = os.time()
    
local disappear_timer = gears.timer {
    timeout = 1,
    autostart = true,
    single_shot = true,
    callback = function()
        widget.visible = false
    end
}

function volume_control.update(silent)
    silent = silent or false
    awful.spawn.easy_async_with_shell(
        "pactl get-sink-mute 0 | awk '{print $2}'",
        function(stdout)
            if (stdout:find("no") ~= nil) then
                widget:get_children_by_id("icon")[1].text = "󰕾"
            else
                widget:get_children_by_id("icon")[1].text = "󰝟"
            end
        end
    )

    awful.spawn.easy_async_with_shell(
        "pactl get-sink-volume 0 | awk '{print $5}'",
        function(stdout)
            widget:get_children_by_id("percentage")[1].text = stdout
        end
    )

    if (not silent) then
        last_update = os.time()
        widget.visible = true

        disappear_timer:again()
    end
end

volume_control.update(true)

return volume_control
