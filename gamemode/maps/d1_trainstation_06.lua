INFO_PLAYER_SPAWN = { Vector( -9961, -3668, 330 ), 90 }

NEXT_MAP = "d1_canals_01"


-- Initialize entities
function HL2C_InitPostEntity()

	ents.FindByName( "player_spawn_items_template" )[ 1 ]:Remove()

end
hook.Add( "InitPostEntity", "HL2C_InitPostEntity", HL2C_InitPostEntity )
