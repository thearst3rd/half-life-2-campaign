NEXT_MAP = "d1_canals_01a"

CANALS_TRAIN_PREVENT_STARTFOWARD = false


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:Give( "weapon_crowbar" )

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	ents.FindByName( "start_item_template" )[ 1 ]:Remove()
	if ( !game.SinglePlayer() ) then ents.FindByName( "boxcar_door_close" )[ 1 ]:Remove() end

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "barrelpush_cop1_sched" ) && ( string.lower( input ) == "startschedule" ) ) then
	
		CANALS_TRAIN_PREVENT_STARTFOWARD = true
	
	end

	if ( !game.SinglePlayer() && CANALS_TRAIN_PREVENT_STARTFOWARD && ( ent:GetName() == "looping_traincar1" ) && ( string.lower( input ) == "startforward" ) ) then
	
		return true
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "looping_traincar2" ) && ( string.lower( input ) == "startforward" ) ) then
	
		return true
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
