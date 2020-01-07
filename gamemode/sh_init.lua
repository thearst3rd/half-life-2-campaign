-- Include the required lua files
include( "sh_config.lua" )
include( "sh_player.lua" )
include( "player_class/player_hl2c.lua" )


-- General gamemode information
GM.Name = "Half-Life 2 Campaign"
GM.Author = "AMT (ported and improved by D4 the Perth Fox)"


-- Constants
FRIENDLY_NPCS = {
	"npc_citizen"
}

GODLIKE_NPCS = {
	"npc_alyx",
	"npc_barney",
	"npc_breen",
	"npc_dog",
	"npc_eli",
	"npc_fisherman",
	"npc_gman",
	"npc_kleiner",
	"npc_magnusson",
	"npc_monk",
	"npc_mossman",
	"npc_vortigaunt"
}


-- Create the teams that we are going to use throughout the game
function GM:CreateTeams()

	TEAM_ALIVE = 1
	team.SetUp( TEAM_ALIVE, "ALIVE", Color( 192, 192, 192, 255 ) )
	
	TEAM_COMPLETED_MAP = 2
	team.SetUp( TEAM_COMPLETED_MAP, "COMPLETED MAP", Color( 255, 215, 0, 255 ) )
	
	TEAM_DEAD = 3
	team.SetUp( TEAM_DEAD, "DEAD", Color( 128, 128, 128, 255 ) )

end


-- Called when a gravity gun is attempting to punt something
function GM:GravGunPunt( ply, ent ) 

	if ( IsValid( ent ) && ent:IsVehicle() && ( ent != ply.vehicle ) && IsValid( ent.creator ) ) then
	
		return false
	
	end

	return true

end 


-- Called when a physgun tries to pick something up
function GM:PhysgunPickup( ply, ent )

	if ( string.find( ent:GetClass(), "trigger_" ) || ( ent:GetClass() == "player" ) ) then
	
		return false
	
	end

	return true

end


-- Player input changes
function GM:StartCommand( ply, ucmd )

	if ( ucmd:KeyDown( IN_SPEED ) && IsValid( ply ) && !ply:IsSuitEquipped() ) then
	
		ucmd:RemoveKey( IN_SPEED )
	
	end

	if ( ucmd:KeyDown( IN_WALK ) && IsValid( ply ) && !ply:IsSuitEquipped() ) then
	
		ucmd:RemoveKey( IN_WALK )
	
	end

end


-- Players should never collide with each other or NPC's
function GM:ShouldCollide( entA, entB )

	-- Player and NPCs
	if ( IsValid( entA ) && IsValid( entB ) && ( ( entA:IsPlayer() && ( entB:IsPlayer() || table.HasValue( GODLIKE_NPCS, entB:GetClass() ) || table.HasValue( FRIENDLY_NPCS, entB:GetClass() ) ) ) || ( entB:IsPlayer() && ( entA:IsPlayer() || table.HasValue( GODLIKE_NPCS, entA:GetClass() ) || table.HasValue( FRIENDLY_NPCS, entA:GetClass() ) ) ) ) ) then
	
		return false
	
	end

	-- Passenger seating
	if ( IsValid( entA ) && IsValid( entB ) && ( ( entA:IsPlayer() && entA:InVehicle() && entA:GetAllowWeaponsInVehicle() && entB:IsVehicle() ) || ( entB:IsPlayer() && entB:InVehicle() && entB:GetAllowWeaponsInVehicle() && entA:IsVehicle() ) ) ) then
	
		return false
	
	end

	return true

end


-- Called when a player is being attacked
function GM:PlayerShouldTakeDamage( ply, attacker )

	if ( ( ply:Team() != TEAM_ALIVE ) || !ply.vulnerable || ( attacker:IsPlayer() && ( attacker != ply ) ) || ( attacker:IsVehicle() && IsValid( attacker:GetDriver() ) && attacker:GetDriver():IsPlayer() ) || table.HasValue( GODLIKE_NPCS, attacker:GetClass() ) || table.HasValue( FRIENDLY_NPCS, attacker:GetClass() ) ) then
	
		return false
	
	end

	return true

end


-- Called after the player's think
function GM:PlayerPostThink( ply )

	-- Manage server data on the player
	if ( SERVER ) then
	
		if ( IsValid( ply ) && ply:Alive() && ( ply:Team() == TEAM_ALIVE ) ) then
		
			-- Give them weapons they don't have
			for _, ply2 in ipairs( player.GetAll() ) do
			
				if ( ( ply != ply2 ) && ply2:Alive() && !ply:InVehicle() && !ply2:InVehicle() && IsValid( ply2:GetActiveWeapon() ) && !ply:HasWeapon( ply2:GetActiveWeapon():GetClass() ) && !table.HasValue( ply.givenWeapons, ply2:GetActiveWeapon():GetClass() ) && ( ply2:GetActiveWeapon():GetClass() != "weapon_physgun" ) ) then
				
					ply:Give( ply2:GetActiveWeapon():GetClass() )
					table.insert( ply.givenWeapons, ply2:GetActiveWeapon():GetClass() )
				
				end
			
			end
		
		end
	
	end

end
