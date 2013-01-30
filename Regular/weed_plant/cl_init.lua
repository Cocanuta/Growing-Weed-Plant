include("shared.lua")

function ENT:Draw()
if self.Entity:GetNWBool("Usable") == true then
		self.Entity:SetColor( Color( 0, 255, 0, 255) )
	else
		self.Entity:SetColor( Color( 255, 255, 255, 255) )
	end
	self.Entity:DrawModel()
end