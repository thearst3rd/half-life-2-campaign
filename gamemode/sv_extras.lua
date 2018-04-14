-- Store stuff in this table
hl2cExtras = {}


-- Create data folders
if ( !file.IsDir( "half-life_2_campaign/extras", "DATA" ) ) then

	file.CreateDir( "half-life_2_campaign/extras" )

end


-- Create load file
function hl2cExtras.CreateLoadFile()

	hl2cExtras.data = {}

	for k, v in pairs( file.Find( "gamemodes/half-life_2_campaign/gamemode/extras/*.lua", "GAME" ) ) do
	
		hl2cExtras.data[ v ] = "0"
	
	end

	file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( hl2cExtras.data ) )

end
concommand.Add( "hl2c_server_extras_refresh", function( ply ) if ( IsValid( ply ) && ply:IsAdmin() ) then hl2cExtras.CreateLoadFile() end end )


-- Create data files or start including files
if ( !file.Exists( "half-life_2_campaign/extras/load.txt", "DATA" ) ) then

	hl2cExtras.CreateLoadFile()

else

	hl2cExtras.data = util.KeyValuesToTable( file.Read( "half-life_2_campaign/extras/load.txt", "DATA" ) )
	for k, v in pairs( hl2cExtras.data ) do
	
		if ( tobool( v ) && file.Exists( "gamemodes/half-life_2_campaign/gamemode/extras/"..k, "GAME" ) ) then
		
			include( "extras/"..k )
		
		end
	
	end

end


-- Enable extra include
function hl2cExtras.EnableExtraInclude( ply, args )

	if ( string.lower( args ) == "all" ) then
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Enabling all extras...\n" )
	
		for k, v in pairs( hl2cExtras.data ) do
		
			if ( !tobool( v ) ) then
			
				hl2cExtras.data[ k ] = "1"
			
			end
		
		end
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( hl2cExtras.data ) )
	
		return
	
	end

	if ( hl2cExtras.data[ args ] && !tobool( hl2cExtras.data[ args ] ) ) then
	
		hl2cExtras.data[ args ] = "1"
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( hl2cExtras.data ) )
	
	else
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Usage: hl2c_server_extras_enable <file.lua>\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "List of disabled extras:\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
		for k, v in pairs( hl2cExtras.data ) do
		
			if ( !tobool( v ) ) then
			
				ply:PrintMessage( HUD_PRINTCONSOLE, k.."\n" )
			
			end
		
		end
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
	
	end

end
concommand.Add( "hl2c_server_extras_enable", function( ply, cmd, argt, args ) if ( IsValid( ply ) && ply:IsAdmin() ) then hl2cExtras.EnableExtraInclude( ply, args ) end end )


-- Disable extra include
function hl2cExtras.DisableExtraInclude( ply, args )

	if ( string.lower( args ) == "all" ) then
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Disabling all extras...\n" )
	
		for k, v in pairs( hl2cExtras.data ) do
		
			if ( tobool( v ) ) then
			
				hl2cExtras.data[ k ] = "0"
			
			end
		
		end
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( hl2cExtras.data ) )
	
		return
	
	end

	if ( hl2cExtras.data[ args ] && tobool( hl2cExtras.data[ args ] ) ) then
	
		hl2cExtras.data[ args ] = "0"
	
		file.Write( "half-life_2_campaign/extras/load.txt", util.TableToKeyValues( hl2cExtras.data ) )
	
	else
	
		ply:PrintMessage( HUD_PRINTCONSOLE, "Usage: hl2c_server_extras_disable <file.lua>\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "List of enabled extras:\n" )
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
		for k, v in pairs( hl2cExtras.data ) do
		
			if ( tobool( v ) ) then
			
				ply:PrintMessage( HUD_PRINTCONSOLE, k.."\n" )
			
			end
		
		end
		ply:PrintMessage( HUD_PRINTCONSOLE, "---------------------\n" )
	
	end

end
concommand.Add( "hl2c_server_extras_disable", function( ply, cmd, argt, args ) if ( IsValid( ply ) && ply:IsAdmin() ) then hl2cExtras.DisableExtraInclude( ply, args ) end end )
