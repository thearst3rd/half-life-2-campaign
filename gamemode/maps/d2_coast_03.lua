ALLOWED_VEHICLE = "Jeep"

NEXT_MAP = "d2_coast_04"


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

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	ents.FindByName( "player_spawn_items_maker" )[ 1 ]:Remove()
	ents.FindByName( "jeep_filter" )[ 1 ]:Fire( "AddOutput", "filterclass prop_vehicle_jeep_old" )
	if ( !game.SinglePlayer() ) then
	
		ents.FindByName( "antlion_spawner" )[ 1 ]:Fire( "AddOutput", "spawntarget jeep" )
	
	end

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "basement_gordon_first_entered" ) && ( string.lower( input ) == "trigger" ) ) then
	
		ALLOWED_VEHICLE = nil
		PrintMessage( HUD_PRINTTALK, "Vehicle spawning has been disabled." )
	
		for _, ply in pairs( player.GetAll() ) do
		
			if ( !IsValid( ply.vehicle ) && !ply:InVehicle() ) then
			
				ply:SetVelocity( Vector( 0, 0, 0 ) )
				ply:SetPos( Vector( 8755, 4055, 257 ) )
				ply:SetEyeAngles( Angle( 0, 0, 0 ) )
			
			end
		
		end
		GAMEMODE:CreateSpawnPoint( Vector( 8755, 4055, 257 ), 0 )
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "spawner_rpg" ) && ( string.lower( input ) == "forcespawn" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:Give( "weapon_rpg" )
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "lr_odessa_goodbye" ) && ( string.lower( input ) == "trigger" ) ) then
	
		ALLOWED_VEHICLE = "Jeep"
		PrintMessage( HUD_PRINTTALK, "You're now allowed to spawn the Jeep (F3)." )
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
