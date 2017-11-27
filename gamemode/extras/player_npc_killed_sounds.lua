-- Add npc killed scenes to a table
HL2C_EXTRAS.NPC_KILLED_SOUNDS = {
	"scenes/npc/$gender01/fantastic01.vcd",
	"scenes/npc/$gender01/fantastic02.vcd",
	"scenes/npc/$gender01/gotone01.vcd",
	"scenes/npc/$gender01/gotone02.vcd",
	"scenes/npc/$gender01/likethat.vcd",
	"scenes/npc/$gender01/oneforme.vcd",
	"scenes/npc/$gender01/thislldonicely.vcd",
	"scenes/npc/$gender01/yeah01.vcd"
}


-- Called when the player spawns
function HL2C_EXTRAS.OnNPCKilled( npc, killer, weapon )

	if ( ( math.random( 1, 3 ) == 1 ) && IsValid( killer ) && killer:IsPlayer() && killer:Alive() && ( killer:Team() == TEAM_ALIVE ) ) then
	
		killer:PlayScene( table.Random( HL2C_EXTRAS.NPC_KILLED_SOUNDS ) )
	
	end

end
hook.Add( "OnNPCKilled", "HL2C_EXTRAS.OnNPCKilled", HL2C_EXTRAS.OnNPCKilled )
