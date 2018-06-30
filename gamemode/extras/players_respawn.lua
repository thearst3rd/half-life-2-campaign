-- Called when map entities are finished being initialized
function hl2cExtras.InitPostEntity()

	restartWhenAllDead = false

end
hook.Add( "InitPostEntity", "hl2cExtras.InitPostEntity", hl2cExtras.InitPostEntity )


-- Called when the player spawns
function hl2cExtras.PlayerSpawn( ply )

	if ( table.HasValue( deadPlayers, ply:SteamID() ) ) then
	
		table.RemoveByValue( deadPlayers, ply:SteamID() )
		ply:SetTeam( TEAM_ALIVE )
	
	end

end
hook.Add( "PlayerSpawn", "hl2cExtras.PlayerSpawn", hl2cExtras.PlayerSpawn )


-- Called to carry out actions when a player dies
function hl2cExtras.DoPlayerDeath( ply )

	-- Cancel out the player info
	ply.info = nil

end
hook.Add( "DoPlayerDeath", "hl2cExtras.DoPlayerDeath", hl2cExtras.DoPlayerDeath )
