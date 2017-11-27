-- Function to return a good player to spectate
function HL2C_EXTRAS.GetPlayerToSpectate()

	for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
	
		if ( IsValid( ply ) && ply:Alive() ) then
		
			return ply
		
		end
	
	end

	return nil

end


-- Time the observer stuff
function HL2C_EXTRAS.UpdatePlayerSpectatorEntity()

	if ( spectatorMode != OBS_MODE_CHASE ) then spectatorMode = OBS_MODE_CHASE end

	for _, ply in pairs( team.GetPlayers( TEAM_DEAD ) ) do
	
		if ( IsValid( ply ) && IsValid( HL2C_EXTRAS.GetPlayerToSpectate() ) && ( ply:GetObserverTarget() != HL2C_EXTRAS.GetPlayerToSpectate() ) ) then
		
			ply:SpectateEntity( HL2C_EXTRAS.GetPlayerToSpectate() )
		
		end
	
	end

end
timer.Create( "HL2C_EXTRAS.UpdatePlayerSpectatorEntity", 1, 0, HL2C_EXTRAS.UpdatePlayerSpectatorEntity )
