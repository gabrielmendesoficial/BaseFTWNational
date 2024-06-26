-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
usersIdentity = {}

function vRP.getUserIdentity(user_id,refresh)
	if not user_id then return {} end
	if not usersIdentity[user_id] or refresh then
		usersIdentity[user_id] = {}
		local rows = vRP.getInformation(user_id)
		if rows[1] then
			local nplayer = vRP.getUserSource(user_id)
			local sex = 'm'
			if nplayer then
				if vRP.modelPlayer(nplayer) == 'mp_f_freemode_01' then sex = 'f' end
			end
			usersIdentity[user_id] = rows[1]
			usersIdentity[user_id]["firstname"] = rows[1]["name2"]
			usersIdentity[user_id]["sex"] = sex
			usersIdentity[user_id]["port"] = 0
			usersIdentity[user_id]["blood"] = 1
			usersIdentity[user_id]["fines"] = vRP.getFines(user_id)
			usersIdentity[user_id]["serial"] = rows[1]["registration"]
		end
	end
	return usersIdentity[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERREGISTRATION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserRegistration(user_id)
	if usersIdentity[user_id] then
		return usersIdentity[user_id]['registration']
	end
	local rows = vRP.getInformation(user_id)
	return rows[1].registration
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERIDREGISTRATION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserIdRegistration(registration)
	local rows = vRP.query("vRP/get_vrp_registration",{ registration = registration })
	if rows[1] then
		return rows[1].id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.initPrison(user_id,amount)
	vRP.execute("vRP/set_prison",{ user_id = user_id, prison = parseInt(amount), locate = 1 })

	if usersIdentity[user_id] then
		usersIdentity[user_id]["prison"] = parseInt(amount)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePrison(user_id)
	vRP.execute("vRP/rem_prison",{ user_id = user_id, prison = 1 })

	if usersIdentity[user_id] then
		usersIdentity[user_id]["prison"] = usersIdentity[user_id]["prison"] - 1

		if usersIdentity[user_id]["prison"] < 0 then
			usersIdentity[user_id]["prison"] = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeChars(user_id)
	vRP.execute("accounts/infosUpdatechars",{ steam = usersIdentity[user_id]["steam"] })

	if usersIdentity[user_id] then
		usersIdentity[user_id]["chars"] = usersIdentity[user_id]["chars"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userGemstone(steam)
	local infoAccount = vRP.infoAccount(steam)
	return infoAccount["gems"] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeGemstone(user_id,amount)
	vRP.execute("vRP/set_vRP_gems",{ steam = usersIdentity[user_id]["steam"], gems = amount })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeNames(user_id,name,name2)
	vRP.execute("vRP/rename_characters",{ name = name, name2 = name2, id = user_id })

	if usersIdentity[user_id] then
		usersIdentity[user_id]["name2"] = name2
		usersIdentity[user_id]["name"] = name
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePhone(user_id,phone)
	vRP.execute("characters/updatePhone",{ phone = phone, id = user_id })

	if usersIdentity[user_id] then
		usersIdentity[user_id]["phone"] = phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETVEHICLEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
local plateUser = {}

function vRP.getVehiclePlate(plate)
	if not plateUser[plate] then
		local rows = vRP.query("vRP/get_vehicle_plate",{ plate = plate })
		if rows[1] then
			plateUser[plate] = rows[1].user_id
		end
	end
	return plateUser[plate]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERBYPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserByPhone(phone)
	local rows = vRP.query("vRP/get_vrp_phone",{ phone = phone })
	if rows[1] then
		return rows[1].id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getPhone(id)
	if usersIdentity[user_id] then
		return usersIdentity[user_id]['phone']
	end
	local rows = vRP.query("vRP/get_vrp_users",{ id = id })
	if rows[1] then
		return rows[1].phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRINGNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then
			number = number..string.char(abyte+math.random(0,25))
		else
			number = number..char
		end
	end
	return number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEREGISTRATIONNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateRegistrationNumber()
	local user_id = nil
	local registration = ""
	repeat
		Citizen.Wait(0)
		registration = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.getUserIdRegistration(registration)
	until not user_id

	return registration
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePlateNumber()
	local user_id = nil
	local registration = ""
	repeat
		Citizen.Wait(0)
		registration = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.getVehiclePlate(registration)
	until not user_id

	return registration
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.genPlate()
	return vRP.generateStringNumber("LLDDDLLL")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONENUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePhoneNumber()
	local user_id = nil
	local phone = ""

	repeat
		Citizen.Wait(0)
		phone = vRP.generateStringNumber("DDD-DDD")
		user_id = vRP.getUserByPhone(phone)
	until not user_id

	return phone
end
