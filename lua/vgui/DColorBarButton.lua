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

	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )
	self:SetText("")
	self:SetCursor( "hand" )
	self.color = Color(0,0,0,0)
	self.selected = false
	
end

--[[---------------------------------------------------------
NAME: SetColor( col )
desc: 
-----------------------------------------------------------]]
function PANEL:SetColor( col )

	self.color = col

end

--[[---------------------------------------------------------
NAME: IsSelected()
desc: 
-----------------------------------------------------------]]
function PANEL:IsSelected()

	return self.selected

end

--[[---------------------------------------------------------
NAME: SetSelected( b )
desc: 
-----------------------------------------------------------]]
function PANEL:SetSelected( b )

	self.selected = b

end

--[[---------------------------------------------------------
NAME: GetColor()
desc: 
-----------------------------------------------------------]]
function PANEL:GetColor()

	return self.color 

end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(0,0,w,h)
	surface.SetDrawColor( self.color )
	surface.DrawRect(1,1,w-2,h-2)

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

	if( self.selected ) then
		
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial( Material("clock/color/check.png") )
		surface.DrawTexturedRect(0,0,w,h)

	else

	end
end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

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

	if( self.selected ) then
		self:SetSelected(false)
	else
		self:SetSelected(true)
	end
end

derma.DefineControl( "DColorBarButton", "Kalender Button app", PANEL, "DLabel" )