local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local utils = require("utils")

local visible = false
local system_status = {}

local function setup_monitor(args)
    local icon = args.icon
    local icon_size = args.icon_size or 40
    local widget = wibox.widget {
        {
            {
                id = "icon",
                markup = utils.set_color(icon, beautiful.xcolor3),
                font = beautiful.icon_font_name .. beautiful.dpi(icon_size),
                widget = wibox.widget.textbox,
                align = "center",
                valign = "center",
            },
            {
                id = "value",
                markup = "N/A",
                font = "Fira Mono Regular " .. beautiful.dpi(24),
                widget = wibox.widget.textbox,
                align = "center",
                valign = "center",
            },
            layout = wibox.layout.align.horizontal
        },
        layout = wibox.container.margin,
        left = beautiful.dpi(20),
        right = beautiful.dpi(20),
    }
    return widget
end

local cpu = setup_monitor {icon = " "}
local cpu_update = function()
    awful.spawn.easy_async_with_shell(
        "vmstat 1 2 | tail -n1 | awk '{print 100 - $15}'",
        function(stdout)
            local usage = tonumber(stdout)
            cpu:get_children_by_id("value")[1].markup = utils.set_color(tostring(usage) .. "%", beautiful.xcolor2)
        end
    )
end

local cpu_timer = gears.timer {
    timeout = 2,
    callback = cpu_update
}

local ram = setup_monitor {icon = " "}
local ram_update = function()
    awful.spawn.easy_async_with_shell(
        "free -m | grep \"Mem:\" | awk '{print $3}'",
        function(stdout)
            local usage = tonumber(stdout) / 1000
            local value = utils.set_color(string.sub(tostring(usage), 1, 3) .. "G", beautiful.xcolor2)
            ram:get_children_by_id("value")[1].markup = value
        end
    )
end
local ram_timer = gears.timer {
    timeout = 2,
    callback = ram_update
}

local mem_root = setup_monitor {icon = "/~", icon_size = 36}
local mem_root_update = function()
    awful.spawn.easy_async_with_shell(
        "df -h | grep '/$' | awk '{print $4}'",
        function(stdout)
            local usage = string.gsub(stdout, "\n", "")
            mem_root:get_children_by_id("value")[1].markup = utils.set_color(usage, beautiful.xcolor2)
        end
    )
end
local mem_root_timer = gears.timer {
    timeout = 30,
    callback = mem_root_update
}

local mem_home = setup_monitor {icon = "/ ~", icon_size = 32}
local mem_home_update = function()
    awful.spawn.easy_async_with_shell(
        "df -h | grep '/home' | awk '{print $4}'",
        function(stdout)
            local usage = string.gsub(stdout, "\n", "")
            mem_home:get_children_by_id("value")[1].markup = utils.set_color(usage, beautiful.xcolor2)
        end
    )
end
local mem_home_timer = gears.timer {
    timeout = 30,
    callback = mem_home_update
}

local status_widget = wibox({visible = true, ontop = true, screen = screen.primary, type = "normal"})
status_widget.width = beautiful.dpi(250)
status_widget.height = beautiful.dpi(292)
status_widget.border_width = 2
status_widget.border_color = beautiful.border_focus
status_widget.x = beautiful.dpi(20)
status_widget.y = beautiful.dpi(50)
status_widget.visible = false

status_widget:setup {
    {
        cpu,
        bg = beautiful.xbackground,
        widget = wibox.container.background
    },
    {
        ram,
        bg = beautiful.xcolor15,
        widget = wibox.container.background
    },
    {
        mem_root,
        bg = beautiful.xbackground,
        widget = wibox.container.background
    },
    {
        mem_home,
        bg = beautiful.xcolor15,
        widget = wibox.container.background
    },
    layout = wibox.layout.fixed.vertical,
    expand = "none",
}

local update_functions = {cpu_update, ram_update, mem_root_update, mem_home_update}
local timers = {cpu_timer, ram_timer, mem_root_timer, mem_home_timer}


function system_status.toggle()
    if (visible) then
        for ind, timer in pairs(timers) do
            timer:stop()
        end
        status_widget.visible = false
        visible = false
    else
        for ind, func in pairs(update_functions) do
            func()
        end
        for ind, timer in pairs(timers) do
            timer:start()
        end
        status_widget.visible = true
        visible = true
    end
end

return system_status
