local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local taglist_filter = function(tag)
    return string.sub(tag.name, 1, 1) ~= "-"
end

local get_taglist = function(s)
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

    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    local mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = taglist_filter, --awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        {
                            id = "text_role",
                            font = beautiful.taglist_font,
                            widget = wibox.widget.textbox
                        },
                        -- Blank space around tag names.
                        top = beautiful.dpi(1),
                        bottom = beautiful.dpi(1),
                        left = beautiful.dpi(10),
                        right = beautiful.dpi(10),
                        widget = wibox.container.margin,
                    },
                    id = "background_role",
                    widget = wibox.container.background,
                },
                -- Width of the line above occupied tags.
                top = beautiful.dpi(2),
                widget = wibox.container.margin,
            },
            -- The line above occupied tags.
            bg = beautiful.taglist_bg_empty,
            widget = wibox.container.background,
            update_callback = function(self, c3, index, objects)
                if (#c3:clients() > 0 or c3.selected) then
                    self.bg = beautiful.taglist_bg_focus
                else
                    self.bg = beautiful.taglist_bg_empty
                end
            end,
        },
    }
    return mytaglist
end
return get_taglist
