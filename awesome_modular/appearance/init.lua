local awful = require("awful")
awful.util = require("awful.util")

-- available themes: multicolor, cesious, zenburn, pro-dark, powerarrow-dark, powerarrow
--chosen_theme = "ayu"
--chosen_theme = "multicolor"
--chosen_theme = "cesious"
--chosen_theme = "zenburn"
--chosen_theme = "pro-dark"
chosen_theme = "powerarrow"
--chosen_theme = "powerarrow-dark"

local config = {
	use_xresources = false
}

theme_path = awful.util.getdir("config") .. "appearance/themes/" .. chosen_theme
icon_dir = awful.util.getdir("config") .. "appearance/theme_icons/"

-- used for main/tag.lua and binding/bindtotags.lua
if chosen_theme == "pro-dark" then
	names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
else
	names = { "Term", "Web", "Chat", "Editor", "Video", "Games", "Music", "Mail", "Spare" }
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- default variables
if chosen_theme == "ayu" then

	local theme = {}
	dofile(theme_path .. "/init.lua")

	return theme

else

	theme = {}

	if config.use_xresources then
		dofile(theme_path .. "/colors_xrdb.lua")
	else
		dofile(theme_path .. "/colors.lua")
	end

	dofile(theme_path .. "/titlebar.lua")
	dofile(theme_path .. "/layouts.lua")
	dofile(theme_path .. "/widgets.lua")

	theme.tasklist_plain_task_name                  = true
	theme.tasklist_disable_icon                     = true

	theme.useless_gap = 4
	theme.border_width = 1

	--Wallpaper management
	--awful.spawn.with_shell("~/.fehbg") --better used with azote, for dual screen layout
	require("appearance.wallchange") -- wallpaper changes on specific time

	return theme
end
