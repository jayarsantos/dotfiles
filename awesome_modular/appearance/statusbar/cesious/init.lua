-- Standard awesome library
local gears = require("gears")
local awful     = require("awful")
local beautiful 	= require("beautiful")

-- Wibox handling library
local wibox = require("wibox")

local calendar_widget = require("widget.awesome-wm-widgets.calendar-widget.calendar")
local wibox_widget	=require("widget.awesome-wm-widgets.wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
	wallpaper = require("deco.wallpaper"),
	taglist   = require("deco.taglist"),
	tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local separator = wibox.widget {
	widget = wibox.widget.separator,
	shape = gears.shape.circle,
	forced_width = 6,
	color = theme.fg_normal,
	visible = true
}
local spr = wibox.widget{
	widget = wibox.widget.separator,
	shape = gears.shape.square,
	forced_width = 10,
	visible = true,
	color = theme.bg_normal
}

-- {{{ Wibar
-- Create a textclock widget
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
-- default
--local cw = calendar_widget()
-- or customized
local cw = calendar_widget({
	theme = 'outrun',
	placement = 'bottom_right'
})
mytextclock:connect_signal("button::press",
function(_, _, _, button)
	if button == 1 then cw.toggle() end
end)

awful.screen.connect_for_each_screen(function(s)
	-- systemtray - use together with require(widget.systemtray')
	-- hide systemtray and make a toggle button
	s.systray = wibox.widget.systray()
	s.systray.visible = false
	s.systray:set_horizontal(true)
	s.systray:set_base_size(28)
	s.systray.opacity = 0.3
	beautiful.systray_icon_spacing = 10
	-- Wallpaper
	set_wallpaper(s)

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

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.all, --show all tags
		--filter = function (t) return t.selected or #t:clients() > 0 end, --show only occupied tags
		buttons = taglist_buttons
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen   = s,
		filter   = awful.widget.tasklist.filter.currenttags,
		buttons  = tasklist_buttons,
		style    = {
			shape_border_width = 1,
			shape_border_color = theme.bg_minimized,
			shape  = gears.shape.rounded_bar,
		},
		layout   = {
			spacing = 10,
			spacing_widget = {
				{
					forced_width = 5,
					shape        = gears.shape.circle,
					widget       = wibox.widget.separator
				},
				valign = 'center',
				halign = 'center',
				widget = wibox.container.place,
			},
			layout  = wibox.layout.flex.horizontal
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id     = 'icon_role',
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget  = wibox.container.margin,
					},
					{
						id     = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 10,
				right = 10,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
		},
	}

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		RC.launcher,
		s.mytaglist,
		s.mypromptbox,
	},
	s.mytasklist, -- Middle widget
	{ -- Right widgets
	layout = wibox.layout.fixed.horizontal,
	mykeyboardlayout,
	s.systray,
	require('widget.systemtray'),
	wibox_widget.volume,
	spr,
	wibox_widget.bat,
	spr,
	wibox_widget.fs,
	spr,
	wibox_widget.cpu,
	spr,
	mytextclock,
	spr,
	s.mylayoutbox,
},
  }
end)
-- }}}
