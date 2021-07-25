-- Statusbar for specific themes link from here
-- by: jayarsantos@gmail.com

local awful     = require("awful")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

theme_path = awful.util.getdir("config") .. "/appearance/statusbar/" .. chosen_theme .. "/"

local _M = {}
-- themes required for specific configs
dofile(theme_path .. "init.lua")
