local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local utils = require("utils")


local clock = wibox.widget {
    format = " %a %d %R ",
    align = "center",
    valign = "center",
    widget = wibox.widget.textclock,
    font = beautiful.font_name .. "10",
}

clock.markup = utils.set_color(clock.text, beautiful.xcolor7)
clock:connect_signal("widget::redraw_needed", 
    function()
        clock.markup = utils.set_color(clock.text, beautiful.xcolor7)
    end
)

local clock_widget = wibox.widget {
    {
        clock,
        bg = beautiful.xcolor15,
        widget = wibox.container.background
    },
    widget = wibox.container.margin
}

local systray = wibox.widget.systray()
systray:set_base_size(beautiful.systray_icon_size)

local systray_widget = wibox.widget {
    {
        systray,
        top = beautiful.dpi(2),
        left = beautiful.dpi(5),
        right = beautiful.dpi(5),
        layout = wibox.container.margin
    },
    bg = beautiful.xcolor8,
    widget = wibox.container.background
}


awful.screen.connect_for_each_screen(function(s)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    s.mytaglist = wibox.widget {
        require("interface.taglist")(s),
        bg = beautiful.color15,
        widget = wibox.container.background
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 20 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        -- s.mytasklist, -- Middle widget
        nil,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.only_on_screen(systray_widget, screen[1]),
            clock_widget,
        },
    }
end)
