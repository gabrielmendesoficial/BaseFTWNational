-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
will = {}
Tunnel.bindInterface("identity",will)
vCLIENT = Tunnel.getInterface("identity")
Reborn = Proxy.getInterface("Reborn")

function will.getIndentity()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local job = vRP.getUserGroupByType(user_id,"job") or "Desempregado"
    local vip = vRP.getUserGroupByType(user_id,"vip") or "Indefinido"
    local multas = vRP.getFines(user_id)
    local infos = {
        userId = user_id,
        name = identity.name.." "..identity.name2,
        bank = identity.bank,
        phone = identity.phone,
        job = job,
        vip = vip,
        fines = multas,
    }
    return infos
end
