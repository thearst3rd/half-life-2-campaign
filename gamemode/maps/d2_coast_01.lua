NEXT_MAP = "d2_coast_03"


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

	ents.FindByName( "global_newgame_template_ammo" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_base_items" )[ 1 ]:Remove()
	ents.FindByName( "global_newgame_template_local_items" )[ 1 ]:Remove()

	ents.FindByName( "jeep" )[ 1 ]:Fire( "EnableGun", "1" )
	ents.FindByName( "jeep" )[ 1 ]:SetBodygroup( 1, 1 )

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "logic_startcraneseq" ) && ( string.lower( input ) == "trigger" ) ) then
	
		ALLOWED_VEHICLE = "Jeep"
		PrintMessage( HUD_PRINTTALK, "You're now allowed to spawn the Jeep (F3)." )
	
	end

	if ( !game.SinglePlayer() && ( ent:GetName() == "push_car_superjump_01" ) && ( string.lower( input ) == "disable" ) ) then
	
		return true
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
