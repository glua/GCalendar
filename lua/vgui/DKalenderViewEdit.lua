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
self.lang = {}
self.aclose = true
self:MakePopup()
self.textentry = vgui.Create( "DTextEntry", self )
self.textentry.Parent = self
self.textentry.OnEnter = function(self) self.Parent:SetText() end
self.textentry.OnLoseFocus = function( self ) self.Parent:SetText() end
	self.DComboBox = vgui.Create( "DComboBox", self )
	self.DComboBox:AddChoice("all")
	for k,v in ipairs(player.GetAll()) do
		if( v == LocalPlayer() ) then
		else
		self.DComboBox:AddChoice(v:GetName())
		end
	end
	
self.buttons = vgui.Create( "DButton", self )
self.buttons.Parent = self
self.buttons.DoClick = function(self) self.Parent:DoSend() self.Parent:Remove() end
self.button = vgui.Create( "DButton", self )

self.button.Parent = self
self.button.DoClick = function(self) self.Parent:DoClick()  end
self.colp = vgui.Create( "DColorBar" , self )
self.colp:SetColorButtons({Color(48,196,255,255),Color(84,132,237,255),Color(164,189,252,255),Color(70,214,219,255),Color(122,231,191,255),Color(81,183,73,255),Color(251,215,91,255),Color(255,136,184,255),Color(220,33,39,255),Color(219,173,255,255),Color(225,225,225,255)})

self.selected = ""
self.label = ""
self.main = ""
self.addtext = ""
self.color = Color(48,196,255,255)
self.info = ""

end

--[[---------------------------------------------------------
NAME: SetLanguage( lang )
desc: 
-----------------------------------------------------------]]
function PANEL:SetLanguage( lang )

	self.lang = table.Copy(lang)

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
NAME: GetName()
desc: 
-----------------------------------------------------------]]
function PANEL:GetName()

	return self.addtext 

end

--[[---------------------------------------------------------
NAME: SetInfo( inf )
desc: 
-----------------------------------------------------------]]
function PANEL:SetInfo( inf )

	self.info = inf

end

--[[---------------------------------------------------------
NAME: AutoClose( bool )
desc: 
-----------------------------------------------------------]]
function PANEL:AutoClose( bool )

	self.aclose = bool

end

--[[---------------------------------------------------------
NAME: SetText()
desc: 
-----------------------------------------------------------]]
function PANEL:SetText()

	self.addtext = self.textentry:GetValue()

end

--[[---------------------------------------------------------
NAME: SetColor(  )
desc: 
-----------------------------------------------------------]]
function PANEL:SetColor(  )

end

--[[---------------------------------------------------------
NAME: GetColor()
desc: 
-----------------------------------------------------------]]
function PANEL:GetColor()

	return self.color

end

--[[---------------------------------------------------------
NAME: Clicked()
desc: 
-----------------------------------------------------------]]
function PANEL:Clicked()

end

--[[---------------------------------------------------------
NAME: GivePanel( pnl )
desc: 
-----------------------------------------------------------]]
function PANEL:GivePanel( pnl )

	self.main = pnl

end

--[[---------------------------------------------------------
NAME: PaintOver( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PaintOver( w, h )

	draw.SimpleText("" .. self.lang.eventtime .. ": " .. self.info .. "", "DermaDefault",15, 25, Color(0,0,0,255), 0, 1 )
	draw.SimpleText("" .. self.lang.eventname .. ": ", "DermaDefault", 30, 60, Color(0,0,0,255), 1, 1 )

end

--[[---------------------------------------------------------
NAME: DoClick()
desc: 
-----------------------------------------------------------]]
function PANEL:DoClick()

	self:Clicked()
	self:Close()

end

--[[---------------------------------------------------------
NAME: DoSend()
desc: 
-----------------------------------------------------------]]
function PANEL:DoSend()

end

--[[---------------------------------------------------------
NAME: Think()
desc: 
-----------------------------------------------------------]]
function PANEL:Think()

	local x1,y1 = self:GetPos()

		if( !self:IsActive() ) then

		end
		if( LocalPlayer():IsAdmin() ) then self.selected = self.DComboBox:GetValue() end
		local x,y = input.GetCursorPos( )

		if( !self:IsInRange( x, y, x1, y1) and input.IsMouseDown( 107 ) or !g_ContextMenu:IsVisible() ) then
	
		else
	
		end 

	if( IsValid(self.colp) ) then
		self.color = self.colp:GetColor()
	end
end

--[[---------------------------------------------------------
NAME: IsInRange( x, y, x1, y1  ) 
desc: 
-----------------------------------------------------------]]
function PANEL:IsInRange( x, y, x1, y1  ) 

	if( x > x1 and x < x1 + self:GetWide() and y > y1 and y < y1 + self:GetTall() ) then
		return true
	else
		return false
	end
end

--[[---------------------------------------------------------
NAME: PerformLayout( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout( w, h )

	self.textentry:SetPos(50,50)
	self.textentry:SetSize(240,25)
	self.textentry:SetText( self.lang.example )
	if( LocalPlayer():IsAdmin() ) then
	self.DComboBox:SetPos(50,110)
	self.DComboBox:SetSize(240,25)


	self.buttons:SetPos(190,h-50)
	self.buttons:SetSize(100,30)
	self.buttons:SetText(self.lang.send)
	else
	self.DComboBox:Remove()
	self.buttons:Remove()
	end
	self.button:SetSize(100,30)
	self.button:SetPos(50,h-50)
	self.button:SetText( self.lang.createevent )

	self.colp:SetPos(50,80)
	self.colp:SetSize(240,25)

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

derma.DefineControl( "DKalenderViewEdit", "A Menu App", PANEL, "EditablePanel" )


