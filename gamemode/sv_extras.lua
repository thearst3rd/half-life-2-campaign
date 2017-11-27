-- Store stuff in this table
HL2C_EXTRAS = {}


-- Create data folders
if ( !file.IsDir( "half-life_2_campaign/extras", "DATA" ) ) then

	file.CreateDir( "half-life_2_campaign/extras" )

end


-- Create load file
function HL2C_EXTRAS.CreateLoadFile()

	HL2C_EXTRAS.DATA = {}

	for k, v in pairs( file.Find( "gamemodes/half-life_2_campaign/gamemode/extras/*.lua", "GAME" ) ) do
	
		HL2C_EXTRAS.DATA[ v ] = "0"
	
	end

	file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( HL2C_EXTRAS.DATA ) )

end
concommand.Add( "hl2c_server_extras_refresh", function( ply ) if ( IsValid( ply ) && ply:IsAdmin() ) then HL2C_EXTRAS.CreateLoadFile() end end )


-- Create data files or start including files
if ( !file.Exists( "half-life_2_campaign/extras/load.txt", "DATA" ) ) then

	HL2C_EXTRAS.CreateLoadFile()

else

	HL2C_EXTRAS.DATA = util.KeyValuesToTable( file.Read( "half-life_2_campaign/extras/load.txt", "DATA" ) )
	for k, v in pairs( HL2C_EXTRAS.DATA ) do
	
		if ( tobool( v ) && file.Exists( "gamemodes/half-life_2_campaign/gamemode/extras/"..k, "GAME" ) ) then
		
			include( "extras/"..k )
		
		end
	
	end

end


-- Enable extra include
function HL2C_EXTRAS.EnableExtraInclude( ply, args )

	if ( string.lower( args ) == "all" ) then
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Enabling all extras...\n" )
	
		for k, v in pairs( HL2C_EXTRAS.DATA ) do
		
			if ( !tobool( v ) ) then
			
				HL2C_EXTRAS.DATA[ k ] = "1"
			
			end
		
		end
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( HL2C_EXTRAS.DATA ) )
	
		return
	
	end

	if ( HL2C_EXTRAS.DATA[ args ] && !tobool( HL2C_EXTRAS.DATA[ args ] ) ) then
	
		HL2C_EXTRAS.DATA[ args ] = "1"
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( HL2C_EXTRAS.DATA ) )
	
	else
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Usage: hl2c_server_extras_enable <file.lua>\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "List of disabled extras:\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
		for k, v in pairs( HL2C_EXTRAS.DATA ) do
		
			if ( !tobool( v ) ) then
			
				ply:PrintMessage( HUD_PRINTCONSOLE, k.."\n" )
			
			end
		
		end
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
	
	end

end
concommand.Add( "hl2c_server_extras_enable", function( ply, cmd, argt, args ) if ( IsValid( ply ) && ply:IsAdmin() ) then HL2C_EXTRAS.EnableExtraInclude( ply, args ) end end )


-- Disable extra include
function HL2C_EXTRAS.DisableExtraInclude( ply, args )

	if ( string.lower( args ) == "all" ) then
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Disabling all extras...\n" )
	
		for k, v in pairs( HL2C_EXTRAS.DATA ) do
		
			if ( tobool( v ) ) then
			
				HL2C_EXTRAS.DATA[ k ] = "0"
			
			end
		
		end
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( HL2C_EXTRAS.DATA ) )
	
		return
	
	end

	if ( HL2C_EXTRAS.DATA[ args ] && tobool( HL2C_EXTRAS.DATA[ args ] ) ) then
	
		HL2C_EXTRAS.DATA[ args ] = "0"
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( HL2C_EXTRAS.DATA ) )
	
	else
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Usage: hl2c_server_extras_disable <file.lua>\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "List of enabled extras:\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
		for k, v in pairs( HL2C_EXTRAS.DATA ) do
		
			if ( tobool( v ) ) then
			
				ply:PrintMessage( HUD_PRINTCONSOLE, k.."\n" )
			
			end
		
		end
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
	
	end

end
concommand.Add( "hl2c_server_extras_disable", function( ply, cmd, argt, args ) if ( IsValid( ply ) && ply:IsAdmin() ) then HL2C_EXTRAS.DisableExtraInclude( ply, args ) end end )
