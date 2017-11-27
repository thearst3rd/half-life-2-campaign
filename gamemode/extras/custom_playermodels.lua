-- Called after setting the player model
function GM:PostPlayerSetModel( ply )

	ply.modelName = player_manager.TranslatePlayerModel( ply:GetInfo( "cl_playermodel" ) )
	util.PrecacheModel( ply.modelName )
	ply:SetModel( ply.modelName )
	ply:SetupHands()

	ply:SetSkin( ply:GetInfoNum( "cl_playerskin", 0 ) )

	ply.modelGroups = ply:GetInfo( "cl_playerbodygroups" )
	if ( ply.modelGroups == nil ) then ply.modelGroups = "" end
	ply.modelGroups = string.Explode( " ", ply.modelGroups )
	for k = 0, ( ply:GetNumBodyGroups() - 1 ) do
	
		ply:SetBodygroup( k, ( tonumber( ply.modelGroups[ k + 1 ] ) || 0 ) )
	
	end

	ply:SetPlayerColor( Vector( ply:GetInfo( "cl_playercolor" ) ) )

end
