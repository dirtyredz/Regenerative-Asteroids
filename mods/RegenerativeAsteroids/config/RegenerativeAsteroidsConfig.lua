local RegenerativeAsteroidsConfig = {}

RegenerativeAsteroidsConfig.Author = "Dirtyredz"
RegenerativeAsteroidsConfig.Version = "[1.4.2]"
RegenerativeAsteroidsConfig.ModName = "[RegenerativeAsteroids]"

RegenerativeAsteroidsConfig.frequency = 300; -- 0 to 1000, probability of this sector to appear. Keep around 300 to be average with other similiar sectors.
RegenerativeAsteroidsConfig.announcment = true; -- true or false, false will disable the server wide message that one of these sectors have been found.
RegenerativeAsteroidsConfig.MinableAsteroidLimit = 50; -- number of asteroids to maintain in the sector.
RegenerativeAsteroidsConfig.SectorGenerator = true; -- true or false, true will allow for random sectors to be regenerative asteroid fields.  use false if you want to have this script run only in SPECIFIC  sectors using the /regen command
RegenerativeAsteroidsConfig.MaintainNaturalAsteroidLimit = true;--true or false, true will allow only enough asteroids to be generated to meet the limit the sector had originaly generated. IE a sector naturally has 50 asteroids, this option will never exceed 50 asteroids in the sector.
RegenerativeAsteroidsConfig.RepeatedSectorEntryAlerts = false;--true or false, true will announce every time a player enters into a regenerative asteroid field.

function RegenerativeAsteroidsConfig.print(...)
  local args = table.pack(...)
  table.insert(args,1,RegenerativeAsteroidsConfig.ModName .. RegenerativeAsteroidsConfig.Version)
  print(table.unpack(args))
end

return RegenerativeAsteroidsConfig
