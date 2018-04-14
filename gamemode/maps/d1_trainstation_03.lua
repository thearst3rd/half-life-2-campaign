NEXT_MAP = "d1_trainstation_04"

TRIGGER_CHECKPOINT = {
	{ Vector( -4998, -4918, 512 ), Vector( -4978, -4699, 619 ) }
}


-- Player spawns
function hl2cPlayerSpawn( ply )

	ply:RemoveSuit()
	timer.Simple( 0.01, function() if ( IsValid( ply ) ) then GAMEMODE:SetPlayerSpeed( ply, 100, 100 ) end end )

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cInitPostEntity()

	game.SetGlobalState( "gordon_precriminal", GLOBAL_ON )
	game.SetGlobalState( "gordon_invulnerable", GLOBAL_ON )

	if ( !game.SinglePlayer() ) then
	
		ents.FindByName( "npc_breakincop3" )[ 1 ]:Remove()
		ents.FindByName( "ai_breakin_cop3goal3_blockplayer" )[ 1 ]:Remove()
		ents.FindByName( "ai_breakin_cop3goal3_blockplayer2" )[ 1 ]:Remove()
		ents.FindByName( "ai_breakin_cop3goal4_blockplayer" )[ 1 ]:Remove()
	
	end

end
hook.Add( "InitPostEntity", "hl2cInitPostEntity", hl2cInitPostEntity )


-- Accept input
function hl2cAcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "lcs_RaidRunner_1" ) && ( string.lower( input ) == "start" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetPos( Vector( -3900, -4507, 385 ) )
			ply:SetEyeAngles( Angle( 0, -260, 0 ) )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "lcs_cit_blocker_holdem" ) && ( string.lower( input ) == "start" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetPos( Vector( -4956, -4752, 513 ) )
			ply:SetEyeAngles( Angle( 0, -150, 0 ) )
		
		end
	
	end

end
hook.Add( "AcceptInput", "hl2cAcceptInput", hl2cAcceptInput )
