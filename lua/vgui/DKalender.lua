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
desc: initialize the main panel values
-----------------------------------------------------------]]
function PANEL:Init()

	self.title = vgui.Create( "DTextChange", self )			// implement DTextChange
	self.lang = {}										   // base language

	self.month = {31,28,31,30,31,30,31,30,30,31,30,31}		// count of days 
	self.ziffer = {0,3,3,6,1,4,6,2,5,0,3,5}					// specific values from wiki 
	self.Week = {M={},D={},Mi={},Do={},Fr={},Sa={},So={}}	// the day of the week table
	self.gap = {}											// the gap between the different kind of month
	self.fill = {m=0,d=0,mi=0,don=0,fr=0,sa=0,so=0}			// "" same
	self.buffer = {}
	self.buttons = {}
	self.buttons1 = {}
	self.color = ""
	


	self.year = os.date("*t")["year"]						// current year example: 2014
	for i=1,self.month[os.date("*t")["month"]] do	       // load the current month
	self:Dates( i, os.date("*t")["month"], self.year )
	end 

	self.title.Parent = self								// set DTextChange parent and modify it
	self.title.Rightpressed = function(self) self.Parent:Next() end
	self.title.Lefttpressed = function(self) self.Parent:Prev() end
	self.title:AdditionalText( self.year )
	self.title:SetLabel(tonumber(os.date("*t")["month"]))
end

--[[---------------------------------------------------------
NAME: SetLanguage( lang )
desc: Current Languagetable
-----------------------------------------------------------]]
function PANEL:SetLanguage( lang )

	self.lang = table.Copy(lang)

end

--[[---------------------------------------------------------
NAME: 
desc: 
-----------------------------------------------------------]]
function PANEL:GetColor( row )

local rows = string.Explode( "\n",  file.Read("Kalender/calender_data.txt","DATA") )

	if( rows[row] == nil ) then
		return Color(48,196,255,255)
	else
		return util.JSONToTable( rows[row] ).c
	end


end
--[[---------------------------------------------------------
NAME: HasTermin( day, month, year )
desc: 
-----------------------------------------------------------]]
function PANEL:HasTermin( day, month, year )

local rows = string.Explode( "\n",  file.Read("Kalender/calender_data.txt","DATA") )
local f = 0
	for k,v in ipairs(rows) do
		if( k == 1 ) then else
			if( v == "" ) then
			else
				if( util.JSONToTable( v ).time == "" ..day.. " " .. month .. " " .. year .. "" ) then
					self.color = self:GetColor(k) 
					f = f + 1
				end
			end
		end
	end
	if( f > 0 ) then return true else return false end
end




--[[---------------------------------------------------------
NAME: Dates( day, month, year )
desc: calculate the day of the week 
algorithm: http://de.wikipedia.org/wiki/Wochentagsberechnung
-----------------------------------------------------------]]
function PANEL:Dates( day, month, year )

local nt = day % 7
	if( month == 1 ) then nm = self.ziffer[1]
	elseif( month == 2 ) then nm = self.ziffer[2]
	elseif( month == 3 ) then nm =  self.ziffer[3]
	elseif( month == 4 ) then nm = self.ziffer[4]
	elseif( month == 5 ) then nm = self.ziffer[5]
	elseif( month == 6 ) then nm = self.ziffer[6]
	elseif( month == 7 ) then nm = self.ziffer[7]
	elseif( month == 8 ) then nm = self.ziffer[8]
	elseif( month == 9 ) then nm = self.ziffer[9]
	elseif( month == 10 ) then nm = self.ziffer[10]
	elseif( month == 11 ) then nm = self.ziffer[11]
	elseif( month == 12 ) then nm = self.ziffer[12]
	end
		local njh = (3 - (tonumber(string.Left( year , 2 )) % 4 ) ) * 2
		local nj = math.floor(( tonumber(string.Right( year, 2 ) ) + ( tonumber(string.Right( year, 2 ) ) / 4 ) ) % 7)
		if( (year % 4 == 0 and year % 100 != 0) or year % 400 == 0 ) then
			nsj = 7
			self.month[2] = 29
		else
			self.month[2] = 28
			nsj = 0
		end

	if( (( nt + nm + njh + nj + nsj )%7) == 0 ) then
		table.insert( self.Week.So, day )
	elseif( (( nt + nm + njh + nj + nsj )%7) == 1 ) then
		table.insert( self.Week.M, day )
	elseif( (( nt + nm + njh + nj + nsj )%7) == 2 ) then
		table.insert( self.Week.D, day )
	elseif( (( nt + nm + njh + nj + nsj )%7) == 3 ) then
		table.insert( self.Week.Mi, day )
	elseif( (( nt + nm + njh + nj + nsj )%7) == 4 ) then
		table.insert( self.Week.Do, day )
	elseif( (( nt + nm + njh + nj + nsj )%7) == 5 ) then
		table.insert( self.Week.Fr, day )
	elseif( (( nt + nm + njh + nj + nsj )%7) == 6 ) then
		table.insert( self.Week.Sa, day )
	end
end

--[[---------------------------------------------------------
MAME: Paint( w, h )
desc: Draw the basic layer
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawRect(1,1,w-2,h-2)

end

--[[---------------------------------------------------------
NAME: Next()
desc: Get the "next" DoClick event from DTextChange
-----------------------------------------------------------]]
function PANEL:Next()
self:CleanCalenderFrame()
	if( self.title:GetIndexValue() == 13 ) then self.year = self.year + 1 end	
		self.Week = {M={},D={},Mi={},Do={},Fr={},Sa={},So={}}
		self.gap = {}
	for i=1,self.month[self.title:GetSelected()] do
		self:Dates( i, self.title:GetSelected(), self.year )
	end 
	self.title:AdditionalText( self.year )
end

--[[---------------------------------------------------------
NAME: Prev()
desc: Get the "previous" DoClick event from DTextChange
-----------------------------------------------------------]]
function PANEL:Prev()
self:CleanCalenderFrame()
if( self.title:GetIndexValue() == 0 ) then self.year = self.year - 1 end
		self.Week = {M={},D={},Mi={},Do={},Fr={},Sa={},So={}}
		self.gap = {}
	for i=1,self.month[self.title:GetSelected()] do
		self:Dates( i, self.title:GetSelected(), self.year )
	end 
	self.title:AdditionalText( self.year )
end

--[[---------------------------------------------------------
Name: OnMouseWheeled( dlta )
desc: >>>Yay update since April 2014
-----------------------------------------------------------]]
function PANEL:OnMouseWheeled( dlta )
	if( dlta > 0 ) then
		self.title.select = self.title.select - 1
		self:Prev()
	elseif( dlta < 0 ) then
		self.title.select = self.title.select + 1
		self:Next()
	end
end

--[[---------------------------------------------------------
NAME: CleanCalenderFrame()
desc:
-----------------------------------------------------------]]
function PANEL:CleanCalenderFrame()

	for k,v in ipairs(self.buttons1) do

		v:Remove()

	end

	table.Empty(self.buttons1)
	table.Empty(self.buffer)
	table.Empty(self.buttons)


end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: draw the Z-layer
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )



		draw.SimpleText( self.lang.mondayshort, "DermaDefault", 15, 30, Color(0,0,0,255), 1, 1 )
		draw.SimpleText( self.lang.tuesdayshort, "DermaDefault", 45, 30, Color(0,0,0,255), 1, 1 )
		draw.SimpleText( self.lang.wednesdayshort, "DermaDefault", 75, 30, Color(0,0,0,255), 1, 1 )
		draw.SimpleText( self.lang.thursdayshort, "DermaDefault", 105, 30, Color(0,0,0,255), 1, 1 )
		draw.SimpleText( self.lang.fridayshort, "DermaDefault", 135, 30, Color(0,0,0,255), 1, 1 )
		draw.SimpleText( self.lang.saturdayshort, "DermaDefault", 165, 30, Color(0,0,0,255), 1, 1 )
		draw.SimpleText( self.lang.sundayshort, "DermaDefault", 195, 30, Color(0,0,0,255), 1, 1 )

	
		surface.SetDrawColor(0,0,0,255)
		surface.DrawLine(0,40,w,40)

		self.gap = {self.Week.M[1], self.Week.D[1],self.Week.Mi[1],self.Week.Do[1],self.Week.Fr[1],self.Week.Sa[1],self.Week.So[1] }
		for k,v in ipairs( self.gap ) do
			if( k+1 <= #self.gap ) then
				if( self.gap[k] > self.gap[k+1] ) then
					for i = 1, k do
						if( k < 2 ) then
							self.fill.m = 0
							self.fill.d = 0
							self.fill.mi = 0
							self.fill.don = 0
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 3) then
							self.fill.mi = 0
							self.fill.don = 0
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 4 ) then
							self.fill.don = 0
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif(k < 5 ) then
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 6 ) then
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 7 ) then
							self.fill.so = 0
						end
						if(i == 1) then
							self.fill.m = 1
						elseif( i == 2) then
							self.fill.d = 1
						elseif( i == 3 ) then
							self.fill.mi = 1
						elseif( i == 4 ) then
						self.fill.don = 1
						elseif( i == 5 ) then
							self.fill.fr = 1
						elseif( i == 6 ) then
							self.fill.sa = 1
						elseif( i == 7 ) then
							self.fill.so = 1
						end

					end
				elseif(self.gap[k] < self.gap[k+1] ) then
					for i = 1, k do
						if( k < 2 ) then
							self.fill.m = 0
							self.fill.d = 0
							self.fill.mi = 0
							self.fill.don = 0
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 3) then
							self.fill.mi = 0
							self.fill.don = 0
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 4 ) then
							self.fill.don = 0
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif(k < 5 ) then
							self.fill.fr = 0
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 6 ) then
							self.fill.sa = 0
							self.fill.so = 0
						elseif( k < 7 ) then
							self.fill.so = 0
						end
					end
				end
			end
		end

		for k,v in ipairs( self.Week.M ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 15, y = 32+(k+self.fill.m)*20 } )
			end	
		end

		for k,v in ipairs( self.Week.D ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 45, y = 32+(k+self.fill.d)*20 } )
			end	
		end

		for k,v in ipairs( self.Week.Mi ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 75, y = 32+(k+self.fill.mi)*20 } )
			end		
		end

		for k,v in ipairs( self.Week.Do ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 105, y = 32+(k+self.fill.don)*20 } )
			end	
		end

		for k,v in ipairs( self.Week.Fr ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 135, y = 32+(k+self.fill.fr)*20 } )
			end	
		end

		for k,v in ipairs( self.Week.Sa ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 165, y = 32+(k+self.fill.sa)*20 } )
			end	
		end
	
		for k,v in ipairs( self.Week.So ) do
			if( !table.HasValue(self.buffer,v) ) then
				table.insert(self.buffer,v)
				table.insert(self.buttons,{ name = v, x = 195, y = 32+(k+self.fill.so)*20 } )
			end	
		end

	if(#self.buffer == self.month[self.title:GetSelected()] and #self.buttons1 < self.month[self.title:GetSelected()]) then
		for k,v in ipairs(self.buttons) do
	
			self.buttons1[k] = vgui.Create("DKalenderButton",self)
			self.buttons1[k]:SetPos(self.buttons[k].x-7.5,self.buttons[k].y-7.5)
			self.buttons1[k]:SetSize(15,15)
			self.buttons1[k]:SetLanguage(self.lang)
			self.buttons1[k]:SetText( self.buttons[k].name )
			self.buttons1[k]:SetInformation( { day = self.buttons[k].name, month = self.title:GetSelected() , year = self.year } )
			if( self:HasTermin( self.buttons[k].name, self.title:GetSelected(), self.year ) ) then // GetHugeColor
				self.buttons1[k]:SetColor(self.color)
			end
			if( self.buttons[k].name == os.date("*t")["day"] ) then
				self.buttons1[k]:SetColor(Color(180,180,180,255)) // today
			end
		end
	end	
end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

self.title:SetPos(0,0)
self.title:SetSize(w,25)
self.title:AddLabel({self.lang.january,self.lang.february,self.lang.march,self.lang.april,self.lang.may,self.lang.june,self.lang.july,self.lang.august,self.lang.september,self.lang.october,self.lang.november,self.lang.december})

end

derma.DefineControl( "DKalender", "A Kalender app", PANEL, "DPanel" )