[center][b][size=24pt][color=red]Regenerative Asteroid Fields[/color][/size][/b][/center]
[center][img]http://imgur.com/MAEqA0zh.png[/img][/center]

[hr]

[center][img]http://imgur.com/dZr8rJZ.png[/img][/center]

[center][b]COMMANDS[/b][/center]
[hr]
[b]/regen start[/b]
Will force a sector to become a Regenerative Asteroid Field Sector. THIS WILL NOT overwrite anything already in the sector. Turn your start sectors or your players home sectors into regenerative Asteroid Fields.

[b]/regen stop[/b]
Will Remove the Regenerative Asteroids script to be removed. This will not remove any asteroids, just the script. Will also make the sector safe for uninstall.

[b]/regen now[/b]
Will force the script to calculate asteroids and the sector limits, instead of waiting on a player to enter the sector.

[b]/regen set x[/b]
Will set a sector to maintain a specific amount of minable asteroids. This will be Priority over MinableAsteroidLimit and MaintainNaturalAsteroidLimit options.


[center][b]INSTALL[/b][/center]
[hr]

simply copy the data folder inside your steam avorion folder (steam local folder) usually C:\Program Files (x86)\Steam\steamapps\common\Avorion

[center][size=14pt]THIS MOD IS REQUIRED ONLY TO BE INSTALLED ON THE SERVER NO CLIENT INSTALLATION IS REQUIRED[/size][/center]

[center][b]UNINSTALL[/b][/center]
[hr]

[b]STEP 1[/b]: Replace sectorspecifics.lua and neutralzone.lua with orignial.

[b]STEP 2[/b]: Delete all files associated with this mod.
	After which you need to delete every file installed by this mod (except sectorscripts.lua which needs to be modified)

[b]STEP 3[/b]: Add my Uninstall script to data/scripts/sector/
	then add the data folder included in "UninstallRegenerativeAsteroids.rar" to your Avorion directory. this will add script to terminate and remove the script from each sector you visit which contains the RegenerativeAsteroids Script.

[b]Step 4[/b]: Visit every sector which was a Regenerative Asteroid Sector
	The uninstall is safe to leave in place as it does nothing but kill the script.
	Otherwise if your confident every sector that had the Regenerative Asteroids script has been visited, you can remove the uninstall file aswell.

[b]WARNING [/b]- Failure to remove the script before deleteing the mod will CLEAR the entire sector of every entity (including your ship)

[hr]

All messages except for those alerting the player to the sector will be sent to the console. by default you can access the sector with the ' key.

[b]GITHUB[/b]
[hr]
https://github.com/dirtyredz/Regenerative-Asteroids

[b]TODO[/b]
[hr]
-Add more configuration options for starting sectors to be Regenerative asteroid Fields.


[center][b]Downloads[/b][/center]
[hr]
Version 1.2.1
[url=https://www.dropbox.com/s/uev023id2xpnhqp/Regenerative-Asteroids-V1.2.1.zip?dl=0]Regenerative Asteroids v1.2.1[/url]


[b]Downloads[/b]
Version 1.2.0
[url=https://www.dropbox.com/s/duj9tqxrjadyyl7/Regenerative-Asteroids-V1.2.0.zip?dl=0]Regenerative Asteroids v1.2.0[/url]
[url=https://www.dropbox.com/s/180qlb9sx48xk61/Uninstall-Regenerative-Asteroids-V1.2.0.zip?dl=0]Uninstall v1.2.0[/url]

Past Download Links:
[spoiler]
Version 1.1.0
[url=https://www.dropbox.com/s/pfqbv8ltoyvd47y/Regenerative-Asteroids-V1.1.0.zip?dl=0]Regenerative Asteroids v1.1.0[/url]
[url=https://www.dropbox.com/s/ducto7s4qxr5uvf/Uninstall-Regenerative-Asteroids-V1.1.0.zip?dl=0]Uninstall v1.1.0[/url]

Version 1.0.0
[url=https://www.dropbox.com/s/zqhb99t73arpehi/RegenerativeAsteroids.rar?dl=0]Regenerative Asteroids v1.0.0[/url]
[url=https://www.dropbox.com/s/xs609eqpwyd2vqr/UninstallRegenerativeAsteroids.RAR?dl=0]Uninstall[/url]
[/spoiler]

[center][b]Changelog[/b][/center]
[hr]
[b]Changelog[/b]
Version 1.2.1
-Removed console print out from asteroid regeneration, forgot that everyone could see the server console....
-Added config option Debug, if true you can see all messages about a sectors regenerative actions. Warning all players can see server console print outs.
-Added config option for Repeated sector entry. By request to broadcast a message whenever a player is inside a regerative sector.

Version 1.2.0
-Consolidated commands into single cmd /regen with sub options start,stop,now,and set.
-Added config option for Natural Asteroid generation, ie if a regenerative sector starts with 56 asteroids the script will never exceed 56 asteroids.
-Added new command /regen set can be used to force a sector to maintain a specific amount of asteroids, ie /regen set 10 will always maintain 10 minable asteroids. see commands.
-Fixed server announcment from always playing discovered message, even after its been discovered previously.
-Added ModInfo and version to console print.
-Consolidated player command scripts into one file. make sure you delete older versions of those files.
-Optimized asteroid regeneration script to generate the specific amount of asteroids needed instead of a random amount. (Let me know if your getting to many none minable asteroids)
-Added Sector X and Y to console print out

Version 1.1.0
-Moved Config.lua FROM scripts/mods/ TO scripts/mods/Regenerative-Asteroids/
-Fixed Server announcment only sending announcment to player and not server.
-Added Neurtral Zone Regenerative ASteroids Configuration option, default false.
-Added config check to neutralzone.lua for configuration options
-Added SectorGenerator Configuration option, default true.
-Added config check to SectorSpecifics.lua for configuration options
-Updated Uninstall to contain original neutralzone.lua(patch 0.11.0.7844) and sectorspecifics.lua(patch 0.11.0.7844)
-Added readme.txt to Uninstall zip



Let me know what you guys think.
