DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

local boostConVar = GetConVar( "hl2c_server_jump_boost" )
local accelConVar = GetConVar( "hl2c_server_jump_accel" )


--
-- Reproduces the jump boost from HL2 singleplayer
-- This code was taken from sandbox/gamemode/player_class/player_sandbox.lua
-- ABH unfix single line of code was taken from "Backhopping Unfix" mod by [MG] Cheezus
-- https://steamcommunity.com/sharedfiles/filedetails/?id=778577682
--
local JUMPING

function PLAYER:StartMove( move )

	-- Only apply the jump boost in FinishMove if the player has jumped during this frame
	-- Using a global variable is safe here because nothing else happens between SetupMove and FinishMove
	if bit.band( move:GetButtons(), IN_JUMP ) ~= 0 and bit.band( move:GetOldButtons(), IN_JUMP ) == 0 and self.Player:OnGround() then
		JUMPING = true
	end

end

function PLAYER:FinishMove( move )

	if boostConVar:GetBool() then
		-- If the player has jumped this frame
		if JUMPING then
			-- Get their orientation
			local forward = move:GetAngles()
			forward.p = 0
			forward = forward:Forward()
		
			-- Compute the speed boost
		
			-- NOTE: orig code didn't check if player was sprinting. We do that here because HL2 does that
			local speedBoostPerc = ( ( not ( self.Player:Crouching() or self.Player:IsSprinting() ) ) and 0.5 ) or 0.1
		
			local speedAddition = math.abs( move:GetForwardSpeed() * speedBoostPerc )
			local maxSpeed = move:GetMaxSpeed() * ( 1 + speedBoostPerc )
			local newSpeed = speedAddition + move:GetVelocity():Length2D()
		
			-- Clamp it to make sure they can't bunnyhop to ludicrous speed
			if newSpeed > maxSpeed then
				speedAddition = speedAddition - (newSpeed - maxSpeed)
			end
		
			-- Reverse it if the player is running backwards
			if accelConVar:GetBool() then
				-- Unfix backwards bunnyhopping :^)
				if move:GetForwardSpeed() < 0 then
					speedAddition = -speedAddition
				end
			else
				if move:GetVelocity():Dot(forward) < 0 then
					speedAddition = -speedAddition
				end
			end
		
			-- Apply the speed boost
			move:SetVelocity( forward * speedAddition + move:GetVelocity() )
		end
	end

	JUMPING = nil

end

player_manager.RegisterClass( "player_hl2c", PLAYER, "player_default" )