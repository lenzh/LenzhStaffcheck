A simple login for staff to use commands.

this is not a plug and play and your server sided commands have to be adjusted with the export like

export is exports.LenzhStaffcheck:getStaffStatus(src) this will either put true or false if not logged in as staff

commands are
/joinstaff /leavestaff /checkstaff

```

QBCore.Commands.Add("bring", "Bring player (STAFF)", {}, true, function(source, args)
    local src = source

-- this line is for checking if you have logged in to staff duty or not make sure to paste either the src if local is there or source

    if not exports.LenzhStaffcheck:getStaffStatus(src) then return QBCore.Functions.Notify(src, 'You are not on staff duty, login to use this command', "info") end

------------

    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    if args[1] ~= nil then
        local target = GetPlayerPed(args[1])
        SetEntityCoords(target, coords)
    end
end, 'admin')
```
