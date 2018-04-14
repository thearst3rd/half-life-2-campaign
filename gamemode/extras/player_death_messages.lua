-- Add question scenes to a table
hl2cExtras.deathMessages = {
	"scenes/npc/$gender01/goodgod.vcd",
	"scenes/npc/$gender01/gordead_ans01.vcd",
	"scenes/npc/$gender01/gordead_ans02.vcd",
	"scenes/npc/$gender01/gordead_ans03.vcd",
	"scenes/npc/$gender01/gordead_ans04.vcd",
	"scenes/npc/$gender01/gordead_ans05.vcd",
	"scenes/npc/$gender01/gordead_ans06.vcd",
	"scenes/npc/$gender01/gordead_ans07.vcd",
	"scenes/npc/$gender01/gordead_ans08.vcd",
	"scenes/npc/$gender01/gordead_ans09.vcd",
	"scenes/npc/$gender01/gordead_ans10.vcd",
	"scenes/npc/$gender01/gordead_ans11.vcd",
	"scenes/npc/$gender01/gordead_ans12.vcd",
	"scenes/npc/$gender01/gordead_ans13.vcd",
	"scenes/npc/$gender01/gordead_ans14.vcd",
	"scenes/npc/$gender01/gordead_ans15.vcd",
	"scenes/npc/$gender01/gordead_ans16.vcd",
	"scenes/npc/$gender01/gordead_ans17.vcd",
	"scenes/npc/$gender01/gordead_ans18.vcd",
	"scenes/npc/$gender01/gordead_ans19.vcd",
	"scenes/npc/$gender01/gordead_ans20.vcd",
	"scenes/npc/$gender01/gordead_ques01.vcd",
	"scenes/npc/$gender01/gordead_ques02.vcd",
	"scenes/npc/$gender01/gordead_ques06.vcd",
	"scenes/npc/$gender01/gordead_ques07.vcd",
	"scenes/npc/$gender01/gordead_ques09.vcd",
	"scenes/npc/$gender01/gordead_ques10.vcd",
	"scenes/npc/$gender01/gordead_ques11.vcd",
	"scenes/npc/$gender01/gordead_ques13.vcd",
	"scenes/npc/$gender01/gordead_ques14.vcd",
	"scenes/npc/$gender01/gordead_ques16.vcd",
	"scenes/npc/$gender01/ohno.vcd",
	"scenes/npc/$gender01/no01.vcd",
	"scenes/npc/$gender01/no02.vcd",
	"scenes/npc/$gender01/uhoh.vcd"
}


-- Player has been hurt
function GM:PostPlayerDeath( ply )

	for _, ply in pairs( team.GetPlayers( TEAM_ALIVE ) ) do
	
		if ( IsValid( ply ) && ply:Alive() && table.HasValue( PLAYER_MODELS, ply:GetModel() ) ) then
		
			timer.Simple( math.Rand( 0.5, 2.5 ), function() if ( IsValid( ply ) && ply:Alive() && ( ply:Team() == TEAM_ALIVE ) && table.HasValue( PLAYER_MODELS, ply:GetModel() ) ) then ply:PlayScene( table.Random( hl2cExtras.deathMessages ) ) end end )
		
		end
	
	end

end
