ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("r3_tasking:loadDatas", function(source, cb)
    local list = Config.Tasks
    local src = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(src)
    local result = MySQL.query.await('SELECT * FROM tasks WHERE identifier = ?', {xPlayer.identifier})
    if next(result) == nil then
        for _, v in pairs(Config.Tasks) do
            if v.RewardItem ~= nil then
                local id = MySQL.insert.await('INSERT INTO tasks (identifier, reward, taskname) VALUES (?, ?, ?) ', {xPlayer.identifier, v.RewardItem, v.TaskName})
            else
                local id = MySQL.insert.await('INSERT INTO tasks (identifier, reward, taskname) VALUES (?, ?, ?) ', {xPlayer.identifier, v.RewardMoney, v.TaskName})
            end
        end
    end
    for _, v in pairs(Config.Tasks) do
        local result = MySQL.query.await('SELECT * FROM tasks WHERE taskname = ?', {v.TaskName})
        if next(result) == nil then
            local id = MySQL.insert.await('INSERT INTO tasks (identifier, reward, taskname) VALUES (?, ?, ?) ', {xPlayer.identifier, v.RewardItem, v.TaskName})
        end
    end
    for k, v in pairs(Config.Tasks) do
        local result = MySQL.query.await('SELECT finished FROM tasks WHERE (identifier = ? AND taskname = ?)', {xPlayer.identifier, v.TaskName})
        if result[1].finished == "true" then
            list[k]["finished"] = true
        else
            list[k]["finished"] = false
        end
    end
    cb(list)
end)

ESX.RegisterServerCallback("r3_tasking:checkTask", function(source, cb, task)
    local src = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(src)
    for _, v in pairs(Config.Tasks) do
        if v.TaskName == task then
            if xPlayer then
                local result = MySQL.query.await('SELECT finished FROM tasks WHERE (identifier = ? AND taskname = ?)', {xPlayer.identifier, v.TaskName})
                if result.finished == "true" then
                    cb(false)
                else
                    cb(true)
                end
            end
        end
    end
end)

RegisterServerEvent("r3_tasking:finishTask")
AddEventHandler("r3_tasking:finishTask", function(task)
    local src = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(src)
    for _, v in pairs(Config.Tasks) do
        if v.TaskName == task then
            local affectedRows = MySQL.update.await('UPDATE tasks SET finished = ? WHERE (identifier = ? AND taskname = ?)', {"true", xPlayer.identifier, v.TaskName})
            print("Görevi Başarıyla tamamladınız!")
            -- Notification Message
            if v.RewardItem ~= nil then
                -- Add Inventory Item Trigger
            else
                -- Add Money Trigger
            end     
        end
    end
end)