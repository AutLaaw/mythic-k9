local Config = require 'shared/config'
local framework = Config.K9.framework
local frameworkName = Config.K9.framework .. "-base"

AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
function RetrieveComponents()
	Fetch = exports[frameworkName]:FetchComponent("Fetch")
	Logger = exports[frameworkName]:FetchComponent("Logger")
	Jobs = exports[frameworkName]:FetchComponent("Jobs")
	Inventory = exports[frameworkName]:FetchComponent("Inventory")
end

AddEventHandler("Core:Shared:Ready", function()
	exports[frameworkName]:RequestDependencies("K9", {
		"Fetch",
		"Logger",
		"Jobs",
		"Inventory",
	}, function(error)
		if #error > 0 then
			exports[frameworkName]:FetchComponent("Logger"):Critical("K9", "Failed To Load All Dependencies")
			return
		end
		RetrieveComponents()
	end)
end)
