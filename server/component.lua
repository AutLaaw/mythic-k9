local Config = require 'shared/config'
local framework = Config.K9.framework

AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
function RetrieveComponents()
	Fetch = exports[framework]:FetchComponent("Fetch")
	Logger = exports[framework]:FetchComponent("Logger")
	Jobs = exports[framework]:FetchComponent("Jobs")
	Inventory = exports[framework]:FetchComponent("Inventory")
end

AddEventHandler("Core:Shared:Ready", function()
	exports[framework]:RequestDependencies("K9", {
		"Fetch",
		"Logger",
		"Jobs",
		"Inventory",
	}, function(error)
		if #error > 0 then
			exports[framework]:FetchComponent("Logger"):Critical("K9", "Failed To Load All Dependencies")
			return
		end
		RetrieveComponents()
	end)
end)
