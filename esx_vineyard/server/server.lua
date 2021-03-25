-- Made by Pural#0001
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_vineyard:addInventoryItem1')
AddEventHandler('esx_vineyard:addInventoryItem1', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = Config.Process
	local ped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(ped)
    Citizen.Wait(2000)
    if Config.OneSync then 
        if #(playerCoords - coords) <= 20.0 then
            if xPlayer.getInventoryItem("grapes").count > 0 then
                xPlayer.removeInventoryItem('grapes', 1)
                TriggerClientEvent('esx:showNotification', source, 'You have successfully proccesed the grapes!')
            xPlayer.addInventoryItem('wine', 1)
            else
                TriggerClientEvent('esx:showNotification', source, 'You dont have any grapes!')
            end
        else
            print("[esx_vineyard]" .. GetPlayerName(source) .. " is cheating")
        end
    else
        if xPlayer.getInventoryItem("grapes").count > 0 then
            xPlayer.removeInventoryItem('grapes', 1)
            TriggerClientEvent('esx:showNotification', source, 'You have successfully proccesed the grapes!')
        xPlayer.addInventoryItem('wine', 1)
        else
            TriggerClientEvent('esx:showNotification', source, 'You dont have any grapes!')
        end
    end
end)

RegisterServerEvent ('esx_vineyard:giveGrapes')
AddEventHandler('esx_vineyard:giveGrapes', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = Config.Location
	local ped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(ped)
    Citizen.Wait(2000)
    if Config.OneSync then 
        if #(playerCoords - coords) <= 20.0 then
            xPlayer.addInventoryItem('grapes', 1)
        else
            print("[esx_vineyard]" .. GetPlayerName(source) .. " is cheating")
        end
    else
        xPlayer.addInventoryItem('grapes', 1)
    end
end)




RegisterNetEvent('esx_vineyard:payMoney')
AddEventHandler('esx_vineyard:payMoney', function()
    local src = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    local coords = Config.Sell
	local ped = GetPlayerPed(source)
	local playerCoords = GetEntityCoords(ped)
    Citizen.Wait(2000)
    if Config.OneSync then 
        if #(playerCoords - coords) <= 20.0 then
            if xPlayer.getInventoryItem("wine").count > 0 then
                xPlayer.removeInventoryItem('wine', 1)
            xPlayer.addMoney(Config.Amount)
            TriggerClientEvent('esx:showNotification', source, 'You have selled the wine!')
            else
                TriggerClientEvent('esx:showNotification', source, 'You dont have any wine!')
            end
        else
            print("[esx_vineyard]" .. GetPlayerName(source) .. " is cheating")
        end
    else
        if xPlayer.getInventoryItem("wine").count > 0 then
            xPlayer.removeInventoryItem('wine', 1)
        xPlayer.addMoney(Config.Amount)
        TriggerClientEvent('esx:showNotification', source, 'You have selled the wine!')
        else
            TriggerClientEvent('esx:showNotification', source, 'You dont have any wine!')
        end
    end
end)

-- Made by Pural#0001
