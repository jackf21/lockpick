Citizen.CreateThread(function()
    local l_key = 182
    while true do 
        Citizen.Wait(0)
        if IsControlJustReleased(1, l_key) then 
            unlockNearestCar()
        end
    end
end)

function Alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function text(content) 
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(1.9,1.9)
    SetTextEntry("STRING")
    AddTextComponentString(content)
    DrawText(0.9,0.7)
end

RegisterNetEvent('InteractSound_CL:PlayWithinDistance')
AddEventHandler('InteractSound_CL:PlayWithinDistance', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1))
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    if(distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        })
    end
end)


function  unlockNearestCar()
    --[[Finding the closest vehicle in a 2m radius]]--
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.0, 0, 70)
    local farvehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 10.0, 0, 70)
    if vehicle then
        if DoesEntityExist(vehicle) then
            if GetVehicleDoorLockStatus(vehicle) ~= 1 then

                local time = 0
                while time < 1000 do
                    vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.0, 0, 70)
                    if DoesEntityExist(vehicle) then
                        Citizen.Wait(0)
                        time = time + 1
                        text(math.ceil(time / 100))
                    else
                        return
                    end
                end

                SetVehicleDoorsLocked(vehicle, 1)
                SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                Alert("Vehicle unlocked")
                return
            else
                Alert("Vehicle already unlocked")
                return
            end
        elseif DoesEntityExist(farvehicle) then
            Alert("Get closer to the vehicle")
            return
        else
            Alert("No vehicle found")
            return
        end
    end
end