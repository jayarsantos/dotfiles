local naughty 		= require("naughty")
local beautiful 	= require('beautiful')
local awful 		= require('awful')
local dpi 		= require('beautiful').xresources.apply_dpi

require('main.notifications.error_handler')
require('main.notifications.spotify')

-- Defaults
naughty.config.defaults.ontop = true
--naughty.config.defaults.height = 100
--naughty.config.defaults.width = 350
naughty.config.defaults.icon_size = dpi(90)
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = 'Notification:'

-- -- Apply theme variables
naughty.config.padding = 8
naughty.config.spacing = 8
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.border_width = 0
naughty.config.defaults.position = 'top_right'

-- Timeouts
naughty.config.defaults.timeout = 10
naughty.config.presets.low.timeout = 5
naughty.config.presets.critical.timeout = 20
naughty.config.presets.normal = {
	font         = 'Terminus 10',
	fg           = beautiful.fg_normal,
	--  bg           = beautiful.background.hue_800,
	border_width = 0,
	margin       = dpi(16),
	position     = 'top_right'
}

naughty.config.presets.low = {
	font         = 'Terminus 10',
	fg           = beautiful.fg_normal,
	--  bg           = beautiful.background.hue_800,
	border_width = 0,
	margin       = dpi(16),
	position     = 'top_right'
}

naughty.config.presets.critical = {
	font         = 'Terminus 10',
	fg           = '#ffffff',
	bg           = '#ff0000',
	border_width = 0,
	margin       = dpi(16),
	position     = 'top_right',
	timeout      = 0
}

naughty.config.presets.ok = naughty.config.presets.normal
naughty.config.presets.info = naughty.config.presets.normal
naughty.config.presets.warn = naughty.config.presets.critical

