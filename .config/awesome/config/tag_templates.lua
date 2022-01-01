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
        terminal_in_directory .. "CP",
        terminal_in_directory .. "CP"
    },
    func = function()
        awful.screen.focused().selected_tag.master_width_factor = 0.75
    end
}

return tag_templates
