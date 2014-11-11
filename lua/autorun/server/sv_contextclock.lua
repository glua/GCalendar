
--[[   _                                

______ _   __      _                _           
|  _  \ | / /     | |              | |          
| | | | |/ /  __ _| | ___ _ __   __| | ___ _ __ 
| | | |    \ / _` | |/ _ \ '_ \ / _` |/ _ \ '__|
| |/ /| |\  \ (_| | |  __/ | | | (_| |  __/ |   
|___/ \_| \_/\__,_|_|\___|_| |_|\__,_|\___|_|   
                                               
					|Royal|

--]]

util.AddNetworkString( "servertime"  )
util.AddNetworkString( "CreateEvent"  )
util.AddNetworkString( "IncomingEvent" )

--[[---------------------------------------------------------
NAME: SendTimeZone( p )
desc: Send servertime to player
-----------------------------------------------------------]]
function SendTimeZone( p )

local time = os.date("*t")["hour"]

    net.Start( "servertime" )
	net.WriteString( time )
	net.Send( p )

end
hook.Add("PlayerAuthed","timezone", SendTimeZone )

--[[---------------------------------------------------------
NAME: CreateEvent
desc: 
-----------------------------------------------------------]]
net.Receive( "CreateEvent", function( len, pl )

	local ent = net.ReadEntity()
	
	if(pl:IsAdmin() ) then

		net.Start( "IncomingEvent" )
		net.WriteTable( net.ReadTable() )
		net.Send( ent )

	else
		// no access
	end
end )

--[[---------------------------------------------------------
NAME: N/A
desc: loads texture`s
-----------------------------------------------------------]]
for k,v in ipairs(file.Find( "materials/clock/*.png", "GAME" ) ) do

	resource.AddFile( "materials/clock/" .. v .. "" )

end

resource.AddFile( "materials/clock/color/check.png" )
resource.AddFile( "materials/clock/Zeiger.png" )
resource.AddFile( "materials/clock/Event/star.png" )