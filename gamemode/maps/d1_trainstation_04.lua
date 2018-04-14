NEXT_MAP = "d1_trainstation_05"

TRIGGER_CHECKPOINT = {
	{ Vector( -7075, -4259, 539 ), Vector( -6873, -4241, 649 ) },
	{ Vector( -7665, -4041, -257 ), Vector( -7653, -3879, -143 ) }
}

TRAINSTATION_VIEWCONTROL = false


-- Player spawns
function hl2cPlayerSpawn( ply )

	ply:RemoveSuit()
	timer.Simple( 0.01, function() if ( IsValid( ply ) ) then GAMEMODE:SetPlayerSpeed( ply, 150, 150 ) end end )

	if ( TRAINSTATION_VIEWCONTROL ) then
	
		ents.FindByName( "blackout_viewcontroller" )[ 1 ]:Fire( "Enable" )
		ply:SetViewEntity( ents.FindByName( "blackout_viewcontroller" )[ 1 ] )
		ply:Freeze( true )
	
	end

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cInitPostEntity()

	game.SetGlobalState( "gordon_precriminal", GLOBAL_OFF )
	game.SetGlobalState( "gordon_invulnerable", GLOBAL_OFF )

	if ( !game.SinglePlayer() ) then
	
		ents.FindByName( "kickdown_relay" )[ 1 ]:Remove()
	
		for _, ent in pairs( ents.GetAll() ) do
		
			if ( ent:GetPos() == Vector( -7818, -4128, -176 ) ) then ent:Remove() end
		
		end
	
	end

end
hook.Add( "InitPostEntity", "hl2cInitPostEntity", hl2cInitPostEntity )


-- Accept input
function hl2cAcceptInput( ent, input )

	if ( ( ent:GetName() == "blackout_viewcontroller" ) && ( string.lower( input ) == "enable" ) ) then
	
		TRAINSTATION_VIEWCONTROL = true
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetViewEntity( ent )
			ply:Freeze( true )
		
		end
	
	end

	if ( ( ent:GetName() == "blackout_viewcontroller" ) && ( string.lower( input ) == "disable" ) ) then
	
		TRAINSTATION_VIEWCONTROL = false
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetViewEntity()
			ply:Freeze( false )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "lcs_alyxgreet02" ) && ( string.lower( input ) == "start" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetPos( Vector( -7740, -3960, 407 ) )
			ply:SetEyeAngles( Angle( 0, 0, 0 ) )
		
		end
	
	end

end
hook.Add( "AcceptInput", "hl2cAcceptInput", hl2cAcceptInput )
