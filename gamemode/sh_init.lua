-- Include the required lua files
include( "sh_config.lua" )
include( "sh_player.lua" )


-- General gamemode information
GM.Name = "HALF-LIFE 2: Campaign"
GM.Author = "AMT (ported and improved by D4UNKN0WNM4N2010)"


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
	team.SetUp( TEAM_ALIVE, "Alive", Color( 81, 124, 199, 255 ) )
	
	TEAM_COMPLETED_MAP = 2
	team.SetUp( TEAM_COMPLETED_MAP, "Completed Map", Color( 81, 124, 199, 255 ) )
	
	TEAM_DEAD = 3
	team.SetUp( TEAM_DEAD, "Dead", Color( 128, 128, 128, 255 ) )

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

	if ( ucmd:KeyDown( IN_SPEED ) && IsValid( ply ) && ( !ply:IsSuitEquipped() || ply:GetNWBool( "sprintDisabled", false ) ) ) then
	
		ucmd:RemoveKey( IN_SPEED )
	
	end

	if ( ucmd:KeyDown( IN_WALK ) && IsValid( ply ) && !ply:IsSuitEquipped() ) then
	
		ucmd:RemoveKey( IN_WALK )
	
	end

end


-- Players should never collide with each other or NPC's
function GM:ShouldCollide( entA, entB )

	if ( IsValid( entA ) && IsValid( entB ) && ( ( entA:IsPlayer() && ( entB:IsPlayer() || table.HasValue( GODLIKE_NPCS, entB:GetClass() ) || table.HasValue( FRIENDLY_NPCS, entB:GetClass() ) ) ) || ( entB:IsPlayer() && ( entA:IsPlayer() || table.HasValue( GODLIKE_NPCS, entA:GetClass() ) || table.HasValue( FRIENDLY_NPCS, entA:GetClass() ) ) ) ) ) then
	
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
