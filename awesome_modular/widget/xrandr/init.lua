package.loaded.foggy = nil

local foggy = {
  xrandr = require('widget.xrandr.xrandr'),
  xinerama = require('widget.xrandr.xinerama'),
  shortcuts = require('widget.xrandr.shortcuts'),
  menu = require('widget.xrandr.menu')
}

return foggy
