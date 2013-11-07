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
	if IsValid(phys) then phys:Wake() end

	self.isReady = false
	self.isPlantable = true
	self.damage = 60
	self.magic = false
	timer.Simple(0, function()
		if self:GetStage() and self:GetStage()>0 then
			self:BeginStage(self:GetStage())
			self.isPlantable = false
		else
			self:SetStage(0)
		end
	end)
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if self.damage <= 0 then
		self:Remove()
	end
end

function ENT:Use(activator)
	if !IsValid(activator) or !activator:IsPlayer() or self.isReady != true then return end
	self.isReady = false
	self.isPlantable = true
	self:SetStage(0)
	self:SetModel("models/nater/weedplant_pot_dirt.mdl")
	local SpawnPos = self:GetPos()
	local OutputMoney = GWPlant.OutputAmount or 250
	self.magic = false
	if !GWPlant.OutputMoney then -- Make weed
		local WeedBag = ents.Create("durgz_weed")
		if !IsValid(WeedBag) then 
			activator:addMoney(OutputMoney)
			local currency = GAMEMODE.Config.currency or "$"
			if currency == "$" then
				DarkRP.notify(activator, 0, 4, "You've received "..currency..OutputMoney.." for looting the weed pot.")
			else
				DarkRP.notify(activator, 0, 4, "You've received "..OutputMoney..currency.." for looting the weed pot.")
			end
			PrintMessage( HUD_PRINTTALK, "[Weed Plant] Drugzmod isn't installed correctly!")
			PrintMessage( HUD_PRINTTALK, "[Weed Plant] Set GWPlant.OutputMoney to true to give money.")
			return false
		end
		WeedBag:SetPos(SpawnPos + Vector(0,0,15))
		WeedBag:Spawn()
	else -- Make money
		activator:addMoney(OutputMoney)
		local currency = GAMEMODE.Config.currency or "$"
		if currency == "$" then
			DarkRP.notify(activator, 0, 4, "You've received "..currency..OutputMoney.." for looting the weed pot.")
		else
			DarkRP.notify(activator, 0, 4, "You've received "..OutputMoney..currency.." for looting the weed pot.")
		end
	end
end

function ENT:Think()
	if self.magic then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() + Vector( 0 , 0, 15 ))
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("inflator_magic", effectdata)
	end
end

function ENT:BeginStage(stage)
	if stage < 1 then return end
	self:SetStage(stage)
	if stage == 7 then
		self:SetModel("models/nater/weedplant_pot_growing7.mdl")
		self.isReady = true
		self.magic = true
		return
	end
	if stage == 1 then
		self:SetModel("models/nater/weedplant_pot_planted.mdl")
		timer.Simple(tonumber(GWPlant.Stage1) or 30, function() if IsValid(self) then self:BeginStage(stage+1) end end)
		return
	end
	self:SetModel("models/nater/weedplant_pot_growing"..tostring(stage-1)..".mdl")
	timer.Simple(tonumber(GWPlant["Stage"..stage]) or 30, function() if IsValid(self) then self:BeginStage(stage+1) end end)
end

function ENT:StartTouch(hitEnt)
	if hitEnt:GetClass() == "seed_weed" and self.isPlantable == true then
		self.isPlantable = false			
		hitEnt:Remove()
		self:BeginStage(1)
	end
end
