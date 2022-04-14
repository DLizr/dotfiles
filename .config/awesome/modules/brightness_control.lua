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
            text = "",
            font = beautiful.icon_font_name .. beautiful.dpi(65),
            widget = wibox.widget.textbox,
            align = "center",
            valign = "top",
        },
        layout = wibox.container.margin,
        top = -beautiful.dpi(15),
        left = -beautiful.dpi(28),
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

local brightness_control = {}

function brightness_control.change_brightness(delta)
    awful.spawn.easy_async_with_shell("brightnessctl -d intel_backlight s " .. delta, 
        function()
            brightness_control.update()
        end
    )
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

function brightness_control.update(silent)
    silent = silent or false
    awful.spawn.easy_async_with_shell(
        "brightnessctl -d intel_backlight get",
        function(stdout)
            local current = tonumber(stdout)
            if (current ~= nil) then
                awful.spawn.easy_async_with_shell(
                    "brightnessctl -d intel_backlight max",
                    function(stdout)
                        local max = tonumber(stdout)
                        widget:get_children_by_id("percentage")[1].text = tostring(current * 100 // max) .. "%"
                    end
                )
            end
        end
    )

    if (not silent) then
        last_update = os.time()
        widget.visible = true

        disappear_timer:again()
    end
end

brightness_control.update(true)

return brightness_control
