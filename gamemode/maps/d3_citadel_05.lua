NEXT_MAP = "d3_breen_01"

NEXT_MAP_PERCENT = 1

SUPER_GRAVITY_GUN = true


-- Player spawns
function HL2C_PlayerSpawn( ply )

	ply:Give( "weapon_physcannon" )

	timer.Simple( 0.1, function() if ( IsValid( ply ) ) then ply:SetNoTarget( true ) end end )

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
	if ( !game.SinglePlayer() ) then
	
		for _, ent in pairs( ents.FindByClass( "env_fade" ) ) do
		
			ent:Remove()
		
		end
	
	end

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "relay_playerpod_resume" ) && ( string.lower( input ) == "kill" ) ) then
	
		return true
	
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
