Regenerative Asteroids

created by David McClain - Dirtyredz

This mods adds regenerate minable asteroids randomly into the sector generation.
When a Regenerative Asteroid sector falls below 200 minable asteroids (By default, can be changed in the config) the next time a player enters this sector, the script will create new minable asteroids.
The appearence of these sectors is propability based like the rest of the game.  This probability can be raised or lowered.

When a player discovers a Regenerative Asteroid sector, a Server wide message is sent alerting everyone to the cordinates of the sector. (Can be disabled in the config)

-----------INSTALL-----------
simply copy the data folder inside your steam avorion folder (steam local folder) usually C:\Program Files (x86)\Steam\steamapps\common\Avorion

-----------UNINSTALL-----------
The issue here is that the script is attatched to the specific sectors.
In order to uninstall properly you need to revert sectorspecific.lua to its original (Which is included in UninstallRegenerativeAsteroids.rar) by removing lines 64 & 65.

STEP 1: Remove these lines or replace with orignial.

	"data/scripts/sectorspecific.lua"

	64	--Added by RegenerativeAsteroids - Dirtyredz
    
	65	self:addTemplate("sectors/RegenerativeAsteroids")

STEP 2: Delete all files associated with this mod.
	After which you need to delete every file installed by this mod (except sectorscripts.lua which needs to be modified)

STEP 3: Add my Uninstall script to data/scripts/sector/
	then add the data folder included in "UninstallRegenerativeAsteroids.rar" to your Avorion directory. this will add script to terminate and remove the script from each sector you visit which contains the RegenerativeAsteroids Script.

Step 4: Visit every sector which was a Regenerative Asteroid Sector
	The uninstall is safe to leave in place as it does nothing but kill the script.
	Otherwise if your confident every sector that had the Regenerative Asteroids script has been visited, you can remove the uninstall file aswell.

WARNING - Failure to remove the script before deleteing the mod will CLEAR the entire sector of every entity (including your ship)

-----------COMMANDS-----------
There are a couple of commands available. (Only Administrators will be able to run these commands)

/regen
  this cmd will turn an already discovered sector into a Regenerative Asteroid sector. This will not destroy or otherwise effect the sector except that it will start to generate minable asteroids.

/deregen
  this cmd will remove the Regenerative Asteroid script from the sector. This will not effect anything already in the sector.

/regennow
  this cmd will run the script to regenerate Asteroids immediately, if the min number of asteroids hasnt been reach the script will not generate more.

All messages except for those alerting the player to the sector will be sent to the console. by default you can access the sector with the ' key.
