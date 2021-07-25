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
-- startup applications
function run_once(cmd)                 
 local findme = "ps x U $USER |grep '" .. cmd .. "' |wc -l"              
 awful.spawn.easy_async_with_shell( findme ,
   function(stdout,stderr,reason,exit_code) 
     if tonumber(stdout) <= 2 then
       awful.spawn( cmd )
     end
   end)
end    

awful.spawn.with_shell("/home/jayar/.config/awesome/scripts/autorun.sh")
