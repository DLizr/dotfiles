local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("utils")


-- Time widget.

local time = wibox.widget.textclock("%H %M")
time.align = "center"
time.valign = "center"
time.font = beautiful.dashboard_time_font .. "40"
time.markup = utils.set_color(time.text, beautiful.dashboard_time_color)

time:connect_signal("widget::redraw_needed", function()
    time.markup = utils.set_color(time.text, beautiful.dashboard_time_color)
end)


-- Putting it all together.

local dash = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
dash.bg = beautiful.dashboard_bg
dash.border_width = 2
dash.border_color = beautiful.dashboard_border_color
dash.height = 300
dash.width = screen.primary.geometry.width - dash.border_width * 2
dash.y = -dash.border_width
dash.x = 0

dash:setup {
    {
        time,
        layout = wibox.layout.align.horizontal
    },
    layout = wibox.layout.align.vertical
}

local dashboard = {}
function dashboard.toggle()
    dash.visible = not dash.visible
end

return dashboard
