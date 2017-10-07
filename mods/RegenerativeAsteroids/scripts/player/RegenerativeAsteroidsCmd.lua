-- this is so the script won't crash when executed in a context where there's no onServer() or onClient() function available -
-- naturally those functions should return false then
if not onServer then onServer = function() return false end end
if not onClient then onClient = function() return false end end
if onClient() then return end

-- namespace RegenerativeAsteroidsCmd
RegenerativeAsteroidsCmd = {}

if onServer() then

  RegenerativeAsteroidsScript = require("mods.RegenerativeAsteroids.scripts.sector.RegenerativeAsteroidsScript")

  --For EXTERNAL configuration files
  exsist, RegenerativeAsteroidsConfig = pcall(require, 'mods.RegenerativeAsteroids.config.RegenerativeAsteroidsConfig')
  RegenerativeAsteroidsCmd.print = RegenerativeAsteroidsConfig.print or function (...) print(...) end

  function RegenerativeAsteroidsCmd.initialize(Command, ...)
    local args = {...}
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "["..x..", "..y.."]"
    local script = Sector:hasScript("mods/RegenerativeAsteroids/scripts/sector/RegenerativeAsteroidsScript.lua")

    if Command == "start" then
      if script == false then
        Sector():addScript("mods/RegenerativeAsteroids/scripts/sector/RegenerativeAsteroidsScript.lua")
        RegenerativeAsteroidsCmd.print("Starting sector asteroid regeneration for sector "..xy)
      else
        RegenerativeAsteroidsCmd.print("Sector "..xy.." is already regeneraterating asteroids, If you would like to stop asteroid regeneration use /regen stop")
      end
      terminate()
      return

    elseif Command == "stop" then
      if script == true then
        Sector():removeScript("mods/RegenerativeAsteroids/scripts/sector/RegenerativeAsteroidsScript.lua")
        RegenerativeAsteroidsCmd.print("Stopping sector asteroid regeneration for sector "..xy)
      else
        RegenerativeAsteroidsCmd.print("Sector "..xy.." does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen start")
      end
      terminate()
      return

    elseif Command == "now" then
      if script == true then
        RegenerativeAsteroidsScript.RegenerateAsteroids()
        RegenerativeAsteroidsCmd.print("Force Regenerating Asteroids for sector "..xy)
      else
        RegenerativeAsteroidsCmd.print("Sector "..xy.." does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen start")
      end
      terminate()
      return

    elseif Command == "set" then
      RegenerativeAsteroidsScript.SetSecotrLimit(args[1])
      RegenerativeAsteroidsCmd.print("Setting Sector "..xy.." Regenerative limits to "..args[1])
      terminate()
      return
    end

    terminate()
    return
  end
end
