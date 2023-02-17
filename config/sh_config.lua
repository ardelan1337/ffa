-- 									IMPORTANT
-- change this in your ambulancejob in the client/main.lua
--=================================================================================--
-- AddEventHandler('esx:onPlayerDeath', function(data)
-- 	if not exports.ultra_ffa:inFFA() then
-- 		OnPlayerDeath()
-- 	end
-- end)
--=================================================================================--

Config = {
	Settings = {
		MainDim = 0, -- if you dont know what this is just leave it!!!!
		Color = {r = 98, g = 87, b = 255, a = 0.7}, -- Max for a = 1.0, min 0.0, dont use 255
		RespawnTime = 3, -- in seconds
		UseOwnWeapons = false,
		Deathscreen = true,
		InfiniteAmmo = true,
		KillPlayerOnZoneLeave = false, -- false = player gets teleported, true = kills the player
		Position = {
			vector3(109.2978, -1089.374, 29.30247),
			vector3(570.2548, 2796.546, 42.0148)
		},
		Blip = {
			Title = 'FFA',
			Colour = 50,
			ID = 119,
			Scale = 1.0
		},
		Stats = {
			CMD = "stats",
			KeyMapping = "PAGEUP"
		},
		Ped = { -- if a Ped should stand on the FFA Marker
			Enable = false,
			Model = "s_m_m_prisguard_01",
		},
		Marker = {
			Enable = true,
			DrawDistance = 7.0,
			Type = 22,
			Move = true,
			RotateToCam = false,
			Size = {
				x = 1.5,
				y = 1.5,
				z = 1.0
			}
		},
		Language = {
			Player = 'Spieler', -- translate it to your language
			Died = "Du bist gestorben",
			KillerMSG = 'Du hast %s getötet', -- the killer receives this message
			KilledMSG = 'Du wurdest von %s getötet', -- the killed one / loser receives this message
			PressE = 'Drücke %s um die Auswahl zu öffnen', -- %s = ~INPUT_CONTEXT~ / E
			LeftFFA = 'Du hast das FFA verlassen!',
			ZoneFull = 'Die Zone ist voll!',
			MoneyMSG = 'Du hast %s getötet + $%s'
		},
		Health = {
			AddHealthOnKill = {
				Enabled = false,
				Health = 200,
				Armour = 100
			},
			AddHealthOnLeave = {
				Enabled = false,
				Health = 200,
				Armour = 0
			},
			AddHealthOnEnter = {
				Enabled = false,
				Health = 200,
				Armour = 100
			},
		},
		ESXStuff = {
			OnPlayerDeath = 'esx:onPlayerDeath',
			SharedObject = 'esx:getSharedObject',
			Revive = 'esx_ambulancejob:revive'
		},
		Money = {
			Enabled = true,
			Count = math.random(100, 240)
		},
		CMD = {
			Quit = 'quitffa',
			Enabled = true, -- if you should be able to show the ffa selection with a command
			Name = 'ffa',
			KeyMapping = true, -- Enabled has to be true | if you want to have the command bindable
			Standard = 'F4' -- KeyMapping has to be true
		},
		CLNotify = function(msg)
			TriggerEvent('notifications', '', 'FFA - SYSTEM', msg)
		end,
		SVNotify = function(target, msg)
			TriggerClientEvent('notifications', target, '', 'FFA - SYSTEM', msg)
		end,
	},
	Zone = {
		['würfelpark'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'würfelpark',
			dim = 32,
			count = 32,
			img = 'assets/img/LegionSquare-GTAV.webp',
			middle = vector3(195.15, -934.44, 30.69), -- only vector3
			scale = 100.0, -- scale of the zone
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = { -- vector4 and vector3 works
				vector4(157.6892, -989.6053, 30.09194, 317.4216),
				vector4(220.8715, -951.728, 30.08694, 58.00145),
				vector4(255.3023, -875.9902, 30.29221, 113.0529),
				vector4(190.3949, -852.0831, 31.12877, 271.187),
				vector4(215.1449, -877.4598, 31.49833, 154.5738),
				vector4(158.6901, -912.0421, 30.18313, 225.2565),
				vector4(158.9277, -933.8146, 30.06242, 355.4258)
			}
		},
		['ls supply'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'ls supply',
			dim = 187,
			count = 20,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013240483918651432/Hardwood_LumberSupply-GTAV.PNG.png',
			middle = vector3(1206.09, -1298.38, 35.23),
			scale = 90.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(1162.925, -1250.998, 34.56584, 261.0392),
				vector4(1176.472, -1277.408, 34.80234, 180.4994),
				vector4(1168.067, -1312.777, 34.7427, 137.2748),
				vector4(1138.779, -1337.134, 34.65668, 262.075),
				vector4(1163.472, -1357.529, 34.74192, 264.7823),
				vector4(1206.54, -1353.652, 35.22697, 350.6649),
				vector4(1197.346, -1302.481, 35.19452, 165.8914),
				vector4(1219.394, -1270.309, 35.36277, 84.20734),
				vector4(1195.393, -1249.936, 35.21939, 195.1078)
			}
		},
		['prison'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'prison',
			dim = 69,
			count = 24,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013240484212265050/BolingbrokePenitentiary-GTAV.png',
			middle = vector3(1671.95, 2624.73, 15.36),
			scale = 110.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(1667.172, 2632.174, 45.56485, 269.4165),
				vector4(1651.275, 2667.676, 45.59027, 237.5806),
				vector4(1705.234, 2677.412, 45.56489, 114.4845),
				vector4(1715.688, 2619.912, 45.56484, 11.5814),
				vector4(1607.062, 2613.667, 45.56492, 100.6444),
				vector4(1609.623, 2670.542, 45.56488, 147.8673)
			}
		},
		['dach'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'dach',
			dim = 86,
			count = 12,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013240484514250794/RockfordPlaza-GTAV.png',
			middle = vector3(-176.03, -234.67, 81.64),
			scale = 40.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(-140.8202, -219.4948, 81.8303, 132.8486),
				vector4(-172.6833, -266.6667, 81.63596, 71.45306),
				vector4(-206.0854, -236.4263, 78.33944, 268.1722),
				vector4(-175.767, -211.4946, 78.33948, 66.66546),
				vector4(-183.7961, -199.2265, 85.2247, 243.1413)
			}
		},
		['marktplatz'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'marktplatz',
			dim = 3122,
			count = 30,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013239584987033672/unknown.png',
			middle = vector3(394.92, -338.73, 46.95),
			scale = 100.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(353.0579, -359.4925, 46.22213, 262.0073),
				vector4(359.9211, -324.8547, 46.68782, 239.6025),
				vector4(372.0424, -308.9507, 46.72132, 153.5635),
				vector4(400.507, -312.1168, 49.88263, 162.8053),
				vector4(431.7586, -326.8474, 47.22244, 154.331),
				vector4(420.2935, -357.1806, 47.21375, 52.11491),
				vector4(398.003, -373.2784, 46.82435, 19.76275),
				vector4(370.0265, -380.4681, 46.47663, 351.8302)
			}
		},
		['golfplatz'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'golfplatz',
			dim = 1232,
			count = 100,
			img = 'https://cs2.gtaall.eu/attachments/2018-09/original/9aa5a795f278c9a51f2309bd0bd86cb865daef08/9127-GTA5-2018-09-20-11-32-38-96.jpg',
			middle = vector3(-1106.4, -13.91, 50.6),
			scale = 250.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(-1299.173, -0.1469895, 50.53505, 294.0743),
				vector4(-1248.193, -29.33296, 46.73771, 325.4792),
				vector4(-1195.748, -63.47789, 44.90764, 44.32942),
				vector4(-1066.749, -58.65329, 45.53696, 35.67076),
				vector4(-1024.098, 42.28226, 50.9103, 113.8047),
				vector4(-1084.372, 110.1996, 58.97729, 138.7058),
				vector4(-1140.313, 117.3666, 59.57724, 205.977),
				vector4(-1229.84, 111.2117, 57.42917, 196.6264),
				vector4(-1255.38, 74.89209, 52.62662, 242.3832)
			}
		},
		['hafen'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'hafen',
			dim = 4332,
			count = 50,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013240484866564106/Terminal-GTAV.png',
			middle = vector3(978.7192, -3034.33, 5.9),
			scale = 200.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(978.2601, -2959.705, 5.901155, 180.1658),
				vector4(938.1274, -2970.862, 5.900765, 176.0846),
				vector4(944.7655, -2980.458, 5.900762, 89.67774),
				vector4(957.3328, -3034.246, 5.902031, 89.75153),
				vector4(880.5753, -3062.099, 5.900759, 269.4048),
				vector4(882.9471, -3116.521, 5.900797, 329.6466),
				vector4(1017.483, -3133.131, 5.900769, 10.12412)
			}
		},
		['berg'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'berg',
			dim = 200,
			count = 100,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013239785600602163/unknown.png',
			middle = vector3(1507.26, -1176.17, 87.83),
			scale = 180.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(1664.09, -1118.239, 137.0778, 122.5486),
				vector4(1664.182, -1176.868, 119.0876, 63.66121),
				vector4(1630.783, -1287.981, 87.22037, 38.45815),
				vector4(1510.535, -1347.202, 104.5713, 359.2625),
				vector4(1453.874, -1326.925, 102.7629, 322.6618),
				vector4(1414.24, -1300.846, 83.15678, 282.7624),
				vector4(1373.707, -1236.085, 81.90948, 247.7623)
			}
		},
		['sandy shores'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'sandy shores',
			dim = 392,
			count = 40,
			img = 'https://img.gta5-mods.com/q95/images/the-new-saandy-shores/1ca607-20160815115313_1.jpg',
			middle = vector3(1287.44, 3092.4, 40.9),
			scale = 170.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(1284.815, 3027.964, 43.38708, 30.32573),
				vector4(1308.769, 2993.957, 42.16092, 293.0556),
				vector4(1359.764, 3038.39, 43.41048, 37.95364),
				vector4(1422.963, 3134.129, 40.95913, 69.15572),
				vector4(1349.244, 3245.612, 39.02732, 105.97),
				vector4(1238.111, 3222.598, 39.3313, 181.4512),
				vector4(1255.561, 3197.266, 37.98803, 294.1552),
				vector4(1173.392, 3183.755, 39.19094, 277.9721),
				vector4(1128.679, 3138.245, 39.06324, 291.6844),
				vector4(1122.925, 3085.965, 40.43426, 265.9507),
				vector4(1158.289, 2988.621, 39.96696, 351.8668),
				vector4(1249.798, 2940.147, 41.43707, 315.7386),
				vector4(1291.413, 2926.976, 41.37663, 285.0942)
			}
		},
		['brücke'] = {
			asd = 0, -- DO NOT TOUCH IT
			name = 'brücke',
			dim = 32632,
			count = 20,
			img = 'https://cdn.discordapp.com/attachments/1012341309471723570/1013240950446903356/unknown.png',
			middle = vector3(-764.38, -1734.64, 39.65),
			scale = 120.0,
			weapons = {
				'weapon_specialcarbine_mk2',
				'weapon_advancedrifle',
				'weapon_bullpuprifle',
				'weapon_gusenberg',
				'weapon_pistol',
			},
			position = {
				vector4(-705.0051, -1711.479, 32.69899, 288.2238),
				vector4(-649.7656, -1742.442, 37.51706, 74.8999),
				vector4(-874.4491, -1754.364, 38.06834, 329.441),
				vector4(-826.9987, -1727.066, 34.2841, 112.2596),
				vector4(-785.5777, -1735.237, 39.58717, 257.8259),
				vector4(-733.136, -1732.617, 39.24821, 97.21735)
			}
		},
	}
}
