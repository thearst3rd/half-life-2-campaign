-- Add npc killed scenes to a table
hl2cExtras.npcKilledSounds = {
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
function hl2cExtras.OnNPCKilled( npc, killer, weapon )

	if ( ( math.random( 1, 3 ) == 1 ) && IsValid( killer ) && killer:IsPlayer() && killer:Alive() && ( killer:Team() == TEAM_ALIVE ) && table.HasValue( PLAYER_MODELS, killer:GetModel() ) ) then
	
		killer:PlayScene( table.Random( hl2cExtras.npcKilledSounds ) )
	
	end

end
hook.Add( "OnNPCKilled", "hl2cExtras.OnNPCKilled", hl2cExtras.OnNPCKilled )
