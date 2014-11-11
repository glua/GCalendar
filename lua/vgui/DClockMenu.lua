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

self.pos = {}
self.aclose = true
self:MakePopup()

end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(42,42,42,255)
	surface.DrawRect(0,0,w,h)
	surface.SetDrawColor(250,250,250,255)
	surface.DrawRect(10,10,w-20,h-20)

end

--[[---------------------------------------------------------
NAME: AutoClose( bool )
desc: 
-----------------------------------------------------------]]
function PANEL:AutoClose( bool )

	self.aclose = bool

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )


end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

	local x1,y1 = self:GetPos()
	if( !self:IsActive() ) then end
	local x,y = input.GetCursorPos( )

	if( !self:IsInRange( x, y, x1, y1) and input.IsMouseDown( 107 ) or !g_ContextMenu:IsVisible()  ) then
		if( self.aclose ) then
			self:Close()
		elseif( self.aclose and !g_ContextMenu:IsVisible()) then
			self:Close()
		end
	else
	
	end 
end

--[[---------------------------------------------------------
NAME: IsInRange( x, y, x1, y1  ) 
desc: Is mousecursor in range
-----------------------------------------------------------]]
function PANEL:IsInRange( x, y, x1, y1  ) 

	if( x > x1 and x < x1 + self:GetWide() and y > y1 and y < y1 + self:GetTall() ) then
		return true
	else
		return false
	end

end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )


end

--[[---------------------------------------------------------
NAME: Close()
desc: 
-----------------------------------------------------------]]
function PANEL:Close()

	self:Remove()

end

--[[---------------------------------------------------------
NAME: IsActive()
desc: 
-----------------------------------------------------------]]
function PANEL:IsActive()

	if ( self:HasFocus() ) then return true end
	if ( vgui.FocusedHasParent( self ) ) then return true end
	
	return false

end

derma.DefineControl( "DClockMenu", "A Menu App", PANEL, "DPanel" )


