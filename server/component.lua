AddEventHandler("K9:Shared:DependencyUpdate", RetrieveComponents)
function RetrieveComponents()
	Fetch = exports["mythic-base"]:FetchComponent("Fetch")
	Logger = exports["mythic-base"]:FetchComponent("Logger")
	Jobs = exports["mythic-base"]:FetchComponent("Jobs")
	Inventory = exports["mythic-base"]:FetchComponent("Inventory")
end

AddEventHandler("Core:Shared:Ready", function()
	exports["mythic-base"]:RequestDependencies("K9", {
		"Fetch",
		"Logger",
		"Jobs",
		"Inventory",
	}, function(error)
		if #error > 0 then
			exports["mythic-base"]:FetchComponent("Logger"):Critical("K9", "Failed To Load All Dependencies")
			return
		end
		RetrieveComponents()
	end)
end)
