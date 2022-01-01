local wibox = require("wibox")
local awful = require("awful")
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
            text = "墳",
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

function volume_control.update()
    awful.spawn.easy_async_with_shell(
        "pactl get-sink-mute 0 | awk '{print $2}'",
        function(stdout)
            if (stdout:find("no") ~= nil) then
                widget:get_children_by_id("icon")[1].text = "墳"
            else
                widget:get_children_by_id("icon")[1].text = "婢"
            end
        end
    )

    awful.spawn.easy_async_with_shell(
        "pactl get-sink-volume 0 | awk '{print $5}'",
        function(stdout)
            widget:get_children_by_id("percentage")[1].text = stdout
        end
    )
end

function volume_control.toggle_widget()
    widget.visible = not widget.visible
end

volume_control.update()

return volume_control
