local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local utils = require("utils")
local terminal_names = require("config/terminal_names")

local notes = {}

local visible = true

function notes.spawn()
    utils.spawn_terminal({ name = terminal_names.dashboard_notes, command = "htop"})
end

function notes.callback(c)
    c.floating = true
    c.x = beautiful.dpi(250)
    c.y = beautiful.dpi(480)
    c.width = beautiful.dpi(640)
    c.height = beautiful.dpi(300)
end


return notes
