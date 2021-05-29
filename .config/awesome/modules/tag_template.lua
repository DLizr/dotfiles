-- tag_templates is a small module that allows you to run certain applications/functions
-- by typing special commands in prompt.

-- To add a new command edit config/tag_templates.


local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")

local tag_templates = require("config.tag_templates")

local tag_template = {}

local textbox = wibox.widget.textbox()

local input_handler = function(input)
    if tag_templates[input] then
        if tag_templates[input].apps then
            for i, app in pairs(tag_templates[input].apps) do
                awful.spawn(app)
            end
        end
        if tag_templates[input].func then
            tag_templates[input].func()
        end
    else
        naughty.notify { text = "Invalid tag template: `".. input .."`." }
    end
end


function tag_template.run()
    awful.prompt.run {
        prompt = "Tag Template: ",
        textbox = awful.screen.focused().mypromptbox.widget,
        exe_callback = input_handler
    }
end

return tag_template

