-- Called when the player spawns
function hl2cExtras.PlayerSpawn( ply )

	if ( restartWhenAllDead ) then restartWhenAllDead = false end

	if ( table.HasValue( deadPlayers, ply:SteamID() ) ) then
	
		table.RemoveByValue( deadPlayers, ply:SteamID() )
		ply:SetTeam( TEAM_ALIVE )
	
	end

end
hook.Add( "PlayerSpawn", "hl2cExtras.PlayerSpawn", hl2cExtras.PlayerSpawn )
