-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
	local tags = {}

	local l = awful.layout.suit -- Alias to save time :)
	-- local layouts = { l.max, l.floating, l.max, l.max , l.tile,
	--     l.max, l.max, l.max, l.floating, l.tile}
	local layouts = {
		l.tile.top, l.max, l.tile, l.tile , l.max,
		l.floating, l.max, l.tile, l.tile, l.max
	}

	-- Create tags
	awful.tag.add(names[1], {
		layout = layouts[1],
		screen = s,
		gap_single_client  = false,
		selected = true,
	})

	awful.tag.add(names[2], {
		layout = layouts[2],
		gap_single_client  = false,
		screen = s,
	})

	awful.tag.add(names[3], {
		layout = layouts[3],
		gap_single_client  = false,
		master_width_factor = 0.34,
		column_count = 2,
		screen = s,
	})

	awful.tag.add(names[4], {
		layout = layouts[4],
		gap_single_client  = false,
		column_count = 2,
		screen = s,
	})

	awful.tag.add(names[5], {
		layout = layouts[5],
		gap_single_client  = false,
		screen = s,
	})

	awful.tag.add(names[6], {
		layout = layouts[6],
		screen = s,
	})

	awful.tag.add(names[7], {
		layout = layouts[7],
		screen = screen.count()>1 and 2 or 1,
	})

	awful.tag.add(names[8], {
		layout = layouts[8],
		--gap = 3,
		screen = screen.count()>1 and 2 or 1,
	})

	awful.tag.add(names[9], {
		layout = layouts[9],
		screen = screen.count()>1 and 2 or 1,
	})

end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
