-- Function to return a good player to spectate
function hl2cExtras.GetPlayerToSpectate()

	for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
	
		if ( IsValid( ply ) && ply:Alive() ) then
		
			return ply
		
		end
	
	end

	return nil

end


-- Time the observer stuff
function hl2cExtras.UpdatePlayerSpectatorEntity()

	if ( spectatorMode != OBS_MODE_CHASE ) then spectatorMode = OBS_MODE_CHASE end

	for _, ply in pairs( team.GetPlayers( TEAM_DEAD ) ) do
	
		if ( IsValid( ply ) && IsValid( hl2cExtras.GetPlayerToSpectate() ) && ( ply:GetObserverTarget() != hl2cExtras.GetPlayerToSpectate() ) ) then
		
			ply:SpectateEntity( hl2cExtras.GetPlayerToSpectate() )
			ply:SetPos( hl2cExtras.GetPlayerToSpectate():GetPos() )
		
		end
	
	end

end
timer.Create( "hl2cExtras.UpdatePlayerSpectatorEntity", 1, 0, hl2cExtras.UpdatePlayerSpectatorEntity )
