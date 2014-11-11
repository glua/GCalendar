	
--[[   _                                

______ _   __      _                _           
|  _  \ | / /     | |              | |          
| | | | |/ /  __ _| | ___ _ __   __| | ___ _ __ 
| | | |    \ / _` | |/ _ \ '_ \ / _` |/ _ \ '__|
| |/ /| |\  \ (_| | |  __/ | | | (_| |  __/ |   
|___/ \_| \_/\__,_|_|\___|_| |_|\__,_|\___|_|   
                                               
					|Royal|

--]]

local LANG = {}
local L = {}
CreateClientConVar( "rc_clockleft", "2", true, false )
CreateClientConVar( "rc_clockright", "2", true, false )
--[[---------------------------------------------------------
English
-----------------------------------------------------------]]

L[1] = {
language = "GB",
lang = "languages",
send = "send",
example = "sample event",
eventname = "What",
eventtime = "When",
createevent = "Create event", 
settingsdates = "Date(short)",
settingsdatel = "Date(long)",
settingstimes = "time of day(short)",
settingstimel = "time of day(long)",
settingsformat = "format",
settingsq = "You want to overwrite a event for a newer one ?",
settingse = "Event ",
settingsb = " has begun!",
settingsnew = "New event: ",
settingsyes = "Yes",
settingsno = "No",
monday = "Monday",
tuesday = "Tuesday",
wednesday = "Wednesday",
thursday = "Thursday",
friday = "Friday",
saturday = "Saturday",
sunday = "Sunday",
mondayshort = "Mon",
tuesdayshort = "Tue",
wednesdayshort = "Wed",
thursdayshort = "Thu",
fridayshort = "Fri",
saturdayshort = "Sat",
sundayshort = "Sun",
january = "January",
february =  "February",
march = "March",
april = "April",
may = "May",
june = "June",
july = "July",
august = "August",
september = "September",
october = "October",
november = "November",
december = "December",
server = "server",
client = "client",
timeadd = true
}
--[[---------------------------------------------------------
German
-----------------------------------------------------------]]

L[2] = {
language = "DE",
lang = "Sprachen",
send = "senden",
example = "Beispiel Termin",
eventname = "Was",
eventtime = "Wann",
createevent = "Termin erstellen", 
settingsdates = "Datum(kurz)",
settingsdatel = "Datum(lang)",
settingstimes = "Uhrzeit(kurz)",
settingstimel = "Uhrzeit(lang)",
settingsformat = "Format",
settingsq = "Sie wollen eine Veranstaltung fuer eine neuere ueberschreiben?", 
settingse = "Termin ",
settingsb = " hat begonnen!",
settingsnew = "Neuer Termin: ",
settingsyes = "Ja",
settingsno = "Nein",
monday = "Montag",
tuesday = "Dienstag",
wednesday = "Mittwoch",
thursday = "Donnerstag",
friday = "Freitag",
saturday = "Samstag",
sunday = "Sonntag",
mondayshort = "Mo",
tuesdayshort = "Di",
wednesdayshort = "Mi",
thursdayshort = "Do",
fridayshort = "Fr",
saturdayshort = "Sa",
sundayshort = "So",
january = "Januar",
february =  "Februar",
march = "Maerz",
april = "April",
may = "Mai",
june = "Juni",
july = "Juli",
august = "August",
september = "September",
october = "Oktober",
november = "November",
december = "Dezember",
server = "Server",
client = "Client",
timeadd = false
}
--[[---------------------------------------------------------
French
-----------------------------------------------------------]]

L[3] = {
language = "FR",
lang = "langues",
send = "envoyer",
example = "cas de l echantillon",
eventname = "Quoi",
eventtime = "Quand",
createevent = "", 
settingsdates = "",
settingsdatel = "",
settingstimes = "",
settingstimel = "",
settingsformat = "format",
settingsq = "Vous souhaitez remplacer un evenement pour une plus recente?",
settingsnew = "Nouvel evenement: ",
settingse = "L evenement ",
settingsb = " a commence!",
settingsyes = "Oui",
settingsno = "Aucun",
monday = "Lundi",
tuesday = "Mardi",
wednesday = "Mercredi",
thursday = "Jeudi",
friday = "Vendredi",
saturday = "Samedi",
sunday = "Dimanche",
mondayshort = "Lu",
tuesdayshort = "Ma",
wednesdayshort = "Me",
thursdayshort = "Je",
fridayshort = "Ve",
saturdayshort = "Sa",
sundayshort = "Di",
january = "Janvier",
february =  "Fevrier",
march = "Mars",
april = "Avril",
may = "Mai",
june = "Juin",
july = "Juillet",
august = "aout",
september = "Septembre",
october = "Octobre",
november = "November",
december = "Decembre",
server = "Serveur",
client = "client",
timeadd = false
}

--[[---------------------------------------------------------
NAME: CreateLanguageFile( name, tab )
desc: create languagefile from table
-----------------------------------------------------------]]
function CreateLanguageFile( name, tab )
	local t = util.TableToJSON(tab)
		file.Write("Kalender/" .. name .. ".txt",t)
end

--[[---------------------------------------------------------
NAME: CheckNewLanguageFiles()
desc: all languagefiles created ?
-----------------------------------------------------------]]
function CheckNewLanguageFiles()
	for k,v in ipairs( L ) do
		if( !file.Exists( "Kalender/" .. v.language .. ".txt", "DATA" ) ) then
			CreateLanguageFile( v.language, v )
		end
	end
end

local ClockButton = {}
if( !file.Exists( "Kalender/calender_data.txt", "DATA" ) ) then file.CreateDir( "Kalender" ) file.Write("Kalender/calender_data.txt",".") end
 servertimezone = os.date("*t")["hour"]
net.Receive( "servertime", function( len ) servertimezone = servertimezone - tonumber(net.ReadString()) end)

 CheckNewLanguageFiles()	

--[[---------------------------------------------------------
NAME: loadlanguage( lang )
desc: load language files
-----------------------------------------------------------]]
 local function loadlanguage( lang )

	if( !file.Exists( "Kalender/" .. lang .. ".txt", "DATA" ) ) then
	 // load GB.txt
	local l = util.JSONToTable( file.Read("Kalender/GB.txt","DATA") )
	LANG = table.Copy( l ) 
	else
	local l = util.JSONToTable( file.Read("Kalender/" .. lang .. ".txt","DATA") )
	LANG = table.Copy( l ) 
	end

 end

 loadlanguage( system.GetCountry() )

 M = { LANG.january, LANG.february, LANG.march, LANG.april, LANG.may, LANG.june, LANG.july, LANG.august, LANG.september, LANG.october, LANG.november, LANG.december }

--[[---------------------------------------------------------
NAME: NiceTime( time )
desc: return a string value like 00:00:00
-----------------------------------------------------------]]
local function NiceTime( time )

if( servertimezone == time["hour"] ) then servertimezone = 0 end
	local sec = time["sec"]
	local min = time["min"]
	local hour = time["hour"] + servertimezone
	local add = " am"
	local string = ""
	if( LANG.timeadd ) then
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
			hour = "0"..time["hour"] + servertimezone
		end
		string = (hour .. ":" .. min .. ":" .. sec .. "")
	end
	return string
end

--[[---------------------------------------------------------
NAME: ContextMenu()
desc: Init Calender
-----------------------------------------------------------]]
function ContextMenu()

if(#ClockButton >= 1 ) then ClockButton[1]:Remove() table.Empty(ClockButton) end
EventTimer()
local time = os.date("*t")
local Main = g_ContextMenu:Add( "DButton" )
	  Main:SetPos(g_ContextMenu:GetWide()-80,0)
	  Main:SetText("")
	  Main:SetSize(100,30)
	  Main.DoClick = function()
	  local Cmenu = vgui.Create( "DClockMenu" )
			Cmenu:SetPos( g_ContextMenu:GetWide()-(640), 50 )
			Cmenu:SetSize( 635, 230 )

			local TestKale = vgui.Create( "DKalender",Cmenu)
				  TestKale:SetPos( 20 , 40 )
				  TestKale:SetSize( 210 , 160 )
				  TestKale:SetLanguage( LANG )
				  
			local Clock = vgui.Create( "DClockSkinChanger", Cmenu )
				  Clock:SetPos( 260,20 )   
				  Clock:ConVar( "rc_clockleft")   
				  Clock:SetClockImage( "clock/clock4.png")                        
				  Clock:SetSize( 160, 160 ) 

			local ctime = vgui.Create( "DLabel", Cmenu )
				  ctime:SetPos(324,15)
				  ctime:SetSize(80,10)
				  ctime:SetText( " User " )

			local Watchleft = vgui.Create( "DWatch", Cmenu)
				  Watchleft:SetPos(260,175)
				  Watchleft:SetSize(160,20)
				  Watchleft:SetLanguage(LANG)

			local Watchright = vgui.Create( "DWatch", Cmenu)
				  Watchright:SetPos(425,175)
				  Watchright:SetSize(160,20)
				  Watchright:SetTimeZone( servertimezone )	
				  Watchright:SetLanguage(LANG)
				  			  
			local ClockServer = vgui.Create( "DClockSkinChanger", Cmenu )
				  ClockServer:SetPos( 425,20 )                             
				  ClockServer:SetSize( 160, 160 )
				  ClockServer:ConVar( "rc_clockright")
				  ClockServer:SetClockImage( "clock/clock3.png")
				  ClockServer:SetTimeZone( servertimezone )

			local stime = vgui.Create( "DLabel", Cmenu )
				  stime:SetPos(488,15)
				  stime:SetSize(80,10)
				  stime:SetText( " Server " )

			local settings = vgui.Create( "DImageButton",Cmenu )
				  settings:SetPos(590,190)
				  settings:SetSize(20,20)
				  settings:SetImage("icon16/cog_go.png")
				  settings.DoClick = function(btn)
			local b=table.Copy(file.Find("Kalender/*.txt","DATA"))

		    local Settingsmenu = vgui.Create( "DClockMenu" )
				  Settingsmenu:SetPos(g_ContextMenu:GetWide()-(505),285 )
				  Settingsmenu:SetSize(500,20+(#b*24) )
						local w,h = Settingsmenu:GetSize()
						local DComboBox = vgui.Create( "DComboBox", Settingsmenu )
						DComboBox:SetPos( 30, 15 )
						DComboBox:SetSize(  w-60, 20 )
						DComboBox:SetValue( LANG.lang )
					
						for k,v in ipairs(b) do
							if( v == "calender_data.txt" ) then
							else
								DComboBox:AddChoice( string.Explode(".",v)[1] )
							end
						end

						DComboBox.OnSelect = function( panel, index, value )
							loadlanguage( value )
						end
				  end
	  end
	  function Main:PaintOver()
	  
		draw.SimpleText(NiceTime( time ), "DermaDefault", self:GetWide()/2, 2, Color(40,40,40,255), 1, 0 )
		draw.SimpleText( time["day"] .. "." .. time["month"] .. "." .. time["year"], "DermaDefault", self:GetWide()/2, self:GetTall()/2+2, Color(40,40,40,255), 1, 0 )
	
	  end

	  function Main:Paint(w,h)
	  
		surface.SetDrawColor(0,0,0,0)
		surface.DrawRect(0,0,w,h)
		
	  end
	  table.insert(ClockButton,Main)
end

hook.Add("ContextMenuOpen","ContextMenuOpen",ContextMenu)


--[[---------------------------------------------------------
NAME: SendToServer( t, p )
desc: SendToServer( {name = "Neues Event!",time= "10 5 2014", tab={1,2,3,4,5,6,7,8,9,10},color=Color(118,30,80,255)}, player.GetAll()[2] )
-----------------------------------------------------------]]
function SendToServer( t, p )

	net.Start( "CreateEvent" )
	net.WriteEntity( p ) 
	net.WriteTable( { name = t.name, time = t.time, tab = t.tab, c = t.color }  )
	net.SendToServer()

end

--[[---------------------------------------------------------
NAME: IncomingEvent
desc: 
-----------------------------------------------------------]]
net.Receive( "IncomingEvent", function( len )

--[[---------------------------------------------------------
NAME: DeleteRow( row, f )
desc: Delete a spec. row from file
-----------------------------------------------------------]]
local function DeleteRow( row, f )
local t =  {}
// load file
	local source = string.Explode("\n", file.Read(f,"DATA"))
	
		for k,v in ipairs( source ) do
			if( k == row ) then
			else
				table.insert( t, v ) 
			end
		end
		file.Delete(f)
		for k,v in ipairs( t ) do
			if(file.Exists(f,"DATA") ) then
				file.Write( f, file.Read(f,"DATA") .. "\n" .. v .. "")
			else
				file.Write( f,  v )
			end
		end	
end

--[[---------------------------------------------------------
NAME: EventExists( time, tab, overwrite )
desc: Event Exists ?  overwrite them ?
-----------------------------------------------------------]]
local function EventExists( time, tab, overwrite )
local rows = string.Explode( "\n",  file.Read("Kalender/calender_data.txt","DATA") )
local count = 0
local r = 0
	for k,v in ipairs(rows) do
		if( util.JSONToTable( v ) == nil  ) then
		else
			if(util.JSONToTable( v ).time == time ) then
				for a,b in ipairs( util.JSONToTable( v ).tab ) do
					for c,d in ipairs(tab) do
						if( b == d ) then
							r = k
							count = count + 1
						end
					end
				end
			end
		end
	end
	if( overwrite ) then
	// delete this row and add a new event
	DeleteRow( r, "Kalender/calender_data.txt" )
	end
	if( count > 0 ) then
		return true
	else
		return false
	end
end



local t = net.ReadTable()
	// command für die Erlaubnis vom User das der Server Events adden darf
	if( EventExists( t.time, t.tab, false ) ) then
		// overwrite =?
			// Yes or No
			local event = vgui.Create("DEvent")
			  event:SetPos(ScrW()/2-125,ScrH()/2-50)
			  event:SetSize(surface.GetTextSize(LANG.settingsq)+40,100)
			  event:SetCloseTime( 10 )
			  event:SetText(LANG.settingsq)
			  event:AllowEvent( false )

			local yes = vgui.Create("DButton",event)
				  yes:SetPos(event:GetWide()/4,event:GetTall()-event:GetTall()/2)
				  yes:SetSize(event:GetWide()/8,30)
				  yes:SetText( LANG.settingsyes )
				  yes.DoClick = function( btn )
							 EventExists( t.time, t.tab, true )
							 event:Remove()
		local save = util.TableToJSON( { name = t.name, time = t.time, tab = t.tab, c = t.c } )
		file.Write( "Kalender/calender_data.txt", file.Read("Kalender/calender_data.txt","DATA") .. "\n" .. save )
		Msg( "Created a new Event .. " .. t.time .. "\n")
		
		local event = vgui.Create("DEvent")
			  event:SetPos(ScrW()-250,-100)
			  event:SetSize(250,100)
			  event:SetCloseTime( 10 )
			  event:SetUpDown(true)
			  event:SetText("" .. LANG.settingsnew .. t.time .. "")
				  end

			local no = vgui.Create("DButton",event)
				  no:SetPos((event:GetWide()-event:GetWide()/4)-((event:GetWide()/8)),event:GetTall()-event:GetTall()/2)
				  no:SetSize(event:GetWide()/8,30)
				  no:SetText( LANG.settingsno )
				  no.DoClick = function( btn ) 
						// close and do nothing
						event:Remove()
				  end
	else

		local save = util.TableToJSON( { name = t.name, time = t.time, tab = t.tab, c = t.c } )
		file.Write( "Kalender/calender_data.txt", file.Read("Kalender/calender_data.txt","DATA") .. "\n" .. save )
		Msg( "Created a new Event  .. " .. t.time .. "\n")
		
		local event = vgui.Create("DEvent")
			  event:SetPos(ScrW()-250,-100)
			  event:SetSize(250,100)
			  event:SetCloseTime( 10 )
			  event:SetUpDown(true)
			  event:SetText("" .. LANG.settingsnew .. t.time .. "")
	end
end)

--[[---------------------------------------------------------
NAME: EventTimer()
desc: create a timer if an event exists
-----------------------------------------------------------]]
function EventTimer()

local t = os.date("*t")
local first = { t = 99, e = nil }
	local source = string.Explode( "\n", file.Read( "Kalender/calender_data.txt", "DATA" ) )
		for k,v in ipairs( source ) do
			if( util.JSONToTable( v ) == nil  ) then
			else
				if( util.JSONToTable( v ).time == "" .. t["day"] .. " " .. t["month"]  .. " " .. t["year"] .. "" ) then
					if( util.JSONToTable( v ).tab[1] < first.t and (-30 + util.JSONToTable( v ).tab[1] * 30) / 60 > (t["hour"] * 60 + t["min"]) / 60 ) then 
						first = { t = util.JSONToTable( v ).tab[1], e = v }
					end
				end
			end
		end
	if( first.e == nil ) then return end
	local dif = ((-30+util.JSONToTable( first.e ).tab[1] * 30) * 60) -  (t["hour"] * 60 * 60 + t["min"] * 60 + t["sec"]) 
		if( timer.Exists(  util.JSONToTable( first.e ).name ) ) then
			timer.Adjust( util.JSONToTable( first.e ).name, dif, 1, function() EventTimer() 
			
			local event = vgui.Create("DEvent")
			  event:SetPos(ScrW()-250,-100)
			  event:SetSize(250,100)
			  event:SetCloseTime( 10 )
			  event:SetUpDown(true)
			  event:SetText("" .. LANG.settingse .. util.JSONToTable( first.e ).time .. LANG.settingsb .. "")
			  end )
		return end 
			timer.Create( util.JSONToTable( first.e ).name , dif, 1, function() Msg( "" .. LANG.settingse .. util.JSONToTable( first.e ).time .. LANG.settingsb .. "\n" ) EventTimer() 

			local event = vgui.Create("DEvent")
			  event:SetPos(ScrW()-250,-100)
			  event:SetSize(250,100)
			  event:SetCloseTime( 10 )
			  event:SetUpDown(true)
			  event:SetText("" .. LANG.settingse .. util.JSONToTable( first.e ).time .. LANG.settingsb .. "")
			  end )
end

EventTimer()