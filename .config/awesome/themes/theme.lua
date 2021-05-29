local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}


-- ~/.Xresources colors

theme.dpi = dpi

theme.xbackground = xrdb.background or "#282c34"
theme.xforeground = xrdb.foreground or "#abb2bf"

theme.xcolor0 = xrdb.color0 or "#5c6370" -- Black
theme.xcolor1 = xrdb.color1 or "#e06c75" -- Red
theme.xcolor2 = xrdb.color2 or "#98c379" -- Green
theme.xcolor3 = xrdb.color3 or "#e5c07b" -- Yellow
theme.xcolor4 = xrdb.color4 or "#61afef" -- Blue
theme.xcolor5 = xrdb.color5 or "#c678dd" -- Magenta
theme.xcolor6 = xrdb.color6 or "#56b6c2" -- Cyan
theme.xcolor7 = xrdb.color7 or "#abb2bf" -- White

theme.xcolor8 = xrdb.color8 or "#4b5263" -- Black
theme.xcolor9 = xrdb.color9 or "#be5046" -- Red
theme.xcolor10 = xrdb.color10 or "#98c379" -- Green
theme.xcolor11 = xrdb.color11 or "#d19a66" -- Yellow
theme.xcolor12 = xrdb.color12 or "#61afef" -- Blue
theme.xcolor13 = xrdb.color13 or "#c678dd" -- Magenta
theme.xcolor14 = xrdb.color14 or "#56b6c2" -- Cyan
theme.xcolor15 = xrdb.color15 or "#3e4452" -- White

theme.font_name = "Prompt "
theme.font     = "Prompt 12"
theme.icon_font_name = "Shure Tech Mono Nerd Font "
-- theme.wallpaper = "/home/user/Pictures/Background.png"

theme.bg_normal     = theme.xbackground
theme.bg_focus      = theme.xcolor0
theme.bg_urgent     = theme.xcolor1
theme.bg_minimize   = theme.xcolor8
theme.bg_systray    = theme.xcolor8

theme.fg_normal     = theme.xforeground
theme.fg_focus      = theme.xcolor3
theme.fg_urgent     = theme.xcolor0
theme.fg_minimize   = theme.xcolor8

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(2)
theme.border_normal = theme.xcolor0
theme.border_focus  = theme.xforeground
theme.border_marked = theme.xcolor3

theme.taglist_bg_empty = theme.xcolor15
theme.taglist_bg_occupied = theme.xcolor15
theme.taglist_fg_occupied = theme.xcolor4
theme.taglist_font = theme.font_name .. " Bold 12" 

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
theme.systray_icon_size = dpi(15)
theme.systray_icon_spacing = dpi(2)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"


-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

