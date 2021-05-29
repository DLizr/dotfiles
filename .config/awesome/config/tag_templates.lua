-- Format:
-- tag_templates.command_name {
--     apps {
--         application1,
--         application2,
--     },
--     func = function()
--         -- Function to run after launching applications.
--     end
-- }


local awful = require("awful")


local tag_templates = {}

tag_templates.cp = {
    apps = {
        terminal_in_directory .. "NotSchool/CPP/Competitive",
        terminal_in_directory .. "NotSchool/CPP/Competitive"
    }
}

return tag_templates