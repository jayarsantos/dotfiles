-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")
local lain          = require("lain")
local beautiful     = require("beautiful")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist   = require("deco.taglist"),
	tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()
local markup = lain.util.markup

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Widgets
space3 = markup.font("Terminus 3", " ")
-- space2 = markup.font("Terminus 2", " ")
-- vspace1 = '<span font="Terminus 3"> </span>'
-- vspace2 = '<span font="Terminus 3">  </span>'
clockgf = beautiful.clockgf

spr = wibox.widget.imagebox(beautiful.spr)
spr4px = wibox.widget.imagebox(beautiful.spr4px)
spr5px = wibox.widget.imagebox(beautiful.spr5px)

widget_display = wibox.widget.imagebox(beautiful.widget_display)
widget_display_r = wibox.widget.imagebox(beautiful.widget_display_r)
widget_display_l = wibox.widget.imagebox(beautiful.widget_display_l)
widget_display_c = wibox.widget.imagebox(beautiful.widget_display_c)

-- Clock / Calendar
local clock_icon = wibox.widget.imagebox(beautiful.widget_clock)
local clock_types = {
	"%H:%M",          -- 13:19
	"%a %d %b %H:%M", -- Thu 08 Feb 13:19
}

local chosen_clock_type = clock_types[1] -- You can choose a clock type
local textclock = wibox.widget.textclock(markup(clockgf, space3 .. chosen_clock_type .. markup.font("Tamsyn 3", " ")))
local clock_widget = wibox.container.background(textclock)
clock_widget.bgimage=beautiful.widget_display
--[[
lain.widget.calendar({
cal = "cal --color=always",
attach_to = { textclock },
notification_preset = {
font = beautiful.calendar_font,
fg   = beautiful.fg_normal,
bg   = beautiful.bg_normal
}
})
--]]
-- Chrome_button
local chrome_button = awful.widget.button({ image = beautiful.chrome })
chrome_button:buttons(awful.util.table.join(
awful.button({ }, 1, function () awful.util.spawn("google-chrome-stable") end)
))

-- CPU
local cpu_icon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(space3 .. cpu_now.usage .. "%" .. markup.font("Tamsyn 4", " "))
	end
})
local cpu_widget = wibox.container.background(cpu.widget)
cpu_widget.bgimage=beautiful.widget_display

-- MEM
local mem_icon = wibox.widget.imagebox(beautiful.widget_mem)
local mem = lain.widget.mem({
	settings = function()
		widget:set_markup(space3 .. mem_now.used .. "MB" .. markup.font("Tamsyn 4", " "))
	end
})
local mem_widget = wibox.container.background(mem.widget)
mem_widget.bgimage=beautiful.widget_display

-- Net
local netdl_icon = wibox.widget.imagebox(beautiful.widget_netdl)
local netup_icon = wibox.widget.imagebox(beautiful.widget_netul)

local net_widgetdl = lain.widget.net({
	iface = "wlp2s0",
	settings = function()
		widget:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received)
	end
})
local net_widgetul = lain.widget.net({
	iface = "wlp2s0",
	settings = function()
		widget:set_markup(markup.font("Tamsyn 1", "  ") .. net_now.sent)
	end
})
local netdl_widget = wibox.container.background(net_widgetdl.widget)
netdl_widget.bgimage=beautiful.widget_display
local netup_widget = wibox.container.background(net_widgetul.widget)
netup_widget.bgimage=beautiful.widget_display

-- Keyboard layout switcher
kbdwidget = wibox.widget.textbox()
kbdwidget.border_width = 1
kbdwidget.border_color = beautiful.bg_normal
kbdwidget.font = beautiful.font
kbdwidget:set_markup("<span foreground=".."'"..beautiful.fg_normal.."'".."> Eng </span>")

kbdstrings = {[0] = " Eng ",
[1] = " Rus "}

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.connect_signal("ru.gentoo.kbdd", function(...)
	local data = {...}
	local layout = data[2]
	kbdwidget:set_markup("<span foreground=".."'"..beautiful.fg_normal.."'"..">" .. kbdstrings[layout] .. "</span>")
end
)
local kbd_widget = wibox.container.background(kbdwidget)
kbd_widget.bgimage=beautiful.widget_display

-- FS
local fs_icon = wibox.widget.imagebox(beautiful.widget_fs)
local fs = lain.widget.fs({
	notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = beautiful.fs_font },
	settings = function()
		local fsp = string.format(" %3.2f %s ", fs_now["/home"].free, fs_now["/home"].units)
		widget:set_markup(markup.font(beautiful.font, fsp))
	end
})
local fs_widget = wibox.container.background(fs.widget)
fs_widget.bgimage=beautiful.widget_display

widget_vol = wibox.widget.imagebox(beautiful.widget_vol)
-- MPD

prev_icon = wibox.widget.imagebox(beautiful.mpd_prev)
next_icon = wibox.widget.imagebox(beautiful.mpd_nex)
stop_icon = wibox.widget.imagebox(beautiful.mpd_stop)
pause_icon = wibox.widget.imagebox(beautiful.mpd_pause)
play_pause_icon = wibox.widget.imagebox(beautiful.mpd_play)
mpd_sepl = wibox.widget.imagebox(beautiful.mpd_sepl)
mpd_sepr = wibox.widget.imagebox(beautiful.mpd_sepr)

mpdwidget = lain.widget.mpd({
	settings = function ()
		mpd_notification_preset = {
			text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
			mpd_now.album, mpd_now.date, mpd_now.title)
		}

		if mpd_now.state == "play" then
			mpd_now.artist = mpd_now.artist:upper():gsub("&.-;", string.lower)
			mpd_now.title = mpd_now.title:upper():gsub("&.-;", string.lower)
			widget:set_markup(markup.font("Tamsyn 3", " ")
			.. markup.font("Tamsyn 7",
			mpd_now.artist
			.. " - " ..
			mpd_now.title
			.. markup.font("Tamsyn 2", " ")))
			play_pause_icon = wibox.widget.imagebox(beautiful.mpd_pause)
			mpd_sepl = wibox.widget.imagebox(beautiful.mpd_sepl)
			mpd_sepr = wibox.widget.imagebox(beautiful.mpd_sepr)
		elseif mpd_now.state == "pause" then
			widget:set_markup(markup.font("Tamsyn 4", "") ..
			markup.font("Tamsyn 7", "MPD PAUSED") ..
			markup.font("Tamsyn 10", ""))
			play_pause_icon = wibox.widget.imagebox(beautiful.mpd_play)
			mpd_sepl = wibox.widget.imagebox(beautiful.mpd_sepl)
			mpd_sepr = wibox.widget.imagebox(beautiful.mpd_sepr)
		else
			widget:set_markup("")
			play_pause_icon = wibox.widget.imagebox(beautiful.mpd_play)
			mpd_sepl = wibox.widget.imagebox(nil)
			mpd_sepr = wibox.widget.imagebox(nil)
		end
	end
})

music_widget = wibox.container.background(mpdwidget.widget)
music_widget.bgimage=beautiful.widget_display
music_widget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(ncmpcpp) end)))
prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
	awful.util.spawn_with_shell("mpc prev || ncmpcpp prev")
	mpdwidget.update()
end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
	awful.util.spawn_with_shell("mpc next || ncmpcpp next")
	mpdwidget.update()
end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
	play_pause_icon:set_image(beautiful.play)
	awful.util.spawn_with_shell("mpc stop || ncmpcpp stop")
	mpdwidget.update()
end)))
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
	awful.util.spawn_with_shell("mpc toggle || ncmpcpp toggle")
	mpdwidget.update()
end)))

-- Battery
local bat_icon = wibox.widget.imagebox(beautiful.widget_battery)
local bat = lain.widget.bat({
	battery = "BAT0",
	timeout = 1,
	notify = "on",
	n_perc = {5,15},
	settings = function()
		bat_notification_low_preset = {
			title = "Battery low",
			text = "Plug the cable!",
			timeout = 15,
			fg = beautiful.fg_normal,
			bg = beautiful.bg_normal
		}
		bat_notification_critical_preset = {
			title = "Battery exhausted",
			text = "Shutdown imminent",
			timeout = 15,
			fg = beautiful.bat_fg_critical,
			bg = beautiful.bat_bg_critical
		}

		if bat_now.status ~= "N/A" then
			if bat_now.status == "Charging" then
				widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " +" .. bat_now.perc .. "%")))
				bat_icon:set_image(beautiful.widget_ac)
			elseif bat_now.status == "Full" then
				widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " ~" .. bat_now.perc .. "%")))
				bat_icon:set_image(beautiful.widget_battery)
			elseif tonumber(bat_now.perc) <= 35 then
				bat_icon:set_image(beautiful.widget_battery_empty)
				widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " -" .. bat_now.perc .. "%")))
			elseif tonumber(bat_now.perc) <= 80 then
				bat_icon:set_image(beautiful.widget_battery_low)
				widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " -" .. bat_now.perc .. "%")))
			elseif tonumber(bat_now.perc) <= 99 then
				bat_icon:set_image(beautiful.widget_battery)
				widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " -" .. bat_now.perc .. "%")))
			else
				bat_icon:set_image(beautiful.widget_battery)
				widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " -" .. bat_now.perc .. "%")))
			end
		else
			widget:set_markup(markup.font(beautiful.font, markup.fg.color(beautiful.fg_normal, " AC0 ")))
			bat_icon:set_image(beautiful.widget_ac)
		end
	end
})
local bat_widget = wibox.container.background(bat.widget)
bat_widget.bgimage=beautiful.widget_display

-- Mail
local mail_icon = wibox.widget.imagebox(beautiful.widget_mail)
-- commented because it needs to be set before use
-- local mail = lain.widget.imap({
--     timeout  = 180,
--     server   = "server",
--     mail     = "login",
--     password = "password",
--     settings = function()
--         mail_notification_preset.fg = beutiful.fg_normal
--         mail  = ""
--         count = ""

--         if mailcount > 0 then
--             mail = "Mail "
--             count = mailcount .. " "
--         end

--         widget:set_markup(markup.font(beautiful.font, markup(blue, mail) .. markup("#FFFFFF", count)))
--     end
-- })
-- local mail_widget = wibox.container.background(mail.widget)
-- mail_widget.bgimage=beautiful.widget_display

awful.screen.connect_for_each_screen(function(s)

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Wallpaper
	set_wallpaper(s)

	-- Tags
	--awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
	layout = { awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[1], awful.layout.layouts[3], awful.layout.layouts[5], awful.layout.layouts[5]}
	--awful.tag({ "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  " }, s, layout)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all, --show all tags
		--filter = function (t) return t.selected or #t:clients() > 0 end, --show only occupied tags
		buttons = taglist_buttons
	}

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- systemtray - use together with require(widget.systemtray')
	-- hide systemtray and make a toggle button
	s.systray = wibox.widget.systray()
	s.systray.visible = false
	s.systray:set_horizontal(true)
	s.systray:set_base_size(28)
	s.systray.opacity = 0.3
	beautiful.systray_icon_spacing = 10
	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = 22, bg = beautiful.panel, fg = beautiful.fg_normal })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		RC.launcher,
		spr5px,
		s.mytaglist,
		spr5px,
		chrome_button,

	},
	s.mytasklist, -- Middle widget
	--nil,
	{ -- Right widgets
	layout = wibox.layout.fixed.horizontal,
	s.mypromptbox,
	s.systray,
	require('widget.systemtray'),
	spr5px,
	spr,
	widget_display_l,
	kbd_widget,
	widget_display_r,
	spr,
	spr5px,
	-- MPD widget
	spr,
	prev_icon,
	spr,
	stop_icon,
	spr,
	play_pause_icon,
	spr,
	next_icon,
	mpd_sepl,
	music_widget,
	mpd_sepr,
	spr5px,
	-- Volume widget
	widget_vol,
	require('widget.volume') {},
	spr5px,
	-- Mail widget
	spr,
	mail_icon,
	widget_display_l,
	mail_widget,
	widget_display_r,
	spr5px,
	-- CPU widget
	spr,
	cpu_icon,
	widget_display_l,
	cpu_widget,
	widget_display_r,
	spr5px,
	-- Mem widget
	spr,
	mem_icon,
	widget_display_l,
	mem_widget,
	widget_display_r,
	spr5px,
	-- Fs widget
	spr,
	fs_icon,
	widget_display_l,
	fs_widget,
	widget_display_r,
	spr5px,
	-- Net widget
	spr,
	netdl_icon,
	widget_display_l,
	netdl_widget,
	widget_display_c,
	netup_widget,
	widget_display_r,
	netup_icon,
	-- Battery widget
	spr,
	bat_icon,
	widget_display_l,
	bat_widget,
	widget_display_r,
	spr5px,
	-- Clock
	spr,
	clock_icon,
	widget_display_l,
	clock_widget,
	widget_display_r,
	spr5px,
	spr,
	-- Layout box
	s.mylayoutbox,
},
  }
end)
