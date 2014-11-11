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

	self:MakePopup()
	self.nodes = {}
	self.buttons = {}
	self.lang = {}
	self.Termine = {}
	self.used = {}
	self.loaded = {}
	self.old = {}
	self.selected = {}
	self.edit = {}
	self.title = ""
	self.addtext = ""
	self.color = Color(48,196,255,255)
	self.aclose = true
	self.pnl = nil
	self.wopened = false

	self.b = vgui.Create("DPanel",self)
	self.b.Parent = self
	self.b.Paint = function(self) self.Parent:PaintPanel() end
	self.t = vgui.Create("DLabel",self.b)
	for i = 1, 48 do
		 a = vgui.Create("DKalenderView_Node",self.b)
		table.insert(self.nodes,a)
	end
	for i = 1, 24 do
		 b = vgui.Create("DButton",self.b)
		table.insert(self.buttons,b)
	end
end

--[[---------------------------------------------------------
NAME: DeleteRow( row, f )
desc: 
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
desc: 
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

--[[---------------------------------------------------------
NAME: SetLanguage( lang 
desc: 
-----------------------------------------------------------]]
function PANEL:SetLanguage( lang )

	self.lang = table.Copy(lang)

end

--[[---------------------------------------------------------
NAME: SetTitle( title )
desc: 
-----------------------------------------------------------]]
function PANEL:SetTitle( title )

	self.title = title

end

--[[---------------------------------------------------------
NAME: PaintPanel()
desc: 
-----------------------------------------------------------]]
function PANEL:PaintPanel()

	surface.SetDrawColor(0,0,0,0)
	surface.DrawRect(0,0,self:GetWide(),self:GetTall())

end

--[[---------------------------------------------------------
NAME: LoadFromFile( file )
desc: 
-----------------------------------------------------------]]
function PANEL:LoadFromFile( file )

	local rows = string.Explode( "\n", file )

	for i = 2, #rows do
		if( rows[i] == "" ) then
		else
			if( util.JSONToTable( rows[i] ).time == self.title ) then
				for k,v in ipairs( util.JSONToTable( rows[i] ).tab ) do
					self.nodes[v]:Select(true)
					self.nodes[util.JSONToTable(  rows[i] ).tab[1]]:EnableDeleteButton()
					self.nodes[util.JSONToTable(  rows[i] ).tab[1]].Delete = function()
						EventExists(util.JSONToTable( rows[i] ).time,util.JSONToTable(  rows[i] ).tab,true)
							for k,v in ipairs(util.JSONToTable(  rows[i] ).tab) do
							self.nodes[util.JSONToTable(  rows[i] ).tab[1]].DBut:Remove()
							self.nodes[v]:Select(false)
							self.nodes[v]:SetText("")
							end
					end
					self.nodes[v]:SetColor( util.JSONToTable( rows[i] ).c )
					if( !self.lang.timeadd ) then 
						self.nodes[util.JSONToTable(  rows[i] ).tab[1]]:SetText("" .. self:NiceTime((-30+util.JSONToTable(  rows[i] ).tab[1] * 30)/60 ) .. " - " .. self:NiceTime(((-30+util.JSONToTable(  rows[i] ).tab[#util.JSONToTable(  rows[i] ).tab] *30)/60)) .. " " ..  util.JSONToTable(  rows[i] ).name .. "" )
					else
						if(util.JSONToTable(  rows[i] ).tab[1] == 1 ) then
							self.nodes[util.JSONToTable(  rows[i] ).tab[1]]:SetText("" .. 12  .. " - " .. self:NiceTime(((-30+util.JSONToTable(  rows[i] ).tab[#util.JSONToTable(  rows[i] ).tab]*30)/60))  .. " " .. util.JSONToTable(  rows[i] ).name .. "")
						elseif( util.JSONToTable(  rows[i] ).tab[1] > 24 ) then
							self.nodes[util.JSONToTable(  rows[i] ).tab[1]]:SetText("" .. self:NiceTime(((-30+util.JSONToTable(  rows[i] ).tab[1] * 30)) /60 -12 )  .. " - " .. self:NiceTime((((-30+util.JSONToTable(  rows[i] ).tab[#util.JSONToTable(  rows[i] ).tab]*30))/60)-12)  .. "  " .. util.JSONToTable(  rows[i] ).name .. "")
						elseif( util.JSONToTable(  rows[i] ).tab[1] < 24 ) then
							self.nodes[util.JSONToTable(  rows[i] ).tab[1]]:SetText("" .. self:NiceTime(((-30+util.JSONToTable(  rows[i] ).tab[1] * 30)) /60 )  .. " - " .. self:NiceTime((((-30+util.JSONToTable(  rows[i] ).tab[#util.JSONToTable(  rows[i] ).tab]*30))/60))  .. "  " .. util.JSONToTable(  rows[i] ).name .. "")
						elseif( util.JSONToTable(  rows[i] ).tab[1] == 26 ) then
						self.nodes[util.JSONToTable(  rows[i] ).tab[1]]:SetText("" .. 12  .. " - " .. self:NiceTime(((-30+util.JSONToTable(  rows[i] ).tab[#util.JSONToTable(  rows[i] ).tab]*30)/60))  .. " " .. util.JSONToTable(  rows[i] ).name .. "")
						end
					end
					table.insert( self.loaded, v )
				end
			end
		end
	end
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
NAME: SetPanel( pnl )
desc: 
-----------------------------------------------------------]]
function PANEL:SetPanel( pnl )

self.pnl = pnl

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )
	self.b:SetPos(10,10)
	self.b:SetSize(w-20,h-20)
	for i = 1, 48 do
		self.nodes[i]:SetPos(76,-28+math.floor(25)*i)
		self.nodes[i]:SetSize((w-22)-75,25)
	end
	for i = 1, 24 do
		self.buttons[i]:SetPos(0,-28+math.floor(50)*i-25)
		self.buttons[i]:SetSize(75,50)
	end
	for i = 1, 24 do
		if( self.lang.timeadd ) then 
		// for the english community
			if( i <= 12 ) then
				if(i == 1 ) then
					self.buttons[i]:SetText("12:00" .. " AM")
				else
					if( i < 10 ) then
						self.buttons[i]:SetText("0" .. i-1 ..  ":00" .. " AM")
					else
						self.buttons[i]:SetText("" .. i-1 ..  ":00" .. " AM")
					end
				end
			else
				if( i == 13 ) then
					self.buttons[i]:SetText("12:00" .. " PM")
				else
					if( i-13 < 10 ) then
						self.buttons[i]:SetText("0" .. i-13 ..  ":00" .. " PM")
					else
						self.buttons[i]:SetText("" .. i-13 ..  ":00" .. " PM")
					end
				end
			end
		else
			if( i < 11 ) then
				self.buttons[i]:SetText("0" .. i-1 ..  ":00" .. "")
			else	
				self.buttons[i]:SetText("".. i-1 .. ":00" .. "")
			end
		end
	end
	self.t:SetPos(self.b:GetWide()*0.5-15,0)
	self.t:SetSize(self.b:GetWide(),25)
	self.t:SetText( self.title )
	self.t:SetTextColor(Color(0,0,0,255))
end



--[[---------------------------------------------------------
NAME: CreateTermin( name, time, tab )
desc: 
for k,v in ipairs( tab ) do 	
							self.nodes[v]:Select(false)
							self.nodes[v]:SetText("")  end end
-----------------------------------------------------------]]
function PANEL:CreateTermin( name, time, tab )

	if( !self.wopened ) then
	local x,y = self:GetPos()
	local w = self:GetWide()
	local h = self:GetTall()
	local mx,my = input.GetCursorPos( )
	if(#self.edit >= 1 ) then self.edit[1]:Remove() table.Empty(self.edit) for k,v in ipairs( self.old ) do 	
							self.nodes[v]:Select(false)
							self.nodes[v]:SetText("")  end end
	self.old = table.Copy(tab)
		edit = vgui.Create("DKalenderViewEdit")
		edit.Parent = self
		edit:SetPos(x+20,my-self:GetTall()*0.5)
		edit:SetSize(w-90,200)
		edit:GivePanel( self )
		edit:SetLanguage(self.lang)
		self:SetPanel( edit )
		edit:SetInfo( "" .. name .. "" )
		function edit:Clicked()
		table.insert( self.Parent.Termine, { name = self:GetName(), time = time, tab = tab, c = self:GetColor() } )
		local save = util.TableToJSON( { name = self:GetName(), time = time, tab = tab, c = self:GetColor() } )
		file.Write( "Kalender/calender_data.txt", file.Read("Kalender/calender_data.txt","DATA") .. "\n" .. save )
		self.Parent.addtext = self:GetName()
		self.Parent.color = self:GetColor()
		end

		function edit:DoSend()
			if( self.selected == "all" ) then
				for k,v in ipairs( player.GetAll() ) do
					if( v != LocalPlayer() ) then
					 SendToServer( {name = self:GetName(), time = time, tab = tab, color = self:GetColor()}, v )
					 end
				end
			else
				for k,v in ipairs( player.GetAll() ) do
					if( v:GetName() == self.selected ) then
					 SendToServer( {name = self:GetName(), time = time, tab = tab, color = self:GetColor()}, v )
					 end
				end
			end
		end
		 table.insert(self.edit,edit)
	end
	
end

--[[---------------------------------------------------------
NAME: NiceTime( value )
desc: 
-----------------------------------------------------------]]
function PANEL:NiceTime( value )

	local hour = ""
	local min = ""

	local source = string.Explode(".", value )

	if( tonumber(source[1]) < 10 ) then
		hour = "0".. source[1] .. ""
	else
		hour = source[1]
	end

	if( #source > 1 ) then
		min = "30"
	else
		min = "00"
	end
		return "".. hour .. ":" .. min .. ""
end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()
if( self.pnl != nil ) then 
if( self.pnl:IsValid() and self.pnl:IsActive() ) then 
self.aclose = false
else
 self.aclose = true
 end 
   end
	local x1,y1 = self:GetPos()
	local sourcex,sourcey = self.nodes[1]:GetPos()
	
	if( !self:IsActive() ) then

	end
	
	local x,y = input.GetCursorPos( )

	if( self.aclose and !self:IsInRange( x, y, x1, y1) and input.IsMouseDown( 107 ) or !g_ContextMenu:IsVisible() and self.aclose ) then
		if( edit ) then edit:Remove() end
		self:Close()
	else
	
	end 

	for k,v in ipairs( self.nodes ) do
		if( v:IsSelected() ) then
			if( table.HasValue( self.used, k ) or table.HasValue( self.selected, v )  or table.HasValue( self.loaded, k ) )then
			
			else
				table.insert( self.used, k )
				table.sort( self.used )
				table.insert( self.selected, v )
			end

		
		end
	end

	if( #self.used > 0 and !input.IsMouseDown( 107 ) ) then
	
		self:CreateTermin( "" .. self:NiceTime((-30+self.used[1] * 30)/60 ) .. " - " .. self:NiceTime(((-30+self.used[#self.used]*30)/60)) .. "",self.title, table.Copy(self.used) )
		if( !self.lang.timeadd ) then 
			self.nodes[self.used[1]]:SetText("" .. self:NiceTime((-30+self.used[1] * 30)/60 )  .. " - " .. self:NiceTime(((-30+self.used[#self.used]*30)/60))  .. " " .. self.addtext .. "")
		else
			if(self.used[1] == 1 ) then
			self.nodes[self.used[1]]:SetText("" .. 12  .. " - " .. self:NiceTime(((-30+self.used[#self.used]*30)/60))  .. " " .. self.addtext .. "")
			elseif( self.used[1] > 12 ) then
			self.nodes[self.used[1]]:SetText("" .. self:NiceTime(((-30+self.used[1] * 30)-12) /60 )  .. " PM - " .. self:NiceTime((((-30+self.used[#self.used]*30)-12)/60))  .. " PM " .. self.addtext .. "")
			end
		end
		self.nodes[self.used[1]]:SetColor(self.color)
		table.Empty(self.used)
		self.wopened = true
	else
		self.wopened = false
	end
		// is in Termin
end

--[[---------------------------------------------------------
NAME: IsInRange( x, y, x1, y1  ) 
desc: 
-----------------------------------------------------------]]
function PANEL:IsInRange( x, y, x1, y1  ) 

	if( x > x1 and x < x1 + self:GetWide() and y > y1 and y < y1 + self:GetTall()) then
		return true
	else
		return false
	end

end

--[[---------------------------------------------------------
NAME: OnMouseWheeled( dlta )
desc: 
-----------------------------------------------------------]]
function PANEL:OnMouseWheeled( dlta )

local x,y = self.nodes[48]:GetPos()
local x1,y1 = self.nodes[math.floor(((ScrH()*0.5)-40)/self.nodes[1]:GetTall())]:GetPos()
local w,h = self.b:GetSize()
	if( dlta < 0 ) then
		if( (y+self.nodes[48]:GetTall() ) >= h) then
			for i = 1, 48 do
			local x,y = self.nodes[i]:GetPos()
				self.nodes[i]:SetPos(x,y+dlta*self.nodes[1]:GetTall())
			end
			for i = 1, 24 do
			local x,y =	self.buttons[i]:GetPos()
			self.buttons[i]:SetPos(x,y+dlta*self.nodes[1]:GetTall())
			end
	else

		end
	elseif( dlta > 0 ) then
		if( (y1 + self.nodes[1]:GetTall() ) <= h-self.nodes[1]:GetTall() ) then
			for i = 1, 48 do
			local x,y = self.nodes[i]:GetPos()
			self.nodes[i]:SetPos(x,y+dlta*self.nodes[1]:GetTall())
			end
			for i = 1, 24 do
			local x,y =	self.buttons[i]:GetPos()
			self.buttons[i]:SetPos(x,y+dlta*self.nodes[1]:GetTall())
			end
		else
		end
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

derma.DefineControl( "DKalenderView", "Kalender View app", PANEL, "DPanel" )
