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


local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )


awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    local mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    s.mytaglist = wibox.widget {
        mytaglist,
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
