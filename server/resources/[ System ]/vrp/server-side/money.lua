-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addBank(user_id,amount,reason)
	if amount > 0 then
		vRP.execute("vRP/add_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
		if usersIdentity and usersIdentity[user_id] then
			usersIdentity[user_id]['bank'] = usersIdentity[user_id]['bank'] + parseInt(amount)
		end
		local nplayer = vRP.getUserSource(user_id)
		if nplayer then
			local Player = QBCore.Functions.GetPlayer(nplayer)
			local xPlayer = ESX.GetPlayerFromId(nplayer)
			if xPlayer then	xPlayer.addMoney(amount,reason) end
			if Player then Player.Functions.AddMoney("bank", amount, reason) end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBank(user_id,amount)
	if amount >= 0 then
		vRP.execute("vRP/set_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
		if usersIdentity and usersIdentity[user_id] then
			usersIdentity[user_id]['bank'] = parseInt(amount)
		end
		local nplayer = vRP.getUserSource(user_id)
		if nplayer then
			local Player = QBCore.Functions.GetPlayer(nplayer)
			local xPlayer = ESX.GetPlayerFromId(nplayer)
			if xPlayer then	xPlayer.setMoney(amount,reason) end
			if Player then Player.Functions.SetMoney("bank", amount, reason) end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delBank(user_id,amount)
	if amount > 0 then
		vRP.execute("vRP/del_bank",{ id = parseInt(user_id), bank = parseInt(amount) })
		if usersIdentity and usersIdentity[user_id] then
			usersIdentity[user_id]['bank'] = usersIdentity[user_id]['bank'] - parseInt(amount)
		end
		local nplayer = vRP.getUserSource(user_id)
		if nplayer then
			local Player = QBCore.Functions.GetPlayer(nplayer)
			local xPlayer = ESX.GetPlayerFromId(nplayer)
			if xPlayer then	xPlayer.removeMoney(amount,reason) end
			if Player then Player.Functions.RemoveMoney("bank", amount, reason) end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBank(user_id)
	if usersIdentity and usersIdentity[user_id] then
		return usersIdentity[user_id]['bank']
	end
	local consult = vRP.getInformation(user_id)
	if consult[1] then
		return consult[1].bank
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentBank(user_id,amount)
	if amount > 0 then
		local consult = vRP.getInformation(user_id)
		if consult[1] then
			if consult[1].bank >= amount then
				vRP.delBank(parseInt(user_id),parseInt(amount))

				local source = vRP.getUserSource(user_id)
				if source then
					TriggerClientEvent("itensNotify",source,{ "REMOVIDO","dollars",vRP.format(amount),"Dólares" })
				end
				return true
			elseif vRP.tryGetInventoryItem(user_id,"dollars",amount) then
				local source = vRP.getUserSource(user_id)
				if source then
					TriggerClientEvent("itensNotify",source,{ "REMOVIDO","dollars",vRP.format(amount),"Dólares" })
				end
				return true
			end
		end
	end
	return false
end

function vRP.tryFullPayment(user_id, price)
	if price > 0 and vRP.tryGetInventoryItem(user_id,"dollars",price) then
		return true
	end
    return vRP.paymentBank(user_id, price)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.withdrawCash(user_id,amount)
	if amount > 0 then
		local consult = vRP.getInformation(user_id)
		if consult[1] then
			if consult[1].bank >= amount then
				vRP.giveInventoryItem(user_id,"dollars",amount,true)
				vRP.delBank(parseInt(user_id),parseInt(amount))
				return true
			end
		end
	end
	return false
end

function vRP.tryWithdraw(user_id,amount)
	local money = vRP.getBankMoney(user_id)
	if amount >= 0 and money >= amount then
		vRP.setBankMoney(user_id,money-amount)
		vRP.giveMoney(user_id,amount)
		return true
	else
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setInvoice(user_id,price,nuser_id,text)
	vRP.execute("vRP/add_invoice",{ user_id = user_id, nuser_id = tostring(nuser_id), date = os.date("%d.%m.%Y"), price = price, text = tostring(text) })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInvoice(user_id)
	return vRP.query("vRP/get_invoice",{ user_id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETMYINVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getMyInvoice(nuser_id)
	return vRP.query("vRP/get_myinvoice",{ nuser_id = nuser_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setFines(user_id,price)
	local fines = vRP.getFines(user_id)
	vRP.setUData(parseInt(user_id),"vRP:multas",json.encode(fines + parseInt(price)))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getFines(user_id)
	local value = vRP.getUData(parseInt(user_id),"vRP:multas")
    local multas = json.decode(value) or 0
	return parseInt(multas)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getGmsId(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		local infos = vRP.query("vRP/get_vrp_infos",{ steam = identity.steam })
		if infos[1] then
			return infos[1].gems
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remGmsId(user_id,amount)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		local infos = vRP.query("vRP/get_vrp_infos",{ steam = identity.steam })						
        if infos[1].gems >= amount then
			vRP.execute("vRP/rem_vRP_gems",{ steam = identity.steam, gems = parseInt(amount) })
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addGmsId(user_id,amount)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vRP.execute("vRP/set_vRP_gems",{ steam = identity.steam, gems = parseInt(amount) })
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPremium(user_id)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		local consult = vRP.getInfos(identity.steam)
		if consult[1] and os.time() >= (consult[1].premium+24*consult[1].predays*60*60) then
			return false
		else
			return true
		end
	end
end

function vRP.tryDeposit(user_id,amount)
    if amount > 0 and vRP.tryGetInventoryItem(user_id,"dollars",amount) then
        vRP.addBank(user_id,amount)
        return true
    else
        return false
    end
end

function vRP.giveMoney(user_id, amount)
    if parseInt(amount) > 0 then
        vRP.giveInventoryItem(user_id, "dollars", parseInt(amount))
    end
end
