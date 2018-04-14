-- Add hurt scenes to a table
hl2cExtras.hurtSounds = {
	"scenes/npc/$gender01/hitingut01.vcd",
	"scenes/npc/$gender01/hitingut02.vcd",
	"scenes/npc/$gender01/myarm01.vcd",
	"scenes/npc/$gender01/myarm02.vcd",
	"scenes/npc/$gender01/mygut02.vcd",
	"scenes/npc/$gender01/myleg01.vcd",
	"scenes/npc/$gender01/myleg02.vcd",
	"scenes/npc/$gender01/ow01.vcd",
	"scenes/npc/$gender01/ow02.vcd",
	"scenes/npc/$gender01/startle01.vcd",
	"scenes/npc/$gender01/startle02.vcd"
}


-- Player has been hurt
function GM:PlayerHurt( ply, attacker, left, taken )

	if ( ( math.random( 1, 4 ) == 1 ) && IsValid( ply ) && ply:Alive() && ( ply:Team() == TEAM_ALIVE ) && table.HasValue( PLAYER_MODELS, ply:GetModel() ) ) then
	
		ply:PlayScene( table.Random( hl2cExtras.hurtSounds ) )
	
	end

end
