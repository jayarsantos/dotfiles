--------------------------------------------------------------------------------
-- @File:   wibox.lua
-- @Author: Marcel Arpogaus
-- @Date:   2019-07-15 08:12:41
-- [ description ] -------------------------------------------------------------
-- wibar widgets
-- [ changelog ] ---------------------------------------------------------------
-- @Last Modified by:   Marcel Arpogaus
-- @Last Modified time: 2019-07-15 08:51:52
-- @Changes:
--      - added header
--------------------------------------------------------------------------------
local os = os

local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

-- widgets
local batteryarc_widget = require("widget.awesome-wm-widgets.batteryarc-widget.batteryarc")
local storage_widget = require("widget.awesome-wm-widgets.fs-widget.fs-widget")
local cpu_widget = require("widget.awesome-wm-widgets.cpu-widget.cpu-widget")
local volumearc_widget = require("widget.awesome-wm-widgets.volumearc-widget.volumearc")
local weather_widget = require("widget.awesome-wm-widgets.weather-widget.weather")

local _M = {
	bat = batteryarc_widget({
		show_current_level = true,
		arc_thickness = 2,
	}),
	fs = storage_widget({ mounts = { '/', '/home' } }),
	cpu = cpu_widget({
		width = 70,
		step_width = 2,
		step_spacing = 0,
		color = theme.widget_red
	}),
	volume = volumearc_widget({
		main_color = '#af13f7',
		mute_color = '#ff0000',
		thickness = 4,
		height = 25
	}),
	weather = weather_widget({
		api_key = 'a63f4c747a04d05a983111761059b2e3',
		units = 'metric',
		city = 'Isabela,PH',
		--font = 'Ubuntu Mono 9'
	}),
}

return _M
