-- Include the required lua files
include( "sh_init.lua" )
include( "cl_scoreboard.lua" )


-- Create data folders
if ( !file.IsDir( "half-life_2_campaign", "DATA" ) ) then

	file.CreateDir( "half-life_2_campaign" )

end

if ( !file.IsDir( "half-life_2_campaign/client", "DATA" ) ) then

	file.CreateDir( "half-life_2_campaign/client" )

end


-- Create some client console variables
CreateConVar( "cl_playercolor", "0.24 0.34 0.41", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "The value is a Vector - so between 0-1 - not between 0-255" )
CreateConVar( "cl_playerskin", "0", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "The skin to use, if the model has any" )
CreateConVar( "cl_playerbodygroups", "0", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "The bodygroups to use, if the model has any" )

local hl2c_cl_drawhalos = CreateClientConVar( "hl2c_cl_drawhalos", "1" )


-- Client only constants
DROWNING_SOUNDS = {
	"player/pl_drown1.wav",
	"player/pl_drown2.wav",
	"player/pl_drown3.wav"
}


-- Called by ShowScoreboard
function GM:CreateScoreboard()

	if ( scoreboard ) then
	
		scoreboard:Remove()
		scoreboard = nil
	
	end

	scoreboard = vgui.Create( "scoreboard" )

end


-- This creates the drowning effect
function DrowningEffect( len )

	surface.PlaySound( DROWNING_SOUNDS[ math.random( 1, #DROWNING_SOUNDS ) ] )
	deAlpha = 100
	deAlphaUpdate = 0

end
net.Receive( "DrowningEffect", DrowningEffect )


-- Do not want!
function GM:HUDDrawScoreBoard()
end


-- Called every frame to draw the hud
function GM:HUDPaint()

	if ( ( !GetConVar( "cl_drawhud" ):GetBool() ) || ( self.ShowScoreboard && IsValid( LocalPlayer() ) && ( LocalPlayer():Team() != TEAM_DEAD ) ) ) then
	
		return
	
	end

	self:HUDDrawTargetID()
	self:HUDDrawPickupHistory()
	surface.SetDrawColor( 0, 0, 0, 0 )

	w = ScrW()
	h = ScrH()
	centerX = w / 2
	centerY = h / 2

	-- Draw nav marker/point
	if ( showNav && checkpointPosition && ( LocalPlayer():Team() == TEAM_ALIVE ) ) then
	
		local checkpointDistance = math.Round( LocalPlayer():GetPos():Distance( checkpointPosition ) / 39 )
		local checkpointPositionScreen = checkpointPosition:ToScreen()
	
		surface.SetDrawColor( 255, 255, 255, 255 )
	
		if ( ( checkpointPositionScreen.x > 32 ) && ( checkpointPositionScreen.x < ( w - 43 ) ) && ( checkpointPositionScreen.y > 32 ) && ( checkpointPositionScreen.y < ( h - 38 ) ) ) then
		
			surface.SetTexture( surface.GetTextureID( "hl2c_nav_marker" ) )
			surface.DrawTexturedRect( checkpointPositionScreen.x - 14, checkpointPositionScreen.y - 14, 28, 28 )
			draw.DrawText( tostring( checkpointDistance ).." m", "arial16", checkpointPositionScreen.x, checkpointPositionScreen.y + 15, Color( 255, 220, 0, 255 ), 1 )
		
		else
		
			local r = math.Round( centerX / 2 )
			local checkpointPositionRad = math.atan2( checkpointPositionScreen.y - centerY, checkpointPositionScreen.x - centerX )
			local checkpointPositionDeg = 0 - math.Round( math.deg( checkpointPositionRad ) )
			surface.SetTexture( surface.GetTextureID( "hl2c_nav_pointer" ) )
			surface.DrawTexturedRectRotated( math.cos( checkpointPositionRad ) * r + centerX, math.sin( checkpointPositionRad ) * r + centerY, 32, 32, checkpointPositionDeg + 90 )
		
		end
	
	end

	if ( LocalPlayer():Team() == TEAM_DEAD ) then	-- If dead, then draw spectator letterbox
	
		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 0, 0, w, h * 0.10 )
		surface.DrawRect( 0, h - h * 0.10, w, h * 0.10 )
	
	else
	
		-- Drowning Effect
		if ( deAlpha && ( deAlpha > 0 ) ) then
		
			if ( CurTime() >= ( deAlphaUpdate + 0.01 ) ) then
			
				deAlpha = deAlpha - 1
				deAlphaUpdate = CurTime()
			
			end
		
			surface.SetDrawColor( 0, 0, 255, deAlpha )
			surface.DrawRect( 0, 0, w, h )
		
		end
	
		-- Aux bar
		if ( energy < 100 ) then
		
			draw.RoundedBox( 8, ( ScrH() - h * 0.132 ) / 27.75, ScrH() - h * 0.132, h * 0.026 * 8.2, h * 0.026, Color( 0, 0, 0, 75 ) )
			surface.SetDrawColor( 236, 210, 37, 150 )
			surface.DrawRect( ( ScrH() - h * 0.126 ) / 22.3, ScrH() - h * 0.126, ( energy / 100 ) * ( h * 0.015 * 12.75 ), h * 0.015 )
		
		end
	
	end

	-- Are we going to the next map?
	if ( nextMapCountdownStart ) then
	
		local nextMapCountdownLeft = math.Round( nextMapCountdownStart + NEXT_MAP_TIME - CurTime() )
		if ( nextMapCountdownLeft > 0 ) then
		
			draw.DrawText( "Next Map in "..tostring( nextMapCountdownLeft ), "impact32", centerX, h - h * 0.075, Color( 255, 255, 255, 200 ), 1 )
		
		else
		
			draw.DrawText( "Switching Maps!", "impact32", centerX, h - h * 0.075, Color( 255, 255, 255, 200 ), 1 )
		
		end
	
	end

	-- Are we restarting the map?
	if ( restartMapCountdownStart ) then
	
		local restartMapCountdownLeft = math.Round( restartMapCountdownStart + RESTART_MAP_TIME - CurTime() )
		if ( restartMapCountdownLeft > 0 ) then
		
			draw.DrawText( "Restarting Map in "..tostring( restartMapCountdownLeft ), "impact32", centerX, h - h * 0.075, Color( 255, 255, 255, 200 ), 1 )
		
		else
		
			draw.DrawText( "Restarting Map!", "impact32", centerX, h - h * 0.075, Color( 255, 255, 255, 200 ), 1 )
		
		end
	
	end

	-- On top of it all
	self:DrawDeathNotice( 0.85, 0.04 )

end


-- Called every frame
function GM:HUDShouldDraw( name )

	if ( IsValid( LocalPlayer() ) ) then
	
		if ( self.ShowScoreboard && ( LocalPlayer():Team() != TEAM_DEAD ) ) then
		
			return false
		
		end
	
		local wep = LocalPlayer():GetActiveWeapon()
	
		if ( IsValid( wep ) && ( wep.HUDShouldDraw != nil ) ) then
		
			return wep.HUDShouldDraw( wep, name )
		
		end
	
 	end

	return true

end


-- Called when we initialize
function GM:Initialize()

	-- Initial variables for client
	energy = 100
	self.ShowScoreboard = false
	showNav = false
	scoreboard = nil
	haloPlayerTable = {}

	-- Fonts we will need later
	surface.CreateFont( "arial16", { size = 16, weight = 400, antialias = true, additive = false, font = "Arial" } )
	surface.CreateFont( "arial16Bold", { size = 16, weight = 700, antialias = true, additive = false, font = "Arial" } )
	surface.CreateFont( "coolvetica72", { size = 72, weight = 500, antialias = true, additive = false, font = "coolvetica" } )
	surface.CreateFont( "impact32", { size = 32, weight = 400, antialias = true, additive = false, font = "Impact" } )

	-- Language
	language.Add( "worldspawn", "World" )
	language.Add( "func_door_rotating", "Door" )
	language.Add( "func_door", "Door" )
	language.Add( "phys_magnet", "Magnet" )
	language.Add( "trigger_hurt", "Trigger Hurt" )
	language.Add( "entityflame", "Fire" )
	language.Add( "env_explosion", "Explosion" )
	language.Add( "env_fire", "Fire" )
	language.Add( "func_tracktrain", "Train" )
	language.Add( "npc_launcher", "Headcrab Pod" )
	language.Add( "func_tank", "Mounted Turret" )
	language.Add( "npc_helicopter", "Helicopter" )
	language.Add( "npc_bullseye", "Turret" )
	language.Add( "prop_vehicle_apc", "APC" )
	language.Add( "item_healthvial", "Health Vial" )
	language.Add( "combine_mine", "Mine" )
	language.Add( "npc_grenade_frag", "Grenade" )
	language.Add( "npc_metropolice", "Civil Protection" )
	language.Add( "npc_combine_s", "Combine Soldier" )
	language.Add( "npc_strider", "Strider" )

	-- Run these commands for a more HL2 style gameplay
	RunConsoleCommand( "r_radiosity", "4" )
	RunConsoleCommand( "hud_draw_fixed_reticle", "1" )

end


-- Called when a bind is pressed
function GM:PlayerBindPress( ply, bind, down )

	if ( ( bind == "+menu" ) && down ) then
	
		RunConsoleCommand( "lastinv" )
		return true
	
	end

	return false

end


-- Called when a player sends a chat message
function GM:OnPlayerChat( ply, text, team, dead )

	local tab = {}

	if ( dead || ( ply:Team() == TEAM_DEAD ) ) then
	
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "*DEAD* " )
	
	end

	if ( team ) then
	
		table.insert( tab, Color( 30, 160, 40 ) )
		table.insert( tab, "(TEAM) " )
	
	end

	if ( IsValid( ply ) ) then
	
		table.insert( tab, ply )
	
	else
	
		table.insert( tab, "Console" )
	
	end

	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, ": "..text )

	chat.AddText( unpack( tab ) )
	chat.PlaySound()

	return true

end


-- Called when going to the next map
function NextMap( len )

	nextMapCountdownStart = net.ReadInt( 32 )

	if ( LocalPlayer():Team() != TEAM_ALIVE ) then
	
		GAMEMODE:ScoreboardShow()
	
	end

end
net.Receive( "NextMap", NextMap )


-- Called when player spawns for the first time
function PlayerInitialSpawn( len )

	if ( !file.Exists( "half-life_2_campaign/client/shown_help.txt", "DATA" ) ) then
	
		ShowHelp( 0 )
		file.Write( "half-life_2_campaign/client/shown_help.txt", "You've viewed the help menu in Half-Life 2 Campaign." )
	
	end
	checkpointPosition = net.ReadVector()

end
net.Receive( "PlayerInitialSpawn", PlayerInitialSpawn )


-- Called when restarting maps
function RestartMap( len )

	restartMapCountdownStart = net.ReadInt( 32 )

	GAMEMODE:ScoreboardShow()

end
net.Receive( "RestartMap", RestartMap )


-- Called by show help
function ShowHelp( len )

	local helpText = "-= KEYBOARD SHORTCUTS =-\n[F1] (Show Help) - Opens this menu.\n[F2] (Show Team) - Toggles the navigation marker on your HUD.\n[F3] (Spare 1) - Spawns a vehicle if allowed.\n[F4] (Spare 2) - Removes a vehicle if you have one.\n\n-= OTHER NOTES =-\nOnce you're dead you cannot respawn until the next map."

	local helpMenu = vgui.Create( "DFrame" )
	local helpPanel = vgui.Create( "DPanel", helpMenu )
	local helpLabel = vgui.Create( "DLabel", helpPanel )

	helpLabel:SetText( helpText )
	helpLabel:SetTextColor( color_black )
	helpLabel:SizeToContents()
	helpLabel:SetPos( 5, 5 )

	local w, h = helpLabel:GetSize()
	helpMenu:SetSize( w + 20, h + 43 )

	helpPanel:StretchToParent( 5, 28, 5, 5 )

	helpMenu:SetTitle( "Help" )
	helpMenu:Center()
	helpMenu:MakePopup()

end
net.Receive( "ShowHelp", ShowHelp )


-- Called by client pressing -score
function GM:ScoreboardHide()

	self.ShowScoreboard = false

	if ( scoreboard ) then
	
		scoreboard:SetVisible( false )
	
	end

	gui.EnableScreenClicker( false )

end


-- Called by client pressing +score
function GM:ScoreboardShow()

	if ( game.SinglePlayer() ) then return end

	self.ShowScoreboard = true

	if ( !scoreboard ) then
	
		self:CreateScoreboard()
	
	end

	scoreboard:SetVisible( true )
	scoreboard:UpdateScoreboard( true )

	gui.EnableScreenClicker( true )

end


-- Called by the Halo library
function GM:PreDrawHalos()

	if ( #haloPlayerTable > 0 ) then haloPlayerTable = {} end

	if ( ( ( 1 / RealFrameTime() ) >= 30 ) && showNav && hl2c_cl_drawhalos:GetBool() ) then
	
		for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
		
			if ( IsValid( ply ) && ( ply != LocalPlayer() ) && ply:Alive() && !ply:IsLineOfSightClear( LocalPlayer() ) ) then
			
				table.insert( haloPlayerTable, ply )
			
			end
		
		end
	
		if ( #haloPlayerTable > 0 ) then halo.Add( haloPlayerTable, Color( 0, 255, 0 ), 2, 2, 2, true, true ) end
	
	end

end


-- Called by ShowTeam
function ShowTeam( len )

	showNav = !showNav

end
net.Receive( "ShowTeam", ShowTeam )


-- Called by server
function SetCheckpointPosition( len )

	checkpointPosition = net.ReadVector()

end
net.Receive( "SetCheckpointPosition", SetCheckpointPosition )


-- Called by server Think()
function UpdateEnergy( len )

	energy = net.ReadInt( 16 )

end
net.Receive( "UpdateEnergy", UpdateEnergy )
