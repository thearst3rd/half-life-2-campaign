NEXT_MAP = "d1_town_02"

TRIGGER_DELAYMAPLOAD = { Vector( -3801, -65, -3457 ), Vector( -3719, -7, -3335 ) }

if ( !file.Exists( "half-life_2_campaign/d1_town_03.txt", "DATA" ) ) then

	file.Write( "half-life_2_campaign/d1_town_03.txt", "We have been to d1_town_03." )

end


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:Give( "weapon_crowbar" )
	ply:Give( "weapon_pistol" )
	ply:Give( "weapon_smg1" )
	ply:Give( "weapon_357" )
	ply:Give( "weapon_frag" )
	ply:Give( "weapon_physcannon" )
	ply:Give( "weapon_shotgun" )

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	ents.FindByName( "startobjects_template" )[ 1 ]:Remove()

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )
