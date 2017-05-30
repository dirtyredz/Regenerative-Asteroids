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

simply copy the data folder inside your steam avorion folder (steam local folder) usually C:\Program Files (x86)\Steam\steamapps\common\Avorion

### THIS MOD IS REQUIRED ONLY TO BE INSTALLED ON THE SERVER NO CLIENT INSTALLATION IS REQUIRED

## UNINSTALL
___

__STEP 1__: Replace sectorspecifics.lua and neutralzone.lua with orignial.

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

## TODO
___



## Downloads
___
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
__Version 1.2.5__
-Fixed Conflict with MineCorp mod (changed renamed config.lua).
-IMPORTANT:  DELETE THE OLD CONFIG.LUA otheriwse the conflict will remain.
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



Let me know what you guys think.
