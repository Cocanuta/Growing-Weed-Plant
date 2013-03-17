AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/nater/weedplant_pot.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	self.isUsable = false
	self.isPlantable = true
	self.damage = 60
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if self.damage <= 0 then
		self:Remove()
	end
end

function ENT:Use()
	if self.isUsable == true then
		self.isUsable = false
		self.isPlantable = true
		self:SetModel("models/nater/weedplant_pot_dirt.mdl")
		local SpawnPos = self:GetPos()
		if PLANT_CONFIG.Outcome==1 then
			local WeedBag = ents.Create("durgz_weed")
			if !IsValid(WeedBag) then 
				DarkRPCreateMoneyBag(SpawnPos + Vector(0,0,15), PLANT_CONFIG.MoneyAmount or 150)
				PrintMessage( HUD_PRINTTALK, "[Weed Plant] Drugzmod isn't installed correctly!")
				PrintMessage( HUD_PRINTTALK, "[Weed Plant] Set Outcome to 2 in order to print money instead")
				return false
			end
			WeedBag:SetPos(SpawnPos + Vector(0,0,15))
			WeedBag:Spawn()
		else
			DarkRPCreateMoneyBag(SpawnPos + Vector(0,0,15), PLANT_CONFIG.MoneyAmount or 150)
		end
	end
end

local function Stages(self)
	if !IsValid(self) then return end
	-- Timers
	timer.Simple(tonumber(PLANT_CONFIG.Stage1) or 30, function()
		if !IsValid(self) then return end
		self:SetModel("models/nater/weedplant_pot_growing1.mdl")
		timer.Simple(tonumber(PLANT_CONFIG.Stage2) or 30, function()
			if !IsValid(self) then return end
			self:SetModel("models/nater/weedplant_pot_growing2.mdl")
			timer.Simple(tonumber(PLANT_CONFIG.Stage3) or 30, function()
				if !IsValid(self) then return end
				self:SetModel("models/nater/weedplant_pot_growing3.mdl")
				timer.Simple(tonumber(PLANT_CONFIG.Stage4) or 30, function()
					if !IsValid(self) then return end
					self:SetModel("models/nater/weedplant_pot_growing4.mdl")
					timer.Simple(tonumber(PLANT_CONFIG.Stage5) or 30, function()
						if !IsValid(self) then return end
						self:SetModel("models/nater/weedplant_pot_growing5.mdl")
						timer.Simple(tonumber(PLANT_CONFIG.Stage6) or 30, function()
							if !IsValid(self) then return end
							self:SetModel("models/nater/weedplant_pot_growing6.mdl")
							timer.Simple(tonumber(PLANT_CONFIG.Stage7) or 30, function()
								if !IsValid(self) then return end
								self:SetModel("models/nater/weedplant_pot_growing7.mdl")
								self.isUsable = true
							end)
						end)
					end)
				end)
			end)
		end)
	end)
end

function ENT:Touch(hitEnt)
	if hitEnt:GetClass() == "seed_weed" and self.isPlantable == true then
		self.isPlantable = false			
		hitEnt:Remove()
		self:SetModel("models/nater/weedplant_pot_planted.mdl")
		Stages(self)
	end
end