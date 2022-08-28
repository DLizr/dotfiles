local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local tag_template = require("modules.tag_template")
local screen_swapper = require("modules.screen_swapper")
local screenshot_taker = require("modules.screenshot_taker")
local dictionary = require("modules.dictionary")
local dashboard = require("interface.dashboard.dashboard")

local volume_control = require("modules.volume_control")
local brightness_control = require("modules.brightness_control")


local keys = {}

keys.globalkeys = gears.table.join(
    awful.key({ modkey,           }, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({ modkey, shiftkey   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, shiftkey   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey, shiftkey   }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, ctrlkey }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, shiftkey   }, "q", function () awful.spawn.with_shell("shutdown_options") end,
              {description = "show shutdown options", group = "launcher"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, shiftkey   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey }, "i",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, shiftkey }, "i",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, ctrlkey }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, ctrlkey }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.spawn.with_shell("rofi -show drun") end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey, shiftkey }, "r",     function () awful.spawn.with_shell("redshift_rofi") end,
              {description = "run redshift GUI", group = "launcher"}),

    awful.key({ }, "Print",     screenshot_taker.quick_shot,
              {description = "quick screenshot", group = "launcher"}),

    awful.key({ modkey }, "Print",     screenshot_taker.area_shot,
              {description = "area screenshot", group = "launcher"}),

    awful.key({ shiftkey }, "XF86AudioRaiseVolume", function() volume_control.change_volume("+10%") end,
              {description = "raise volume by 10%", group = "user"}),

    awful.key({ shiftkey }, "XF86AudioLowerVolume", function() volume_control.change_volume("-10%") end,
              {description = "lower volume by 10%", group = "user"}),

    awful.key({ }, "XF86AudioRaiseVolume", function() volume_control.change_volume("+2%") end,
              {description = "raise volume by 2%", group = "user"}),

    awful.key({ }, "XF86AudioLowerVolume", function() volume_control.change_volume("-2%") end,
              {description = "lower volume by 2%", group = "user"}),

    awful.key({ }, "XF86AudioMute", function() volume_control.toggle_mute() end,
              {description = "toggle mute", group = "user"}),

    awful.key({ shiftkey }, "XF86MonBrightnessUp", function() brightness_control.change_brightness("10%+") end,
              {description = "increase brightness by 10%", group = "user"}),

    awful.key({ shiftkey }, "XF86MonBrightnessDown", function() brightness_control.change_brightness("10%-") end,
              {description = "decrease brightness by 10%", group = "user"}),

    awful.key({ }, "XF86MonBrightnessUp", function() brightness_control.change_brightness("2%+") end,
              {description = "increase brightness by 2%", group = "user"}),

    awful.key({ }, "XF86MonBrightnessDown", function() brightness_control.change_brightness("2%-") end,
              {description = "decrease brightness by 2%", group = "user"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    awful.key({ modkey }, ",",
        function ()
            awful.screen.focus_relative(1)
        end ,
        {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, shiftkey }, "Tab", screen_swapper.swap,
        {description = "swap clients on 2 screens", group = "screen"}),

    awful.key({ modkey, shiftkey }, "t", tag_template.run,
        {description = "tag template", group = "user"}),

    awful.key({ modkey }, "d", function() dashboard.toggle() end,
        {description = "toggle dashboard", group = "user"}),

    awful.key({ modkey, shiftkey }, "d", function() dictionary.search() end,
        {description = "search in dictionary", group = "user"})
)

keys.clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, shiftkey   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, shiftkey }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, ctrlkey }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, shiftkey   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    awful.key({ modkey, shiftkey }, ",",
        function(c)
            c:move_to_screen()
        end ,
        {description = "move to the next screen", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, ctrlkey }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, shiftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, ctrlkey, shiftkey }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

keys.clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(keys.globalkeys)

return keys
