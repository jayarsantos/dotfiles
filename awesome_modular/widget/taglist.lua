local awful = require('awful')
local wibox = require('wibox')
--local dpi = require('beautiful').xresources.apply_dpi
local capi = {button = _G.button}
local clickable_container = require('widget.material.clickable-container')
local modkey = RC.vars.modkey

local mytagList = function(s)
  return awful.widget.taglist {
		screen  = s,
		--filter  = awful.widget.taglist.filter.all,
		filter = function (t) return t.selected or #t:clients() > 0 end, --show only occupied tags
		-- Add support for hover colors and an index label
		create_callback = function(self, c3, index, objects) --luacheck: no unused args
			self:get_children_by_id('index_role')[1].markup = '<b> '..c3.index..' </b>'
			self:connect_signal('mouse::enter', function()
				if self.bg ~= '#ff0000' then
					self.backup     = self.bg
					self.has_backup = true
				end
				self.bg = '#ff0000'
			end)
			self:connect_signal('mouse::leave', function()
				if self.has_backup then self.bg = self.backup end
			end)
		end,
		update_callback = function(self, c3, index, objects) --luacheck: no unused args
			self:get_children_by_id('index_role')[1].markup = '<b> '..c3.index..--[[c3.index so that tags call on fixed number]]' </b>'
		end,
		buttons = taglist_buttons
	}
end
return mytagList
