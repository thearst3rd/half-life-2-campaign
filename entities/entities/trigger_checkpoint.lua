-- Entity information
ENT.Base = "base_brush"
ENT.Type = "brush"


-- Called when the entity first spawns
function ENT:Initialize()

	self.ipsLocation = Vector( self.pos.x, self.pos.y, self.min.z + 8 )

	local w = self.max.x - self.min.x
	local l = self.max.y - self.min.y
	local h = self.max.z - self.min.z

	local min = Vector( 0 - ( w / 2 ), 0 - ( l / 2 ), 0 - ( h / 2 ) )
	local max = Vector( w / 2, l / 2, h / 2 ) 

	self:DrawShadow( false )
	self:SetCollisionBounds( min, max )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self:SetMoveType( 0 )
	self:SetTrigger( true )

end


-- Called when an entity touches it
function ENT:StartTouch( ent )

	if ( IsValid( ent ) && ent:IsPlayer() && ( ent:Team() == TEAM_ALIVE ) && !self.triggered ) then
	
		self.triggered = true
	
		if ( self.OnTouchRun ) then
		
			self:OnTouchRun()
		
		end
	
		local ang = ent:GetAngles()
	
		if ( !self.skipSpawnpoint ) then
		
			GAMEMODE:CreateSpawnPoint( self.ipsLocation, ang.y )
		
		end
	
		for _, ply in pairs( player.GetAll() ) do
		
			if ( IsValid( ply ) && ( ply != ent ) && ( ply:Team() == TEAM_ALIVE ) ) then
			
				if ( IsValid( ply:GetVehicle() ) ) then
				
					ply:ExitVehicle()
					ply:GetVehicle():Remove()
				
				end
			
				ply:SetPos( self.ipsLocation )
				ply:SetAngles( ang )
			
			end
		
		end
	
		table.remove( checkpointPositions, 1 )
	
		net.Start( "SetCheckpointPosition" )
			net.WriteVector( checkpointPositions[ 1 ] )
		net.Broadcast()
	
		self:Remove()
	
	end

end
