NEXT_MAP = "d3_citadel_03"

NEXT_MAP_PERCENT = 1

TRIGGER_DELAYMAPLOAD = { Vector( 3781, 13186, 3900 ), Vector( 3984, 13590, 4000 ) }

CITADEL_VEHICLE_VIEWCONTROL = true


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

	timer.Simple( 0.1, function() if ( IsValid( ply ) ) then ply:SetNoTarget( true ) end end )

	if ( !game.SinglePlayer() && CITADEL_VEHICLE_VIEWCONTROL ) then
	
		ents.FindByName( "pod_player_viewcontrol" )[ 1 ]:Fire( "Enable" )
		ply:Spectate( OBS_MODE_ROAMING )
		ply:SetViewEntity( ents.FindByName( "pod_player_viewcontrol" )[ 1 ] )
		ply:Freeze( true )
	
	end

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cMapEdit()

	ents.FindByName( "global_newgame_template_base_items" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_local_items" )[ 1 ]:Remove()

	if ( !game.SinglePlayer() ) then
	
		local viewcontrol = ents.Create( "point_viewcontrol" )
		viewcontrol:SetName( "pod_player_viewcontrol" )
		viewcontrol:SetPos( ents.FindByName( "pod_player" )[ 1 ]:GetPos() )
		viewcontrol:SetKeyValue( "spawnflags", "12" )
		viewcontrol:Spawn()
		viewcontrol:Activate()
		viewcontrol:SetParent( ents.FindByName( "pod_player" )[ 1 ] )
		viewcontrol:Fire( "SetParentAttachment", "vehicle_driver_eyes" )
	
	end

end
hook.Add( "MapEdit", "hl2cMapEdit", hl2cMapEdit )


-- Accept input
function hl2cAcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "track_dump" ) && ( string.lower( input ) == "enable" ) ) then
	
		CITADEL_VEHICLE_VIEWCONTROL = false
	
		if ( timer.Exists( "hl2cUpdatePlayerPosition" ) ) then timer.Destroy( "hl2cUpdatePlayerPosition" ) end
	
		GAMEMODE:CreateSpawnPoint( Vector( 3882, 13388, 3950 ), 0 )
	
		for _, ply in pairs( player.GetAll() ) do
		
			ply:UnSpectate()
			ply:SetViewEntity()
			ply:Freeze( false )
		
			ply:Spawn()
		
		end
	
	end

end
hook.Add( "AcceptInput", "hl2cAcceptInput", hl2cAcceptInput )


if ( !game.SinglePlayer() ) then

	-- Update player position to the vehicle
	function hl2cUpdatePlayerPosition()
	
		for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
		
			if ( IsValid( ply ) && ply:Alive() ) then
			
				ply:SetPos( ents.FindByName( "pod_player" )[ 1 ]:GetPos() )
			
			end
		
		end
	
	end
	timer.Create( "hl2cUpdatePlayerPosition", 0.1, 0, hl2cUpdatePlayerPosition )

end
