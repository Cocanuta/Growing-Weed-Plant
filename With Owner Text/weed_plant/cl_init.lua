include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	local owner = self:Getowning_ent()
	owner = (IsValid(owner) and owner:Nick()) or "Unknown"

	surface.SetFont("HUDNumber5")
	local TextWidth = surface.GetTextSize("Weed Plant")
	local TextWidth2 = surface.GetTextSize(owner)

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	local TextAng = Ang
	cam.Start3D2D(Pos + Ang:Right() * -30, TextAng, 0.2)
		draw.WordBox(1, -TextWidth*0.5 + 5, -60, "Weed Plant", "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
		draw.WordBox(1, -TextWidth2*0.5 + 5, -14, owner, "HUDNumber5", Color(140, 0, 0, 100), Color(255,255,255,255))
	cam.End3D2D()
	
	if self.Entity:GetNWBool("Usable") == true then
		self.Entity:SetColor( Color( 0, 255, 0, 255) )
	else
		self.Entity:SetColor( Color( 255, 255, 255, 255) )
	end
end