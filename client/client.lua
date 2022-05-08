

local cooldown = false

CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.esxgetSharedObjectevent, function(obj) ESX = obj end)
        Wait(0)
    end     
    RegisterNetEvent('marlox_markers')
    AddEventHandler('marlox_markers', function(Data)
        SetNewWaypoint(Data.x, Data.y)  
        local blip = AddBlipForCoord(Data.x, Data.y, Data.z)
        SetBlipSprite(blip, Config.Panikbutton.BlipID)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U("PanikbuttonBlipName"))
        EndTextCommandSetBlipName(blip)
        Citizen.SetTimeout(Config.Panikbutton.DeletePanikbuttonBlip, function()
            RemoveBlip(blip)
        end)
    end)  
    RegisterCommand(Config.Panikbutton.Name, function()
        if not cooldown then
            cooldown = true
            SENDBOTTUM()
            Wait(5 * 60000)
            cooldown = false
        else
            ESX.ShowNotification(_U("Panicbuttonalways"))
        end
    end)


    function SENDBOTTUM()
        local playerCoords = GetEntityCoords(GetPlayerPed(-1), true)
        local Data = {x = playerCoords.x,y = playerCoords.y,z = playerCoords.z }
        TriggerServerEvent("marlox_sendbottum",Data)
    end

if Config.Panikbutton.KEY ~= false then RegisterKeyMapping(Config.Panikbutton.Name, Config.Panikbutton.Text, 'keyboard', Config.Panikbutton.KEY) end
end)