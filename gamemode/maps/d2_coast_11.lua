NEXT_MAP = "d2_coast_12"

COAST_PREVENT_CAMP_DOOR = false


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:SetName( "!player" )
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

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	ents.FindByName( "global_newgame_template_ammo" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_base_items" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_local_items" )[ 1 ]:Remove()

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && COAST_PREVENT_CAMP_DOOR && ( ent:GetName() == "camp_door" ) && ( string.lower( input ) == "close" ) ) then
	
		return true
	
	end

	if ( !game.SinglePlayer() && COAST_PREVENT_CAMP_DOOR && ( ent:GetName() == "camp_door_blocker" ) && ( string.lower( input ) == "enable" ) ) then
	
		return true
	
	end

	if ( !game.SinglePlayer() && COAST_PREVENT_CAMP_DOOR && ( ent:GetName() == "antlion_cage_door" ) && ( string.lower( input ) == "close" ) ) then
	
		return true
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "music_antlionguard_1" ) && ( string.lower( input ) == "playsound" ) ) then
	
		GAMEMODE:CreateSpawnPoint( Vector( 4393, 6603, 590 ), 65 )
	
	end

	if ( !game.SinglePlayer() && !COAST_PREVENT_CAMP_DOOR && ( ent:GetName() == "vortigaunt_bugbait" ) && ( string.lower( input ) == "extractbugbait" ) ) then
	
		COAST_PREVENT_CAMP_DOOR = true
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
