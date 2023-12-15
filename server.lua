local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('joinstaff', "Login as staff", {}, false, function(source)
    local src = source
    if getStaffStatus(src) then return QBCore.Functions.Notify(src, 'Already joined Staff duty', "info") end
    SetResourceKvp('staff:'..src, true)
    QBCore.Functions.Notify(src, 'Joined Staff duty', "info")

end, 'admin')

QBCore.Commands.Add('leavestaff', "Logout as staff", {}, false, function(source)
    local src = source
    if getStaffStatus(src) then
        QBCore.Functions.Notify(src, 'Left Staff duty', "info")

        DeleteResourceKvp('staff:'..src)
    end
end, 'admin')

QBCore.Commands.Add('checkstaff', "Check online staff", {}, false, function(source)
    local src = source
    local kvpHandle = StartFindKvp('staff:')
    local key = nil

    print('---- Online Staff ----')
    repeat
        key = FindKvp(kvpHandle)
        if not key then EndFindKvp(kvpHandle) QBCore.Functions.Notify(src, 'No Staff on duty', 'info', 7500) return end

        local playerId = key:gsub('staff:', "")
        local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
        QBCore.Functions.Notify(src, 'Check your F8 console', "info")

        print(Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname .. ' [ ' ..Player.PlayerData.citizenid .. ' ]')

    until not key
    EndFindKvp(kvpHandle)
end, 'admin')

---@param player source
function getStaffStatus(player)
    local result = GetResourceKvpString('staff:'..player)
    return result
end

exports('getStaffStatus', getStaffStatus)

AddEventHandler('playerDropped', function ()
    DeleteResourceKvp('staff:'..source)
end)