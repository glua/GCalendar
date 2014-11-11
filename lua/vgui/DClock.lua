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


end

--[[---------------------------------------------------------
NAME: IsDown()
desc: 
-----------------------------------------------------------]]
function PANEL:IsDown()

end

--[[---------------------------------------------------------
NAME: SetClockImage( img )
desc: 
-----------------------------------------------------------]]
function PANEL:SetClockImage( img )

self.clockimage = img


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

end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(255,255,255,255)
	surface.SetMaterial( Material(self.clockimage))
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

end

derma.DefineControl( "DClock", "A Clock app", PANEL, "DPanel" )

