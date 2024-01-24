local QBCore = exports['qb-core']:GetCoreObject()
local isJobActive = false

RegisterNetEvent('Svelte-Template:server:checkOwned', function()
    local src = source

    lib.callback('Svelte-Template:client:getLocation', src, function(location)
    local Player = QBCore.Functions.GetPlayer(src)
    local row = MySQL.single.await('SELECT `owned`, `citizenid` FROM `playerstores` WHERE `location` = ?', {
        location
    })
    if row.owned == 'false' then
        TriggerClientEvent('Svelte-Template:client:buyStore', src, location)
    else if row.owned == 'true' then
        if row.citizenid == Player.PlayerData.citizenid then
            Wait(500)
            TriggerClientEvent('Svelte-Template:client:openUI', src)
        else
            print('you dont own it')
        end
    end
end
end)
end)

lib.addCommand(Config.Command, {
    help = Config.SubText,
    params = {
        {
            name = 'store',
            type = 'string',
            help = 'Name of the store',
        },
    },
    restricted = 'group.admin'
}, function(source, args, raw)

    local id = MySQL.insert('INSERT INTO `playerstores` (citizenid, owned, balance, stock, capacity, totaldeliveries, rating, location) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
    {
        '',
        'false',
        0,
        0,
        0,
        0,
        0,
        args.store
    })

    print(args.store)
end)

RegisterNetEvent('Svelte-Template:server:buyStore', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    TriggerClientEvent('Svelte-Template:client:openPurchaseUI', src)
end)

RegisterNetEvent('Svelte-Template:server:buyStoreMoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    lib.callback('Svelte-Template:client:getLocation', src, function(location)
        lib.callback('Svelte-Template:client:getPrice', src, function(price)
            if Player.PlayerData.money.cash >= price then
                print('Buying '..location)
                local id = MySQL.insert('UPDATE playerstores SET citizenid = ?, owned = ?, balance = ?, stock = ?, capacity = ?, totaldeliveries = ?, rating = ? WHERE location = ?',
                {
                    Player.PlayerData.citizenid,
                    'true',
                    0,
                    0,
                    100,
                    0,
                    0,
                    location
                })
                print(location..' bought with cash!')
                Player.Functions.RemoveMoney('cash', price)
                TriggerClientEvent('Svelte-Template:client:openUI', src)
            elseif Player.PlayerData.money.bank >= price then
                print('Buying '..location)
                local id = MySQL.insert('UPDATE playerstores SET citizenid = ?, owned = ?, balance = ?, stock = ?, capacity = ?, totaldeliveries = ?, rating = ? WHERE location = ?',
                {
                    Player.PlayerData.citizenid,
                    'true',
                    0,
                    0,
                    100,
                    0,
                    0,
                    location
                })
                print(location..' bought with bank!')
                Player.Functions.RemoveMoney('bank', price)
                TriggerClientEvent('Svelte-Template:client:openUI', src)
            else
                TriggerClientEvent('Svelte-Template:client:openPurchaseUI', src)
            end
        end)
    end)
end)

RegisterNetEvent("Svelte-Template:server:getBalance", function(location)
	local src = source
    QBCore.Functions.CreateCallback('Svelte-Template:server:getBalanceCallback', function(source, cb)
        local src = source
        local balance = MySQL.Sync.prepare('SELECT balance FROM playerstores where location = ?', { location })
        cb(balance)
    end)
end)

RegisterNetEvent("Svelte-Template:server:getStock", function(location)
	local src = source
    QBCore.Functions.CreateCallback('Svelte-Template:server:getStockCallback', function(source, cb)
        local src = source
        local stock = MySQL.Sync.prepare('SELECT stock FROM playerstores where location = ?', { location })
        cb(stock)
    end)
end)

RegisterNetEvent("Svelte-Template:server:getCapacity", function(location)
	local src = source
    QBCore.Functions.CreateCallback('Svelte-Template:server:getCapacityCallback', function(source, cb)
        local src = source
        local capacity = MySQL.Sync.prepare('SELECT capacity FROM playerstores where location = ?', { location })
        cb(capacity)
    end)
end)

RegisterNetEvent("Svelte-Template:server:getTotalDeliveries", function(location)
	local src = source
    QBCore.Functions.CreateCallback('Svelte-Template:server:getTotalDeliveriesCallback', function(source, cb)
        local src = source
        local totaldeliveries = MySQL.Sync.prepare('SELECT totaldeliveries FROM playerstores where location = ?', { location })
        cb(totaldeliveries)
    end)
end)


RegisterNetEvent("Svelte-Template:server:getRating", function(location)
	local src = source
    QBCore.Functions.CreateCallback('Svelte-Template:server:getRatingCallback', function(source, cb)
        local src = source
        local rating = MySQL.Sync.prepare('SELECT rating FROM playerstores where location = ?', { location })
        cb(rating)
    end)
end)

QBCore.Functions.CreateCallback('Svelte-Template:server:isJobActiveCallback', function(source, cb)
    if isJobActive == true then
        cb(true)
    else
        cb(false)
    end
end)