local Config = require 'shared/config'

AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
local function RetrieveComponents()
    Notification = exports["mythic-base"]:FetchComponent("Notification")
    Jobs = exports["mythic-base"]:FetchComponent("Jobs")
    ListMenu = exports["mythic-base"]:FetchComponent("ListMenu")
    Keybinds = exports["mythic-base"]:FetchComponent("Keybinds")
    if Config.K9.target == "mythic" then
        Targeting = exports["mythic-base"]:FetchComponent("Targeting")
    end
end

AddEventHandler("Core:Shared:Ready", function()
    local dependencies = {
        "Notification",
        "Jobs",
        "ListMenu",
        "Keybinds"
    }
    if Config.K9.target == "mythic" then
        table.insert(dependencies, "Targeting")
    end

    exports["mythic-base"]:RequestDependencies("K9", dependencies, function(error)
        if #error > 0 then
            return
        end
        RetrieveComponents()
        InitK9Ped()
        RegisterKeyBinds()
    end)
end)
