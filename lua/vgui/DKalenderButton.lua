--[[   _                                

______ _   __      _                _           
|  _  \ | / /     | |              | |          
| | | | |/ /  __ _| | ___ _ __   __| | ___ _ __ 
| | | |    \ / _` | |/ _ \ '_ \ / _` |/ _ \ '__|
| |/ /| |\  \ (_| | |  __/ | | | (_| |  __/ |   
|___/ \_| \_/\__,_|_|\___|_| |_|\__,_|\___|_|   
                                               
					|Royal|
				 DButton base

--]]


PANEL = {}

AccessorFunc( PANEL, "m_bBorder", 			"DrawBorder", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_bDisabled", 		"Disabled", 		FORCE_BOOL )
AccessorFunc( PANEL, "m_FontName", 			"Font" )

--[[---------------------------------------------------------
NAME: Init()
desc: 
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetContentAlignment( 5 )
	

	self:SetDrawBorder( true )
	self:SetDrawBackground( true )

	self:SetTall( 22 )
	self:SetMouseInputEnabled( true )
	self:SetKeyboardInputEnabled( true )

	self:SetCursor( "hand" )
	self:SetFont( "DermaDefault" )
	self.color = Color(0,0,0,0)
	self.information = {}
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
NAME: IsDown()
desc: 
-----------------------------------------------------------]]
function PANEL:IsDown()

	return self.Depressed

end

--[[---------------------------------------------------------
NAME: GetInformation( )
desc: 
-----------------------------------------------------------]]
function PANEL:GetInformation( )

	return self.information

end

--[[---------------------------------------------------------
NAME: SetColor( color )
desc: 
-----------------------------------------------------------]]
function PANEL:SetColor( color )

	self.color = color

end

--[[---------------------------------------------------------
NAME: SetInformation( tab )
desc: 
-----------------------------------------------------------]]
function PANEL:SetInformation( tab )

	self.information = tab

end

--[[---------------------------------------------------------
NAME: SetImage( img )
desc: 
-----------------------------------------------------------]]
function PANEL:SetImage( img )

	if ( !img ) then
	
		if ( IsValid( self.m_Image ) ) then
			self.m_Image:Remove()
		end
	
		return
	end

	if ( !IsValid( self.m_Image ) ) then
		self.m_Image = vgui.Create( "DImage", self )
	end
	
	self.m_Image:SetImage( img )
	self.m_Image:SizeToContents()
	self:InvalidateLayout()

end

PANEL.SetIcon = PANEL.SetImage

--[[---------------------------------------------------------
NAME: Paint( w, h )
desc: 
-----------------------------------------------------------]]
function PANEL:Paint( w, h )
if( self.color.a != 0 ) then
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(0,0,w,h)
	end
	surface.SetDrawColor( self.color )
	surface.DrawRect(1,1,w-2,h-2)

end

--[[---------------------------------------------------------
NAME: UpdateColours( skin )
desc: 
-----------------------------------------------------------]]
function PANEL:UpdateColours( skin )

	if ( self:GetDisabled() )						then return self:SetTextStyleColor( skin.Colours.Button.Disabled ) end
	if ( self.Depressed || self.m_bSelected )		then return self:SetTextStyleColor( skin.Colours.Button.Down ) end
	if ( self.Hovered )								then return self:SetTextStyleColor( skin.Colours.Button.Hover ) end

	return self:SetTextStyleColor( skin.Colours.Button.Normal )

end

--[[---------------------------------------------------------
NAME: PerformLayout()
desc: 
-----------------------------------------------------------]]
function PANEL:PerformLayout()
		
	--
	-- If we have an image we have to place the image on the left
	-- and make the text align to the left, then set the inset
	-- so the text will be to the right of the icon.
	--
	if ( IsValid( self.m_Image ) ) then
			
		self.m_Image:SetPos( 4, (self:GetTall() - self.m_Image:GetTall()) * 0.5 )
		
		self:SetTextInset( self.m_Image:GetWide() + 16, 0 )
		
	end

	DLabel.PerformLayout( self )

end

--[[---------------------------------------------------------
NAME: SetDisabled( bDisabled )
desc: 
-----------------------------------------------------------]]
function PANEL:SetDisabled( bDisabled )

	self.m_bDisabled = bDisabled	
	self:InvalidateLayout()

end

--[[---------------------------------------------------------
NAME: SetConsoleCommand( strName, strArgs )
desc: 
-----------------------------------------------------------]]
function PANEL:SetConsoleCommand( strName, strArgs )

	self.DoClick = function( self, val ) 
						RunConsoleCommand( strName, strArgs ) 
				   end
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

	if( mousecode == MOUSE_RIGHT ) then
		local x,y = input.GetCursorPos()
	elseif( mousecode == MOUSE_LEFT ) then
		local frame = vgui.Create( "DKalenderView" )
		  frame:SetLanguage(self.lang)
		  frame:SetPos(ScrW()-405,285)
		  frame:SetSize(400,ScrH()*0.5)
		  frame:SetTitle( "" .. self:GetInformation().day ..  " " .. self:GetInformation().month .. " " .. self:GetInformation().year .. "" )
		  if( file.Exists( "Kalender/calender_data.txt", "DATA" ) ) then frame:LoadFromFile( file.Read("Kalender/calender_data.txt","DATA") ) end
	end
end


derma.DefineControl( "DKalenderButton", "Kalender Button app", PANEL, "DLabel" )
