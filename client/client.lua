QBCore = exports['qb-core']:GetCoreObject()
local zoneId
local location
local isJobActive = false

local function toggleUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible",
		data = bool
	})
end

RegisterNUICallback("hideUI", function()
    toggleUI(false)
end)

local function togglePurchaseUI(bool)
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		action = "setVisible2",
		data = bool
	})
end

RegisterNUICallback("hidePurchaseUI", function()
    togglePurchaseUI(false)
    TriggerEvent('gdfgdggdgfg')
end)

RegisterNUICallback("purchaseStore", function(location)
    TriggerServerEvent('Svelte-Template:server:buyStoreMoney', location)
end)

RegisterNUICallback("get_store_title", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.title then
            location = v.title
            cb(location)
        end
    end
end)

RegisterNUICallback("get_player_name", function(_, cb)
    local PlayerData = QBCore.Functions.GetPlayerData()
    cb(PlayerData.charinfo.firstname)
end)

RegisterNUICallback("get_store_balance", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.name then
            location = v.name
        end
    end

    TriggerServerEvent("Svelte-Template:server:getBalance", location)
    QBCore.Functions.TriggerCallback('Svelte-Template:server:getBalanceCallback', function(balance)
        cb(balance)
    end)
end)

RegisterNUICallback("get_store_stock", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.name then
            location = v.name
        end
    end

    TriggerServerEvent("Svelte-Template:server:getStock", location)
    QBCore.Functions.TriggerCallback('Svelte-Template:server:getStockCallback', function(stock)
        cb(stock)
    end)
end)

RegisterNUICallback("get_store_capacity", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.name then
            location = v.name
        end
    end

    TriggerServerEvent("Svelte-Template:server:getCapacity", location)
    QBCore.Functions.TriggerCallback('Svelte-Template:server:getCapacityCallback', function(capacity)
        cb(capacity)
    end)
end)

RegisterNUICallback("get_store_totaldeliveries", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.name then
            location = v.name
        end
    end

    TriggerServerEvent("Svelte-Template:server:getTotalDeliveries", location)
    QBCore.Functions.TriggerCallback('Svelte-Template:server:getTotalDeliveriesCallback', function(totaldeliveries)
        cb(totaldeliveries)
    end)
end)

RegisterNUICallback("get_store_price", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.price then
            cb(v.price)
        end
    end
end)

RegisterNUICallback("get_store_rating", function(_, cb)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.name then
            location = v.name
        end
    end

    TriggerServerEvent("Svelte-Template:server:getRating", location)
    QBCore.Functions.TriggerCallback('Svelte-Template:server:getRatingCallback', function(rating)
        cb(rating)
    end)
end)

RegisterNetEvent('Svelte-Template:client:openUI', function()
    toggleUI(true)
end)

RegisterNetEvent('Svelte-Template:client:openPurchaseUI', function()
    togglePurchaseUI(true)
end)

CreateThread(function()
    for _, v in ipairs(Config.Zones) do
        lib.zones.box({
            coords = v.coords,
            debug = true,
            onEnter = function(s)
                zoneId = s.id
                TriggerServerEvent('Svelte-Template:server:checkOwned')
            end
        })

        print(v.coords)
        if not v.hideBlip then
            local center = v.coords
            local blip = AddBlipForCoord(center.x, center.y, center.z)
            SetBlipSprite(blip, v.blip)
            SetBlipScale(blip, 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.title)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

RegisterNetEvent('Svelte-Template:client:buyStore', function(location)
    TriggerServerEvent('Svelte-Template:server:buyStore', location)
end)

lib.callback.register('Svelte-Template:client:getLocation', function(location)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.name then
            location = v.name
            return location
        end
    end
end)

lib.callback.register('Svelte-Template:client:getPrice', function(price)
    for i, v in ipairs(Config.Zones) do
        if i == zoneId and v.price then
            price = v.price
            return price
        end
    end
end)

RegisterNUICallback("is_job_active", function(_, cb)
    QBCore.Functions.TriggerCallback('Svelte-Template:server:isJobActiveCallback', function(active)
        cb(active)
    end)
end)