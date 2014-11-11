--[[   _                                

______ _   __      _                _           
|  _  \ | / /     | |              | |          
| | | | |/ /  __ _| | ___ _ __   __| | ___ _ __ 
| | | |    \ / _` | |/ _ \ '_ \ / _` |/ _ \ '__|
| |/ /| |\  \ (_| | |  __/ | | | (_| |  __/ |   
|___/ \_| \_/\__,_|_|\___|_| |_|\__,_|\___|_|   
                                               
					|Royal|

--]]

PANEL = {}

--[[---------------------------------------------------------
NAME: Init()
desc: 
-----------------------------------------------------------]]
function PANEL:Init()

	self.select = false
	self.text = ""
	self.addtext = ""
	self.color = Color(48,196,255,255)
	self.xa = 0

end

--[[---------------------------------------------------------
NAME: IsDown()
desc: 
-----------------------------------------------------------]]
function PANEL:IsDown()

	return self.Depressed

end

--[[---------------------------------------------------------
NAME: GetNodePos()
desc: 
-----------------------------------------------------------]]
function PANEL:GetNodePos()

local a,b = self:GetPos()
	return { x = a, y = b }

end

--[[---------------------------------------------------------
NAME: EnableDeleteButton()
desc: 
-----------------------------------------------------------]]
function PANEL:EnableDeleteButton()


	if (self.DBut) then return end
	
	self.DBut = vgui.Create( "DImageButton", self )
	self.DBut.Parent = self
	self.DBut.DoClick = function( self ) self.Parent:Delete() end


end

--[[---------------------------------------------------------
NAME: SetColor( color )
desc: 
-----------------------------------------------------------]]
function PANEL:SetColor( color )

	self.color = color

end

--[[---------------------------------------------------------
NAME: IsSelected()
desc: 
-----------------------------------------------------------]]
function PANEL:IsSelected()

	return self.select

end

--[[---------------------------------------------------------
NAME: Select( bool )
desc: 
-----------------------------------------------------------]]
function PANEL:Select( bool )

	self.select = bool

end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

	if( self:IsHovered( ) and  input.IsMouseDown( 107 ) ) then
		self:Select( true )
	end
end

--[[---------------------------------------------------------
NAME: SetText( text )
desc: 
-----------------------------------------------------------]]
function PANEL:SetText( text )

	self.text = text

end

--[[---------------------------------------------------------
NAME: SetAddText( text )
desc: 
-----------------------------------------------------------]]
function PANEL:SetAddText( text )

	self.addtext = text

end

--[[---------------------------------------------------------
NAME: Delete()
desc: 
-----------------------------------------------------------]]
function PANEL:Delete()

end

--[[---------------------------------------------------------
NAME: OpenEditMenu()
desc: 
-----------------------------------------------------------]]
function PANEL:OpenEditMenu()

end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(42,42,42,255)
	surface.DrawOutlinedRect(0,0,w,h)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawRect(1,1,w-2,h-2)

		local sizet = surface.GetTextSize( self.text .. " " )
	local sizea = surface.GetTextSize( self.addtext )
		if( self.select ) then
				surface.SetDrawColor(self.color)
				surface.DrawRect(1,1,w-2,h-2)
		else

		end
	self.xa = self.xa - 0.5
		if( self.xa <= 0 - (sizet+sizea)  ) then
				self.xa = w + 15
		end
		if( (sizet+sizea)+16 > w ) then
			draw.SimpleText(  self.text .. " " .. self.addtext .. "" , "DermaDefault", self.xa, h/2, Color(0,0,0,255), 0, 1 )
		else
			draw.SimpleText(  self.text .. " " .. self.addtext .. "" , "DermaDefault", w/2, h/2, Color(0,0,0,255), 1, 1 )
		end
end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )
		
		if(self.DBut) then
			self.DBut:SetPos(w-20,h-20)
			self.DBut:SetSize(16,16)
			self.DBut:SetImage("icon16/cross.png")
		end
end

--[[---------------------------------------------------------
NAME: PaintOver( w, h 
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

end

--[[---------------------------------------------------------
NAME: OnMousePressed( mousecode )
desc: 
-----------------------------------------------------------]]
function PANEL:OnMousePressed( mousecode )

end

--[[---------------------------------------------------------
NAME: OnMouseReleased( mousecode )
desc: 
-----------------------------------------------------------]]
function PANEL:OnMouseReleased( mousecode )

end


local PANEL = derma.DefineControl( "DKalenderView_Node", "Kalender Node", PANEL, "DPanel" )
