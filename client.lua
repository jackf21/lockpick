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

function  unlockNearestCar()
    --[[Finding the closest vehicle in a 2m radius]]--
    local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.0, 0, 70)
    if vehicle then
        if DoesEntityExist(vehicle) then
            if GetVehicleDoorLockStatus(vehicle) ~= 1 then

                --[[Playing the lockpick animation on the player]]--
                Citizen.CreateThread(function()
                    local pid = PlayerPedId()
                    RequestAnimDict("random")
                    RequestAnimDict("random@arrests")
                    RequestAnimDict("random@arrests@busted")
                    while (not HasAnimDictLoaded("random@arrests@busted")) do Citizen.Wait(0) end
                    TaskPlayAnim(pid,"random@arrests","idle_2_hands_up",1.0,-1.0, 5000, 0, 1, true, true, true)
                end)

                SetVehicleDoorsLocked(vehicle, 1)
                SetVehicleDoorsLockedForPlayer(vehicle, PlayerId(), false)
                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                return
            else
                Alert("Vehicle already unlocked")
                return
            end
        end
    else
        Alert("No vehicle found")
        return
    end
end