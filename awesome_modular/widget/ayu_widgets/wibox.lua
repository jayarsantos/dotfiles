--------------------------------------------------------------------------------
-- @File:   wibox.lua
-- @Author: Marcel Arpogaus
-- @Date:   2019-07-15 08:12:41
-- [ description ] -------------------------------------------------------------
-- wibar widgets
-- [ changelog ] ---------------------------------------------------------------
-- @Last Modified by:   Marcel Arpogaus
-- @Last Modified time: 2019-07-15 08:51:52
-- @Changes:
--      - added header
--------------------------------------------------------------------------------
local os = os

local gears = require("gears")
local lain = require("lain")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")

local dpi = xresources.apply_dpi
local markup = lain.util.markup

local util = require("themes.util")

-- widgets
local date_time = require("widget.ayu_widgets.date_time")
local weather = require("widget.ayu_widgets.weather")
local fs = require("widget.ayu_widgets.fs")
local cpu = require("widget.ayu_widgets.cpu")
local temp = require("widget.ayu_widgets.temp")
local battery = require("widget.ayu_widgets.battery")
local alsa = require("widget.ayu_widgets.alsa")
local net = require("widget.ayu_widgets.net")
local memory = require("widget.ayu_widgets.memory")
local mpd = require("widget.ayu_widgets.mpd")

local module = {
    weather = weather.gen_wibar_widget,
    net = net.gen_wibar_widget,
    vol = alsa.gen_wibar_widget,
    mem = memory.gen_wibar_widget,
    cpu = cpu.gen_wibar_widget,
    temp = temp.gen_wibar_widget,
    bat = battery.gen_wibar_widget,
    fs = fs.gen_wibar_widget,
    mpd = mpd.gen_wibar_widget,
    datetime = date_time.gen_wibar_widget
}

return module
