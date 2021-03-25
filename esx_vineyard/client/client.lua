-- Made by Pural#0001
ESX              = nil
local PlayerData = {}
local isNear = false
local isNear2 = false 
local isNear3 = false
local ped = PlayerPedId()


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


Citizen.CreateThread(function()
	while true do
	 	local coords = GetEntityCoords(PlayerPedId())

	 	Citizen.Wait(500)

		if #(coords - Config.Location) < Config.Distance then isNear = true  else isNear = false  end
		if #(coords - Config.Process) < Config.Distance2 then isNear2 = true  else isNear2 = false  end
		if #(coords - Config.Sell) < Config.Distance3 then isNear3 = true  else isNear3 = false  end
	end
end)
 


Citizen.CreateThread(function()
	local location = Config.Location
	local location2 = Config.Process
	local location3 = Config.Sell
	while true do
		Citizen.Wait(1)
		if isNear then -- Collect
			Draw3DText(location.x, location.y, location.z, "Press ~y~ [E] ~w~ to ~y~ collect grapes")
			if Vdist(GetEntityCoords(PlayerPedId()), Config.Location) < 1 and IsControlJustReleased(1, 38) then
				TriggerServerEvent('esx_vineyard:giveGrapes')
				playAnim('clothingtie', 'try_tie_negative_a', 2000)
				Citizen.Wait(2000)
			end
		end


		if isNear2 then -- Process
			Draw3DText(location2.x, location2.y, location2.z, "Press ~y~ [E] ~w~ to ~y~ process grapes") -- Process
			if Vdist(GetEntityCoords(PlayerPedId()), Config.Process) < 1 and IsControlJustReleased(1, 38) then
				TriggerServerEvent('esx_vineyard:addInventoryItem1')
				playAnim('amb@prop_human_bum_bin@idle_b', 'idle_d')
				Citizen.Wait(2000)
			end
		end


		if isNear3 then -- Sell
			Draw3DText(location3.x, location3.y, location3.z, "Press ~y~ [E] ~w~ to ~y~ sell wine")
			if Vdist(GetEntityCoords(PlayerPedId()), Config.Sell) < 1 and IsControlJustReleased(1, 38) then
				TriggerServerEvent('esx_vineyard:payMoney')

			end
		end
	end
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextOutline()
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0150, 0.040+ factor, 0.03, 1, 1, 1, 150)
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

--  NPC

local coordonate = {
    {-1903.14, 2083.91, 139.11, "Vine selling", 164.78, 0xE7714013, "g_m_m_armlieut_01"}
}

Citizen.CreateThread(function()
    for _,v in pairs(coordonate) do
		RequestModel(GetHashKey(v[7]))
		while not HasModelLoaded(GetHashKey(v[7])) do
		Wait(1)
		end

		RequestAnimDict("mini@strip_club@idles@bouncer@base")
		while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
		Wait(1)
		end
		ped =  CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
		SetEntityHeading(ped, v[5])
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)
-- Made by Pural#0001

