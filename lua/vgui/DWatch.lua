--[[                                  
______ _    _       _       _     
|  _  \ |  | |     | |     | |    
| | | | |  | | __ _| |_ ___| |__  
| | | | |/\| |/ _` | __/ __| '_ \ 
| |/ /\  /\  / (_| | || (__| | | |
|___/  \/  \/ \__,_|\__\___|_| |_|

               |Royal|             
--]]

PANEL = {}

--[[---------------------------------------------------------
NAME: Init()
desc: 
-----------------------------------------------------------]]
function PANEL:Init()

self.timezone = 0
self.lang = {}

end

--[[---------------------------------------------------------
NAME: SetLanguage( lang )
desc: 
-----------------------------------------------------------]]
function PANEL:SetLanguage( lang )

	self.lang = table.Copy(lang)

end

--[[---------------------------------------------------------
NAME: SetTimeZone( value )
desc: 
-----------------------------------------------------------]]
function PANEL:SetTimeZone( value )

	self.timezone = value

end

--[[---------------------------------------------------------
NAME: NiceTime( time )
desc: 
-----------------------------------------------------------]]
function PANEL:NiceTime( time )

	local sec = time["sec"]
	local min = time["min"]
	local hour = time["hour"] + self.timezone
	local add = " am"
	local string = ""
	if( self.lang.timeadd ) then
		if ( hour > 12 ) then
			hour = hour - 12
			add = " pm"
		elseif( hour == 0 ) then
			hour = 12
			add = " am"
		end
		if( sec < 10 ) then
			sec = "0"..time["sec"]
		end
	
		if( min < 10 ) then
			min = "0"..time["min"]
		end
		string = (hour .. ":" .. min .. ":" .. sec .. "" .. add .. "")
	else
		
		if( sec < 10 ) then
			sec = "0"..time["sec"]
		end
	
		if( min < 10 ) then
			min = "0"..time["min"]
		end
	
		if( hour < 10 ) then
			hour = "0"..time["hour"] + self.timezone
		end
		string = (hour .. ":" .. min .. ":" .. sec .. "")
	end
	return string
end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	draw.SimpleText(  self:NiceTime( os.date("*t") ), "DermaDefault", w/2, h/2, Color(0,0,0,255), 1, 1 )

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h)
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h)
		
end

derma.DefineControl( "DWatch", "A Watch app", PANEL, "DPanel" )
