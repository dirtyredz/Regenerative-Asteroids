local RegenerativeAsteroidsConfig = {}

RegenerativeAsteroidsConfig.Author = "Dirtyredz"
RegenerativeAsteroidsConfig.Version = "[1.4.5]"
RegenerativeAsteroidsConfig.ModName = "[RegenerativeAsteroids]"

RegenerativeAsteroidsConfig.frequency = 300; -- 0 to 1000, probability of this sector to appear. Keep around 300 to be average with other similiar sectors.
RegenerativeAsteroidsConfig.announcment = true; -- true or false, false will disable the server wide message that one of these sectors have been found.
RegenerativeAsteroidsConfig.MinableAsteroidLimit = 50; -- number of asteroids to maintain in the sector.
RegenerativeAsteroidsConfig.SectorGenerator = true; -- true or false, true will allow for random sectors to be regenerative asteroid fields.  use false if you want to have this script run only in SPECIFIC  sectors using the /regen command
RegenerativeAsteroidsConfig.MaintainNaturalAsteroidLimit = false;--true or false, true will allow only enough asteroids to be generated to meet the limit the sector had originaly generated. IE a sector naturally has 50 asteroids, this option will never exceed 50 asteroids in the sector.
RegenerativeAsteroidsConfig.RepeatedSectorEntryAlerts = false;--true or false, true will announce every time a player enters into a regenerative asteroid field.
RegenerativeAsteroidsConfig.MaxNonMinableAsteroids = 1500;--Number of max NonMinable asteroids a regenerative sector can have.

--WARNING only change these if you know what your doing.
RegenerativeAsteroidsConfig.FieldSize = 1800; --any number value, the larger the number the larger the FIELD
RegenerativeAsteroidsConfig.MinAsteroidSize = 5.0; --any number smaler then MaxAsteroidSize
RegenerativeAsteroidsConfig.MaxAsteroidSize = 25.0; --Any number larger then MinAsteroidSize, 100 is the size of claimable asteroids

function RegenerativeAsteroidsConfig.print(...)
  local args = table.pack(...)
  table.insert(args,1,RegenerativeAsteroidsConfig.ModName .. RegenerativeAsteroidsConfig.Version)
  print(table.unpack(args))
end

return RegenerativeAsteroidsConfig
