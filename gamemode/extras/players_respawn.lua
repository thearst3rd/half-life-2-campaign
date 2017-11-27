-- Called when the player spawns
function HL2C_EXTRAS.PlayerSpawn( ply )

	if ( restartWhenAllDead ) then restartWhenAllDead = false end

	if ( table.HasValue( deadPlayers, ply:SteamID() ) ) then
	
		table.RemoveByValue( deadPlayers, ply:SteamID() )
		ply:SetTeam( TEAM_ALIVE )
	
	end

end
hook.Add( "PlayerSpawn", "HL2C_EXTRAS.PlayerSpawn", HL2C_EXTRAS.PlayerSpawn )
