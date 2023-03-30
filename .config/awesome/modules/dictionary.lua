local awful = require("awful")
local gears = require("gears")
local dictionary = {}

local NAME1 = "ScratchDictionary"
local NAME2 = "FloatingDictionary"

local tag = awful.tag.add("-Dictionary", {
    screen = awful.screen.primary
})

local wait_and_do = function(time, func)
    local timer = gears.timer {
        timeout = time,
        autostart = true,
        single_shot = true,
        callback = func,
    }
end

local raise = function()
    local found = false
    for _, c in ipairs(client.get()) do
        if (c.name == NAME1) then
            found = true
            break
        end
    end

    local delay = 0
    if (not found) then
        awful.spawn("alacritty -t " .. NAME1 .. " -e sdcv")
        delay = 0.2
    end

    wait_and_do(delay,
        function()
            for _, c in ipairs(client.get()) do
                if (c.name == NAME1) then
                    client.focus = c
                    break
                end
            end
        end
    )
end

function dictionary.toggle()
    local raised = false
    for _, c in ipairs(client.get()) do
        if (c.name == NAME1 and tag.selected) then
            raised = true
            break
        end
    end
    if (raised) then
        tag.selected = false
    else
        tag.selected = true
        raise()
    end
end

function dictionary.search()
    for _, c in ipairs(client.get()) do
        if (c.name == NAME2) then
            c:kill()
            return
        end
    end
    awful.spawn("alacritty -t " .. NAME2 .. " -e /home/user/.scripts/search_dictionary")

end

return dictionary
