local dpi   		= require("beautiful.xresources").apply_dpi
local gears 		= require("gears")
local theme_assets 	= require("beautiful.theme_assets")

theme.font              	= "Terminus 8"

theme.bg_normal                 = "#000000"
theme.bg_focus                  = "#000000"
theme.bg_urgent                 = "#000000"

theme.fg_normal                 = "#aaaaaa"
theme.fg_focus                  = "#ff8c00"
theme.fg_urgent                 = "#af1d18"
theme.fg_minimize               = "#ffffff"

theme.border_normal             = "#1c2022"
theme.border_focus              = "#606060"
theme.border_marked             = "#3ca4d8"

theme.menu_height 		= dpi(16)
theme.menu_width 		= dpi(120)
theme.menu_border_width         = 0

theme.menu_bg_normal            = "#050505dd"
theme.menu_bg_focus             = "#050505dd"
theme.menu_fg_normal            = "#aaaaaa"
theme.menu_fg_focus             = "#ff8c00"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

--Menu launcher icon
theme.awesome_icon       = icon_dir .. "launcher/arch3.svg"
theme.awesome_subicon    = icon_dir .. "launcher/arch3.svg"

theme.menu_submenu_icon                         = icon_dir .. chosen_theme .. "/submenu.png"
theme.taglist_squares_sel                       = icon_dir .. chosen_theme .. "/square_a.png"
theme.taglist_squares_unsel                     = icon_dir .. chosen_theme .. "/square_b.png"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Try to determine if we are running light or dark colorscheme:
local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)
