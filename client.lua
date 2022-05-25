
ESX, flag = nil, true

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('task', function()
    ESX.TriggerServerCallback("r3_tasking:loadDatas", function(data)
        SendNUIMessage({ action = flag, data = data }) 
        SetNuiFocus(1, 1)
        flag = not flag  
        if (flag) then
            SetNuiFocus(0, 0)
        end
    end)
end)

-- Example Task

Citizen.CreateThread(function()
    
    ESX.TriggerServerCallback("r3_tasking:checkTask", function(result) 
        if result then
            local counter = 1
            local maxTime = 10 -- Saniye
            while counter < maxTime do 
                Citizen.Wait(0)
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    Citizen.Wait(1000)
                    counter = counter + 1
                    print(counter)
                end
            end
            TriggerServerEvent("r3_tasking:finishTask", "10 Saniye Herhangi Bir Araç Kullan")

        end
    end, "10 Saniye Herhangi Bir Araç Kullan")

    --ESX.TriggerServerCallback("r3_tasking:checkTask", function(result) 
    --    if result then
    --        -- Görev
    --    end
    --end, "Görev İsmi")
end)