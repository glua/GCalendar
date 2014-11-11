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
	self.initialtime = CurTime()
	self.closetime = 5
	self.text = ""
	self.image = ""
	self.updown = true
	self.lang = {}
	self.event = true
	self.close = vgui.Create("DButton",self)
	self.close.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "WindowCloseButton", panel, w, h ) end
end

--[[---------------------------------------------------------
NAME: AllowEvent( bool )
desc: 
-----------------------------------------------------------]]
function PANEL:AllowEvent( bool )

	self.event = bool

end

--[[---------------------------------------------------------
NAME: SetLanguage( lang )
desc: 
-----------------------------------------------------------]]
function PANEL:SetLanguage( lang )

	self.lang = table.Copy(lang)

end

--[[---------------------------------------------------------
NAME: SetUpDown( bool )
desc: 
-----------------------------------------------------------]]
function PANEL:SetUpDown( bool )

	self.updown = bool

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
	if( self.event ) then
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial( Material("clock/Event/star.png"))
		surface.DrawTexturedRect(20,20,w/3,h-40)
	end
end

--[[---------------------------------------------------------
NAME: SetCloseTime ( int ) 
desc: 
-----------------------------------------------------------]]
function PANEL:SetCloseTime ( int ) 

	self.closetime = int

end

--[[---------------------------------------------------------
NAME: SetText( text )
desc: 
-----------------------------------------------------------]]
function PANEL:SetText( text )

	self.text = text

end

--[[---------------------------------------------------------
NAME: SetImage( img )
desc: 
-----------------------------------------------------------]]
function PANEL:SetImage( img )

	self.image = img

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )
	if( self.event ) then
		draw.SimpleText(   self.text , "DermaDefault", w/2+50, h/2, Color(0,0,0,255), 1, 1 )
	else
		draw.SimpleText(   self.text , "DermaDefault", w/2, h/3+2, Color(0,0,0,255), 1, 1 )
	end
end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()
if(!self.event) then return end
	local x1,y1 = self:GetPos()

	if( CurTime() > self.initialtime + self.closetime ) then
		self:Close()
	end
	if( self.updown ) then
		if( y1 < 0 and math.Round(self.initialtime + self.closetime - CurTime()) > 4 ) then
			self:SetPos( x1, y1 + 4)
		elseif( (self.initialtime + self.closetime - CurTime()) < 4 ) then
			self:SetPos( x1, y1 - 4)
		end
	elseif( !self.updown ) then
		if( y1 + self:GetTall() > ScrH() and math.Round(self.initialtime + self.closetime - CurTime()) > 4 ) then
			self:SetPos( x1, y1 - 4)
		elseif( (self.initialtime + self.closetime - CurTime()) < 4 ) then
			self:SetPos( x1, y1 + 4)
		end
	end
end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	if( !self.event ) then
		self:MakePopup()
		self.close:SetPos(w-40,8)
		self.close:SetSize(31,31)
		self.close:SetText("")
		self.close.DoClick = function( btn ) 
			 self:Close()
		 end
	else
		self.close:Remove()
	end
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

derma.DefineControl( "DEvent", "A Menu App", PANEL, "DPanel" )


