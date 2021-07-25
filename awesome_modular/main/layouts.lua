-- Standard awesome library
local awful = require("awful")
local lain = require("lain")
local dpi           = require("beautiful.xresources").apply_dpi

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
	-- Table of layouts to cover with awful.layout.inc, order matters.
	local layouts = {
		awful.layout.suit.tile,
		--awful.layout.suit.spiral,
		--awful.layout.suit.tile.left,
		awful.layout.suit.tile.bottom,
		--awful.layout.suit.tile.top,
		lain.layout.centerwork,
		--awful.layout.suit.floating,
		--awful.layout.suit.fair,
		--awful.layout.suit.fair.horizontal,
		--awful.layout.suit.spiral.dwindle,
		awful.layout.suit.max,
		--awful.layout.suit.max.fullscreen,
		--awful.layout.suit.magnifier,
		--awful.layout.suit.corner.nw,
		--awful.layout.suit.corner.ne,
		--awful.layout.suit.corner.sw,
		--awful.layout.suit.corner.se,
		--lain.layout.cascade,
		--lain.layout.cascade.tile,
		--lain.layout.centerwork.horizontal,
		--lain.layout.termfair,
		--lain.layout.termfair.center,
	}

	lain.layout.termfair.nmaster           = 3
	lain.layout.termfair.ncol              = 1
	lain.layout.termfair.center.nmaster    = 3
	lain.layout.termfair.center.ncol       = 1
	lain.layout.cascade.tile.offset_x      = dpi(2)
	lain.layout.cascade.tile.offset_y      = dpi(32)
	lain.layout.cascade.tile.extra_padding = dpi(5)
	lain.layout.cascade.tile.nmaster       = 5
	lain.layout.cascade.tile.ncol          = 2
	return layouts
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
