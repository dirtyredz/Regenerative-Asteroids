# Regenerative Asteroid Fields
![alt text](http://imgur.com/MAEqA0zh.png)

___

![alt text](http://imgur.com/72VYU0uh.png)

___

![alt text](http://imgur.com/7dmHxMOh.png)

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

## Downloads
___

__Version 1.1.0__
[Regenerative Asteroids v1.1.0](https://www.dropbox.com/s/pfqbv8ltoyvd47y/Regenerative-Asteroids-V1.1.0.zip?dl=0)

[Uninstall v1.1.0](https://www.dropbox.com/s/ducto7s4qxr5uvf/Uninstall-Regenerative-Asteroids-V1.1.0.zip?dl=0)

__Version 1.0.0__
[Regenerative Asteroids v1.0.0](https://www.dropbox.com/s/zqhb99t73arpehi/RegenerativeAsteroids.rar?dl=0)

[Uninstall v1.0.0](https://www.dropbox.com/s/xs609eqpwyd2vqr/UninstallRegenerativeAsteroids.RAR?dl=0)

## Changelog
___

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
