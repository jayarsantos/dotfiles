--[[ ---------------------------------------------------------------------------
     AYU Awesome WM desktop widgets

     inspired by Multicolor Awesome WM beutiful 2.0
     github.com/lcpz
--]] ---------------------------------------------------------------------------
-- [ libraries ]-----------------------------------------------------------------
local os = os

local lain = require("lain")
local wibox = require("wibox")
local beautiful = require("beautiful")

local markup = lain.util.markup

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local util = require("util")

-- widgets
local date_time = require("widgets.date_time")
local weather = require("widgets.weather")
local cpu = require("widgets.cpu")
local memory = require("widgets.memory")
local fs = require("widgets.fs")
local battery = require("widgets.battery")

local module = {}

-- [ clock ] -------------------------------------------------------------------
module.clock = date_time.gen_desktop_widget

-- [ weather ] -----------------------------------------------------------------
module.weather = weather.gen_desktop_widget

-- [ arcs ] --------------------------------------------------------------------
module.arcs = function()
    return wibox.widget{
        nil,
        {
            cpu.create_arc_widget(),
            memory.create_arc_widget(),
            fs.create_arc_widget(),
            battery.create_arc_widget(),
            spacing = beautiful.desktop_widgets_arc_spacing,
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        expand = "outer",
        layout = wibox.layout.align.vertical
    }
end
return module
