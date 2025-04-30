local Config = require 'shared/config'
local framework = Config.K9.framework
local frameworkName = Config.K9.framework .. "-base"

AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
local function RetrieveComponents()
    Notification = exports[frameworkName]:FetchComponent("Notification")
    Jobs = exports[frameworkName]:FetchComponent("Jobs")
    ListMenu = exports[frameworkName]:FetchComponent("ListMenu")
    Keybinds = exports[frameworkName]:FetchComponent("Keybinds")
    if Config.K9.target == "mythic" or Config.K9.target == "sandbox" then
        Targeting = exports[frameworkName]:FetchComponent("Targeting")
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

    exports[frameworkName]:RequestDependencies("K9", dependencies, function(error)
        if #error > 0 then
            return
        end
        RetrieveComponents()
        InitK9Ped()
        RegisterKeyBinds()
    end)
end)
