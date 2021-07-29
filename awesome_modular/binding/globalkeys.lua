-- Standard awesome library
local beautiful = require('beautiful')
local gears 		= require('gears')
local awful 		= require('awful')
require('awful.autofocus')
local scratch 		= require('widget.scratch')
require('main.signals')
local naughty 		= require('naughty')
-- local hotkeys_popup = require('awful.hotkeys_popup').widget
local hotkeys_popup 	= require('awful.hotkeys_popup')
-- Menubar library
local menubar 		= require('menubar')
local lain          	= require('lain')

-- Resource Configuration
local modkey 		= RC.vars.modkey
local altkey 		= RC.vars.altkey
local terminal 		= RC.vars.terminal
local fullShot 		= RC.vars.fullShot
local areaShot 		= RC.vars.areaShot
local selectShot	= RC.vars.selectShot
local volumecfg		= RC.vars.volumecfg

local _M = {}

-- reading
-- https://awesomewm.org/wiki/Global_Keybindings

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
	local globalkeys = gears.table.join(
	awful.key({ modkey,           }, 's',      hotkeys_popup.show_help,
	{description='show help', group='awesome'}),

	-- Standard program
	awful.key({ modkey,           }, 'Return', function () awful.spawn(terminal) end,
	{description = 'open a terminal', group = 'launcher'}),
	awful.key({ altkey,           }, 'm', function () awful.spawn(RC.vars.music) end,
	{description = 'open ncmpcpp', group = 'launcher'}),
	awful.key({ altkey,           }, 'l', function () awful.spawn(RC.vars.mail) end,
	{description = 'open neomutt', group = 'launcher'}),
	awful.key({ altkey,           }, 'r', function () awful.spawn(RC.vars.ranger) end,
	{description = 'open ranger filemanager', group = 'launcher'}),
	awful.key({ modkey, 'Control' }, 'r', awesome.restart,
	{description = 'reload awesome', group = 'awesome'}),
	awful.key({ modkey, 'Control'   }, 'q', awesome.quit,
	{description = 'quit awesome', group = 'awesome'}),
	awful.key({ altkey, 'Control' }, 'l', function() awful.spawn.with_shell(RC.vars.locker) end,
	{description = 'Lock the screen', group = 'awesome'}),
	awful.key({ altkey, 'Control' }, 'Delete', function() awful.spawn.with_shell("logout.sh") end,
	{description = 'Open exit prompt', group = 'awesome'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- User added keybingings
	awful.key({ modkey, altkey }, 'y', function () awful.spawn(RC.vars.rofiappmenu) end,
	{description = 'open application menu', group = 'launcher'}),
	awful.key({ altkey            }, 'b', function () awful.spawn(RC.vars.browser) end,
	{description = 'open internet browser', group = 'launcher'}),
	awful.key({ modkey }, '=', function () awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible end,
	{description = 'Toggle systray visibility', group = 'Miscellaneous'}),
	awful.key({ modkey }, 'p', function () awful.spawn("dmenu_run -fn 'Source Code Pro Regular-11' -i -l 10 -p 'Run:' -nb '#2d2d2d' -nf '#cccccc' -sb '#ff033e' -sf '#38000d'") end,
	{description = 'run prompt', group = 'launcher'}),
	awful.key({ }, 'F2', function () scratch.drop('telegram-desktop', 'bottom', 'center', 0.50, 0.60, true, mouse.screen) end,
	{description = 'Open Telegram', group = 'launcher'}),
	awful.key({ }, 'F3', function () scratch.drop(RC.vars.quakeranger, 'top', 'center', 0.97, 0.7, true, mouse.screen) end,
	{description = 'Open Dropdown filemanager', group = 'launcher'}),
	awful.key({ }, 'F4', function () scratch.drop(RC.vars.quake, 'top', 'center', 0.97, 0.7, true, mouse.screen) end,
	{description = 'Open Dropdown terminal', group = 'launcher'}),
	awful.key({ modkey }, 'x', function() if require('widget.right-dashboard') then _G.screen.primary.right_panel:toggle() end end,
	{ description = 'Open Notification Center', group = 'launcher'}),
	awful.key({ modkey }, 'F11', function() awful.spawn.with_shell("/home/jayar/.local/bin/ScreenDisplay.sh") end,
	{ description = 'Open Notification Center', group = 'launcher'}),

	awful.key({ altkey }, 'f', function() awful.spawn.with_shell("dex /home/jayar/.local/share/applications/chrome-facebook.desktop") end,
	{ description = 'Run chrome facebook app', group = 'launcher'}),
	awful.key({ altkey }, 'y', function() awful.spawn.with_shell(RC.vars.youtubedownload) end,
	{ description = 'Run chrome youtube app', group = 'launcher'}),
	awful.key({ modkey, altkey }, 'm', function() awful.spawn.with_shell("dex /home/jayar/.local/share/applications/chrome-youtubemusic.desktop") end,
	{ description = 'Run chrome youtube music app', group = 'launcher'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Tag browsing
	awful.key({ modkey,           }, 'Left',   awful.tag.viewprev,
	{description = 'view previous', group = 'tag'}),
	awful.key({ modkey,           }, 'Right',  awful.tag.viewnext,
	{description = 'view next', group = 'tag'}),
	awful.key({ modkey,           }, 'Escape', awful.tag.history.restore,
	{description = 'go back', group = 'tag'}),
	awful.key({ modkey,           }, 'j', function () awful.client.focus.byidx(1) end,
	{description = 'focus next by index', group = 'client'}),
	awful.key({ modkey,           }, 'k', function () awful.client.focus.byidx(-1) end,
	{description = 'focus previous by index', group = 'client'}),
	awful.key({ modkey,           }, '-', function () RC.mainmenu:show() end,
	{description = 'show main menu', group = 'awesome'}),

	-- Tag browsing (non-empty)
	awful.key({ modkey }, 'u', function () lain.util.tag_view_nonempty(-1) end,
	{description = 'view  previous nonempty', group = 'tag'}),
	awful.key({ modkey }, 'i', function () lain.util.tag_view_nonempty(1) end,
	{description = 'view  previous nonempty', group = 'tag'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Show/Hide Wibox
	awful.key({ modkey }, 'b', function ()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible
			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end,
	{description = 'toggle wibox', group = 'awesome'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Volume Keys

	awful.key({ modkey }, 'F11',
	function() volumecfg:up() end,
	{description = 'volume 0%', group = 'hotkeys'}),
	awful.key({ modkey }, 'F10',
	function() volumecfg:down() end,
	{description = 'volume 0%', group = 'hotkeys'}),
	awful.key({ modkey }, 'F12',
	function() volumecfg:toggle() end,
	{description = 'volume 0%', group = 'hotkeys'}),

	-- MPD control
	awful.key({ modkey }, 'F7',
	function ()
		os.execute('mpc toggle')
	end,
	{description = 'mpc toggle', group = 'widgets'}),
	awful.key({ modkey }, 'F8',
	function ()
		os.execute('mpc stop')
	end,
	{description = 'mpc stop', group = 'widgets'}),
	awful.key({ modkey }, 'F5',
	function ()
		os.execute('mpc prev')
	end,
	{description = 'mpc prev', group = 'widgets'}),
	awful.key({ modkey }, 'F6',
	function ()
		os.execute('mpc next')
	end,
	{description = 'mpc next', group = 'widgets'}),
	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Copy primary to clipboard (terminals to gtk)
	awful.key({ modkey }, 'c', function () awful.spawn.with_shell('xsel | xsel -i -b') end,
	{description = 'copy terminal to gtk', group = 'hotkeys'}),
	-- Copy clipboard to primary (gtk to terminals)
	awful.key({ modkey }, 'v', function () awful.spawn.with_shell('xsel -b | xsel') end,
	{description = 'copy gtk to terminal', group = 'hotkeys'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Screen Shots
	awful.key({ }, 'Print', function () fullShot() end,
	{ description = 'Fullscreen screenshot', group = 'Miscellaneous'}),
	awful.key({modkey}, 'Print', function () areaShot() end,
	{ description = 'Area screenshot', group = 'Miscellaneous'}),
	awful.key({modkey, altkey}, 'Print', function () selectShot() end,
	{ description = 'Selected screenshot', group = 'Miscellaneous'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Layout manipulation
	awful.key({ modkey,           }, 'l',     function () awful.tag.incmwfact( 0.05)          end,
	{description = 'increase master width factor', group = 'layout'}),
	awful.key({ modkey,           }, 'h',     function () awful.tag.incmwfact(-0.05)          end,
	{description = 'decrease master width factor', group = 'layout'}),
	awful.key({ modkey, 'Shift'   }, 'h',     function () awful.tag.incnmaster( 1, nil, true) end,
	{description = 'increase the number of master clients', group = 'layout'}),
	awful.key({ modkey, 'Shift'   }, 'l',     function () awful.tag.incnmaster(-1, nil, true) end,
	{description = 'decrease the number of master clients', group = 'layout'}),
	awful.key({ modkey, 'Control' }, 'h',     function () awful.tag.incncol( 1, nil, true)    end,
	{description = 'increase the number of columns', group = 'layout'}),
	awful.key({ modkey, 'Control' }, 'l',     function () awful.tag.incncol(-1, nil, true)    end,
	{description = 'decrease the number of columns', group = 'layout'}),
	awful.key({ modkey,           }, 'space', function () awful.layout.inc( 1)                end,
	{description = 'select next', group = 'layout'}),
	awful.key({ modkey, 'Shift'   }, 'space', function () awful.layout.inc(-1)                end,
	{description = 'select previous', group = 'layout'}),

	awful.key({ modkey, 'Control' }, 'n',
	function ()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal(
			'request::activate', 'key.unminimize', {raise = true}
			)
		end
	end,
	{description = 'restore minimized', group = 'client'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Focus Manipulation
	awful.key({ modkey, 'Shift'   }, 'j', function () awful.client.swap.byidx(1)    end,
	{description = 'swap with next client by index', group = 'client'}),
	awful.key({ modkey, 'Shift'   }, 'k', function () awful.client.swap.byidx( -1)    end,
	{description = 'swap with previous client by index', group = 'client'}),
	awful.key({ modkey, 'Control' }, 'j', function () awful.screen.focus_relative( 1) end,
	{description = 'focus the next screen', group = 'screen'}),
	awful.key({ modkey, 'Control' }, 'k', function () awful.screen.focus_relative(-1) end,
	{description = 'focus the previous screen', group = 'screen'}),
	awful.key({ modkey,           }, 'c', awful.client.urgent.jumpto,
	{description = 'jump to urgent client', group = 'client'}),
	awful.key({ modkey,           }, 'Tab',
	function ()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end,
	{description = 'go back', group = 'client'}),

	--   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
	-- Prompt
	awful.key({ modkey },            'r',     function () awful.screen.focused().mypromptbox:run() end,
	{description = 'run prompt', group = 'launcher'}),

	awful.key({ modkey, altkey }, 'x',
	function ()
		awful.prompt.run {
			prompt       = 'Run Lua code: ',
			textbox      = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. '/history_eval'
		}
	end,
	{description = 'lua execute prompt', group = 'awesome'}),

	-- Menubar
	awful.key({ modkey }, 'y', function() menubar.show() end,
	{description = 'show the menubar', group = 'launcher'})

	)

	return globalkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
