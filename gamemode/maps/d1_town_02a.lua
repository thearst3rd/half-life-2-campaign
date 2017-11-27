NEXT_MAP = "d1_town_04"

if ( file.Exists( "half-life_2_campaign/d1_town_03.txt", "DATA" ) ) then

	file.Delete( "half-life_2_campaign/d1_town_03.txt" )

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

	local monk = ents.Create( "npc_monk" )
	monk:SetPos( Vector( -5221, 2034, -3240 ) )
	monk:SetAngles( Angle( 0, 90, 0 ) )
	monk:SetName( "monk" )
	monk:SetKeyValue( "additionalequipment", "weapon_annabelle" )
	monk:SetKeyValue( "spawnflags", "4" )
	monk:Spawn()
	monk:Activate()

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )


-- Accept input
function HL2C_AcceptInput( ent, input )

	if ( !game.SinglePlayer() && ( ent:GetName() == "graveyard_exit_door" ) && ( string.lower( input ) == "setposition" ) ) then
	
		ent:Fire( "Open" )
		return true
	
	end

end
hook.Add( "AcceptInput", "HL2C_AcceptInput", HL2C_AcceptInput )
