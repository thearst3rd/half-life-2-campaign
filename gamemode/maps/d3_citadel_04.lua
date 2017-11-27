NEXT_MAP = "d3_citadel_05"

SUPER_GRAVITY_GUN = true

CITADEL_ELEVATOR_CHECKPOINT1 = false
CITADEL_ELEVATOR_CHECKPOINT2 = true


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:Give( "weapon_physcannon" )

end
hook.Add( "PlayerSpawn", "HL2C_PlayerSpawn", HL2C_PlayerSpawn )


-- Initialize entities
function HL2C_InitPostEntity()

	game.ConsoleCommand( "physcannon_tracelength 850\n" )
	game.ConsoleCommand( "physcannon_maxmass 850\n" )
	game.ConsoleCommand( "physcannon_pullforce 8000\n" )

	ents.FindByName( "global_newgame_template_ammo" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_base_items" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_local_items" )[ 1 ]:Remove()

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && !CITADEL_ELEVATOR_CHECKPOINT1 && ( ent:GetName() == "citadel_brush_elevcage1_1" ) && ( string.lower( input ) == "enable" ) ) then
	
		CITADEL_ELEVATOR_CHECKPOINT1 = true
		CITADEL_ELEVATOR_CHECKPOINT2 = false
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( 256, 832, 2320 ) )
			ply:SetEyeAngles( Angle( 0, -90, 0 ) )
		
		end
	
	end

	if ( !game.SinglePlayer() && !CITADEL_ELEVATOR_CHECKPOINT2 && ( ent:GetName() == "citadel_path_lift01_1" ) && ( string.lower( input ) == "inpass" ) ) then
	
		CITADEL_ELEVATOR_CHECKPOINT2 = true
		for _, ply in pairs( player.GetAll() ) do
		
			ply:SetVelocity( Vector( 0, 0, 0 ) )
			ply:SetPos( Vector( 256, 832, 6420 ) )
			ply:SetEyeAngles( Angle( 0, -90, 0 ) )
		
		end
		GAMEMODE:CreateSpawnPoint( Vector( 256, 832, 6420 ), -90 )
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )


-- Every frame or tick
function HL2C_Think()

	if ( SUPER_GRAVITY_GUN ) then
	
		for _, ent in pairs( ents.FindByClass( "ai_weapon_*" ) ) do
		
			if ( IsValid( ent ) && ent:IsWeapon() && ( !IsValid( ent:GetOwner() ) ) ) then
			
				ent:Remove()
			
			end
		
		end
	
		for _, ent in pairs( ents.FindByClass( "weapon_*" ) ) do
		
			if ( IsValid( ent ) && ent:IsWeapon() && ( ent:GetClass() != "weapon_physcannon" ) ) then
			
				ent:Remove()
			
			end
		
		end
	
		for _, ent in pairs( ents.FindByClass( "weapon_physcannon" ) ) do
		
			if ( IsValid( ent ) && ent:IsWeapon() ) then
			
				if ( ent:GetSkin() != 1 ) then ent:SetSkin( 1 ) end
			
			end
		
		end
	
		for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
		
			if ( IsValid( ply ) && ply:Alive() && IsValid( ply:GetActiveWeapon() ) && ( ply:GetActiveWeapon():GetClass() == "weapon_physcannon" ) ) then
			
				if ( ply:GetViewModel():GetModel() != "models/weapons/c_superphyscannon.mdl" ) then ply:GetViewModel():SetModel( "models/weapons/c_superphyscannon.mdl" ) end
			
			end
		
		end
	
	end

end
hook.Add( "Think", "HL2C_Think", HL2C_Think )
