local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local utils = require("utils")
local gears = require("gears")

local todo = {}

local visible = false
local widget = wibox({visible = false, ontop = true, screen = screen.primary, type = "normal"})


local update_timer = gears.timer {
    timeout = 2,
    call_now = true,
    callback = function()
        awful.spawn.easy_async_with_shell(
            "task dash",
            function(stdout)
                widget:get_children_by_id("output")[1].markup = stdout
            end
        )
    end
}

function todo.toggle()
    if (visible) then
        visible = false
        widget.visible = false
        update_timer:stop()
    else
        visible = true
        widget.visible = true
        update_timer:start()
    end
end

return todo
