-- Global Variable Definitions

local awful = require("awful")
local filesystem = require("gears.filesystem")
local home = os.getenv("HOME")
-- load the widget code
local volume_control = require("widget.volume")


local _M = {
	-- This is used later as the default terminal and editor to run.
	locker = "xidlehook-client --socket /tmp/xidlehook.sock control --action trigger --timer 1",
	youtubedownload = "youtube-dl-gui",
	terminal = "xfce4-terminal",
	ranger = "st -e ranger",
	quake = "st --title QuakeTerminal",
	quakeranger = "st --title QuakeRanger -e ranger",
	mail = "st --title NeomuttMail -e neomutt",
	music = "st --title Musicncmpcpp -e ncmpcpp -S visualizer",
	filemanager = "nemo",
	browser = "qutebrowser",
	pavucontrol = "pavucontrol",
	editor = "atom",
	gui_editor = "atom",
	rofi = 'rofi -show Search -modi Search:' .. filesystem.get_configuration_dir() .. '/main/config/rofi/sidebar/rofi-web-search.py' .. ' -theme ' .. filesystem.get_configuration_dir() .. '/main/config/rofi/sidebar/rofi.rasi',
	rofiappmenu = "rofi -show drun -theme " .. filesystem.get_configuration_dir() .. "/main/config/rofi/appmenu/drun.rasi",
	lock = "mantablockscreen -sc",
	--{{ files in main.binaries
	fullShot = require('main.binaries.snap').fullmode,
	areaShot = require('main.binaries.snap').areamode,
	selectShot = require('main.binaries.snap').selectmode,
	--    enableBlur = require('main.binaries.togglewinfx').enable,
	--    disableBlur = require('main.binaries.togglewinfx').disable,
	--    coverUpdate = require('main.binaries.extractcover').extractalbum
	--}}

	wlandev = 'wlp2s0',

	modkey = "Mod4",
	altkey = "Mod1",
	superkey = "Mod4",

	-- define your volume control, using default settings:
	volumecfg = volume_control({
		device  = nil,            -- e.g.: "default", "pulse"
		cardid  = nil,            -- e.g.: 0, 1, ...
		channel = "Master",
		step    = '5%',           -- step size for up/down
		lclick  = "toggle",       -- mouse actions described below
		mclick  = "pavucontrol",
		rclick  = "pavucontrol",
		listen  = false,          -- enable/disable listening for audio status changes
		widget  = nil,            -- use this instead of creating a awful.widget.textbox
		font    = nil,            -- font used for the widget's text
		callback = nil,           -- called to update the widget: `callback(self, state)`
		widget_text = {
			on  = '% 3d%% ',        -- three digits, fill with leading spaces
			off = '% 3dM ',
		},
		tooltip_text = [[
		Volume: ${volume}% ${state}
		Channel: ${channel}
		Device: ${device}
		Card: ${card}]],
	})

}

return _M
