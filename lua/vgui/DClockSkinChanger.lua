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

	self.clockimage = "clock/clock2.png"
	self.timezone = 0
	self.time = os.date("*t")

	self.skins = table.Copy( file.Find( "materials/clock/*.png", "GAME" ) )
	self.image = 2
	self.cvar = ""

	self.right = vgui.Create("DButton", self)
	self.right.Parent = self
	self.right.DoClick = function(self) self.Parent:PressedRightButton() end
	self.left = vgui.Create("DButton", self)
	self.left.Parent = self
	self.left.DoClick = function(self) self.Parent:PressedLeftButton() end

end

--[[---------------------------------------------------------
NAME: IsDown()
desc: 
-----------------------------------------------------------]]
function PANEL:IsDown()



end

--[[---------------------------------------------------------
NAME: ConVar( cvar )
desc: 
-----------------------------------------------------------]]
function PANEL:ConVar( cvar )

	 self.cvar = cvar

end

--[[---------------------------------------------------------
NAME: PressedRightButton()
desc: 
-----------------------------------------------------------]]
function PANEL:PressedRightButton()

	self.image = self.image + 1

	if( self.cvar != "" ) then
		
		RunConsoleCommand (self.cvar, self.image )

	end

end

--[[---------------------------------------------------------
NAME: PressedLeftButton()
desc: 
-----------------------------------------------------------]]
function PANEL:PressedLeftButton()

	self.image = self.image - 1

	if( self.cvar != "" ) then

	RunConsoleCommand (self.cvar, self.image )

	end

end

--[[---------------------------------------------------------
NAME: SetClockImage( img )
desc: 
-----------------------------------------------------------]]
function PANEL:SetClockImage( img )

end

--[[---------------------------------------------------------
NAME: SetTimeZone( value )
desc: 
-----------------------------------------------------------]]
function PANEL:SetTimeZone( value )

	self.timezone = value

end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

self.time = os.date("*t")

	if( self.image <= 0) then

		self.image = #self.skins
		if( self.cvar != "" ) then

		RunConsoleCommand (self.cvar,  #self.skins )

		end

	elseif( self.image > #self.skins ) then

		self.image = 1
		if( self.cvar != "" ) then

		RunConsoleCommand (self.cvar,  #self.skins )

		end
	end

end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial( Material("clock/" .. self.skins[self.image]))
	surface.DrawTexturedRect(0,0,w,h)
	
end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

	surface.SetDrawColor(0,0,0,255)
	surface.SetMaterial( Material("clock/color/Zeiger.png"))
	surface.DrawTexturedRectRotated( w/2,h/2, 100, 2, -1*self.time["sec"]*6+90 )

	surface.SetDrawColor(0,0,0,255)
	surface.SetMaterial( Material("clock/color/Zeiger.png"))
	surface.DrawTexturedRectRotated(  w/2,h/2, 100, 3, -1*self.time["min"]*6+90 )

	surface.SetDrawColor(0,0,0,255)
	surface.SetMaterial( Material("clock/color/Zeiger.png"))
	surface.DrawTexturedRectRotated(  w/2,h/2, 60,4, (-1*(self.time["hour"]+self.timezone))*30+90 )

end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )
		
		self.right:SetPos( w - 10, h-h*0.125)
		self.right:SetSize( 10,h*0.125)
		self.right:SetText(">")
		self.left:SetPos(0, h-h*0.125)
		self.left:SetSize(10,h*0.125)
		self.left:SetText("<")
		if( self.cvar != "" ) then
		self.image = GetConVarNumber( self.cvar )
		end

end

derma.DefineControl( "DClockSkinChanger", "A Clock app", PANEL, "DPanel" )

