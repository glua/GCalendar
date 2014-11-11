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
AccessorFunc( PANEL, "m_bDisabled", 		"Disabled", 		FORCE_BOOL )

--[[---------------------------------------------------------
NAME: Init()
desc: 
-----------------------------------------------------------]]
function PANEL:Init()


	self.right = vgui.Create("DButton", self)
	self.right.Parent = self
	self.right.DoClick = function(self) self.Parent:PressedRightButton() end
	self.left = vgui.Create("DButton", self)
	self.left.Parent = self
	self.left.DoClick = function(self) self.Parent:PressedLeftButton() end
	
	self.text = ""
	self.addtext = ""
	self.select = 1
	self.labels = {}

end


--[[---------------------------------------------------------
NAME: AddLabel( label )
desc: 
-----------------------------------------------------------]]
function PANEL:AddLabel( label )


	self.labels = label


end

--[[---------------------------------------------------------
NAME: AddItem( item )
desc: 
-----------------------------------------------------------]]
function PANEL:AddItem( item )

	table.insert( self.labels, item )

end


--[[---------------------------------------------------------
NAME: 
desc: 
-----------------------------------------------------------]]
function PANEL:Lefttpressed()
	//Overwrite
end

--[[---------------------------------------------------------
NAME: Rightpressed()
desc: 
-----------------------------------------------------------]]
function PANEL:Rightpressed()
	//Overwrite
end

--[[---------------------------------------------------------
NAME: AdditionalText( str )
desc: 
-----------------------------------------------------------]]
function PANEL:AdditionalText( str )

self.addtext = str


end

--[[---------------------------------------------------------
NAME: SetLabel( index )
desc: 
-----------------------------------------------------------]]
function PANEL:SetLabel( index )

if( index < 0 or index > #self.labels) then end

self.select = index

end

--[[---------------------------------------------------------
NAME: SetText( str )
desc: 
-----------------------------------------------------------]]
function PANEL:SetText( str )

	self.text = str


end

--[[---------------------------------------------------------
NAME: PressedRightButton()
desc: 
-----------------------------------------------------------]]
function PANEL:PressedRightButton()

	self.select = self.select + 1
	self:Rightpressed()
end

--[[---------------------------------------------------------
NAME: PressedLeftButton()
desc: 
-----------------------------------------------------------]]
function PANEL:PressedLeftButton()

	self.select = self.select - 1
	self:Lefttpressed()
end

--[[---------------------------------------------------------
NAME: GetIndexValue()
desc: 
-----------------------------------------------------------]]
function PANEL:GetIndexValue()

	return self.select

end

--[[---------------------------------------------------------
NAME: GetText()
desc: 
-----------------------------------------------------------]]
function PANEL:GetText()

	return self.text

end

--[[---------------------------------------------------------
NAME: GetSelected()
desc: 
-----------------------------------------------------------]]
function PANEL:GetSelected()

	if(self.select > 12 ) then
		return 1
	elseif( self.select < 1 ) then
		return 12
	end

	return self.select

end

--[[---------------------------------------------------------
NAME: Select( index )
desc: 
-----------------------------------------------------------]]
function PANEL:Select( index )

 self.select = index


end

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	if( !self.m_bDisabled ) then

		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawRect(1,1,w-2,h-2)
	else
		surface.SetDrawColor(0,0,0,255)
		surface.DrawRect(0,0,w,h)
		surface.SetDrawColor(40,40,40,255)
		surface.DrawRect(1,1,w-2,h-2)

	end
end

--[[---------------------------------------------------------
NAME: SetDisabled( bDisabled )
desc: 
-----------------------------------------------------------]]
function PANEL:SetDisabled( bDisabled )

	self.m_bDisabled = bDisabled	

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )
	
	draw.SimpleText( self.text .. " " .. self.addtext .. "", "DermaDefault", w/2, h/2, Color(0,0,0,255), 1, 1 )

end

--[[---------------------------------------------------------
NAME: UpdateColours( skin )
desc: 
-----------------------------------------------------------]]
function PANEL:UpdateColours( skin )

end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

	if( self.select <= 0) then

		self.select = #self.labels

	elseif( self.select > #self.labels ) then

		self.select = 1

	end
	if( #self.labels > 0) then
		self:SetText( self.labels[self.select] )
	else
		self:SetText( "" )
	end

end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )
		
	self.right:SetPos( w - 10, 0)
	self.right:SetSize( 10,h)
	self.right:SetText(">")
	self.left:SetPos(0,0)
	self.left:SetSize(10,h)
	self.left:SetText("<")

end

derma.DefineControl( "DTextChange", "A TextChange app", PANEL, "DPanel" )