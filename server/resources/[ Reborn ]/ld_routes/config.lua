config = {}

config.animType = 1
config.dinheirolimpo = "dollars"
config.dinheirosujo = "dollars2"

config.hookLDFactions = true

config.craftWarnColor = {163, 0, 0}
config.collectWarnColor = {163, 0, 0}
config.deliveryWarnColor = {163, 0, 0}

config.main = {
	["Milicia"] = {
		["perm"] = "milicia.permissao", --permissão necessária
		["name"] = 'Milicia', --nome na NUI
		["customBlip"] = true, --ativar blip customizado ou apenas o normal do gta?
		["coords"] = {
			vec3(1405.88,1137.7,109.75), --coordenadas do blip
		},
		["craft"] = { --configuração do craft
			["ammo-9"] = {
				["image"] = "ammo-9",
				["amount"] = 1,
				["destroy"] = true, --se os itens necessários pra fazer devem ser gastos ou não
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0, --chance de avisar a policia
				["require"] = {
					["capsule"] = 3,
					["gunpowder"] = 3,
				}
			},
			["ammo-45"] = {
				["image"] = "ammo-45",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["capsule"] = 5,
					["gunpowder"] = 5,
				}
			},			
			["ammo-rifle2"] = {
				["image"] = "ammo-rifle2",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["capsule"] = 7,
					["gunpowder"] = 7,
				}
			},
			["ammo-rifle"] = {
				["image"] = "ammo-rifle",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["capsule"] = 7,
					["gunpowder"] = 7,
				}
			},
			["ammo-shotgun"] = {
				["image"] = "ammo-shotgun",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["capsule"] = 5,
					["gunpowder"] = 5,
				}
			},
		},
		["collect"] = {
			["collectContent"] = {
				['Capsula e Polvora'] = { --Nome que aparece na nui
					image = 'capsule', --Imagem que aparece na nui
					itens = { 
						['capsule'] = { quantidade_min = 2, quantidade_max = 4 }, --itens que vem realizar a ação
						['gunpowder'] = { quantidade_min = 2, quantidade_max = 4 }, --itens que vem realizar a ação
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
			},
			["collectCoords"] = {
				{ 1915.7292480469, 3909.2995605469, 33.441585540771 },
				{ 1930.0754394531, 4634.90625, 40.470970153809 },
				{ 1470.1928710938, 6543.1459960938, 14.904124259949 },
				{ -11.720105171204, 6279.9487304688, 31.376399993896 },
				{ -2304.6062011719, 3427.1062011719, 31.055171966553 },
				{ -3187.359375, 1273.9223632813, 12.673379898071 },
				{ -1604.4786376953, -832.62243652344, 10.26796913147 },
				{ 2932.3322753906, 4624.0795898438, 48.723358154297 },
				{ 2434.4016113281, 5011.5209960938, 46.827575683594 },
				{ 2618.3149414063, 3275.3015136719, 55.73819732666 },
				{ 983.93072509766, 2719.029296875, 39.503429412842 },
				{ -35.534824371338, 2871.5373535156, 59.610176086426 },
				{ -112.28997039795, 1882.0068359375, 197.33317565918 },
				{ 387.48745727539, 3584.6550292969, 33.292278289795 },
				{ 839.49841308594, 2176.7915039063, 52.288890838623 },
				{ 2696.302734375, 1613.8950195313, 24.423755645752 },
				{ 1085.8547363281, -2400.0439453125, 30.669706344604 },
				{ 1429.6936035156, 4377.47265625, 44.599269866943 },
				{ 412.55899047852, 2965.1950683594, 41.888061523438 },
				{ 1759.6368408203, 3299.0029296875, 42.17467880249 },
				{ 726.81042480469, 4168.9228515625, 40.709239959717 },
				{ 2558.876953125, 288.79989624023, 108.60987854004 },
				{ 2352.3764648438, 2523.3559570313, 47.689441680908 },
				{ -428.61862182617, -1728.1860351563, 19.78373336792 },
				{ -1088.3803710938, -1672.3043212891, 4.700074672699 },
				{ -1321.6911621094, -1264.2875976563, 4.5917778015137 },
				{ -1349.6951904297, -945.17681884766, 9.7058086395264 },
				{ -1307.7419433594, -832.76031494141, 17.139245986938 },
				{ -1704.2272949219, -441.75592041016, 41.64807510376 },
				{ -1500.115234375, -202.0580291748, 50.88969039917 },
				{ -1309.2584228516, -175.55511474609, 43.666454315186 },
				{ -966.58758544922, -266.81076049805, 39.334583282471 },
				{ -619.56103515625, -82.884033203125, 41.196720123291 },
				{ -422.22146606445, 71.783996582031, 64.263313293457 },
				{ -159.37677001953, -153.51475524902, 43.621189117432 },
				{ -64.202850341797, 77.092277526855, 71.616172790527 },
				{ -174.67333984375, 219.16426086426, 90.021614074707 },
				{ -771.87231445313, 351.56149291992, 87.998184204102 },
				{ -554.365234375, 541.19622802734, 110.70719909668 },
				{ 57.35270690918, 449.81817626953, 147.03143310547 },
				{ 198.32318115234, 324.37655639648, 105.41010284424 },
				{ 731.67504882813, 134.44757080078, 80.754508972168 },
				{ 1094.6635742188, -265.57302856445, 69.313804626465 },
				{ 1082.4643554688, -787.37548828125, 58.351222991943 },
				{ 810.58142089844, -750.3564453125, 26.739147186279 },
				{ 764.85583496094, -1359.0031738281, 27.878271102905 },
				{ 485.6240234375, -1477.0966796875, 29.289901733398 },
				{ 115.66278839111, -1685.7535400391, 33.491214752197 },
				{ -228.97648620605, -1117.9224853516, 23.025501251221 },
				{ -578.05053710938, -1012.9370117188, 22.325052261353 },
				{ 351.47366333008, -972.78100585938, 29.432527542114 },
				{ 418.35342407227, -206.99436950684, 59.910438537598 },
				{ 981.13293457031, -1705.8330078125, 31.225019454956 },
				{ 951.73376464844, -210.74114990234, 73.208442687988 },
				{ 717.64056396484, 592.41064453125, 129.05075073242 },
				{ -993.37579345703, -519.62097167969, 37.49974822998 },
				{ 216.65922546387, 1192.0157470703, 225.78944396973 },
				{ 372.99267578125, -1441.3872070313, 29.43154335022 },
				{ 141.6071472168, -379.63339233398, 43.256973266602 },
				{ -1120.9721679688, 2712.2465820313, 18.86775970459 },
				{ 1722.2264404297, 4734.9340820313, 42.134326934814 },
				{ 2221.9211425781, 5614.4848632813, 54.901653289795 },
				{ 3310.8198242188, 5176.5361328125, 19.614561080933 },
				{ 3807.6591796875, 4478.4794921875, 6.3653964996338 }
			},
			["collectVehicle"] = nil,
			["collectRandom"] = true,
			["collectMaxDistance"] = 3000,
			["collectAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["collectText"] = "para coletar",
		},
		["delivery"] = {
			["deliveryContent"] = {
				--[[ ['Roupas'] = {
					image = 'roupas',
					itens = { 
						['tarp'] = { quantidade_min = 2, quantidade_max = 4, pagamento_min = 200, pagamento_max = 250, police_multiplier = 0.5 }, 
						['elastic'] = { quantidade_min = 1, quantidade_max = 1, pagamento_min = 200, pagamento_max = 250, police_multiplier = 0.5 },
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
				['Cobre'] = {
					image = 'copper',
					itens = { 
						['copper'] = { quantidade_min = 2, quantidade_max = 4, pagamento_min = 200, pagamento_max = 250, police_multiplier = 0.5 }, 
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
				['Latinha'] = {
					image = 'metalcan',
					itens = { 
						['metalcan'] = { quantidade_min = 2, quantidade_max = 4, pagamento_min = 200, pagamento_max = 250, police_multiplier = 0.5 }, 
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				}, ]]
			},
			["deliveryCoords"] = {
				{ 1915.7292480469, 3909.2995605469, 33.441585540771 },
				{ 1930.0754394531, 4634.90625, 40.470970153809 },
				{ 1470.1928710938, 6543.1459960938, 14.904124259949 },
				{ -11.720105171204, 6279.9487304688, 31.376399993896 },
				{ -2304.6062011719, 3427.1062011719, 31.055171966553 },
				{ -3187.359375, 1273.9223632813, 12.673379898071 },
				{ -1604.4786376953, -832.62243652344, 10.26796913147 },
				{ 2932.3322753906, 4624.0795898438, 48.723358154297 },
				{ 2434.4016113281, 5011.5209960938, 46.827575683594 },
				{ 2618.3149414063, 3275.3015136719, 55.73819732666 },
				{ 983.93072509766, 2719.029296875, 39.503429412842 },
				{ -35.534824371338, 2871.5373535156, 59.610176086426 },
				{ -112.28997039795, 1882.0068359375, 197.33317565918 },
				{ 387.48745727539, 3584.6550292969, 33.292278289795 },
				{ 839.49841308594, 2176.7915039063, 52.288890838623 },
				{ 2696.302734375, 1613.8950195313, 24.423755645752 },
				{ 1085.8547363281, -2400.0439453125, 30.669706344604 },
				{ 1429.6936035156, 4377.47265625, 44.599269866943 },
				{ 412.55899047852, 2965.1950683594, 41.888061523438 },
				{ 1759.6368408203, 3299.0029296875, 42.17467880249 },
				{ 726.81042480469, 4168.9228515625, 40.709239959717 },
				{ 2558.876953125, 288.79989624023, 108.60987854004 },
				{ 2352.3764648438, 2523.3559570313, 47.689441680908 },
				{ -428.61862182617, -1728.1860351563, 19.78373336792 },
				{ -1088.3803710938, -1672.3043212891, 4.700074672699 },
				{ -1321.6911621094, -1264.2875976563, 4.5917778015137 },
				{ -1349.6951904297, -945.17681884766, 9.7058086395264 },
				{ -1307.7419433594, -832.76031494141, 17.139245986938 },
				{ -1704.2272949219, -441.75592041016, 41.64807510376 },
				{ -1500.115234375, -202.0580291748, 50.88969039917 },
				{ -1309.2584228516, -175.55511474609, 43.666454315186 },
				{ -966.58758544922, -266.81076049805, 39.334583282471 },
				{ -619.56103515625, -82.884033203125, 41.196720123291 },
				{ -422.22146606445, 71.783996582031, 64.263313293457 },
				{ -159.37677001953, -153.51475524902, 43.621189117432 },
				{ -64.202850341797, 77.092277526855, 71.616172790527 },
				{ -174.67333984375, 219.16426086426, 90.021614074707 },
				{ -771.87231445313, 351.56149291992, 87.998184204102 },
				{ -554.365234375, 541.19622802734, 110.70719909668 },
				{ 57.35270690918, 449.81817626953, 147.03143310547 },
				{ 198.32318115234, 324.37655639648, 105.41010284424 },
				{ 731.67504882813, 134.44757080078, 80.754508972168 },
				{ 1094.6635742188, -265.57302856445, 69.313804626465 },
				{ 1082.4643554688, -787.37548828125, 58.351222991943 },
				{ 810.58142089844, -750.3564453125, 26.739147186279 },
				{ 764.85583496094, -1359.0031738281, 27.878271102905 },
				{ 485.6240234375, -1477.0966796875, 29.289901733398 },
				{ 115.66278839111, -1685.7535400391, 33.491214752197 },
				{ -228.97648620605, -1117.9224853516, 23.025501251221 },
				{ -578.05053710938, -1012.9370117188, 22.325052261353 },
				{ 351.47366333008, -972.78100585938, 29.432527542114 },
				{ 418.35342407227, -206.99436950684, 59.910438537598 },
				{ 981.13293457031, -1705.8330078125, 31.225019454956 },
				{ 951.73376464844, -210.74114990234, 73.208442687988 },
				{ 717.64056396484, 592.41064453125, 129.05075073242 },
				{ -993.37579345703, -519.62097167969, 37.49974822998 },
				{ 216.65922546387, 1192.0157470703, 225.78944396973 },
				{ 372.99267578125, -1441.3872070313, 29.43154335022 },
				{ 141.6071472168, -379.63339233398, 43.256973266602 },
				{ -1120.9721679688, 2712.2465820313, 18.86775970459 },
				{ 1722.2264404297, 4734.9340820313, 42.134326934814 },
				{ 2221.9211425781, 5614.4848632813, 54.901653289795 },
				{ 3310.8198242188, 5176.5361328125, 19.614561080933 },
				{ 3807.6591796875, 4478.4794921875, 6.3653964996338 }
			},
			["deliveryDirtyMoney"] = true,
			["deliveryVehicle"] = nil,
			["deliveryRandom"] = true,
			["deliveryMaxDistance"] = 3000,
			["deliveryAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["deliveryText"] = "para entregar",
		},
	},
	["Mafia"] = {
		["perm"] = "mafia.permissao", --permissão necessária
		["name"] = 'Mafia', --nome na NUI
		["customBlip"] = true, --ativar blip customizado ou apenas o normal do gta?
		["coords"] = {
			vec3(591.47,-3273.54,6.07), --coordenadas do blip
		},
		["craft"] = { --configuração do craft
			["WEAPON_PISTOL"] = {
				["image"] = "WEAPON_PISTOL",
				["amount"] = 1,
				["destroy"] = true, --se os itens necessários pra fazer devem ser gastos ou não
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0, --chance de avisar a policia
				["require"] = {
					["aluminum"] = 15,
					["copper"] = 15,
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["image"] = "WEAPON_PISTOL_MK2",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 15,
					["copper"] = 15,
				}
			},			
			["WEAPON_SMG_MK2"] = {
				["image"] = "WEAPON_SMG_MK2",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 20,
				}
			},
			["WEAPON_MICROSMG"] = {
				["image"] = "WEAPON_MICROSMG",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 20,
				}
			},
			["WEAPON_MINISMG"] = {
				["image"] = "WEAPON_MINISMG",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 20,
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["image"] = "WEAPON_ASSAULTRIFLE",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 25,
					["copper"] = 25,
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["image"] = "WEAPON_ASSAULTRIFLE_MK2",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 25,
					["copper"] = 25,
				}
			},
			["WEAPON_CARBINERIFLE"] = {
				["image"] = "WEAPON_CARBINERIFLE",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 25,
					["copper"] = 25,
				}
			},
			["WEAPON_CARBINERIFLE_MK2"] = {
				["image"] = "WEAPON_CARBINERIFLE_MK2",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 25,
					["copper"] = 25,
				}
			},
		},
		["collect"] = {
			["collectContent"] = {
				['Aluminio e Cobre'] = { --Nome que aparece na nui
					image = 'aluminum', --Imagem que aparece na nui
					itens = { 
						['copper'] = { quantidade_min = 2, quantidade_max = 4 }, --itens que vem realizar a ação
						['aluminum'] = { quantidade_min = 2, quantidade_max = 4 }, --itens que vem realizar a ação
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
			},
			["collectCoords"] = {
				{ 1915.7292480469, 3909.2995605469, 33.441585540771 },
				{ 1930.0754394531, 4634.90625, 40.470970153809 },
				{ 1470.1928710938, 6543.1459960938, 14.904124259949 },
				{ -11.720105171204, 6279.9487304688, 31.376399993896 },
				{ -2304.6062011719, 3427.1062011719, 31.055171966553 },
				{ -3187.359375, 1273.9223632813, 12.673379898071 },
				{ -1604.4786376953, -832.62243652344, 10.26796913147 },
				{ 2932.3322753906, 4624.0795898438, 48.723358154297 },
				{ 2434.4016113281, 5011.5209960938, 46.827575683594 },
				{ 2618.3149414063, 3275.3015136719, 55.73819732666 },
				{ 983.93072509766, 2719.029296875, 39.503429412842 },
				{ -35.534824371338, 2871.5373535156, 59.610176086426 },
				{ -112.28997039795, 1882.0068359375, 197.33317565918 },
				{ 387.48745727539, 3584.6550292969, 33.292278289795 },
				{ 839.49841308594, 2176.7915039063, 52.288890838623 },
				{ 2696.302734375, 1613.8950195313, 24.423755645752 },
				{ 1085.8547363281, -2400.0439453125, 30.669706344604 },
				{ 1429.6936035156, 4377.47265625, 44.599269866943 },
				{ 412.55899047852, 2965.1950683594, 41.888061523438 },
				{ 1759.6368408203, 3299.0029296875, 42.17467880249 },
				{ 726.81042480469, 4168.9228515625, 40.709239959717 },
				{ 2558.876953125, 288.79989624023, 108.60987854004 },
				{ 2352.3764648438, 2523.3559570313, 47.689441680908 },
				{ -428.61862182617, -1728.1860351563, 19.78373336792 },
				{ -1088.3803710938, -1672.3043212891, 4.700074672699 },
				{ -1321.6911621094, -1264.2875976563, 4.5917778015137 },
				{ -1349.6951904297, -945.17681884766, 9.7058086395264 },
				{ -1307.7419433594, -832.76031494141, 17.139245986938 },
				{ -1704.2272949219, -441.75592041016, 41.64807510376 },
				{ -1500.115234375, -202.0580291748, 50.88969039917 },
				{ -1309.2584228516, -175.55511474609, 43.666454315186 },
				{ -966.58758544922, -266.81076049805, 39.334583282471 },
				{ -619.56103515625, -82.884033203125, 41.196720123291 },
				{ -422.22146606445, 71.783996582031, 64.263313293457 },
				{ -159.37677001953, -153.51475524902, 43.621189117432 },
				{ -64.202850341797, 77.092277526855, 71.616172790527 },
				{ -174.67333984375, 219.16426086426, 90.021614074707 },
				{ -771.87231445313, 351.56149291992, 87.998184204102 },
				{ -554.365234375, 541.19622802734, 110.70719909668 },
				{ 57.35270690918, 449.81817626953, 147.03143310547 },
				{ 198.32318115234, 324.37655639648, 105.41010284424 },
				{ 731.67504882813, 134.44757080078, 80.754508972168 },
				{ 1094.6635742188, -265.57302856445, 69.313804626465 },
				{ 1082.4643554688, -787.37548828125, 58.351222991943 },
				{ 810.58142089844, -750.3564453125, 26.739147186279 },
				{ 764.85583496094, -1359.0031738281, 27.878271102905 },
				{ 485.6240234375, -1477.0966796875, 29.289901733398 },
				{ 115.66278839111, -1685.7535400391, 33.491214752197 },
				{ -228.97648620605, -1117.9224853516, 23.025501251221 },
				{ -578.05053710938, -1012.9370117188, 22.325052261353 },
				{ 351.47366333008, -972.78100585938, 29.432527542114 },
				{ 418.35342407227, -206.99436950684, 59.910438537598 },
				{ 981.13293457031, -1705.8330078125, 31.225019454956 },
				{ 951.73376464844, -210.74114990234, 73.208442687988 },
				{ 717.64056396484, 592.41064453125, 129.05075073242 },
				{ -993.37579345703, -519.62097167969, 37.49974822998 },
				{ 216.65922546387, 1192.0157470703, 225.78944396973 },
				{ 372.99267578125, -1441.3872070313, 29.43154335022 },
				{ 141.6071472168, -379.63339233398, 43.256973266602 },
				{ -1120.9721679688, 2712.2465820313, 18.86775970459 },
				{ 1722.2264404297, 4734.9340820313, 42.134326934814 },
				{ 2221.9211425781, 5614.4848632813, 54.901653289795 },
				{ 3310.8198242188, 5176.5361328125, 19.614561080933 },
				{ 3807.6591796875, 4478.4794921875, 6.3653964996338 }
			},
			["collectVehicle"] = nil,
			["collectRandom"] = true,
			["collectMaxDistance"] = 3000,
			["collectAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["collectText"] = "para coletar",
		},
		["delivery"] = {
			["deliveryContent"] = {},
			["deliveryCoords"] = {},
			["deliveryDirtyMoney"] = true,
			["deliveryVehicle"] = nil,
			["deliveryRandom"] = true,
			["deliveryMaxDistance"] = 3000,
			["deliveryAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["deliveryText"] = "para entregar",
		},
	},
	["Bahamas"] = {
		["perm"] = "bahamas.permissao", --permissão necessária
		["name"] = 'Bahamas', --nome na NUI
		["customBlip"] = true, --ativar blip customizado ou apenas o normal do gta?
		["coords"] = {
			vec3(-1855.11,2056.79,135.46), --coordenadas do blip
		},
		["craft"] = { --configuração do craft
			["lockpick"] = {
				["image"] = "lockpick",
				["amount"] = 1,
				["destroy"] = true, --se os itens necessários pra fazer devem ser gastos ou não
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0, --chance de avisar a policia
				["require"] = {
					["aluminum"] = 8,
					["copper"] = 6,
				}
			},
			["blackcard"] = {
				["image"] = "blackcard",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["plastic"] = 5,
					["eletronics"] = 5,
				}
			},			
			["c4"] = {
				["image"] = "c4",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 8,
					["copper"] = 6,
					["gunpowder"] = 7,
					["eletronics"] = 2,
					["glass"] = 2,
				}
			},
			["vest"] = {
				["image"] = "vest",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 5,
					["copper"] = 5,
					["tecido"] = 20,
				}
			},
			["handcuff"] = {
				["image"] = "handcuff",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 12,
				}
			},
			["rope"] = {
				["image"] = "rope",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["tecido"] = 20,
				}
			},
			["hood"] = {
				["image"] = "hood",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["tecido"] = 15,
				}
			},
		},
		["collect"] = {
			["collectContent"] = {
				['Aluminio e Cobre'] = { --Nome que aparece na nui
					image = 'aluminum', --Imagem que aparece na nui
					itens = { 
						['copper'] = { quantidade_min = 3, quantidade_max = 5 }, --itens que vem realizar a ação
						['aluminum'] = { quantidade_min = 3, quantidade_max = 5 }, --itens que vem realizar a ação
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
				['Plastico e Tecido'] = { --Nome que aparece na nui
					image = 'plastic', --Imagem que aparece na nui
					itens = { 
						['tecido'] = { quantidade_min = 3, quantidade_max = 5 }, --itens que vem realizar a ação
						['plastic'] = { quantidade_min = 2, quantidade_max = 4 }, --itens que vem realizar a ação
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
				['Itens complementares'] = { --Nome que aparece na nui
					image = 'eletronics', --Imagem que aparece na nui
					itens = { 
						['eletronics'] = { quantidade_min = 3, quantidade_max = 5 }, --itens que vem realizar a ação
						['gunpowder'] = { quantidade_min = 2, quantidade_max = 4 }, --itens que vem realizar a ação
						['glass'] = { quantidade_min = 1, quantidade_max = 3 }, --itens que vem realizar a ação
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
			},
			["collectCoords"] = {
				{ 1915.7292480469, 3909.2995605469, 33.441585540771 },
				{ 1930.0754394531, 4634.90625, 40.470970153809 },
				{ 1470.1928710938, 6543.1459960938, 14.904124259949 },
				{ -11.720105171204, 6279.9487304688, 31.376399993896 },
				{ -2304.6062011719, 3427.1062011719, 31.055171966553 },
				{ -3187.359375, 1273.9223632813, 12.673379898071 },
				{ -1604.4786376953, -832.62243652344, 10.26796913147 },
				{ 2932.3322753906, 4624.0795898438, 48.723358154297 },
				{ 2434.4016113281, 5011.5209960938, 46.827575683594 },
				{ 2618.3149414063, 3275.3015136719, 55.73819732666 },
				{ 983.93072509766, 2719.029296875, 39.503429412842 },
				{ -35.534824371338, 2871.5373535156, 59.610176086426 },
				{ -112.28997039795, 1882.0068359375, 197.33317565918 },
				{ 387.48745727539, 3584.6550292969, 33.292278289795 },
				{ 839.49841308594, 2176.7915039063, 52.288890838623 },
				{ 2696.302734375, 1613.8950195313, 24.423755645752 },
				{ 1085.8547363281, -2400.0439453125, 30.669706344604 },
				{ 1429.6936035156, 4377.47265625, 44.599269866943 },
				{ 412.55899047852, 2965.1950683594, 41.888061523438 },
				{ 1759.6368408203, 3299.0029296875, 42.17467880249 },
				{ 726.81042480469, 4168.9228515625, 40.709239959717 },
				{ 2558.876953125, 288.79989624023, 108.60987854004 },
				{ 2352.3764648438, 2523.3559570313, 47.689441680908 },
				{ -428.61862182617, -1728.1860351563, 19.78373336792 },
				{ -1088.3803710938, -1672.3043212891, 4.700074672699 },
				{ -1321.6911621094, -1264.2875976563, 4.5917778015137 },
				{ -1349.6951904297, -945.17681884766, 9.7058086395264 },
				{ -1307.7419433594, -832.76031494141, 17.139245986938 },
				{ -1704.2272949219, -441.75592041016, 41.64807510376 },
				{ -1500.115234375, -202.0580291748, 50.88969039917 },
				{ -1309.2584228516, -175.55511474609, 43.666454315186 },
				{ -966.58758544922, -266.81076049805, 39.334583282471 },
				{ -619.56103515625, -82.884033203125, 41.196720123291 },
				{ -422.22146606445, 71.783996582031, 64.263313293457 },
				{ -159.37677001953, -153.51475524902, 43.621189117432 },
				{ -64.202850341797, 77.092277526855, 71.616172790527 },
				{ -174.67333984375, 219.16426086426, 90.021614074707 },
				{ -771.87231445313, 351.56149291992, 87.998184204102 },
				{ -554.365234375, 541.19622802734, 110.70719909668 },
				{ 57.35270690918, 449.81817626953, 147.03143310547 },
				{ 198.32318115234, 324.37655639648, 105.41010284424 },
				{ 731.67504882813, 134.44757080078, 80.754508972168 },
				{ 1094.6635742188, -265.57302856445, 69.313804626465 },
				{ 1082.4643554688, -787.37548828125, 58.351222991943 },
				{ 810.58142089844, -750.3564453125, 26.739147186279 },
				{ 764.85583496094, -1359.0031738281, 27.878271102905 },
				{ 485.6240234375, -1477.0966796875, 29.289901733398 },
				{ 115.66278839111, -1685.7535400391, 33.491214752197 },
				{ -228.97648620605, -1117.9224853516, 23.025501251221 },
				{ -578.05053710938, -1012.9370117188, 22.325052261353 },
				{ 351.47366333008, -972.78100585938, 29.432527542114 },
				{ 418.35342407227, -206.99436950684, 59.910438537598 },
				{ 981.13293457031, -1705.8330078125, 31.225019454956 },
				{ 951.73376464844, -210.74114990234, 73.208442687988 },
				{ 717.64056396484, 592.41064453125, 129.05075073242 },
				{ -993.37579345703, -519.62097167969, 37.49974822998 },
				{ 216.65922546387, 1192.0157470703, 225.78944396973 },
				{ 372.99267578125, -1441.3872070313, 29.43154335022 },
				{ 141.6071472168, -379.63339233398, 43.256973266602 },
				{ -1120.9721679688, 2712.2465820313, 18.86775970459 },
				{ 1722.2264404297, 4734.9340820313, 42.134326934814 },
				{ 2221.9211425781, 5614.4848632813, 54.901653289795 },
				{ 3310.8198242188, 5176.5361328125, 19.614561080933 },
				{ 3807.6591796875, 4478.4794921875, 6.3653964996338 }
			},
			["collectVehicle"] = nil,
			["collectRandom"] = true,
			["collectMaxDistance"] = 3000,
			["collectAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["collectText"] = "para coletar",
		},
		["delivery"] = {
			["deliveryContent"] = {},
			["deliveryCoords"] = {},
			["deliveryDirtyMoney"] = true,
			["deliveryVehicle"] = nil,
			["deliveryRandom"] = true,
			["deliveryMaxDistance"] = 3000,
			["deliveryAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["deliveryText"] = "para entregar",
		},
	},
	["Mechanic"] = {
		["perm"] = "mecanico.permissao", --permissão necessária
		["name"] = 'Mecanica', --nome na NUI
		["customBlip"] = true, --ativar blip customizado ou apenas o normal do gta?
		["coords"] = {
			vec3(840.27,-938.35,20.3), --coordenadas do blip
			vec3(-198.93,-1315.3,31.09),
		},
		["craft"] = { --configuração do craft
			["toolbox"] = {
				["image"] = "toolbox",
				["amount"] = 1,
				["destroy"] = true,
				["webhook"] = 'https://discord.com/api/webhooks/SEUWEBHOOK',
				["police_chance"] = 0,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 10,
				}
			},
		},
		["collect"] = {
			["collectContent"] = {
				['Aluminio e Cobre'] = { --Nome que aparece na nui
					image = 'aluminum', --Imagem que aparece na nui
					itens = { 
						['copper'] = { quantidade_min = 3, quantidade_max = 5 }, --itens que vem realizar a ação
						['aluminum'] = { quantidade_min = 3, quantidade_max = 5 }, --itens que vem realizar a ação
					},
					porcentagem_policia = 0,
					webhook = 'https://discord.com/api/webhooks/SEUWEBHOOK'
				},
			},
			["collectCoords"] = {
				{ 726.81042480469, 4168.9228515625, 40.709239959717 },
				{ 2558.876953125, 288.79989624023, 108.60987854004 },
				{ 2352.3764648438, 2523.3559570313, 47.689441680908 },
				{ -428.61862182617, -1728.1860351563, 19.78373336792 },
				{ -1088.3803710938, -1672.3043212891, 4.700074672699 },
				{ -1321.6911621094, -1264.2875976563, 4.5917778015137 },
				{ -1349.6951904297, -945.17681884766, 9.7058086395264 },
				{ -1307.7419433594, -832.76031494141, 17.139245986938 },
				{ -1704.2272949219, -441.75592041016, 41.64807510376 },
				{ -1500.115234375, -202.0580291748, 50.88969039917 },
				{ -1309.2584228516, -175.55511474609, 43.666454315186 },
				{ -966.58758544922, -266.81076049805, 39.334583282471 },
				{ -619.56103515625, -82.884033203125, 41.196720123291 },
				{ -422.22146606445, 71.783996582031, 64.263313293457 },
				{ -159.37677001953, -153.51475524902, 43.621189117432 },
				{ -64.202850341797, 77.092277526855, 71.616172790527 },
				{ -174.67333984375, 219.16426086426, 90.021614074707 },
				{ -771.87231445313, 351.56149291992, 87.998184204102 },
				{ -554.365234375, 541.19622802734, 110.70719909668 },
				{ 57.35270690918, 449.81817626953, 147.03143310547 },
				{ 198.32318115234, 324.37655639648, 105.41010284424 },
				{ 731.67504882813, 134.44757080078, 80.754508972168 },
				{ 1094.6635742188, -265.57302856445, 69.313804626465 },
				{ 1082.4643554688, -787.37548828125, 58.351222991943 },
				{ 810.58142089844, -750.3564453125, 26.739147186279 },
				{ 764.85583496094, -1359.0031738281, 27.878271102905 },
				{ 485.6240234375, -1477.0966796875, 29.289901733398 },
				{ 115.66278839111, -1685.7535400391, 33.491214752197 },
				{ -228.97648620605, -1117.9224853516, 23.025501251221 },
				{ -578.05053710938, -1012.9370117188, 22.325052261353 },
				{ 351.47366333008, -972.78100585938, 29.432527542114 },
				{ 418.35342407227, -206.99436950684, 59.910438537598 },
				{ 981.13293457031, -1705.8330078125, 31.225019454956 },
				{ 951.73376464844, -210.74114990234, 73.208442687988 },
				{ 717.64056396484, 592.41064453125, 129.05075073242 },
				{ -993.37579345703, -519.62097167969, 37.49974822998 },
				{ 216.65922546387, 1192.0157470703, 225.78944396973 },
				{ 372.99267578125, -1441.3872070313, 29.43154335022 },
				{ 141.6071472168, -379.63339233398, 43.256973266602 },
				{ -1120.9721679688, 2712.2465820313, 18.86775970459 },
				{ 1722.2264404297, 4734.9340820313, 42.134326934814 },
				{ 2221.9211425781, 5614.4848632813, 54.901653289795 },
				{ 3310.8198242188, 5176.5361328125, 19.614561080933 },
				{ 3807.6591796875, 4478.4794921875, 6.3653964996338 }
			},
			["collectVehicle"] = nil,
			["collectRandom"] = true,
			["collectMaxDistance"] = 3000,
			["collectAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["collectText"] = "para coletar",
		},
		["delivery"] = {
			["deliveryContent"] = {},
			["deliveryCoords"] = {},
			["deliveryDirtyMoney"] = true,
			["deliveryVehicle"] = nil,
			["deliveryRandom"] = true,
			["deliveryMaxDistance"] = 3000,
			["deliveryAnim"] = { false,"anim@heists@narcotics@trash","pickup_45_r",true },
			["deliveryText"] = "para entregar",
		},
	},
}
