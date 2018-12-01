NEXT_MAP = "d3_breen_01"

NEXT_MAP_PERCENT = 1


-- Player spawns
function hl2cPlayerSpawn( ply )

	ply:Give( "weapon_physcannon" )

	timer.Simple( 0.1, function() if ( IsValid( ply ) ) then ply:SetNoTarget( true ) end end )

end
hook.Add( "PlayerSpawn", "hl2cPlayerSpawn", hl2cPlayerSpawn )


-- Initialize entities
function hl2cInitPostEntity()

	SetGlobalBool( "SUPER_GRAVITY_GUN", true )

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
hook.Add( "InitPostEntity", "hl2cInitPostEntity", hl2cInitPostEntity )


-- Accept input
function hl2cAcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "relay_playerpod_resume" ) && ( string.lower( input ) == "kill" ) ) then
	
		return true
	
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
