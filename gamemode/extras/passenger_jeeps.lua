-- Entity was created
function HL2C_EXTRAS.OnEntityCreated( ent )

	if ( !game.SinglePlayer() && !GetConVar( "hl2_episodic" ):GetBool() && ent:IsVehicle() && string.find( ent:GetClass(), "prop_vehicle_jeep" ) ) then
	
		ent.passengerSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		ent.passengerSeat:SetPos( ent:LocalToWorld( Vector( 21, -32, 18 ) ) )
		ent.passengerSeat:SetAngles( ent:LocalToWorldAngles( Angle( 0, -3.5, 0 ) ) )
		ent.passengerSeat:SetModel( "models/nova/jeep_seat.mdl" )
		ent.passengerSeat:SetMoveType( MOVETYPE_NONE )
		ent.passengerSeat:SetParent( ent )
		ent.passengerSeat:Spawn()
		ent.passengerSeat:Activate()
	
	end

end
hook.Add( "OnEntityCreated", "HL2C_EXTRAS.OnEntityCreated", HL2C_EXTRAS.OnEntityCreated )
