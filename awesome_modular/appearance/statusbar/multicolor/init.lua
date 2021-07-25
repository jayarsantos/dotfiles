-- awesome wm 4.3 config
local gears 		= require("gears")
local awful     	= require("awful")
local beautiful 	= require("beautiful")
local dpi   		= require("beautiful.xresources").apply_dpi
local wibox 		= require("wibox")
local lain  		= require("lain")
local foggy 		= require("widget.xrandr")
local theme 		= require("appearance")

-- Custom Local Library: Common Functional Decoration
local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist   = require("deco.taglist"),
	tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()
local markup = lain.util.markup

local volumecfg = RC.vars.volumecfg

local _M = {}

-- Textclock
os.setlocale(os.getenv("LANG")) -- to localize the clock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local mytextclock = wibox.widget.textclock(markup("#7788af", "%A %d %B ") .. markup("#ab7367", ">") .. markup("#de5e1e", " %H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
	attach_to = { mytextclock },
	notification_preset = {
		font = "Terminus 10",
		fg   = theme.fg_normal,
		bg   = theme.bg_normal
	}
})

-- Weather
local weathericon = wibox.widget.imagebox(theme.widget_weather)
theme.weather = lain.widget.weather({
	city_id = 1710515, -- placeholder (province of isabela)
	notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
	weather_na_markup = markup.fontfg(theme.font, "#eca4c4", "N/A "),
	settings = function()
		descr = weather_now["weather"][1]["description"]:lower()
		units = math.floor(weather_now["main"]["temp"])
		widget:set_markup(markup.fontfg(theme.font, "#eca4c4", descr .. " @ " .. units .. "°C "))
	end
})

-- / fs
-- commented because it needs Gio/Glib >= 2.54
local fsicon = wibox.widget.imagebox(theme.widget_fs)
theme.fs = lain.widget.fs({
	notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
	settings  = function()
		widget:set_markup(markup.fontfg(theme.font, "#80d9d8", string.format("%.1f", fs_now["/"].used) .. "% "))
	end
})

-- Mail IMAP check
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox()
theme.mail = lain.widget.imap({
timeout  = 180,
server   = "server",
mail     = "mail",
password = "keyring get mail",
settings = function()
if mailcount > 0 then
mailicon:set_image(theme.widget_mail)
widget:set_markup(markup.fontfg(theme.font, "#cccccc", mailcount .. " "))
else
widget:set_text("")
--mailicon:set_image() -- not working in 4.0
mailicon._private.image = nil
mailicon:emit_signal("widget::redraw_needed")
mailicon:emit_signal("widget::layout_changed")
end
end
})
--]]

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "% "))
	end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
	settings = function()
		widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C "))
	end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
local batticon = wibox.widget.imagebox(theme.widget_batt)

-- Net
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netupinfo = lain.widget.net({
	settings = function()
		if iface ~= "network off" and
			string.match(theme.weather.widget.text, "N/A")
			then
				theme.weather.update()
			end

			widget:set_markup(markup.fontfg(theme.font, "#e54c62", net_now.sent .. " "))
			netdowninfo:set_markup(markup.fontfg(theme.font, "#87af5f", net_now.received .. " "))
		end
	})

	-- MEM
	local memicon = wibox.widget.imagebox(theme.widget_mem)
	local memory = lain.widget.mem({
		settings = function()
			widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.used .. "M "))
		end
	})

	-- MPD
	local mpdicon = wibox.widget.imagebox()
	theme.mpd = lain.widget.mpd({
		settings = function()
			mpd_notification_preset = {
				text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
				mpd_now.album, mpd_now.date, mpd_now.title)
			}

			if mpd_now.state == "play" then
				artist = mpd_now.artist .. " > "
				title  = mpd_now.title .. " "
				mpdicon:set_image(theme.widget_note_on)
			elseif mpd_now.state == "pause" then
				artist = "mpd "
				title  = "paused "
			else
				artist = ""
				title  = ""
				--mpdicon:set_image() -- not working in 4.0
				mpdicon._private.image = nil
				mpdicon:emit_signal("widget::redraw_needed")
				mpdicon:emit_signal("widget::layout_changed")
			end
			widget:set_markup(markup.fontfg(theme.font, "#e54c62", artist) .. markup.fontfg(theme.font, "#b2b2b2", title))
		end
	})

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	awful.screen.connect_for_each_screen(function(s)
		-- incorporate tasglist in tags
		-- Create a taglist widget
		s.mytaglist = awful.widget.taglist {
			screen  = s,
			filter  = awful.widget.taglist.filter.all, --show all tags
			--filter = function (t) return t.selected or #t:clients() > 0 end, --show only occupied tags
			buttons = taglist_buttons
		}

		-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- systemtray - use together with require(widget.systemtray')
		-- hide systemtray and make a toggle button
		-- Create to each screen
		awful.screen.connect_for_each_screen(function(s)
			s.systray = wibox.widget.systray()
			s.systray.visible = false
			s.systray:set_horizontal(true)
			s.systray:set_base_size(28)
			s.systray.opacity = 0.3
			beautiful.systray_icon_spacing = 16
		end)

		-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Create a tasklist widget
		s.mytasklist = awful.widget.tasklist {
			screen  = s,
			filter  = awful.widget.tasklist.filter.currenttags,
			buttons = tasklist_buttons
		}

		-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Wallpaper
		set_wallpaper(s)

		-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- xrandr control
		scrnicon = wibox.container.background(wibox.widget.imagebox(os.getenv("HOME") .. "/.config/awesome/widget/xrandr/icon.svg"), '#313131')
		scrnicon:buttons(awful.util.table.join(
		awful.button({ }, 1, function () foggy.menu() end)))

		-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
		-- Create a promptbox for each screen
		s.mypromptbox = awful.widget.prompt()

		-- Create an imagebox widget which will contain an icon indicating which layout we're using.
		-- We need one layoutbox per screen.
		s.mylayoutbox = awful.widget.layoutbox(s)
		s.mylayoutbox:buttons(gears.table.join(
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end),
		awful.button({ }, 4, function () awful.layout.inc( 1) end),
		awful.button({ }, 5, function () awful.layout.inc(-1) end)
		))

		-- Create the wibox
		s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(19), bg = theme.bg_normal, fg = theme.fg_normal })

		-- Add widgets to the wibox
		s.mywibox:setup {
			layout = wibox.layout.align.horizontal,
			{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			RC.launcher,
			--s.mylayoutbox,
			s.mytaglist,
			s.mypromptbox,
		},
		--s.mytasklist, -- Middle widget
		nil,
		{ -- Right widgets
		layout = wibox.layout.fixed.horizontal,
		awful.widget.keyboardlayout(),
		s.systray,
		require('widget.systemtray'),
		volicon,
		volumecfg,
		--mailicon,
		--theme.mail.widget,
		netdownicon,
		netdowninfo,
		netupicon,
		netupinfo.widget,
		memicon,
		memory.widget,
		cpuicon,
		cpu.widget,
		tempicon,
		temp.widget,
		batticon,
		require('widget.battery'){},
		fsicon,
		theme.fs.widget,
		weathericon,
		theme.weather.widget,
		clockicon,
		mytextclock,
	},
}

-- Create the bottom wibox
s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, border_width = 0, height = dpi(20), bg = theme.bg_normal, fg = theme.fg_normal })

-- Add widgets to the bottom wibox
s.mybottomwibox:setup {
	layout = wibox.layout.align.horizontal,
	{ -- Left widgets
	layout = wibox.layout.fixed.horizontal,
	scrnicon,
	mpdicon,
	theme.mpd.widget,
},
s.mytasklist, -- Middle widget
{ -- Right widgets
layout = wibox.layout.fixed.horizontal,
s.mylayoutbox,
		},
	}
end)
