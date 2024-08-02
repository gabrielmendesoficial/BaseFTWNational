-----------------------------------------------------------------------------
--##################### Funções vRP || Inventories ######################--
-----------------------------------------------------------------------------
CreateThread(function()
	if GlobalState['Inventory'] == "will_inventory" then
        assert(GetResourceState("will_inventory") ~= "missing","will_inventory não encontrado, confira o resource ou altere GlobalState['Inventory']")
		vRP.getInventory = function(inventory)
			if tonumber(inventory) > 0 then
				inventory = 'content-'..inventory
			end
			return exports['will_inventory']:getInventory(inventory)
		end
		
		vRP.getInventoryMaxWeight = function(user_id)
			return exports['will_inventory']:getInvWeight(user_id) or 0
		end
	
		vRP.getInventoryWeight = function(inventory)
			if parseInt(inventory) > 0 then
				inventory = 'content-'..inventory
			end
			return exports['will_inventory']:computeInvWeight(inventory)
		end
	
		vRP.computeItemsWeight = function(itemslist)
			local weight = 0
			for k,v in pairs(itemslist) do
				local name = v.name and v.name:lower() or ''
				local item = items[v.item] or items[name]
				if item then
					weight = weight + (item.weight or 0) * parseInt(v.amount)
				end
			end
			return weight
		end
	
		vRP.getBackpack = function(user_id)
			return exports['will_inventory']:getInvWeight(user_id) or 0
		end
	end
	
	if GlobalState['Inventory'] == "ox_inventory" then
        assert(GetResourceState("ox_inventory") ~= "missing","ox_inventario não encontrado, confira o resource ou altere GlobalState['Inventory']")
		vRP.getInventory = function(user_id)
			local nplayer = vRP.getUserSource(user_id)
			if nplayer then
				local userInv = exports.ox_inventory:GetInventory(nplayer)
				if userInv then
					local playerItems = userInv.items or {}
					for k,v in pairs(playerItems) do
						playerItems[k].item = v.name
						playerItems[k].amount = v.count
					end
					return playerItems
				end
			end
			return {}
		end

		vRP.getInventoryMaxWeight = function(user_id)
			local nplayer = vRP.getUserSource(user_id)
			if nplayer then
				local inventory = exports.ox_inventory:GetInventory(nplayer)
				return inventory and inventory.maxWeight or 30000
			end
		end
	
		vRP.getInventoryWeight = function(inventory)
			local nplayer = vRP.getUserSource(user_id)
			if nplayer then
				local inventory = exports.ox_inventory:GetInventory(nplayer)
				return inventory and inventory.weight or 0
			end
		end
	
		vRP.computeItemsWeight = function(itemslist)
			local weight = 0
			for k,v in pairs(itemslist) do
				local name = v.name and v.name:lower() or ''
				local item = items[v.item] or items[name]
				if item then
					weight = weight + (item.weight or 0) * parseInt(v.amount)
				end
			end
			return weight
		end
	
		vRP.getBackpack = function(user_id)
			local nplayer = vRP.getUserSource(user_id)
			if nplayer then
				local inventory = exports.ox_inventory:GetInventory(nplayer)
				return inventory and inventory.maxWeight or 30000
			end
		end
		local Tunnel = module("vrp","lib/Tunnel")
		vTASKBAR = Tunnel.getInterface("taskbar")
		vSURVIVAL = Tunnel.getInterface("Survival")
		vPLAYER = Tunnel.getInterface("Player")
		vGARAGE = Tunnel.getInterface("will_garages_v2")
	
		local active = {}
		local Objects = {}
	
		RegisterServerEvent("ox_inventory:useItem")
		AddEventHandler("ox_inventory:useItem",function(source, itemName)
			local user_id = vRP.getUserId(source)
			if vRPclient.getHealth(source) <= 101 then return end
			Player(source)["state"]["Commands"] = true
			if itemName == "analgesic" then
				if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
					active[user_id] = 6
					TriggerClientEvent('ld-inv:Client:CloseInventory',source)
					TriggerClientEvent("Progress",source,6000,"Utilizando...")
					vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)
	
					repeat
						if active[user_id] == 0 then
							active[user_id] = nil
							vRPclient._stopAnim(source,false)
	
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								vRP.upgradeStress(user_id,5)
								vRPclient.updateHealth(source,20)
							end
						end
						Citizen.Wait(0)
					until active[user_id] == nil
				else
					TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.",5000)
				end
			end
	
			if itemName == "weed" then
				if vRP.getInventoryItemAmount(user_id,"weed") >= 1 and vRP.getInventoryItemAmount(user_id,"silk") >= 1 then
					active[user_id] = 3
					TriggerClientEvent("Progress",source,3000,"Utilizando...")
	
					repeat
						if active[user_id] == 0 then
							active[user_id] = nil
	
							if vRP.tryGetInventoryItem(user_id,"weed",1,true,slot) and vRP.tryGetInventoryItem(user_id,"silk",1,true) then
								vRP.giveInventoryItem(user_id,"joint",1,true)
							end
						end
						Citizen.Wait(0)
					until active[user_id] == nil
				else
					TriggerClientEvent("Notify",source,"aviso","Você não tem uma seda.",5000)
				end
			end
	
			if itemName == "joint" then
				if vRP.getInventoryItemAmount(user_id,"lighter") <= 0 then
					TriggerClientEvent("Notify",source,"aviso","Você não tem um isqueiro.",5000)
					return
				end
				
				active[user_id] = 1
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,1000,"Fumando...")
				vRPclient._createObjects(source,"amb@world_human_aa_smoke@male@idle_a","idle_c","prop_cs_ciggy_01",49,28422)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.weedTimer(user_id,2)
							vRP.downgradeHunger(user_id,20)
							vRP.downgradeThirst(user_id,15)
							vRPclient.updateHealth(source,5)
							vRP.downgradeStress(user_id,40)
							vPLAYER.movementClip(source,"move_m@shadyped@a")
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "lean" then
				active[user_id] = 6
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,6000,"Utilizando...")
				vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._stopAnim(source,false)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.chemicalTimer(user_id,2)
							vRP.downgradeStress(user_id,50)
							TriggerClientEvent("cleanEffectDrugs",source)
							--TriggerClientEvent("setMeth",source)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "ecstasy" then
				active[user_id] = 6
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,6000,"Utilizando...")
				vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._stopAnim(source,false)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.chemicalTimer(user_id,2)
							vRP.upgradeStress(user_id,3)
							vRP.upgradeHunger(user_id,5)
							vRP.downgradeThirst(user_id,10)
							TriggerClientEvent("setEcstasy",source)
							TriggerClientEvent("setEnergetic",source,20,1.25)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "lsd" then
				active[user_id] = 6
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,6000,"Utilizando...")
				vRPclient._playAnim(source,true,{"mp_suicide","pill"},true)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._stopAnim(source,false)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.chemicalTimer(user_id,2)
							vRP.downgradeStress(user_id,3)
							vRP.upgradeHunger(user_id,5)
							vRP.upgradeThirst(user_id,5)
							TriggerClientEvent("setEcstasy",source)
							TriggerClientEvent("setEnergetic",source,30,1.15)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "meth" then
				active[user_id] = 6
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,6000,"Utilizando...")
				vRPclient._playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._stopAnim(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.chemicalTimer(user_id,2)
							vRP.upgradeStress(user_id,5)
							vRP.upgradeThirst(user_id,5)
							TriggerClientEvent("setMeth",source)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "cocaine" then
				active[user_id] = 6
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,6000,"Utilizando...")
				vRPclient._playAnim(source,true,{"anim@amb@nightclub@peds@","missfbi3_party_snort_coke_b_male3"},true)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._stopAnim(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.chemicalTimer(user_id,2)
							--vRPclient.setArmour(source,2)
							vRP.upgradeStress(user_id,15)
							TriggerClientEvent("setMeth",source)
							TriggerClientEvent("setEnergetic",source,10,1.41)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "warfarin" then
				local nplayer = vRPclient.nearestPlayer(source,2.5)
				if nplayer then
					if vRPclient.getHealth(nplayer) <= 101 then
						active[user_id] = 10
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						TriggerClientEvent("royale:reanimado",nplayer)
						TriggerClientEvent("Progress",source,10000,"Utilizando...")
						TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo reanimado.")
						vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
						repeat
							if active[user_id] == 0 then
								active[user_id] = nil
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									vSURVIVAL._revivePlayer(nplayer,110)
									TriggerClientEvent("resetBleeding",nplayer)
									vRPclient._stopAnim(source)
								end
							end
							Citizen.Wait(0)
						until active[user_id] == nil
					end			
				else
					if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
						active[user_id] = 30
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						TriggerClientEvent("Progress",source,30000,"Utilizando...")
						vRPclient._createObjects(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
	
						repeat
							if active[user_id] == 0 then
								active[user_id] = nil
								vRPclient._removeObjects(source)
	
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									vRPclient.updateHealth(source,50)
									TriggerClientEvent("resetBleeding",source)
								end
							end
							Citizen.Wait(0)
						until active[user_id] == nil
					else
						TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.",5000)
					end
				end
			end
	
			if itemName == "gauze" then
				if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 200 then
					active[user_id] = 3
					TriggerClientEvent('ld-inv:Client:CloseInventory',source)
					TriggerClientEvent("Progress",source,3000,"Utilizando...")
					vRPclient._playAnim(source,true,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)
	
					repeat
						if active[user_id] == 0 then
							active[user_id] = nil
							vRPclient._stopAnim(source,false)
	
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								TriggerClientEvent("resetBleeding",source)
							end
						end
						Citizen.Wait(0)
					until active[user_id] == nil
				else
					TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.",5000)
				end
			end
	
			if itemName == "premiumgarage" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					vRP.execute("vRP/update_garages",{ id = parseInt(user_id) })
					TriggerClientEvent("Notify",source,"negado","Voce adicionou uma vaga na garagem.",5000)
				end
			end
	
			if itemName == "binoculars" then
				active[user_id] = 2
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,2000,"Utilizando...")
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._createObjects(source,"amb@world_human_binoculars@male@enter","enter","prop_binoc_01",50,28422)
						Citizen.Wait(750)
						TriggerClientEvent("useBinoculos",source)
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "camera" then
				active[user_id] = 2
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,2000,"Utilizando...")
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._createObjects(source,"amb@world_human_paparazzi@male@base","base","prop_pap_camera_01",49,28422)
						Citizen.Wait(100)
						TriggerClientEvent("useCamera",source)
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "celular" then
				TriggerClientEvent("gcPhone:activePhone",source)
			end
	
			if itemName == "adrenaline" then

				local adrenalineCds = {
					{ 1978.76,5171.11,47.64 },
					{ 707.86,4183.95,40.71 },
					{ 436.64,6462.23,28.75 },
					{ -2173.5,4291.73,49.04 }
				}

				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local adrenalineDistance = false
				for k,v in pairs(adrenalineCds) do
					local distance = #(coords - vector3(v[1],v[2],v[3]))
					if distance <= 5 then
						adrenalineDistance = true
					end
				end
				local parAmount = vRP.numPermission("Paramedic")
				if #parAmount > 0 or not adrenalineDistance then
					return
				end
	
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						if vSURVIVAL.deadPlayer(nplayer) then
							active[user_id] = 10
							vRPclient.stopActived(source)
							TriggerClientEvent('ld-inv:Client:CloseInventory',source)
							TriggerClientEvent("Progress",source,10000,"Utilizando...")
							vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
	
							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vSURVIVAL._reverseRevive(source)
	
									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										vRP.upgradeStress(user_id,10)
										vRP.upgradeStress(nuser_id,10)
										vRP.upgradeThirst(nuser_id,10)
										vRP.upgradeHunger(nuser_id,10)
										vRP.chemicalTimer(nuser_id,1)
										vSURVIVAL._revivePlayer(nplayer,110)
										TriggerClientEvent("resetBleeding",nplayer)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end
					end
				end
			end
	
			if itemName == "teddy" then
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				vRPclient._createObjects(source,"impexp_int-0","mp_m_waremech_01_dual-0","v_ilev_mr_rasberryclean",49,24817,-0.20,0.46,-0.016,-180.0,-90.0,0.0)
			end
	
			if itemName == "rose" then
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				vRPclient._createObjects(source,"anim@heists@humane_labs@finale@keycards","ped_a_enter_loop","prop_single_rose",49,18905,0.13,0.15,0.0,-100.0,0.0,-20.0)
			end
	
			if itemName == "identity" then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					local identity = vRP.getUserIdentity(user_id)
					if identity then
						TriggerClientEvent("Notify",nplayer,"importante","<b>Passaporte:</b> "..vRP.format(parseInt(identity.id)).."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone,10000)
					end
				end
			end
	
			if itemName == "cirurgia" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					vRP.setUData(user_id,"vRP:spawnController",json.encode(0))
					vRP.kick(user_id, "Você resetou sua aparência")  
				end
			end
	
			if itemName == "bonusDelivery" then
				local myBonus = vRP.bonusDelivery(user_id)
				if parseInt(myBonus) >= 100 then
					return
				end
	
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					vRP.setBonusDelivery(user_id,1)
					TriggerClientEvent("Notify",source,"importante","O nível de experiência no <b>Delivery</b> aumentou.",5000)
				end
			end
	
			if itemName == "bonusPostOp" then
				local myBonus = vRP.bonusPostOp(user_id)
				if parseInt(myBonus) >= 100 then
					return
				end
	
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					vRP.setbonusPostOp(user_id,1)
					TriggerClientEvent("Notify",source,"importante","O nível de experiência no <b>Entregador</b> aumentou.",5000)
				end
			end
	
				--[[ 			if itemName == "firecracker" then
				if firecracker[user_id] == nil then
					active[user_id] = 3
					firecracker[user_id] = 250
					TriggerClientEvent('ld-inv:Client:CloseInventory',source)
					TriggerClientEvent("Progress",source,3000,"Utilizando...")
					vRPclient._playAnim(source,false,{"anim@mp_fireworks","place_firework_3_box"},true)
	
					repeat
						if active[user_id] == 0 then
							active[user_id] = nil
							vRPclient._stopAnim(source,false)
	
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								TriggerClientEvent("vrp_inventory:Firecracker",source)
							end
						end
						Citizen.Wait(0)
					until active[user_id] == nil
				end
			end ]]
	
			if itemName == "gsrkit" then
				local nplayer = vRPclient.nearestPlayer(source,5)
				if nplayer then
					if vPLAYER.getHandcuff(nplayer) then
						active[user_id] = 10
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						TriggerClientEvent("Progress",source,10000,"Utilizando...")
	
						repeat
							if active[user_id] == 0 then
								active[user_id] = nil
	
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									local check = vPLAYER.gsrCheck(nplayer)
									if parseInt(check) > 0 then
										TriggerClientEvent("Notify",source,"sucesso","Resultado positivo.",5000)
									else
										TriggerClientEvent("Notify",source,"negado","Resultado negativo.",3000)
									end
								end
							end
							Citizen.Wait(0)
						until active[user_id] == nil
					end
				end
			end
	
			if itemName == "gdtkit" then
				local nplayer = vRPclient.nearestPlayer(source,5)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						active[user_id] = 10
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						TriggerClientEvent("Progress",source,10000,"Utilizando...")
	
						repeat
							if active[user_id] == 0 then
								active[user_id] = nil
	
								if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
									local weed = vRP.weedReturn(nuser_id)
									local chemical = vRP.chemicalReturn(nuser_id)
									local alcohol = vRP.alcoholReturn(nuser_id)
									local chemStr = ""
									local alcoholStr = ""
									local weedStr = ""
	
									if chemical == 0 then
										chemStr = "Nenhum"
									elseif chemical == 1 then
										chemStr = "Baixo"
									elseif chemical == 2 then
										chemStr = "Médio"
									elseif chemical >= 3 then
										chemStr = "Alto"
									end
	
									if alcohol == 0 then
										alcoholStr = "Nenhum"
									elseif alcohol == 1 then
										alcoholStr = "Baixo"
									elseif alcohol == 2 then
										alcoholStr = "Médio"
									elseif alcohol >= 3 then
										alcoholStr = "Alto"
									end
	
									if weed == 0 then
										weedStr = "Nenhum"
									elseif weed == 1 then
										weedStr = "Baixo"
									elseif weed == 2 then
										weedStr = "Médio"
									elseif weed >= 3 then
										weedStr = "Alto"
									end
	
									TriggerClientEvent("Notify",source,"importante","<b>Químicos:</b> "..chemStr.."<br><b>Álcool:</b> "..alcoholStr.."<br><b>Drogas:</b> "..weedStr,8000)
								end
							end
							Citizen.Wait(0)
						until active[user_id] == nil
					end
				end
			end
	
			if itemName == "vest" then
				active[user_id] = 10
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._playAnim(source,true,{"clothingtie","try_tie_negative_a"},true)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._stopAnim(source,false)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRPclient.setArmour(source,100)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "removedor" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_spray:removeClosestSpray",source)
				end
			end
	
			if itemName == "GADGET_PARACHUTE" or item == "parachute" then
				active[user_id] = 10
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
	
				repeat	
					if active[user_id] == 0 then
						active[user_id] = nil
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRPclient.giveWeapons(source, {["GADGET_PARACHUTE"] = { ammo = 1 }})
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "skate" then
				active[user_id] = 3
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,3000,"Utilizando...")
	
				repeat	
					if active[user_id] == 0 then
						active[user_id] = nil
						TriggerClientEvent("skate",source)
						
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "toolbox" then
				if not vRPclient.inVehicle(source) then
					local vehicle,vehNet = vRPclient.vehList(source,3)
					if vehicle then
						active[user_id] = 30
						vRPclient.stopActived(source)
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						vRPclient._playAnim(source,false,{"mini@repair","fixing_a_player"},true)
						local taskResult = vTASKBAR.taskLockpick(source)
						if taskResult then
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								vRP.upgradeStress(user_id,2)
								TriggerClientEvent("vrp_inventory:repairTires",-1,vehNet)
								TriggerClientEvent("will_garages_v2:repairVehicle",-1,vehNet,true)
								TriggerClientEvent("Notify",source,"aviso","Carro arrumado com sucesso.",7000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Voce falhou.",7000)
						end
						vRPclient._stopAnim(source,false)
						active[user_id] = nil
					end
				end
			end
	
			if itemName == "lockpick" then
				local checkHome = exports['will_homes']:tryEnterHome(source, true)
				if checkHome then
					vRPclient.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)
					local taskResult = vTASKBAR.taskLockpick(source)
					if taskResult then
						TriggerClientEvent("will_homes:client:enterHouse",source, checkHome, true)
					end
					vRPclient._stopAnim(source,false)
					return
				end
				local vehicle,vehNet,vehPlate,vehName,vehLock,vehBlock,vehHealth,vehModel,vehClass = vRPclient.vehList(source,3)
				if vehicle and vehClass ~= 15 and vehClass ~= 16 then
					if vRPclient.inVehicle(source) then
						active[user_id] = 100
						vRPclient.stopActived(source)
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						vGARAGE.startAnimHotwired(source)
	
						local taskResult = vTASKBAR.taskLockpick(source)
						if taskResult then
							--vRP.upgradeStress(user_id,4)
							local iddoroubado = vRP.getVehiclePlate(vehPlate)
							--SendWebhookMessage(webhookrobberycar,"```prolog\n[ID]: "..user_id.."\n[ROUBOU CARRO]: "..vRP.vehicleName(vehName).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							if iddoroubado and math.random(100) >= 50 then
								TriggerClientEvent("Notify",source,"aviso","O alarme do seu veículo <b>"..vRP.vehicleName(vehName).."</b> foi acionado.",7000)
							end
							TriggerEvent("setPlateEveryone",vehPlate)
							TriggerEvent("setPlatePlayers",vehPlate,user_id)
							if math.random(100) >= 15 then
								local x,y,z = vRPclient.getPositions(source)
								local copAmount = vRP.numPermission("Police")
								for k,v in pairs(copAmount) do
									local player = vRP.getUserSource(v)
									async(function()
										TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",5000)
										TriggerClientEvent("NotifyPush",player,{ time = os.date("%H:%M:%S - %d/%m/%Y"), text = "Opa tem um cara aqui no bairro querendo roubar um carro!", code = 31, title = "Roubo de Veículo", x = x, y = y, z = z, vehicle = vRP.vehicleName(vehName).." - "..vehPlate, rgba = {15,110,110} })
									end)
								end
							end
						else
							TriggerClientEvent("Notify",source,"aviso","Voce falhou, tente novamente.",7000)
						end
	
						if parseInt(math.random(100)) >= 85 then
							vRP.removeInventoryItem(user_id,itemName,1,true)
						end
						vGARAGE.stopAnimHotwired(source,vehicle)
						active[user_id] = nil
					else
						active[user_id] = 100
						vRPclient.stopActived(source)
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						vRPclient._playAnim(source,false,{"missfbi_s4mop","clean_mop_back_player"},true)
	
						local taskResult = vTASKBAR.taskLockpick(source)
						if taskResult then
							vRP.upgradeStress(user_id,4)
							local iddoroubado = vRP.getVehiclePlate(vehPlate)
							--SendWebhookMessage(webhookrobberycar,"```prolog\n[ID]: "..user_id.."\n[ROUBOU CARRO]: "..vRP.vehicleName(vehPlate).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							if iddoroubado then
								TriggerClientEvent("Notify",source,"aviso","Veículo <b>"..vRP.vehicleName(vehName).."</b> foi roubado.",7000)
							end
							if math.random(100) >= 50 then
								TriggerEvent("setPlateEveryone",vehPlate)
								local networkVeh = NetworkGetEntityFromNetworkId(vehNet)
								TriggerClientEvent("vrp_sound:source",source,"unlock",0.3)
								SetVehicleDoorsLocked(networkVeh,1)   -- Destrancado
							end
	
							if math.random(100) >= 15 then
								local x,y,z = vRPclient.getPositions(source)
								local copAmount = vRP.numPermission("Police")
								for k,v in pairs(copAmount) do
									local player = vRP.getUserSource(v)
									async(function()
										TriggerClientEvent("NotifyPush",player,{ time = os.date("%H:%M:%S - %d/%m/%Y"), text = "Opa tem um cara aqui no bairro querendo roubar um carro!", code = 31, title = "Roubo de Veículo", x = x, y = y, z = z, vehicle = vRP.vehicleName(vehName).." - "..vehPlate, rgba = {15,110,110} })
									end)
								end
							end
						else
							TriggerClientEvent("Notify",source,"aviso","Voce falhou.",7000)
						end
	
						if parseInt(math.random(1000)) >= 850 then
							vRP.removeInventoryItem(user_id,itemName,1,true,slot)
						end
	
						vRPclient._stopAnim(source,false)
						active[user_id] = nil
					end
				end
			end
	
			if itemName == "barrier" then
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				local application,coords,heading = vRPclient.objectCoords(source,"prop_mp_barrier_02b")
				if application then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true) then
						local Number = 0
	
						repeat
							Number = Number + 1
						until Objects[tostring(Number)] == nil
	
						Objects[tostring(Number)] = { x = mathLegth(coords["x"]), y = mathLegth(coords["y"]), z = mathLegth(coords["z"]), h = heading, object = "prop_mp_barrier_02b", item = itemName, distance = 100, mode = "3" }
						TriggerClientEvent("objects:Adicionar",-1,tostring(Number),Objects[tostring(Number)])
					end
				end
			end
	
			if itemName == "energetic" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309,0.0,0.0,0.0,0.0,0.0,130.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeStress(user_id,4)
							TriggerClientEvent("setEnergetic",source,90,1.10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "absolut" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
	
			if itemName == "hennessy" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "chandon" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "dewars" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "saque" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_tequila",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.alcoholTimer(user_id,1)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setDrunkTime",source,300)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "water" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_ld_flow_bottle",49,60309,0.0,0.0,0.02,0.0,0.0,130.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,25)
							vRP.giveInventoryItem(user_id,"emptybottle",1)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "sinkalmy" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_ld_flow_bottle",49,28422)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,25)
							vRP.chemicalTimer(user_id,1)
							vRP.downgradeStress(user_id,25)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "ritmoneury" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_ld_flow_bottle",49,28422)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,5)
							vRP.chemicalTimer(user_id,1)
							vRP.downgradeStress(user_id,50)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "dirtywater" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_ld_flow_bottle",49,60309)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeStress(user_id,4)
							vRP.upgradeThirst(user_id,25)
							vRPclient.downHealth(source,10)
							vRP.giveInventoryItem(user_id,"emptybottle",1)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "cola" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.0,0.0,0.04,0.0,0.0,130.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,20)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "soda" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,20)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "sucocereja" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_plastic_cup_02",49,28422,0.0,-0.01,0.0,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,50)
							vRP.downgradeStress(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "sucolaranja" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_drinking@coffee@male@idle_a","idle_c","prop_plastic_cup_02",49,28422,0.0,-0.01,0.0,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeThirst(user_id,50)
							vRP.downgradeStress(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "fishingrod" then
				local fishingStatus = false
				local fishingCoords = vector3(-1202.71,2714.76,4.11)
				local coords = GetEntityCoords(GetPlayerPed(source))
				local distance = #(coords - fishingCoords)
				if distance <= 20 then
					fishingStatus = true
				end
				if fishingStatus then
					active[user_id] = 30
					TriggerClientEvent('ld-inv:Client:CloseInventory',source)
					vRPclient.stopActived(source)
					vRPclient._createObjects(source,"amb@world_human_stand_fishing@idle_a","idle_c","prop_fishing_rod_01",49,60309)
					if vTASKBAR.taskFishing(source) then
						local rand = parseInt(math.random(3))
						local fishs = { "octopus","shrimp","carp" }
	
						if vRP.computeInvWeight(user_id) + vRP.itemWeightList(fishs[rand]) * rand <= vRP.getBackpack(user_id) then
							if vRP.tryGetInventoryItem(user_id,"bait",rand,true) then
								vRP.giveInventoryItem(user_id,fishs[rand],rand,true)
							else
								TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..vRP.format(rand).."x "..vRP.itemNameList("bait").."</b>.",5000)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
						end
					end
	
					active[user_id] = nil
				else
					TriggerClientEvent("Notify",source,"negado","Muito longe do local de pesca.",5000)
				end
			end
	
			if itemName == "coffee" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeStress(user_id,2)
							vRP.upgradeThirst(user_id,20)
							TriggerClientEvent("setEnergetic",source,30,1.15)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "hamburger" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,30)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "delivery" then
				active[user_id] = 5
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,5000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_drinking@beer@male@base","","prop_paper_bag_01",49,28422,0.0,-0.02,-0.05,0.0,0.0,0.0)
				vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_kol_idle"},false)
				local itemList = {
					[1] = { "tacos","hamburger","hotdog","soda","cola","chocolate","sandwich","fries","absolut","chandon","dewars","donut","hennessy" }
				}
				local food = itemList[1][math.random(#itemList[1])]
				
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
						vRPclient._stopAnim(source,false)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.giveInventoryItem(user_id,food,math.random(3),true)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "yakisoba" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_drinking@beer@male@base","static","v_ret_fh_noodle",49,28422,0.0,-0.02,-0.05,0.0,0.0,0.0)
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,50)
							vRP.updateHealth(user_id,5)
							vRP.downgradeStress(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "lamen" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_drinking@beer@male@base","static","prop_bar_nuts",49,28422,0.0,-0.02,-0.05,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,50)
							vRP.updateHealth(user_id,5)
							vRP.downgradeStress(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "temaki" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_drinking@beer@male@base","static","v_ret_fh_noodle",49,28422,0.0,-0.02,-0.05,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,50)
							vRP.updateHealth(user_id,5)
							vRP.downgradeStress(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "sushi" then
				--active[user_id] = 10
				--vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("will_spray:removeClosestSpray",source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_drinking@beer@male@base","static","prop_bar_limes",49,28422,0.0,-0.02,-0.038,0.0,0.0,0.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,50)
							vRP.updateHealth(user_id,5)
							vRP.downgradeStress(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "hotdog" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_hotdog_01",49,28422)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,20)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "sandwich" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,20)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "tacos" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_taco_01",49,18905,0.16,0.06,0.02,-50.0,220.0,60.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,30)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "fries" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_bs_chips",49,18905,0.10,0.0,0.08,150.0,320.0,160.0)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,20)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "chocolate" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.upgradeHunger(user_id,10)
							vRP.downgradeStress(user_id,25)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "donut" then
				active[user_id] = 10
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("Progress",source,10000,"Utilizando...")
				vRPclient._createObjects(source,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422)
	
				repeat
					if active[user_id] == 0 then
						active[user_id] = nil
						vRPclient._removeObjects(source)
	
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.downgradeStress(user_id,8)
							vRP.upgradeHunger(user_id,10)
						end
					end
					Citizen.Wait(0)
				until active[user_id] == nil
			end
	
			if itemName == "postit" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent('ld-inv:Client:CloseInventory',source)
					TriggerClientEvent("vrp_notepad:createNotepad",source)
				end
			end
	
			if itemName == "backpackp" then
				if GetResourceState("ox_inventory") == "started" then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						exports.ox_inventory:SetMaxWeight(source, 40000)
						exports.ox_inventory:SetSlotCount(source, 60)
					end
				else
					local exp = vRP.getBackpack(user_id)
					if exp < 25 then
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.setBackpack(user_id,25)
						end
					else
						TriggerClientEvent("Notify",source,"aviso","No momento você não pode usar essa mochila.",5000)
					end
				end
			end
	
			if itemName == "backpackm" then
				if GetResourceState("ox_inventory") == "started" then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						exports.ox_inventory:SetMaxWeight(source, 60000)
						exports.ox_inventory:SetSlotCount(source, 75)
					end
				else
					local exp = vRP.getBackpack(user_id)
					if exp >= 25 and exp < 50 then
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.setBackpack(user_id,50)
						end
					else
						TriggerClientEvent("Notify",source,"aviso","No momento você não pode usar essa mochila.",5000)
					end
				end
			end
	
			if itemName == "backpackg" then
				if GetResourceState("ox_inventory") == "started" then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						exports.ox_inventory:SetMaxWeight(source, 80000)
						exports.ox_inventory:SetSlotCount(source, 90)
					end
				else
					local exp = vRP.getBackpack(user_id)
					if exp >= 50 and exp < 75 then
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.setBackpack(user_id,75)
						end
					else
						TriggerClientEvent("Notify",source,"aviso","No momento você não pode usar essa mochila.",5000)
					end
				end
			end
	
			if itemName == "backpackx" then
				if GetResourceState("ox_inventory") == "started" then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						exports.ox_inventory:SetMaxWeight(source, 100000)
						exports.ox_inventory:SetSlotCount(source, 100)
					end
				else
					local exp = vRP.getBackpack(user_id)
					if exp >= 75 and exp < 100 then
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.setBackpack(user_id,100)
						end
					else
						TriggerClientEvent("Notify",source,"aviso","No momento você não pode usar essa mochila.",5000)
					end
				end
			end
	
			if itemName == "tires" then
				--TriggerClientEvent("vrp_inventory:createprop",source,"prop_rub_tyre_01")
				if not vRPclient.inVehicle(source) then
					local vehicle,vehNet = vRPclient.vehList(source,3)
					if vehicle then
						active[user_id] = 30
						vRPclient.stopActived(source)
						TriggerClientEvent('ld-inv:Client:CloseInventory',source)
						vRPclient._playAnim(source,false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
	
						local taskResult = vTASKBAR.taskTwo(source)
						if taskResult then
							if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
								TriggerClientEvent("vrp_inventory:repairTires",-1,vehNet)
							end
						end
	
						vRPclient._stopAnim(source,false)
						active[user_id] = nil
					end
				end
			end
	
			if itemName == "premiumplate" then
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
	
				local vehModel = vRP.prompt(source,"Nome de spawn do veiculo:","")
				if vehModel == "" then
					return
				end
	
				local vehicle = vRP.query("vRP/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehModel) })
				if vehicle[1] then
					local vehPlate = vRP.prompt(source,"NOVA PLACA:","")
					if vehPlate == "" or string.upper(vehPlate) == "CNVRP - RP" then
						return
					end
	
					local plateUserId = vRP.getVehiclePlate(vehPlate)
					if plateUserId then
						TriggerClientEvent("Notify",source,"negado","A placa escolhida já está sendo usada por outro veículo.",5000)
						return
					end
	
					local plateCheck = sanitizeString(vehPlate,"abcdefghijklmnopqrstuvwxyz0123456789",true)
					if plateCheck and string.len(plateCheck) == 8 then
						if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
							vRP.execute("vRP/update_plate_vehicle",{ user_id = parseInt(user_id), vehicle = tostring(vehModel), plate = string.upper(tostring(vehPlate)) })
							TriggerClientEvent("Notify",source,"sucesso","Placa atualizada com sucesso.",5000)
						end
					else
						TriggerClientEvent("Notify",source,"importante","O nome da definição para placas deve conter no máximo 8 caracteres e podem ser usados números e letras minúsculas.",5000)
					end
				else
					TriggerClientEvent("Notify",source,"negado","Modelo de veículo não encontrado em sua garagem.",5000)
				end
			end
	
	
			if itemName == "premiumname" then
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
	
				local newName = vRP.prompt(source,"Primeiro Nome (NOVO):","")
				if newName == "" then
					return
				end
	
				local newLastName = vRP.prompt(source,"Sobre Nome (NOVO):","")
				if newLastName == "" then
					return
				end
				
				vRP.execute("vRP/rename_characters",{ id = user_id, name = newName, name2 = newLastName })
			end
			end
	
			if itemName == "aio_box" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_battlepass:openLootbox",source,"aio_box")
				end
			end
	
			if itemName == "vest_box" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_battlepass:openLootbox",source,"vest_box")
				end
			end
	
			if itemName == "money_box" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_battlepass:openLootbox",source,"money_box")
				end
			end
	
			if itemName == "weapon_box" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_battlepass:openLootbox",source,"weapon_box")
				end
			end
	
			if itemName == "medkit_box" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_battlepass:openLootbox",source,"medkit_box")
				end
			end
	
			if itemName == "vehicle_box" then
				if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
					TriggerClientEvent("will_battlepass:openLootbox",source,"vehicle_box")
				end
			end
	
			if itemName == "fueltech" then
				if vRPclient.inVehicle(source) then
					local techDistance = false
					local techCoords = vector3(1174.66,2640.45,37.82)
					local coords = GetEntityCoords(GetPlayerPed(source))
					local distance = #(coords - techCoords)
					if distance <= 10 then
						techDistance = true
					end
					if techDistance then
						local vehPlate = vRPclient.vehiclePlate(source)
						local plateUsers = vRP.getVehiclePlate(vehPlate)
						if not plateUsers then
							active[user_id] = 30
							TriggerClientEvent('ld-inv:Client:CloseInventory',source)
							TriggerClientEvent("Progress",source,30000,"Utilizando...")
							vRPclient._playAnim(source,true,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
	
							repeat
								if active[user_id] == 0 then
									active[user_id] = nil
									vRPclient._stopAnim(source,false)
	
									if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
										TriggerClientEvent("vrp_admin:vehicleTuning",source)
									end
								end
								Citizen.Wait(0)
							until active[user_id] == nil
						end
					end
				end
			end
	
			if itemName == "radio" then
				vRPclient.stopActived(source)
				TriggerClientEvent('ld-inv:Client:CloseInventory',source)
				TriggerClientEvent("radio:openSystem",source)
			end
	
			if itemName == "divingsuit" then
				if not vRP.wantedReturn(user_id) and not vRP.reposeReturn(user_id) then
					vPLAYER.setDiving(source)
				end
			end
	
			if itemName == "handcuff" then
				if not vRPclient.inVehicle(source) then
					local nplayer = vRPclient.nearestPlayer(source,1.5)
					if nplayer then
						if vPLAYER.getHandcuff(nplayer) then
							vRPclient._playAnim(source,false,{"mp_arresting","a_uncuff"},false)
							SetTimeout(4000,function()
								vPLAYER.toggleHandcuff(nplayer)
								vRPclient._stopAnim(nplayer,false)
								TriggerClientEvent("vrp_sound:source",nplayer,"uncuff",0.5)
								TriggerClientEvent("vrp_sound:source",source,"uncuff",0.5)
							end)
						else
							active[user_id] = 30
							local taskResult = vTASKBAR.taskHandcuff(nplayer)
							if not taskResult then
								TriggerClientEvent("vrp_sound:source",source,"cuff",0.5)
								TriggerClientEvent("vrp_sound:source",nplayer,"cuff",0.5)
								vRPclient._playAnim(source,false,{"mp_arrest_paired","cop_p2_back_left"},false)
								vRPclient._playAnim(nplayer,false,{"mp_arrest_paired","crook_p2_back_left"},false)
								--vRPclient._playAnim(nplayer,true,{"mp_arresting","idle"},true)
								SetTimeout(3500,function()
									vPLAYER.toggleHandcuff(nplayer)
									vRPclient._stopAnim(source,false)
								end)
							else
								TriggerClientEvent("Notify",source,"importante","O cidadao resistiu de ser algemado.",5000)
							end
							active[user_id] = nil
						end
					end
				end
			end
	
			if itemName == "hood" then
				local nplayer = vRPclient.nearestPlayer(source,1)
				if nplayer and vPLAYER.getHandcuff(nplayer) then
					TriggerClientEvent("vrp_hud:toggleHood",nplayer)
				end
			end
	
			if itemName == "rope" then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer and not vRPclient.inVehicle(source) then
					local taskResult = vTASKBAR.taskHandcuff(nplayer)
					if not taskResult then
						TriggerClientEvent("vrp_rope:toggleRope",source,nplayer)
					else
						TriggerClientEvent("Notify",source,"importante","O cidadao resistiu de ser carregado.",5000)
					end
				end
			end
	
			if itemName == "c4" then
				TriggerClientEvent("vrp_cashmachine:machineRobbery",source)
			end
	
			if itemName == "premium01" then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						if not vRP.getPremium(user_id) then
							vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), chars = 2, predays = 3, priority = 20 })
						else
							vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 3 })
						end
					end
				end
			end
	
			if itemName == "premium02" then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						if not vRP.getPremium(user_id) then
							vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), chars = 2, predays = 7, priority = 30 })
						else
							vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 7 })
						end
					end
				end
			end
	
			if itemName == "premium03" then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						if not vRP.getPremium(user_id) then

							vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), chars = 2, predays = 15, priority = 40 })
						else
							vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 15 })
						end
					end
				end
			end
	
			if itemName == "premium04" then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
						if not vRP.getPremium(user_id) then
							vRP.execute("vRP/set_premium",{ steam = identity.steam, premium = parseInt(os.time()), chars = 2, predays = 30, priority = 50 })
						else
							vRP.execute("vRP/update_premium",{ steam = identity.steam, predays = 30 })
						end
					end
				end
			end
	
			if itemName == "pager" then
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						if vRP.hasPermission(nuser_id,"Police") then
							TriggerClientEvent("radio:outServers",nplayer)
							TriggerEvent("vrp_blipsystem:serviceExit",nplayer)
							vRP.removePermission(vRP.getUserSource(nuser_id),"Police")
							vRP.execute("vRP/upd_group",{ user_id = nuser_id, permiss = "Police", newpermiss = "waitPolice" })
							TriggerClientEvent("Notify",source,"importante","Todas as comunicações da polícia foram retiradas.",5000)
						end
					end
				end
			end
			Player(source)["state"]["Commands"] = false
			TriggerClientEvent('ld-inv:Client:RefreshInventory',source)
		end)
	
		CreateThread(function()
			while true do
				for k,v in pairs(active) do
					if active[k] > 0 then
						active[k] = active[k] - 1
					end
				end
				Wait(1000)
			end
		end)
	
	end
end)