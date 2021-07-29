-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful") -- for awesome.icon
local menubar 		= require("menubar")
xdg_menu = require("main.archmenu")

local M = {}  -- menu
local _M = {} -- module

-- reading
-- https://awesomewm.org/apidoc/popups%20and%20bars/awful.menu.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- This is used later as the default terminal and editor to run.
-- local terminal = "xfce4-terminal"
local terminal = RC.vars.terminal

-- Variable definitions
-- This is used later as the default terminal and editor to run.
local editor = os.getenv("EDITOR") or "nano"
local editor_cmd = terminal .. " -e " .. editor

-- This is used later as the default terminal and editor to run.
local terminal = RC.vars.terminal
local gui_editor = RC.vars.gui_editor
local browser = RC.vars.browser
local filemanager = RC.vars.filemanager
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Menu
-- Create a launcher widget and a main menu
M.myawesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end, menubar.utils.lookup_icon("preferences-desktop-keyboard-shortcuts") },
	{ "manual", terminal .. " -e man awesome", menubar.utils.lookup_icon("system-help") },
	{ "edit config", gui_editor .. " " .. awesome.conffile,  menubar.utils.lookup_icon("accessories-text-editor") },
	{ "restart", awesome.restart, menubar.utils.lookup_icon("system-restart") }
}
M.myexitmenu = {
	{ "log out", function() awesome.quit() end, menubar.utils.lookup_icon("system-log-out") },
	{ "suspend", "systemctl suspend", menubar.utils.lookup_icon("system-suspend") },
	{ "hibernate", "systemctl hibernate", menubar.utils.lookup_icon("system-suspend-hibernate") },
	{ "reboot", "systemctl reboot", menubar.utils.lookup_icon("system-reboot") },
	{ "shutdown", "systemctl poweroff", menubar.utils.lookup_icon("system-shutdown") }
}
M.desktopmenu = {
	{"Gmail", "dex /home/jayar/.local/share/applications/chrome-gmail.desktop"},
	{"Netflix", "dex /home/jayar/.local/share/applications/chrome-netflix.desktop"},
	{"Youtube", "dex /home/jayar/.local/share/applications/chrome-youtube.desktop"},
	{"Youtube Music", "dex /home/jayar/.local/share/applications/chrome-youtubemusic.desktop"},
	{"Facebook", "dex /home/jayar/.local/share/applications/chrome-facebook.desktop"},
	{"Reddit", "dex /home/jayar/.local/share/applications/chrome-reddit.desktop"},
	{"Twitter", "dex /home/jayar/.local/share/applications/chrome-twitter.desktop"}
}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()

	-- Main Menu
	local menu_items = {
		{ "Terminal", terminal, menubar.utils.lookup_icon("utilities-terminal") },
		{ "Browser", browser, menubar.utils.lookup_icon("internet-web-browser") },
		{ "Files", filemanager, menubar.utils.lookup_icon("system-file-manager") },
		{ "Favorite Apps", M.desktopmenu },
		{ "Applications", xdgmenu, menubar.utils.lookup_icon("applications") },
		{ "Awesome", M.myawesomemenu, beautiful.awesome_icon },
		{ "Exit", M.myexitmenu, menubar.utils.lookup_icon("system-shutdown") }
	}

	return menu_items
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
