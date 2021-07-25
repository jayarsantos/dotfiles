-- Standard awesome library
local beautiful 	= require("beautiful")
local dpi   		= require("beautiful.xresources").apply_dpi
local lain  		= require("lain")
local foggy 		= require("widget.xrandr")
local theme 		= require("appearance")
local gears = require("gears")
local awful     = require("awful")

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


local _M = {}

local markup = lain.util.markup
local separators = lain.util.separators

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
	"date +'%a %d %b %R'", 60,
	function(widget, stdout)
		widget:set_markup(" " .. markup.font(theme.font, stdout))
	end
	)

-- Calendar
theme.cal = lain.widget.cal({
		attach_to = { clock },
		notification_preset = {
			font = "Terminus 10",
			fg   = theme.fg_normal,
			bg   = theme.bg_normal
		}
	})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
	if mailcount > 0 then
	    widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
	    mailicon:set_image(theme.widget_mail_on)
	else
	    widget:set_text("")
	    mailicon:set_image(theme.widget_mail)
	end
    end
})
--]]

-- MPD
local musicplr = RC.vars.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(gears.table.join(
		awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
		awful.button({ }, 1, function ()
			os.execute("mpc prev")
			theme.mpd.update()
		end),
		awful.button({ }, 2, function ()
			os.execute("mpc toggle")
			theme.mpd.update()
		end),
		awful.button({ }, 3, function ()
			os.execute("mpc next")
			theme.mpd.update()
		end)))
		theme.mpd = lain.widget.mpd({
				settings = function()
					if mpd_now.state == "play" then
						artist = " " .. mpd_now.artist .. " "
						title  = mpd_now.title  .. " "
						mpdicon:set_image(theme.widget_music_on)
					elseif mpd_now.state == "pause" then
						artist = " mpd "
						title  = "paused "
					else
						artist = ""
						title  = ""
						mpdicon:set_image(theme.widget_music)
					end

					widget:set_markup(markup.font(theme.font, markup("#EA6F81", artist) .. title))
				end
			})

		-- MEM
		local memicon = wibox.widget.imagebox(theme.widget_mem)
		local mem = lain.widget.mem({
				settings = function()
					widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
				end
			})

		-- CPU
		local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
		local cpu = lain.widget.cpu({
				settings = function()
					widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
				end
			})

		-- Coretemp
		local tempicon = wibox.widget.imagebox(theme.widget_temp)
		local temp = lain.widget.temp({
				settings = function()
					widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
				end
			})

		-- / fs
		local fsicon = wibox.widget.imagebox(theme.widget_hdd)
		theme.fs = lain.widget.fs({
				notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
				settings = function()
					widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
				end
			})

		-- Battery
		local baticon = wibox.widget.imagebox(theme.widget_battery)
		local bat = lain.widget.bat({
				settings = function()
					if bat_now.status and bat_now.status ~= "N/A" then
						if bat_now.ac_status == 1 then
							baticon:set_image(theme.widget_ac)
						elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
							baticon:set_image(theme.widget_battery_empty)
						elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
							baticon:set_image(theme.widget_battery_low)
						else
							baticon:set_image(theme.widget_battery)
						end
						widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
					else
						widget:set_markup(markup.font(theme.font, " AC "))
						baticon:set_image(theme.widget_ac)
					end
				end
			})

		-- ALSA volume
		local volicon = wibox.widget.imagebox(theme.widget_vol)
		theme.volume = lain.widget.alsa({
				settings = function()
					if volume_now.status == "off" then
						volicon:set_image(theme.widget_vol_mute)
					elseif tonumber(volume_now.level) == 0 then
						volicon:set_image(theme.widget_vol_no)
					elseif tonumber(volume_now.level) <= 50 then
						volicon:set_image(theme.widget_vol_low)
					else
						volicon:set_image(theme.widget_vol)
					end

					widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
				end
			})
		theme.volume.widget:buttons(awful.util.table.join(
				awful.button({}, 4, function ()
					awful.util.spawn("amixer set Master 1%+")
					theme.volume.update()
				end),
				awful.button({}, 5, function ()
					awful.util.spawn("amixer set Master 1%-")
					theme.volume.update()
				end)
			))

		-- Net
		local neticon = wibox.widget.imagebox(theme.widget_net)
		local net = lain.widget.net({
				settings = function()
					widget:set_markup(markup.font(theme.font,
							markup("#7AC82E", " " .. string.format("%06.1f", net_now.received))
							.. " " ..
						markup("#46A8C3", " " .. string.format("%06.1f", net_now.sent) .. " ")))
				end
			})

		-- Separators
		local spr     = wibox.widget.textbox(' ')
		local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
		local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

		awful.screen.connect_for_each_screen(function(s)
			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
			-- systemtray - use together with require(widget.systemtray')
			-- hide systemtray and make a toggle button
			s.systray = wibox.widget.systray()
			s.systray.visible = false
			s.systray:set_horizontal(true)
			s.systray:set_base_size(28)
			s.systray.opacity = 0.3
			beautiful.systray_icon_spacing = 10

			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
			-- incorporate tasglist in tags
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
			-- Wallpaper
			set_wallpaper(s)

			-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
			-- Quake application
			s.quake = lain.util.quake({ app = awful.util.terminal })

			-- Create a promptbox for each screen
			s.mypromptbox = awful.widget.prompt()
			-- Create an imagebox widget which will contains an icon indicating which layout we're using.
			-- We need one layoutbox per screen.
			s.mylayoutbox = awful.widget.layoutbox(s)
			s.mylayoutbox:buttons(gears.table.join(
					awful.button({}, 1, function () awful.layout.inc( 1) end),
					awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
					awful.button({}, 3, function () awful.layout.inc(-1) end),
					awful.button({}, 4, function () awful.layout.inc( 1) end),
				awful.button({}, 5, function () awful.layout.inc(-1) end)))

				-- Create the wibox
				s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })

				-- Add widgets to the wibox
				s.mywibox:setup {
					layout = wibox.layout.align.horizontal,
					{ -- Left widgets
						layout = wibox.layout.fixed.horizontal,
						spr,
						RC.launcher,
						spr,
						s.mytaglist,
						s.mypromptbox,
						spr,
					},
					s.mytasklist, -- Middle widget
					{ -- Right widgets
						layout = wibox.layout.fixed.horizontal,
						s.systray,
						--require('widget.systemtray'),
						spr,
						arrl_ld,
						wibox.container.background(mpdicon, theme.bg_focus),
						wibox.container.background(theme.mpd.widget, theme.bg_focus),
						arrl_dl,
						volicon,
						RC.vars.volumecfg,
						arrl_ld,
						wibox.container.background(mailicon, theme.bg_focus),
						--wibox.container.background(theme.mail.widget, theme.bg_focus),
						arrl_dl,
						memicon,
						mem.widget,
						arrl_ld,
						wibox.container.background(cpuicon, theme.bg_focus),
						wibox.container.background(cpu.widget, theme.bg_focus),
						arrl_dl,
						tempicon,
						temp.widget,
						arrl_ld,
						wibox.container.background(fsicon, theme.bg_focus),
						wibox.container.background(theme.fs.widget, theme.bg_focus),
						arrl_dl,
						baticon,
						require('widget.battery'){},
						arrl_ld,
						wibox.container.background(neticon, theme.bg_focus),
						wibox.container.background(net.widget, theme.bg_focus),
						arrl_dl,
						clock,
						spr,
						arrl_ld,
						wibox.container.background(s.mylayoutbox, theme.bg_focus),
					},
				}
			end)
