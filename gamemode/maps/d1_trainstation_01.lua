NEXT_MAP = "d1_trainstation_02"

RESET_PL_INFO = true

TRIGGER_CHECKPOINT = {
	{ Vector( -9386, -2488, 24 ), Vector( -9264, -2367, 92 ), true },
	{ Vector( -5396, -1984, 16 ), Vector( -5310, -1932, 113 ) },
	{ Vector( -3609, -338, -24 ), Vector( -3268, -141, 54 ) }
}

TRAINSTATION_VIEWCONTROL = true
TRAINSTATION_LEAVEBARNEYDOOROPEN = false


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:RemoveSuit()
	timer.Simple( 0.01, function() if ( IsValid( ply ) ) then GAMEMODE:SetPlayerSpeed( ply, 150, 150 ) end end )

	if ( TRAINSTATION_VIEWCONTROL ) then
	
		ents.FindByName( "viewcontrol_final" )[ 1 ]:Fire( "Enable" )
		ply:SetViewEntity( ents.FindByName( "viewcontrol_final" )[ 1 ] )
		ply:Freeze( true )
	
	end

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	if ( !game.SinglePlayer() ) then
	
		ents.FindByName( "razor_gate_retreat_block_2" )[ 1 ]:Remove()
		ents.FindByName( "cage_playerclip" )[ 1 ]:Remove()
		ents.FindByName( "barney_room_blocker_2" )[ 1 ]:Remove()
	
	end

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( ( ent:GetName() == "viewcontrol_final" ) && ( string.lower( input ) == "disable" ) ) then
	
		TRAINSTATION_VIEWCONTROL = false
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetViewEntity()
			ply:Freeze( false )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "point_teleport_destination" ) && ( string.lower( input ) == "teleport" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( ent:GetPos() )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "storage_room_door" ) && ( string.lower( input ) == "close" ) ) then
	
		return true
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "razor_train_gate_2" ) && ( string.lower( input ) == "close" ) ) then
	
		TRAINSTATION_LEAVEBARNEYDOOROPEN = true
	
	end

	if ( !game.SinglePlayer() && TRAINSTATION_LEAVEBARNEYDOOROPEN && ( ent:GetName() == "barney_door_1" ) && ( string.lower( input ) == "close" ) ) then
	
		return true
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
