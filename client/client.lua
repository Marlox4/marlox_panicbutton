local cooldown = false
RegisterNetEvent('marlox_markers')
AddEventHandler('marlox_markers', function(coord)
    SetNewWaypoint(coord.x, coord.y)  
    local blip = AddBlipForCoord(coord.x, coord.y, coord.z)
    SetBlipSprite(blip, Config.Panicbutton.BlipID)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U("PanicButtonBlipName"))
    EndTextCommandSetBlipName(blip)
    SetTimeout(Config.Panicbutton.DeletePanikbuttonBlip, function()
        RemoveBlip(blip)
    end)
end)  
RegisterCommand(Config.Panicbutton.Name, function()
    if not cooldown then
        cooldown = true
        sendButton()
        CreateThread(function()
            Wait(5 * 60000)
            cooldown = false
        end)
    else
        ESX.ShowNotification(_U("PanicButtonAlways"))
    end
end)


function sendButton()
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    TriggerServerEvent("marlox_sendButton", playerCoords)
end

if Config.Panicbutton.KEY ~= false then RegisterKeyMapping(Config.Panicbutton.Name, _U("Press_Panic_Button"), 'keyboard', Config.Panicbutton.KEY) end