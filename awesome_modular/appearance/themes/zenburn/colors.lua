local dpi = require("beautiful.xresources").apply_dpi

theme.font      = "sans 8"

theme.fg_normal  = "#DCDCCC"
theme.fg_focus   = "#F0DFAF"
theme.fg_urgent  = "#CC9393"
theme.bg_normal  = "#242835"
theme.bg_focus   = "#3A3E4F"
theme.bg_urgent  = "#B40D05"
theme.bg_systray = theme.bg_normal

theme.border_width  = dpi(2)
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#6F6F6F"
theme.border_marked = "#CC9393"

theme.titlebar_bg_focus  = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal

theme.menu_submenu_icon                         = icon_dir .. chosen_theme .. "/submenu.png"
theme.taglist_squares_sel                       = icon_dir .. chosen_theme .. "/square_a.png"
theme.taglist_squares_unsel                     = icon_dir .. chosen_theme .. "/square_b.png"

theme.widget_main_color = "#74aeab"
theme.widget_red = "#e53935"
theme.widget_yelow = "#c0ca33"
theme.widget_green = "#43a047"
theme.widget_black = "#000000"
theme.widget_transparent = "#00000000"

theme.mouse_finder_color = "#CC9393"

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.awesome_icon       = icon_dir .. "launcher/arch3.svg"
theme.awesome_subicon    = icon_dir .. "launcher/arch3.svg"
