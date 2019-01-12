INFO_PLAYER_SPAWN = { Vector( -2489, -1292, 580 ), 90 }

NEXT_MAP_PERCENT = 1

RESET_WEAPONS = true

TRIGGER_DELAYMAPLOAD = { Vector( 14095, 15311, 14964 ), Vector( 13702, 14514, 15000 ) }

if ( PLAY_EPISODE_1 ) then

	NEXT_MAP = "ep1_citadel_00"

else

	NEXT_MAP = "d1_trainstation_01"

end

BREEN_VEHICLE_VIEWCONTROL = true


-- Player spawns
function hl2cPlayerSpawn( ply )

	if ( !game.SinglePlayer() && BREEN_VEHICLE_VIEWCONTROL ) then
	
		ents.FindByName( "pod_viewcontrol" )[ 1 ]:Fire( "Enable" )
		ply:Spectate( OBS_MODE_ROAMING )
		ply:SetViewEntity( ents.FindByName( "pod_viewcontrol" )[ 1 ] )
		ply:Freeze( true )
	
	end

	if ( game.SinglePlayer() && IsValid( ents.FindByName( "pod" )[ 1 ] ) ) then
	
		ply:EnterVehicle( ents.FindByName( "pod" )[ 1 ] )
	
	end

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cMapEdit()

	game.SetGlobalState( "super_phys_gun", GLOBAL_ON )

	SetGlobalBool( "SUPER_GRAVITY_GUN", true )

	game.ConsoleCommand( "physcannon_tracelength 850\n" )
	game.ConsoleCommand( "physcannon_maxmass 850\n" )
	game.ConsoleCommand( "physcannon_pullforce 8000\n" )

	if ( !game.SinglePlayer() ) then
	
		ents.FindByName( "citadel_template_combinewall_start1" )[ 1 ]:Remove()
	
		local viewcontrol = ents.Create( "point_viewcontrol" )
		viewcontrol:SetName( "pod_viewcontrol" )
		viewcontrol:SetPos( ents.FindByName( "pod" )[ 1 ]:GetPos() )
		viewcontrol:SetKeyValue( "spawnflags", "12" )
		viewcontrol:Spawn()
		viewcontrol:Activate()
		viewcontrol:SetParent( ents.FindByName( "pod" )[ 1 ] )
		viewcontrol:Fire( "SetParentAttachment", "vehicle_driver_eyes" )
	
	end

end
hook.Add( "MapEdit", "hl2cMapEdit", hl2cMapEdit )


-- Accept input
function hl2cAcceptInput( ent, input, activator, caller, value )

	if ( !game.SinglePlayer() && ( ent:GetName() == "logic_fade_view" ) && ( string.lower( input ) == "trigger" ) ) then
	
		BREEN_VEHICLE_VIEWCONTROL = false
	
		if ( timer.Exists( "hl2cUpdatePlayerPosition" ) ) then timer.Destroy( "hl2cUpdatePlayerPosition" ) end
	
		GAMEMODE:CreateSpawnPoint( Vector( -1875, 887, 591 ), 265.5 )
		for _, ply in pairs( player.GetAll() ) do
		
			ply:UnSpectate()
			ply:SetViewEntity()
			ply:Freeze( false )
		
			ply:Spawn()
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "clip_door_BreenElevator" ) && ( string.lower( input ) == "enable" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( -1968, 0, 600 ) )
			ply:SetEyeAngles( Angle( 0, -90, 0 ) )
		
		end
		GAMEMODE:CreateSpawnPoint( Vector( -1860, 0, 1380 ), 0 )
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "lcs_al_doworst" ) && ( string.lower( input ) == "start" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( -1056, 464, 1340 ) )
			ply:SetEyeAngles( Angle( 0, -90, 0 ) )
		
		end
		GAMEMODE:CreateSpawnPoint( Vector( -1056, 300, -200 ), -90 )
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "citadel_scene_al_rift1" ) && ( string.lower( input ) == "start" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( -640, -400, 1320 ) )
			ply:SetEyeAngles( Angle( 0, 35, 0 ) )
		
		end
		GAMEMODE:CreateSpawnPoint( Vector( -640, -400, 1320 ), 35 )
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "relay_portalfinalexplodeshake" ) && ( string.lower( input ) == "trigger" ) ) then
	
		SUPER_GRAVITY_GUN = false
	
		game.ConsoleCommand( "physcannon_tracelength 250\n" )
		game.ConsoleCommand( "physcannon_maxmass 250\n" )
		game.ConsoleCommand( "physcannon_pullforce 4000\n" )
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "teleport_player_gman_1" ) && ( string.lower( input ) == "teleport" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetPos( ent:GetPos() )
			ply:Lock()
		
		end
	
	end

	if ( !game.SinglePlayer() && ( ent:GetClass() == "player_speedmod" ) && ( string.lower( input ) == "modifyspeed" ) ) then
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetLaggedMovementValue( tonumber( value ) )
		
		end
	
	end

end
hook.Add( "AcceptInput", "hl2cAcceptInput", hl2cAcceptInput )


-- Every frame or tick
function hl2cThink()

	if ( GetGlobalBool( "SUPER_GRAVITY_GUN" ) ) then
	
		for _, ent in pairs( ents.FindByClass( "weapon_physcannon" ) ) do
		
			if ( IsValid( ent ) && ent:IsWeapon() ) then
			
				if ( ent:GetSkin() != 1 ) then ent:SetSkin( 1 ); end
			
			end
		
		end
	
		for _, ent in pairs( ents.FindByClass( "weapon_*" ) ) do
		
			if ( IsValid( ent ) && ent:IsWeapon() && ( ent:GetClass() != "weapon_physcannon" ) && ( !IsValid( ent:GetOwner() ) || ( IsValid( ent:GetOwner() ) && ent:GetOwner():IsPlayer() ) ) ) then
			
				ent:Remove()
			
			end
		
		end
	
	end

end
hook.Add( "Think", "hl2cThink", hl2cThink )


if ( !game.SinglePlayer() ) then

	-- Update player position to the vehicle
	function hl2cUpdatePlayerPosition()
	
		for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
		
			if ( IsValid( ply ) && IsValid( ents.FindByName( "pod" )[ 1 ] ) && ply:Alive() ) then
			
				ply:SetPos( ents.FindByName( "pod" )[ 1 ]:GetPos() )
			
			end
		
		end
	
	end
	timer.Create( "hl2cUpdatePlayerPosition", 0.1, 0, hl2cUpdatePlayerPosition )

end
