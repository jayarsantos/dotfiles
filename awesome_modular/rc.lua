-- Alejandro P. Santos III
-- email: jayarsantos@gmail.com

pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
require("awful.dbus")
-- Theme handling library
local beautiful = require("beautiful")
-- Miscellanous awesome library
local menubar = require("menubar")
RC = {} -- global namespace, on top before require any modules
RC.vars = require("main.user-variables")
modkey = RC.vars.modkey
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Notifications
-- Error handling
--require("main.error-handling")
--  Specify notification formats
require("main.notifications")
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
beautiful.init(require("appearance"))
beautiful.icon_theme = 'Papirus'
beautiful.gap_single_client = false --remove gaps on single client
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Calling All Module Libraries
-- Custom Local Library
local main = {
	layouts = require("main.layouts"),
	tags    = require("main.tags"),
	menu    = require("main.menu"),
	rules   = require("main.rules"),
}
-- Custom Local Library: Keys and Mouse Binding
local binding = {
	globalbuttons = require("binding.globalbuttons"),
	clientbuttons = require("binding.clientbuttons"),
	globalkeys    = require("binding.globalkeys"),
	clientkeys    = require("binding.clientkeys"),
	bindtotags    = require("binding.bindtotags")
}
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Layouts
RC.layouts = main.layouts()
-- Tags
RC.tags = main.tags()
-- Menu
RC.mainmenu = awful.menu({ items = main.menu() }) -- in globalkeys
RC.launcher = awful.widget.launcher(
	{ image = beautiful.awesome_icon, menu = RC.mainmenu }
	)
menubar.utils.terminal = RC.vars.terminal
--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
-- Mouse and Key bindings
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)
-- Set root
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
require("appearance.statusbar")
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Rules
awful.rules.rules = main.rules(
	binding.clientkeys(),
	binding.clientbuttons()
	)
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Signals
require("main.signals")
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- {{{ Autostart windowless processes
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "urxvtd", "unclutter -root" }) -- comma-separated entries

awful.spawn.with_shell("/home/jayar/.config/awesome/scripts/autorun.sh")
--
-- This function implements the XDG autostart specification
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --autostart --search-paths "~/.config/autostart"' -- https://github.com/jceb/dex
)
