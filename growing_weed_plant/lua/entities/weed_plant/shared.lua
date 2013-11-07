ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Growing Weed Plant"
ENT.Author = "ms333 and other"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Int",1,"Stage")
	self:NetworkVar("Entity",0,"owning_ent")
end