--Add these into your addentities.lua file
--I suggest changing the prices to suit your needs

AddEntity("Pot Plant", {
 ent = "weed_plant",
 model = "models/nater/weedplant_pot_planted.mdl",
 price = 75,
 max = 4, 
 cmd = "/buyweed",
})

AddEntity("Weed Seed", {
 ent = "seed_weed",
 model = "models/props_junk/watermelon01.mdl",
 price = 150,
 max = 8, 
 cmd = "/buyseed",
})
