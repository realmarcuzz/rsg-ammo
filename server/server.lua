local RSGCore = exports['rsg-core']:GetCoreObject()

for _itemName, _ammoType in pairs(Config.BoxAmmo) do
    RSGCore.Functions.CreateUseableItem(_itemName, function(source, item)
        local src = source
        local Player = RSGCore.Functions.GetPlayer(src)
        if not Player then return end
        TriggerClientEvent('rsg-ammo:client:openAmmoBox', src, item.name, _ammoType, Config.AmmoTypes[_ammoType].refill)
    end)
end

------------------------------------------
-- use arrow ammo
------------------------------------------
RSGCore.Functions.CreateUseableItem('ammo_arrow', function(source, item)
    TriggerClientEvent('rsg-ammo:client:AddAmmo', source, 'AMMO_ARROW', Config.AmmoTypes['AMMO_ARROW'].refill)
end)

RSGCore.Functions.CreateUseableItem('ammo_arrow_small', function(source, item)
    TriggerClientEvent('rsg-ammo:client:AddAmmo', source, 'AMMO_ARROW_SMALL_GAME', Config.AmmoTypes['AMMO_ARROW_SMALL_GAME'].refill)
end)

RSGCore.Functions.CreateUseableItem('ammo_arrow_fire', function(source, item)
    TriggerClientEvent('rsg-ammo:client:AddAmmo', source, 'AMMO_ARROW_FIRE', Config.AmmoTypes['AMMO_ARROW_FIRE'].refill)
end)

RSGCore.Functions.CreateUseableItem('ammo_arrow_poison', function(source, item)
    TriggerClientEvent('rsg-ammo:client:AddAmmo', source, 'AMMO_ARROW_POISON', Config.AmmoTypes['AMMO_ARROW_POISON'].refill)
end)

RSGCore.Functions.CreateUseableItem('ammo_arrow_dynamite', function(source, item)
    TriggerClientEvent('rsg-ammo:client:AddAmmo', source, 'AMMO_ARROW_DYNAMITE', Config.AmmoTypes['AMMO_ARROW_DYNAMITE'].refill)
end)

---------------------------------------------
-- remove item
---------------------------------------------
RegisterServerEvent('rsg-ammo:server:removeitem')
AddEventHandler('rsg-ammo:server:removeitem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove', amount)
end)

---------------------------------------------
-- add item
---------------------------------------------
RegisterServerEvent('rsg-ammo:server:additem')
AddEventHandler('rsg-ammo:server:additem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'add', amount)
end)

---------------------------------------------
-- open ammo box
---------------------------------------------
RegisterServerEvent('rsg-ammo:server:openAmmoBox')
AddEventHandler('rsg-ammo:server:openAmmoBox', function(ammoBoxItem, ammoType, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(ammoBoxItem, 1)
    TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[ammoBoxItem], 'remove', 1)
    TriggerClientEvent('rsg-ammo:client:AddAmmo', src, ammoBoxItem, ammoType, amount)
end)

RSGCore.Functions.CreateCallback('rsg-ammo:server:initializeDb', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    local citizenid = Player.PlayerData.citizenid
    if not citizenid then return end
    MySQL.single('SELECT * FROM player_ammo WHERE citizenid = ? LIMIT 1', {
        citizenid
    }, function(row)
        if not row then
            MySQL.insert.await('INSERT INTO player_ammo (citizenid) VALUES (?)', {
                citizenid
            })
            row = MySQL.single.await('SELECT * FROM player_ammo WHERE citizenid = ? LIMIT 1', {
                citizenid
            })
        end
     
        cb(row)
    end)
end)

RegisterServerEvent('rsg-ammo:server:updateDb')
AddEventHandler('rsg-ammo:server:updateDb', function(update)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end

    if next(update) then 
        local setClauses = {}
        local params = {}
        for column, value in pairs(update) do
            table.insert(setClauses, column .. " = @" .. column)
            params["@" .. column] = value
        end
    
        local sql = "UPDATE player_ammo SET " .. table.concat(setClauses, ", ") .. " WHERE citizenid = @citizenid"
        params["@citizenid"] = Player.PlayerData.citizenid
    
        MySQL.Sync.execute(sql, params)
    end
end)
