-- Dedicated to Viewmodel stuff

-- Console variables
local cl_wpn_sway_hl2 = CreateClientConVar( "cl_wpn_sway_hl2", 1, true, false )

-- Local variables
local m_vecLastFacing = Vector( 0, 0, 0 )
local g_fMaxViewModelLag = 1.5


-- Source SDK ported VectorMA
function VectorMA( start, scale, direction, dest )

	dest.x = start.x + direction.x * scale
	dest.y = start.y + direction.y * scale
	dest.z = start.z + direction.z * scale

end


-- Source SDK ported CalcViewModelLag
function CalcViewModelLag( origin, angles, original_angles )

	-- Frame Timing
	if ( game.SinglePlayer() ) then
	
		frameTime = FrameTime()
	
	else
	
		frameTime = RealFrameTime()
	
	end

	local vOriginalOrigin = origin
	local vOriginalAngles = angles

	-- Calculate our drift
	local forward = angles:Forward()

	if ( frameTime != 0.0 ) then
	
		local vDifference = forward - m_vecLastFacing
	
		local flSpeed = 5.0
	
		-- If we start to lag too far behind, we'll increase the "catch up" speed.  Solves the problem with fast cl_yawspeed, m_yaw or joysticks
		--  rotating quickly.  The old code would slam lastfacing with origin causing the viewmodel to pop to a new position
		local flDiff = vDifference:Length()
		if ( ( flDiff > g_fMaxViewModelLag ) && ( g_fMaxViewModelLag > 0.0 ) ) then
		
			local flScale = flDiff / g_fMaxViewModelLag
			flSpeed = flSpeed * flScale
		
		end
	
		-- FIXME: Needs to be predictable?
		VectorMA( m_vecLastFacing, flSpeed * frameTime, vDifference, m_vecLastFacing )
		-- Make sure it doesn't grow out of control!!!
		m_vecLastFacing:Normalize()
		VectorMA( origin, 5.0, vDifference * -1.0, origin )
	
	end

	local right, up = angles:Right(), angles:Up()

	local pitch = original_angles.p
	if ( pitch > 180.0 ) then
	
		pitch = pitch - 360.0
	
	elseif ( pitch < -180.0 ) then
	
		pitch = pitch + 360.0
	
	end

	if ( g_fMaxViewModelLag == 0.0 ) then
	
		origin = vOriginalOrigin
		angles = vOriginalAngles
	
	end

	-- FIXME: These are the old settings that caused too many exposed polys on some models
	VectorMA( origin, -pitch * 0.035, forward, origin )
	VectorMA( origin, -pitch * 0.03, right, origin )
	VectorMA( origin, -pitch * 0.02, up, origin )

end


-- Called to set the view model's position
function GM:CalcViewModelView( weapon, viewmodel, oldEyePos, oldEyeAng, eyePos, eyeAng )

	if ( !IsValid( weapon ) ) then return; end

	local vm_origin, vm_angles = eyePos, eyeAng

	-- Use the old HL2 weapon swaying
	if ( cl_wpn_sway_hl2:GetBool() ) then
	
		local vm_angles_original = oldEyeAng
	
		local pWeapon = weapon
		if ( IsValid( pWeapon ) ) then
		
			CalcViewModelLag( vm_origin, vm_angles, vm_angles_original )
		
		end
	
	end

	-- Controls the position of all viewmodels
	local func = weapon.GetViewModelPosition
	if ( func ) then
	
		local pos, ang = func( weapon, eyePos * 1, eyeAng * 1 )
		vm_origin = pos || vm_origin
		vm_angles = ang || vm_angles
	
	end

	-- Controls the position of individual viewmodels
	func = weapon.CalcViewModelView
	if ( func ) then
	
		local pos, ang = func( weapon, viewmodel, oldEyePos * 1, oldEyeAng * 1, eyePos * 1, eyeAng * 1 )
		vm_origin = pos || vm_origin
		vm_angles = ang || vm_angles
	
	end

	return vm_origin, vm_angles

end


-- Called before the viewmodel is drawn
function GM:PreDrawViewModel( vm, ply, wep )

	if ( !IsValid( wep ) ) then return false; end

	-- Super gravity gun thing
	if ( GetGlobalBool( "SUPER_GRAVITY_GUN" ) ) then
	
		if ( ply:Alive() && ( ply:Team() != TEAM_DEAD ) && ( wep:GetClass() == "weapon_physcannon" ) && ( wep:GetModel() != "models/weapons/c_superphyscannon.mdl" ) ) then
		
			vm:SetModel( "models/weapons/c_superphyscannon.mdl" )
		
		end
	
	end

	player_manager.RunClass( ply, "PreDrawViewModel", vm, wep )

	if ( wep.PreDrawViewModel == nil ) then return false; end
	return wep:PreDrawViewModel( vm, wep, ply )

end
