local gears = require("gears")

local taglist_types = {
    "bubbles",        -- 1
    "sticks",         -- 2
}

local chosen_taglist_type = taglist_types[2]

theme.icons           = icon_dir .. chosen_theme .. "/icons"
theme.panel           = "png:" .. theme.icons .. "/panel/panel.png"
theme.font            = "Terminus 10"
theme.calendar_font   = "Meslo LGS Regular 10"
theme.fs_font         = "Meslo LGS Regular 10"

theme.fg_normal         = "#888888"
theme.fg_focus          = "#e4e4e4"
theme.fg_urgent         = "#CC9393"
theme.bat_fg_critical   = "#232323"

theme.bg_normal         = "#3F3F3F"
theme.bg_focus          = "#5a5a5a"
theme.bg_urgent         = "#3F3F3F"
theme.bg_systray        = "#343434"
theme.bat_bg_critical   = "#ff0000"

theme.clockgf           = "#d5d5c3"

-- Borders


theme.border_width                              = 2
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#6F6F6F"
theme.border_marked                             = "#CC9393"

-- Menu

theme.menu_height = 16
theme.menu_width  = 160
--[[
-- Notifications
theme.notification_font                         = "Meslo LGS Regular 12"
theme.notification_bg                           = "#232323"
theme.notification_fg                           = "e4e4e4"
theme.notification_border_width                 = 0
theme.notification_border_color                 = "#232323"
theme.notification_shape                        = gears.shape.infobubble
theme.notification_opacity                      = 1
theme.notification_margin                       = 30
--]]

-- Layout

-- Taglist

theme.taglist_bg_empty    = "png:" .. theme.icons .. "/panel/taglist/" .. chosen_taglist_type .. "/empty.png"
theme.taglist_bg_occupied = "png:" .. theme.icons .. "/panel/taglist/" .. chosen_taglist_type .. "/occupied.png"
theme.taglist_bg_urgent   = "png:" .. theme.icons .. "/panel/taglist/" .. chosen_taglist_type .. "/urgent.png"
theme.taglist_bg_focus    = "png:" .. theme.icons .. "/panel/taglist/" .. chosen_taglist_type .. "/focus.png"
theme.taglist_font        = "Terminus 9"
-- Tasklist

theme.tasklist_font                 = "Terminus 8"
theme.tasklist_disable_icon         = true
theme.tasklist_bg_normal            = "png:" .. theme.icons .. "/panel/tasklist/normal.png"
theme.tasklist_bg_focus             = "png:" .. theme.icons .. "/panel/tasklist/focus.png"
theme.tasklist_bg_urgent            = "png:" .. theme.icons .. "/panel/tasklist/urgent.png"
theme.tasklist_fg_focus             = "#DDDDDD"
theme.tasklist_fg_urgent            = "#EEEEEE"
theme.tasklist_fg_normal            = "#AAAAAA"
theme.tasklist_floating             = ""
theme.tasklist_sticky               = ""
theme.tasklist_ontop                = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

-- Widget

theme.widget_display   = theme.icons .. "/panel/widgets/display/widget_display.png"
theme.widget_display_r = theme.icons .. "/panel/widgets/display/widget_display_r.png"
theme.widget_display_c = theme.icons .. "/panel/widgets/display/widget_display_c.png"
theme.widget_display_l = theme.icons .. "/panel/widgets/display/widget_display_l.png"

-- MPD

theme.mpd_prev  = theme.icons .. "/panel/widgets/mpd/mpd_prev.png"
theme.mpd_nex   = theme.icons .. "/panel/widgets/mpd/mpd_next.png"
theme.mpd_stop  = theme.icons .. "/panel/widgets/mpd/mpd_stop.png"
theme.mpd_pause = theme.icons .. "/panel/widgets/mpd/mpd_pause.png"
theme.mpd_play  = theme.icons .. "/panel/widgets/mpd/mpd_play.png"
theme.mpd_sepr  = theme.icons .. "/panel/widgets/mpd/mpd_sepr.png"
theme.mpd_sepl  = theme.icons .. "/panel/widgets/mpd/mpd_sepl.png"

-- Separators

theme.spr    = theme.icons .. "/panel/separators/spr.png"
theme.sprtr  = theme.icons .. "/panel/separators/sprtr.png"
theme.spr4px = theme.icons .. "/panel/separators/spr4px.png"
theme.spr5px = theme.icons .. "/panel/separators/spr5px.png"

-- Clock / Calendar

theme.widget_clock = theme.icons .. "/panel/widgets/widget_clock.png"
theme.widget_cal   = theme.icons .. "/panel/widgets/widget_cal.png"

-- CPU / TMP

theme.widget_cpu    = theme.icons .. "/panel/widgets/widget_cpu.png"
-- theme.widget_tmp = theme.icons .. "/panel/widgets/widget_tmp.png"

-- MEM

theme.widget_mem = theme.icons .. "/panel/widgets/widget_mem.png"

-- FS

theme.widget_fs     = theme.icons .. "/panel/widgets/widget_fs.png"
theme.widget_fs_hdd = theme.icons .. "/panel/widgets/widget_fs_hdd.png"

-- Mail

theme.widget_mail = theme.icons .. "/panel/widgets/widget_mail.png"

-- NET

theme.widget_netdl = theme.icons .. "/panel/widgets/widget_netdl.png"
theme.widget_netul = theme.icons .. "/panel/widgets/widget_netul.png"

theme.widget_vol             = theme.icons .. "/panel/widgets/widget_vol.png"
-- Battery
theme.widget_ac             = theme.icons .. "/panel/widgets/battery/ac.png"
theme.widget_battery        = theme.icons .. "/panel/widgets/battery/battery.png"
theme.widget_battery_low    = theme.icons .. "/panel/widgets/battery/battery_low.png"
theme.widget_battery_empty  = theme.icons .. "/panel/widgets/battery/battery_empty.png"

-- Misc
--Menu launcher icon
theme.awesome_icon       = icon_dir .. "launcher/arch3.svg"
theme.awesome_subicon    = icon_dir .. "launcher/arch3.svg"

theme.menu_submenu_icon = theme.icons .. "/submenu.png"

theme.chrome         = theme.icons .. "/apps/chrome.png"
