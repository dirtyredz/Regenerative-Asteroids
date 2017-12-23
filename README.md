# Regenerative Asteroid Fields
![alt text](http://imgur.com/MAEqA0zh.png)

___

![alt text](http://imgur.com/dZr8rJZ.png)

## Commands
___
### /regen start
Will force a sector to become a Regenerative Asteroid Field Sector. THIS WILL NOT overwrite anything already in the sector. Turn your start sectors or your players home sectors into regenerative Asteroid Fields.

### /regen stop
Will Remove the Regenerative Asteroids script to be removed. This will not remove any asteroids, just the script. Will also make the sector safe for uninstall.

### /regen now
Will force the script to calculate asteroids and the sector limits, instead of waiting on a player to enter the sector.

### /regen set x
Will set a sector to maintain a specific amount of minable asteroids. This will be Priority over MinableAsteroidLimit and MaintainNaturalAsteroidLimit options.


## INSTALL
___

simply copy the DATA and MODS folders inside your steam avorion folder (steam local folder) usually C:\Program Files (x86)\Steam\steamapps\common\Avorion

### THIS MOD IS REQUIRED ONLY TO BE INSTALLED ON THE SERVER NO CLIENT INSTALLATION IS REQUIRED

## UNINSTALL
___

__STEP 1__: Replace sectorspecifics.lua with orignial.

__STEP 2__: Delete all files associated with this mod.
	After which you need to delete every file installed by this mod (except sectorscripts.lua which needs to be modified)

__STEP 3__: Add my Uninstall script to data/scripts/sector/
	then add the data folder included in "UninstallRegenerativeAsteroids.rar" to your Avorion directory. this will add script to terminate and remove the script from each sector you visit which contains the RegenerativeAsteroids Script.

__Step 4__: Visit every sector which was a Regenerative Asteroid Sector
	The uninstall is safe to leave in place as it does nothing but kill the script.
	Otherwise if your confident every sector that had the Regenerative Asteroids script has been visited, you can remove the uninstall file aswell.

__WARNING __- Failure to remove the script before deleteing the mod will CLEAR the entire sector of every entity (including your ship)

___

All messages except for those alerting the player to the sector will be sent to the console. by default you can access the sector with the ' key.

## GITHUB
___
https://github.com/dirtyredz/Regenerative-Asteroids

## Downloads
___
__Version 1.4.4__
[Regenerative Asteroids v1.4.4](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.4.4/Regenerative-Asteroids-v1.4.4.zip)

__Version 1.4.3__
[Regenerative Asteroids v1.4.3](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.4.3/Regenerative-Asteroids-v1.4.3.zip)

__Version 1.4.2__
[Regenerative Asteroids v1.4.2](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.4.2/Regenerative-Asteroids-v1.4.2.zip)

__Version 1.4.1__
[Regenerative Asteroids v1.4.1](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.4.1/Regenerative-Asteroids-v1.4.1.zip)

__Version 1.4.0__
[Regenerative Asteroids v1.4.0](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.4.0/Regenerative-Asteroids-v1.4.0.zip)

__Version 1.3.0__
[Regenerative Asteroids v1.3.0](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.3.0/Regenerative-Asteroids.v1.3.0.zip)

__Version 1.2.5__
[Regenerative Asteroids v1.2.5](https://github.com/dirtyredz/Regenerative-Asteroids/releases/download/1.2.5/Regenerative-Asteroids.v1.2.5.zip)

__Version 1.2.4__
[Regenerative Asteroids v1.2.4](https://www.dropbox.com/s/5olg83i9iikwdxh/Regenerative-Asteroids-V1.2.4.zip?dl=0)

__Version 1.2.3__
[Regenerative Asteroids v1.2.3](https://www.dropbox.com/s/p81jf2u4ccbkcwp/Regenerative-Asteroids-V1.2.3.zip?dl=0)

__Version 1.2.2__
[Regenerative Asteroids v1.2.2](https://www.dropbox.com/s/6ile21i9vls4xn0/Regenerative-Asteroids-V1.2.2.zip?dl=0)

__Version 1.2.1__
[Regenerative Asteroids v1.2.1](https://www.dropbox.com/s/uev023id2xpnhqp/Regenerative-Asteroids-V1.2.1.zip?dl=0)

__Version 1.2.0__
[Regenerative Asteroids v1.2.0](https://www.dropbox.com/s/duj9tqxrjadyyl7/Regenerative-Asteroids-V1.2.0.zip?dl=0)
[Uninstall v1.2.0](https://www.dropbox.com/s/180qlb9sx48xk61/Uninstall-Regenerative-Asteroids-V1.2.0.zip?dl=0)

__Version 1.1.0__
[Regenerative Asteroids v1.1.0](https://www.dropbox.com/s/pfqbv8ltoyvd47y/Regenerative-Asteroids-V1.1.0.zip?dl=0)
[Uninstall v1.1.0](https://www.dropbox.com/s/ducto7s4qxr5uvf/Uninstall-Regenerative-Asteroids-V1.1.0.zip?dl=0)

__Version 1.0.0__
[Regenerative Asteroids v1.0.0](https://www.dropbox.com/s/zqhb99t73arpehi/RegenerativeAsteroids.rar?dl=0)

[Uninstall v1.0.0](https://www.dropbox.com/s/xs609eqpwyd2vqr/UninstallRegenerativeAsteroids.RAR?dl=0)


## Changelog
___
__Version 1.4.4__
	--Added MaxNonMinable config option, Deletes any non-minable asteroids past the config option default 1500.

__Version 1.4.3__
	--Updated sectorspecifics.lua

__Version 1.4.2__
	--Added missing loglevel commands
	--Redid entire config file.
	--Updated all files to match new config file settup
	--Removed NeutralZone option, and neutralzone file.

__Version 1.4.1__
-Moved most file to mods/ directory in preperation for steam support
-Added Loglevel
-Fixed custom nsming on newly generated sectors

__Version 1.4.0__
-Moved configuration to /configs/

__Version 1.3.0__
-Added Namespacing

__Version 1.2.5__
-Fixed Conflict with MineCorp mod (changed renamed config.lua).
-IMPORTANT:  DELETE THE OLD CONFIG.LUA otheriwse the conflict will remain.
-Updated All files to compensate for the rename of CONFIG.lua, also Updated SectorSpecifics.lua.
-Added CustonName support for sectors generated as Regenerative Asteroids.
  ie: it will now show "Regenerative Asteroids" on the map overview when hovering or a Regernative Asteroid SectorTemplate
  ![alt text](http://imgur.com/XEnUQLS.png)

__Version 1.2.4__
-Added clickable sector cords, to discovery message.
-Fixed bug from version 1.2.3

__Version 1.2.3__
-Removed redundant code in Sectors files causing a cyclic dependency.

__Version 1.2.2__
-Fixxed race condition in script Initialize().  (Error: could not execute function 'initialize' in '""':)

__Version 1.2.1__
-Removed console print out from asteroid regeneration, forgot that everyone could see the server console....
-Added config option Debug, if true you can see all messages about a sectors regenerative actions. Warning all players can see server console print outs.
-Added config option for Repeated sector entry. By request to broadcast a message whenever a player is inside a regerative sector.


__Version 1.2.0__
-Consolidated commands into single cmd /regen with sub options start,stop,now,and set.
-Added config option for Natural Asteroid generation, ie if a regenerative sector starts with 56 asteroids the script will never exceed 56 asteroids.
-Added new command /regen set can be used to force a sector to maintain a specific amount of asteroids, ie /regen set 10 will always maintain 10 minable asteroids. see commands.
-Fixed server announcment from always playing discovered message, even after its been discovered previously.
-Added ModInfo and version to console print.
-Consolidated player command scripts into one file. make sure you delete older versions of those files.
-Optimized asteroid regeneration script to generate the specific amount of asteroids needed instead of a random amount. (Let me know if your getting to many none minable asteroids)
-Added Sector X and Y to console print out

__Version 1.1.0__
-Moved Config.lua FROM scripts/mods/ TO scripts/mods/Regenerative-Asteroids/
-Fixed Server announcment only sending announcment to player and not server.
-Added Neurtral Zone Regenerative ASteroids Configuration option, default false.
-Added config check to neutralzone.lua for configuration options
-Added SectorGenerator Configuration option, default true.
-Added config check to SectorSpecifics.lua for configuration options
-Updated Uninstall to contain original neutralzone.lua(patch 0.11.0.7844) and sectorspecifics.lua(patch 0.11.0.7844)
-Added readme.txt to Uninstall zip


## DONATE
___
Wanna show your appreciation?
http://dirtyredz.com/donate

Become a patron:
https://www.patreon.com/Dirtyredz


## MY OTHER MODS
___
__DSM_
-A project dedicated to server deployment, management, and exposing features to a web interface.
http://www.avorion.net/forum/index.php/topic,3507.0.html

__Reganerative Asteroid Fields__
-Regenerates designated sectors, and randomly appearing sectors, of minable asteroids.
http://www.avorion.net/forum/index.php/topic,3055.0.html

__MoveUI__
-A mod for adding custom UIs to the screen.
http://www.avorion.net/forum/index.php/topic,3834.0.html

__Subspace Corridor__
-A modders recources, designed to mimick /teleport, due to server commands not being available through the api.
http://www.avorion.net/forum/index.php/topic,3148.0.html

__Dirty Buoy's__
-Allows players to spawn Navigational and Sentry Buoys, More to come soon.
-These buoys have unique features players cant get in normal game play, for example: Navigational buoys are invincible and cannot be moved. A great way to mark a distance wreckage or minarable rich asteroid field.
--Rusty Servers only at the moment.

__LogLevels__
-LogLevels gives modders the ability to set levels for there print functions.
-Aswell as allowing server owners to clean up there consoles, making it easier to read.
http://www.avorion.net/forum/index.php/topic,3799.0.html

__NoNeutralCore__
-A small script for stopping the creation of neutral zones inside the core.
http://www.avorion.net/forum/index.php/topic,3472.0.html

__DirtyCargoExtender__
-Extends the cargo hold of any NPC station discovered with low cargo holds.
--Patreon Members only

__DirtySecure__
-A mod which assigned PVP or PVE sectors based on distance from core.
-Provides Offline Protection to Players ships.
-Provides protection for NPC stations.
--Rusty Servers only at the moment

__Reganerative Claimable Asteroids__
-A mod which respawns claimable asteroids, when theyve been moved or turned into a mine.
-Also will unclaim or unsell an asteroid after a configured number of days
-Keeps the galaxy alive, providing claimable asteroids for new players.
--Rusty Servers only at the moment

__Death Info__
-Used to track cords of a players death point, assigning player values, for other mods to use.
--Rusty Servers only at the moment.

__/Back__
-A command using DeathInfo and Subspace Corridor, to teleport a players drone BACK to there death point.
--Rusty Servers only at the moment.

Any mod listed as Rusty Servers only, are live and active on the Rusty Servers.
Want the mod for your server? Lets talk and ill see about releasing the mod to you/public.
Not all mods on Rusty will remain there, they will eventually be released to the public.
