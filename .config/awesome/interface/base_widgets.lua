local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local utils = require("utils")
local gears = require("gears")

local base_widgets = {}

function base_widgets.command_output(args)
    local widget = wibox({visible = false, ontop = true, screen = screen.primary, type = "normal"})
    widget.x = args.x or 0
    widget.y = args.y or 0
    widget.width = args.width or 100
    widget.height = args.height or 100
    widget.border_width = args.border_width or 2
    widget.border_color = args.border_color or beautiful.border_focus

    widget:setup {
        {
            id = "output",
            markup = "N/A",
            font = "Fira Mono Regular " .. (args.font_size or beautiful.dpi(16)),
            widget = wibox.widget.textbox,
            valign = "top",
            align = "left",
        },
        left = beautiful.dpi(12),
        right = beautiful.dpi(12),
        top = beautiful.dpi(4),
        bottom = beautiful.dpi(4),
        layout = wibox.container.margin
    }
    local wrapper = {}
    wrapper.widget = widget
    wrapper.visible = false

    wrapper.update = function()
        awful.spawn.easy_async_with_shell(
            args.command,
            function(stdout)
                widget:get_children_by_id("output")[1].markup = utils.set_color(stdout, args.color or beautiful.xforeground)
            end
        )
    end
    wrapper.update_interval = args.update_interval or 2

    wrapper.update_timer = gears.timer {
        timeout = wrapper.update_interval,
        callback = wrapper.update
    }

    function wrapper.toggle()
        if (wrapper.visible) then
            wrapper.visible = false
            wrapper.widget.visible = false
            wrapper.update_timer:stop()
        else
            wrapper.visible = true
            wrapper.widget.visible = true
            wrapper.update_timer:start()
            wrapper.update()
        end
    end

    return wrapper
end

return base_widgets
