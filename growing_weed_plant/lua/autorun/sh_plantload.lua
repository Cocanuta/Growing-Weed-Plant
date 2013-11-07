GWPlant = {}

include("plant_settings.lua")
AddCSLuaFile("plant_settings.lua")
local Values = {}
Values.AllowedJobs = GWPlant.AllowedJobs or false
Values.SeedName = GWPlant.SeedName or "Seed"
Values.PotName = GWPlant.PotName or "Pot Plant"
Values.SeedPrice = GWPlant.SeedPrice or 300
Values.PlantPrice = GWPlant.PlantPrice or 300
Values.SeedMax = GWPlant.MaxSeeds or 3
Values.PotMax = GWPlant.MaxPots or 3

-- Seed
Values.SeedTable = {
    ent = "seed_weed",
    model = "models/props_lab/crematorcase.mdl",
    price = Values.SeedPrice,
    max = Values.SeedMax,
    cmd = "buyseed"
}

-- Plant
Values.PlantTable = {
    ent = "weed_plant",
    model = "models/props_lab/crematorcase.mdl",
    price = Values.PlantPrice,
    max = Values.PotMax,
    cmd = "buyplant"
}

hook.Add("Initialize", "LoadEntities", function()
    DarkRP.createEntity(Values.SeedName, Values.SeedTable)
    DarkRP.createEntity(Values.PotName, Values.PlantTable)
end)