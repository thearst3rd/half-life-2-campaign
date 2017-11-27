ALLOWED_VEHICLE = "Airboat"

INFO_PLAYER_SPAWN = { Vector( 7512, -11398, -438 ), 0 }

NEXT_MAP = "d1_canals_09"


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:Give( "weapon_crowbar" )
	ply:Give( "weapon_pistol" )
	ply:Give( "weapon_smg1" )

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	ents.FindByName( "global_newgame_template" )[ 1 ]:Remove()
	if ( !game.SinglePlayer() ) then ents.FindByName( "trigger_close_gates" )[ 1 ]:Remove() end

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )
