ALLOWED_VEHICLE = "Airboat Gun"

NEXT_MAP = "d1_canals_13"


-- Player spawns
function hl2cPlayerSpawn( ply )

	ply:Give( "weapon_crowbar" )
	ply:Give( "weapon_pistol" )
	ply:Give( "weapon_smg1" )
	ply:Give( "weapon_357" )

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cInitPostEntity()

	ents.FindByName( "global_newgame_template" )[ 1 ]:Remove()

end
hook.Add( "InitPostEntity", "hl2cInitPostEntity", hl2cInitPostEntity )
