UNINSTALL

The issue here is that the script is attatched to the specific sectors.
In order to uninstall properly you need to revert sectorspecific.lua to its original which is included in Uninstall.zip.

STEP 1: Replace with orignial. Included in the Latest Uninstall


STEP 2: Delete all files associated with this mod.
   After which you need to delete every file installed by this mod (except sectorscripts.lua which needs to be modified)

STEP 3: Add my Uninstall script to data/scripts/sector/
   then add the data folder included in "Uninstall.zip" to your Avorion directory. this will add script to terminate and remove the script from each sector you visit which contains the RegenerativeAsteroids Script.

Step 4: Visit every sector which was a Regenerative Asteroid Sector
   The uninstall is safe to leave in place as it does nothing but kill the script.
   Otherwise if your confident every sector that had the Regenerative Asteroids script has been visited, you can remove the uninstall file aswell.

WARNING - Failure to remove the script before deleteing the mod will CLEAR the entire sector of every entity (including your ship)
