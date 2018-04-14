-- Disable in singleplayer
if ( game.SinglePlayer() ) then return end


-- Entity was created
function hl2cExtras.OnEntityCreated( ent )

	if ( !GetConVar( "hl2_episodic" ):GetBool() && ent:IsVehicle() && string.find( ent:GetClass(), "prop_vehicle_jeep" ) ) then
	
		ent.passengerSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		ent.passengerSeat:SetPos( ent:LocalToWorld( Vector( 21, -32, 18 ) ) )
		ent.passengerSeat:SetAngles( ent:LocalToWorldAngles( Angle( 0, -3.5, 0 ) ) )
		ent.passengerSeat:SetModel( "models/nova/jeep_seat.mdl" )
		ent.passengerSeat:SetMoveType( MOVETYPE_NONE )
		ent.passengerSeat:SetParent( ent )
		ent.passengerSeat:Spawn()
		ent.passengerSeat:Activate()
		ent.passengerSeat.allowWeapons = true
	
	end

end
hook.Add( "OnEntityCreated", "hl2cExtras.OnEntityCreated", hl2cExtras.OnEntityCreated )


-- Called if the player is allowed to enter the vehicle
function hl2cExtras.CanPlayerEnterVehicle( ply, vehicle, role )

	ply:SetAllowWeaponsInVehicle( vehicle.allowWeapons )

end
hook.Add( "CanPlayerEnterVehicle", "hl2cExtras.CanPlayerEnterVehicle", hl2cExtras.CanPlayerEnterVehicle )


-- Disable collisions with the vehicles
function hl2cExtras.ShouldCollide( entA, entB )

	if ( IsValid( entA ) && IsValid( entB ) && ( ( entA:IsPlayer() && entA:InVehicle() && entA:GetAllowWeaponsInVehicle() && entB:IsVehicle() ) || ( entB:IsPlayer() && entB:InVehicle() && entB:GetAllowWeaponsInVehicle() && entA:IsVehicle() ) ) ) then
	
		return false
	
	end

end
hook.Add( "ShouldCollide", "hl2cExtras.ShouldCollide", hl2cExtras.ShouldCollide )
