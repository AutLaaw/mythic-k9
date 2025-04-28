local Config = require 'shared/config'
local framework = Config.K9.framework

AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
local function RetrieveComponents()
    Notification = exports[framework]:FetchComponent("Notification")
    Jobs = exports[framework]:FetchComponent("Jobs")
    ListMenu = exports[framework]:FetchComponent("ListMenu")
    Keybinds = exports[framework]:FetchComponent("Keybinds")
    if Config.K9.target == "mythic" or Config.K9.target == "sandbox" then
        Targeting = exports[framework]:FetchComponent("Targeting")
    end
end

AddEventHandler("Core:Shared:Ready", function()
    local dependencies = {
        "Notification",
        "Jobs",
        "ListMenu",
        "Keybinds"
    }
    if Config.K9.target == "mythic" or Config.K9.target == "sandbox" then
        table.insert(dependencies, "Targeting")
    end

    exports[framework]:RequestDependencies("K9", dependencies, function(error)
        if #error > 0 then
            return
        end
        RetrieveComponents()
        InitK9Ped()
        RegisterKeyBinds()
    end)
end)
