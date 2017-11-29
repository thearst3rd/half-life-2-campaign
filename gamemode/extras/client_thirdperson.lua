-- Execute on server
if ( SERVER ) then

	AddCSLuaFile()


	-- Called when the player initially spawns
	function HL2C_EXTRAS.PlayerInitialSpawn( ply )
	
		ply:SendLua( "include( \"half-life_2_campaign/gamemode/extras/client_thirdperson.lua\" )" )
	
	end
	hook.Add( "PlayerInitialSpawn", "HL2C_EXTRAS.PlayerInitialSpawn", HL2C_EXTRAS.PlayerInitialSpawn )

end


-- Execute on client
if ( CLIENT ) then

	local HL2C_EXTRAS = {}

	local hl2c_cl_thirdperson = CreateClientConVar( "hl2c_cl_thirdperson", "0", false, false )


	-- Called every frame to calculate player views
	function HL2C_EXTRAS.CalcView( ply, pos, ang, fov, zn, zf )
	
		if ( hl2c_cl_thirdperson:GetBool() ) then
		
			local view = {}
		
			view.origin = util.TraceHull( { start = pos, endpos = pos - ( ang:Forward() * 128 ), maxs = Vector( 4, 4, 4 ), mins = Vector( -4, -4, -4 ), filter = LocalPlayer() } ).HitPos
			view.angles = ang
			view.fov = fov
			view.znear = zn
			view.zfar = zf
			view.drawviewer = true
		
			return view
		
		end
	
	end
	hook.Add( "CalcView", "HL2C_EXTRAS.CalcView", HL2C_EXTRAS.CalcView )

end
