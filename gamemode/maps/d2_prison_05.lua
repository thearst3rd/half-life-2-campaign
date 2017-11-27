INFO_PLAYER_SPAWN = { Vector( 1439, 612, 388 ), 90 }

NEXT_MAP = "d2_prison_06"


-- Player initial spawn
function HL2C_PlayerInitialSpawn( ply )

	ply:SendLua( "table.insert( FRIENDLY_NPCS, \"npc_antlion\" )" )

end
hook.Add( "PlayerInitialSpawn", "HL2C_PlayerInitialSpawn", HL2C_PlayerInitialSpawn )


-- Player spawns
function HL2C_PlayerSpawn( ply )

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
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	game.SetGlobalState( "antlion_allied", GLOBAL_ON )

	table.insert( FRIENDLY_NPCS, "npc_antlion" )

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "point_of_no_return" ) && ( string.lower( input ) == "enable" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( -3662, -548, 439 ) )
			ply:SetEyeAngles( Angle( 0, 180, 0 ) )
		
		end
		GAMEMODE:CreateSpawnPoint( Vector( -4650, -745, 641 ), -50 )
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
