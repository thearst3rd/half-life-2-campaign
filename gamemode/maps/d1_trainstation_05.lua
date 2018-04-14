NEXT_MAP = "d1_trainstation_06"

TRIGGER_CHECKPOINT = {
	{ Vector( -6509, -1105, 0 ), Vector( -6459, -1099, 92 ) },
	{ Vector( -10461, -4749, 319 ), Vector( -10271, -4689, 341 ) }
}

TRAINSTATION_VIEWCONTROL = false
TRAINSTATION_REMOVESUIT = true


-- Player spawns
function hl2cPlayerSpawn( ply )

	if ( TRAINSTATION_REMOVESUIT ) then
	
		ply:RemoveSuit()
		timer.Simple( 0.01, function() if ( IsValid( ply ) ) then GAMEMODE:SetPlayerSpeed( ply, 150, 150 ) end end )
	
	end

	if ( TRAINSTATION_VIEWCONTROL ) then
	
		ply:Freeze( true )
	
	end

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Entity removed
function hl2cEntityRemoved( ent )

	if ( ent:GetClass() == "item_suit" ) then
	
		TRAINSTATION_REMOVESUIT = false
		for _, ply in pairs( player.GetAll() ) do
		
			ply:EquipSuit()
			ply:SetModel( string.gsub( ply:GetModel(), "group01", "group03" ) )
			ply:SetupHands()
			GAMEMODE:SetPlayerSpeed( ply, 190, 320 )
		
		end
	
	end

end
hook.Add( "EntityRemoved", "hl2cEntityRemoved", hl2cEntityRemoved )


-- Accept input
function hl2cAcceptInput( ent, input, activator, caller, value )

	if ( ( ent:GetName() == "viewcontrol_ickycam" ) && ( string.lower( input ) == "enable" ) ) then
	
		TRAINSTATION_VIEWCONTROL = true
		for _, ply in pairs( player.GetAll() ) do
		
			ply:Freeze( true )
		
		end
	
	end

	if ( ( ent:GetName() == "viewcontrol_ickycam" ) && ( string.lower( input ) == "disable" ) ) then
	
		TRAINSTATION_VIEWCONTROL = false
		for _, ply in pairs( player.GetAll() ) do
		
			ply:Freeze( false )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ( ent:GetName() == "lab_door" ) || ( ent:GetName() == "lab_door_clip" ) ) && ( string.lower( input ) == "close" ) ) then
	
		return true
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "kleiner_teleport_player_starter_1" ) && ( string.lower( input ) == "trigger" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( -7186.700195, -1176.699951, 28 ) )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetClass() == "player_speedmod" ) && ( string.lower( input ) == "modifyspeed" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetLaggedMovementValue( tonumber( value ) )
		
		end
	
	end

end
hook.Add( "AcceptInput", "hl2cAcceptInput", hl2cAcceptInput )
