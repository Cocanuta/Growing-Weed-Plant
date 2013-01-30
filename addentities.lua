--Add these into your addentities.lua file
--I suggest changing the prices to suit your needs

AddEntity("Pot Plant", {
 ent = "weed_plant",
 model = "models/nater/weedplant_pot_planted.mdl",
 price = 75,
 max = 10, 
 cmd = "/buyweed",
})

AddEntity("Weed Seed", {
 ent = "seed_weed",
 model = "models/props_junk/watermelon01.mdl",
 price = 150,
 max = 15, 
 cmd = "/buyseed",
})

--OR, if you're using the Cannabis Entities instead (there is no real difference; it's just personal preference)

AddEntity("Pot Plant", {
 ent = "cannabis_plant",
 model = "models/nater/weedplant_pot_planted.mdl",
 price = 75,
 max = 10, 
 cmd = "/buyweed",
})

AddEntity("Cannabis Seed", {
 ent = "seed_cannabis",
 model = "models/props_junk/watermelon01.mdl",
 price = 150,
 max = 15, 
 cmd = "/buyseed",
})