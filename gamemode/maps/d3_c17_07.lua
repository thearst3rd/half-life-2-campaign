INFO_PLAYER_SPAWN = { Vector( 4435, 1211, 291 ), 0 }

NEXT_MAP = "d3_c17_08"

TRIGGER_CHECKPOINT = {
	{ Vector( 7284, 1410, -3 ), Vector( 7341, 1663, 157 ) }
}


-- Player spawns
function hl2cPlayerSpawn( ply )

	ply:Give( "weapon_crowbar" )
	ply:Give( "weapon_pistol" )
	ply:Give( "weapon_smg1" )
	ply:Give( "weapon_357" )
	ply:Give( "weapon_frag" )
	ply:Give( "weapon_physcannon" )
	ply:Give( "weapon_shotgun" )
	ply:Give( "weapon_ar2" )
	ply:Give( "weapon_rpg" )
	ply:Give( "weapon_crossbow" )
	ply:Give( "weapon_bugbait" )

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cInitPostEntity()

	ents.FindByName( "player_items_template" )[ 1 ]:Remove()

end
hook.Add( "InitPostEntity", "hl2cInitPostEntity", hl2cInitPostEntity )
