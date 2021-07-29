-- Standard awesome library
local awful     = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

local _M = {}

-- reading
-- https://awesomewm.org/apidoc/libraries/awful.rules.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get(clientkeys, clientbuttons)
	local rules = {

		-- All clients will match this rule.
		{ rule = { },
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus     = awful.client.focus.filter,
				raise     = true,
				keys      = clientkeys,
				buttons   = clientbuttons,
				screen    = awful.screen.preferred,
				placement = awful.placement.no_overlap+awful.placement.no_offscreen
			}
		},

		-- Floating clients.
		{ rule_any = {
				instance = {
					"DTA",  -- Firefox addon DownThemAll.
					"copyq",  -- Includes session name in class.
					"pinentry",
				},
				class = {
					"Arandr",
					"Blueman-manager",
					"Gpick",
					"Kruler",
					"MessageWin",  -- kalarm.
					"Sxiv",
					"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
					"Wpa_gui",
					"veromix",
					"xtightvncviewer",
					"Wpg",
					"Yad",
					"Nm-connection-editor",
                    "Tk",
                    "Thunar",
                    "Xfce4-appfinder",
                    "Software-properties-gtk",
                    "Gnome-calculator",
                    "Synaptic",
					"mpv"
				},

				-- Note that the name property shown in xprop might be set slightly after creation of the client
				-- and the name shown there might not match defined rules here.
				name = {
					"Event Tester",  -- xev.
					"Authenticate"
				},
				role = {
					"AlarmWindow",  -- Thunderbird's calendar.
					"ConfigManager",  -- Thunderbird's about:config.
					--			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
				}
			},
			properties = {
				ontop = true,
				floating = true,
				drawBackdrop = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		},

		{ rule_any = {
				class = {
					"mpv"
				}
			},
				properties = {
					ontop = true,
					floating = true,
					drawBackdrop = true,
					skip_decoration = true,
					width = 400,
					height = 350,
					x = 1250,
					y = 30
				}
			},

			-- Add titlebars to normal clients and dialogs
			{
				rule_any = {
					type = {
						"normal",
						"dialog"
					},
				},
				except_any = {
					role = {
						"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
					},
					class = {
						"Firefox",
						"Tor Browser",
						"Google-chrome"
					},
					instance = {
						-- Dont't switch to tag `1` when opening QuakeTerminal
						'QuakeTerminal',
						'Musicncmpcpp',
						'QuakeRanger'
					}
				},
				properties = {
					titlebars_enabled = true
				}
			},

			-- Terminals[1]
			{
				rule_any = {
					class = {
						"URxvt",
						"XTerm",
						"UXTerm",
						"kitty",
						"K3rmit"
					},
				},
				except_any = {
					instance = {
						-- Dont't switch to tag `1` when opening QuakeTerminal
						'QuakeTerminal',
						'QuakeRanger'
					}
				},
				properties = {
					size_hints_honor = false,
					screen = 1,
					tag = '1' and names[1],
					switchtotag = true,
				}
			},

			-- Browsers[2]
			{
				rule_any = {
					class = {
						"Firefox",
						"Tor Browser",
						"qutebrowser",
						"Google-chrome"
					},
				},
				properties = {
					screen = 1,
					tag = '2' and names[2],
					switchtotag = true
				}
			},


			-- Chat[3]
			{
				rule_any = {
					class = {
						"Caprine",
						"TelegramDesktop",
						"Pidgin"
					},
				},
				properties = {
					screen = 1,
					tag = '3' and names[3]
				}
			},

			-- File Managers/Editor[4]
			{
				rule_any = {
					class = {
						"Atom",
						"Subl3",
						"code-oss",
						"Geany",
						"Gimp-2.10",
						"Inkscape",
						"Flowblade",
						"Mirage",
						"Nemo",
						"File-roller"
					},
				},
				properties = {
					screen = 1,
					tag = '4' and names[4],
					switchtotag = true
				}
			},

			-- Music[5]
			{
				rule_any = {
					instance = {
						'Musicncmpcpp'
					},
				},
				properties = {
					screen = 1,
					tag = '5' and names[5],
					switchtotag = true
				}
			},

			-- Games[6]
			{
				rule_any = {
					class = {
						"Wine",
						"dolphin-emu",
						"Steam",
						"Citra",
						"PCSX2",
						"Pcsxr",
						"Minetest",
						"Snes9x-gtk",
						"dota2"
					},
				},
				properties = {
					screen = 1,
					tag = '6' and names[6],
					switchtotag = true,
					--floating = true,
					hide_titlebars = true
				}
			},

			-- Video
			{
				rule_any = {
					class = {
						"vlc",
						"smplayer"
					},
					instance = {
						"Musicncmpcpp",
					},
				},
				properties = {
					screen = screen.count()>1 and 2 or 1,
					tag = '7' and names[7],
					switchtotag = true
				}
			},
			-- Mail
			{
				rule_any = {
					class = {
						"Thunderbird"
					},
					instance = {
						"NeomuttMail"
					},
				},
				properties = {
					screen = screen.count()>1 and 2 or 1,
					tag = '8' and names[8],
					switchtotag = true
				}
			},
			-- Spare
			{
				rule_any = {
				},
				properties = {
					screen = screen.count()>1 and 2 or 1,
					tag = '9' and names[9],
					switchtotag = true
				}
			},



			-- Normally we'd do this with a rule but Spotify and SuperTuxKart doesnt set
			-- its class or name until is starts up, so we need to catch that signal
			client.connect_signal("property::class",function(c)

				if c.class == 'Spotify' or c.class == 'SuperTuxKart' then
					-- Check if already opened
					local app = function(c)
						if c.class == 'SuperTuxKart' then
							return awful.rules.match(c, { class = 'SuperTuxKart' } )
						elseif c.class == 'Spotify' then
							return awful.rules.match(c, { class = 'Spotify' } )
						end
					end

					-- Move it to the desired tag in THIS SCREEN
					local tagName = ''
					if c.class == 'Spotify' then
						tagName = '5'
					elseif c.class == 'SuperTuxKart' then
						tagName = '6'
					end
					local t = awful.tag.find_by_name(awful.screen.focused(), tagName)
					c:move_to_tag(t)
					t:view_only()

					if c.class == 'SuperTuxKart' then
						c.fullscreen = not c.fullscreen
						c:raise()
					end
				end
			end)
		}

		return rules

	end

	-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

	return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
