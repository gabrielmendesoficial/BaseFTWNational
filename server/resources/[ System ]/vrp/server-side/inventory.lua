-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
Reborn = Proxy.getInterface("Reborn")
local items = module('vrp',"Reborn/Itemlist")
local Webhooks = module("Reborn/webhooks")

RegisterServerEvent("Reborn:reloadInfos",function() items = module('vrp',"Reborn/Itemlist") end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDEFINITION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getItemDefinition(item)
	if items[item] then
		return vRP.itemNameList(item),vRP.itemWeightList(item)
	end
	return nil,nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODYLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemBodyList(item)
	if items[item] ~= nil then
		return items[item]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemIndexList(item)
	if items[item] ~= nil then
		return items[item].index
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAMELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemNameList(item)
	if items[item] ~= nil then
		return items[item].name
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemTypeList(item)
	if items[item] ~= nil then
		return items[item].type
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMOLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemAmmoList(item)
	if items[item] then
		return items[item].ammo
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemWeightList(item)
	if items[item] then
		return items[item].weight
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETITEMBYSLOT AND GETSLOTBYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GetItemBySlot(user_id,slot)
	local data = vRP.getInventory(user_id)
	if data and slot then
		local slot = tostring(slot)
		if data[slot] then
			return data[slot]
		end
	end
	return nil
end

function vRP.GetSlotByItem(inv,item)
	local data = inv
	if data and item then
		for k,v in pairs(data) do
			if v.item == tostring(item) then
				return k
			end
		end
	end
	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.giveInventoryItem(user_id,item,amount,slot,notify)
	local nplayer = vRP.getUserSource(tonumber(user_id))
	if nplayer then
		local metadata = nil
		Reborn.addItem(nplayer,item,amount,metadata,slot,notify)
	end
end

function vRP.giveInventoryItemCustom(source,idname,amount,slot,notify,metadata)
	local user_id = vRP.getUserId(source)
	local data = vRP.getInventory(user_id)
	if data and parseInt(amount) > 0 then
		if type(slot) == "boolean" then 
			backupslot = slot
			slot = notify
			notify = backupslot
		end
		if not slot or slot == nil then
			local initial = 12
			
			local slot = vRP.GetSlotByItem(data, idname)
			if slot == nil then
				repeat
					initial = initial + 1
				until data[tostring(initial)] == nil or (data[tostring(initial)] and data[tostring(initial)].item == idname)
			else
				initial = tonumber(slot)
			end
			
			initial = tostring(initial)

			if data[initial] == nil then
				data[initial] = { item = idname, amount = parseInt(amount) }
			elseif data[initial] and data[initial].item == idname then
				data[initial].amount = parseInt(data[initial].amount) + parseInt(amount)
			end

			--notify
			if notify and vRP.itemBodyList(idname) then
				TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
			end
		else
			slot = tostring(slot)

			if data[slot] then
				if data[slot].item == idname then
					local oldAmount = parseInt(data[slot].amount)
					data[slot] = { item = idname, amount = parseInt(oldAmount) + parseInt(amount) }
				end
			else
				data[slot] = { item = idname, amount = parseInt(amount) }
			end

			--notify
			if notify and vRP.itemBodyList(idname) then
				TriggerClientEvent("itensNotify",vRP.getUserSource(user_id),{ "RECEBEU",vRP.itemIndexList(idname),vRP.format(parseInt(amount)),vRP.itemNameList(idname) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYGETINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryGetInventoryItem(user_id,idname,amount,slot,notify)
	local nplayer = vRP.getUserSource(tonumber(user_id))
	if nplayer then
		return Reborn.removeItem(nplayer,idname,amount,slot,notify)
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPUTEINVWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeInvWeight(user_id)
	local weight = 0
	local inventory = vRP.getInventory(user_id)
	if inventory then
		for k,v in pairs(inventory) do
			if vRP.itemBodyList(v.item) then
				weight = weight + vRP.itemWeightList(v.item) * parseInt(v.amount)
			end
		end
		return weight
	end
	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemAmount(user_id,idname)
	local nplayer = vRP.getUserSource(tonumber(user_id))
	if nplayer then
		local itemData = Reborn.getItem(nplayer,idname)
		if itemData then
			return tonumber(itemData.count) or tonumber(itemData.amount) or 0
		end
	end
	return 0
end

function vRP.getInventoryItemCustom(source,item)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getInventory(user_id)
		for k,v in pairs(data) do
			if v.item == item then
				return v
			end
		end
	end
	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removeInventoryItem(user_id,item,amount,slot,notify)
	local nplayer = vRP.getUserSource(tonumber(user_id))
	if nplayer then
		Reborn.removeItem(nplayer,item,amount,slot,notify)
	end
end

function vRP.removeItemCustom(source,item,amount,slot,notify)
	local user_id = vRP.getUserId(source)
	local data = vRP.getInventory(user_id)
	if data then
		if slot then
			local slot  = tostring(slot)
			if data[slot] and data[slot].item == item and parseInt(data[slot].amount) >= parseInt(amount) then
				data[slot].amount = parseInt(data[slot].amount) - parseInt(amount)
				if parseInt(data[slot].amount) <= 0 then
					data[slot] = nil
				end
				TriggerClientEvent("itensNotify",source,{ "REMOVIDO",item,amount,vRP.itemNameList(item) })
				return true
			end
		else
			for k,v in pairs(data) do
				if v.item == item and parseInt(v.amount) >= parseInt(amount) then
					v.amount = parseInt(v.amount) - parseInt(amount)
					if parseInt(v.amount) <= 0 then
						data[k] = nil
					end
					TriggerClientEvent("itensNotify",source,{ "REMOVIDO",item,amount,vRP.itemNameList(item) })
					return true
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVED
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		local slyphe = 500
		if actived then
			slyphe = 100 
			for k,v in pairs(actived) do
				if actived[k] > 0 then
					actived[k] = v - 1
					if actived[k] <= 0 then
						actived[k] = nil
					end
				end
			end
		end
		Citizen.Wait(slyphe)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCHESTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryChestItem(user_id,chestData,itemName,amount,slot)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					activedAmount[user_id] = parseInt(items[itemName].amount)
				end
				local new_weight = vRP.computeInvWeight(user_id) + vRP.itemWeightList(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getBackpack(user_id) then
					vRP.giveInventoryItem(user_id,itemName,parseInt(activedAmount[user_id]),true,slot)
					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])
					vRP.createWeebHook(Webhooks.retiradadeitens,"```PASSAPORTE: "..user_id.." ( RETIROU )\nBAU:"..chestData.." \nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end
					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHESTITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight,slot)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local slot = tostring(slot)
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				local inv = vRP.getInventory(user_id)
				if inv[slot] then
					activedAmount[user_id] = parseInt(inv[slot].amount)
				end
			end
			local new_weight = vRP.computeChestWeight(items) + vRP.itemWeightList(itemName) * parseInt(activedAmount[user_id])
			if new_weight <= chestWeight then
				if vRP.tryGetInventoryItem(user_id,itemName,parseInt(activedAmount[user_id]),true,slot) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end
					vRP.createWeebHook(Webhooks.colocouitens,"```PASSAPORTE: "..user_id.." ( GUARDOU )\nBAU:"..chestData.."\nITEM: "..vRP.format(parseInt(activedAmount[user_id])).."x "..vRP.itemNameList(itemName).."```")
					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.computeChestWeight(chestData)
	local totalWeight = 0
	for k,v in pairs(chestData) do
		totalWeight = totalWeight + vRP.itemWeightList(v["item"]) * parseInt(v["amount"])
	end
	return totalWeight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBackpack(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data.backpack == nil then
		data.backpack = 5
	end
	return data.backpack
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBackpack(user_id,amount)
	local data = vRP.getUserDataTable(user_id)
	if data then
		data.backpack = amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONUSDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.bonusDelivery(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data.delivery == nil then
		data.delivery = 0
	end
	return data.delivery
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBONUSDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBonusDelivery(user_id,amount)
	local data = vRP.getUserDataTable(user_id)
	if data.delivery then
		data.delivery = data.delivery + amount
	else
		data.delivery = amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONUSPOSTOP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.bonusPostOp(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data.postop == nil then
		data.postop = 0
	end
	return data.postop
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBONUSPOSTOP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setbonusPostOp(user_id,amount)
	local data = vRP.getUserDataTable(user_id)
	if data.postop then
		data.postop = data.postop + amount
	else
		data.postop = amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMEPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateHomePosition(user_id,x,y,z)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		if data then
			data.position = { x = tvRP.mathLegth(x), y = tvRP.mathLegth(y), z = tvRP.mathLegth(z) }
		end
	end
end

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
	end
end)