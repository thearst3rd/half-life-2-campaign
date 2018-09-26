INFO_PLAYER_SPAWN = { Vector( -4257, -179, -61 ), -95 }

NEXT_MAP = "d1_trainstation_03"


-- Player spawns
function hl2cPlayerSpawn( ply )

	ply:RemoveSuit()
	timer.Simple( 0.01, function() if ( IsValid( ply ) ) then GAMEMODE:SetPlayerSpeed( ply, 150, 150 ) end end )

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cInitPostEntity()

	game.SetGlobalState( "gordon_precriminal", GLOBAL_ON )
	game.SetGlobalState( "gordon_invulnerable", GLOBAL_ON )

end
hook.Add( "InitPostEntity", "hl2cInitPostEntity", hl2cInitPostEntity )
