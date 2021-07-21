local awful = require("awful")
local naughty = require("naughty")

local screen_swapper = {}

function screen_swapper.swap()
    if screen:count() == 2 then
        local clients1 = screen[1].selected_tag:clients()

        for _, c in ipairs(screen[2].selected_tag:clients()) do
            c:move_to_tag(screen[1].selected_tag)
        end

        for _, c in ipairs(clients1) do
            c:move_to_tag(screen[2].selected_tag)
        end

    else
        naughty.notify({ text = "Only 2 screen setups are supported." })
    end
end

return screen_swapper
