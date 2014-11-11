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

	self.colors = {}
	self.element = {}
	self.gcolor = Color(0,0,0,0)
	self.selectede = {}
	
end


--[[---------------------------------------------------------
NAME: SetColorButtons( t ) 
desc: 
-----------------------------------------------------------]]
function PANEL:SetColorButtons( t ) 

	self.colors = table.Copy(t)

	for k,v in ipairs (self.colors) do
		if( k == 1 ) then
			self.element[k] = vgui.Create("DColorBarButton",self)
			self.element[k]:SetPos(5,5)
			self.element[k]:SetSize(16,16)
			self.element[k]:SetColor(v)
		else
			self.element[k] = vgui.Create("DColorBarButton",self)
			self.element[k]:SetPos(10+(k-1)*21,5)
			self.element[k]:SetSize(16,16)
			self.element[k]:SetColor(v)
		end
	end
end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(0,0,w,h)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawRect(1,1,w-2,h-2)

end

--[[---------------------------------------------------------
NAME: GetColor()
desc: 
-----------------------------------------------------------]]
function PANEL:GetColor()

	return self.gcolor

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

	surface.SetDrawColor(0,0,0,255)
	surface.DrawLine(25,2,25,h-4)


end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

	for k,v in ipairs( self.element ) do
		if( v:IsSelected() ) then
			if( table.HasValue( self.selectede, v ) ) then
			else
				if( #self.selectede > 0 ) then
					self.selectede[1]:SetSelected(false)
					table.Empty( self.selectede )
				end 
				table.insert( self.selectede, v )
			end
			self.gcolor = v:GetColor()
		end
	end
end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	if( #self.element > 0 ) then
		self.element[1]:SetSelected( true )
	end
end

derma.DefineControl( "DColorBar", "Kalender ColorChange app", PANEL, "DPanel" )