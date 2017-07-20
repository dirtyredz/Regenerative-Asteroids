RegenerativeAsteroidsConfig = {
    frequency = 300; -- 0 to 1000, probability of this sector to appear. Keep around 300 to be average with other similiar sectors.
    announcment = true; -- true or false, false will disable the server wide message that one of these sectors have been found.
    MinableAsteroidLimit = 50; -- number of asteroids to maintain in the sector.
    NeutralZone = false; -- true or false, true will enable Regenerative-Asteroids for all neutral zones.
    SectorGenerator = true; -- true or false, true will allow for random sectors to be regenerative asteroid fields.  use false if you want to have this script run only in SPECIFIC  sectors using the /regen command
    MaintainNaturalAsteroidLimit = false;--true or false, true will allow only enough asteroids to be generated to meet the limit the sector had originaly generated. IE a sector naturally has 50 asteroids, this option will never exceed 50 asteroids in the sector.
    RepeatedSectorEntryAlerts = false;--true or false, true will announce every time a player enters into a regenerative asteroid field.
}
RegenerativeAsteroidsModInfo = {
    ModPrefix = "[Regenerative-Asteroids]";
    Version = "[1.4.0]";
    Debug = false;--Will enable extra console messages for how many asteroids detected and what method of generation was used.
}
