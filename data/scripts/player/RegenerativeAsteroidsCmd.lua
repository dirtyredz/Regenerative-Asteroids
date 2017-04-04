if onServer() then
  package.path = package.path .. ";data/scripts/sector/?.lua"
  require ("RegenerativeAsteroidsScript")
  package.path = package.path .. ";data/scripts/mods/Regenerative-Asteroids/?.lua"
  require("Config")
  function initialize(Command, ...)
      local args = {...}
      local Sector = Sector()
      local x, y = Sector:getCoordinates()
      local xy = "["..x..", "..y.."]"
      if Command == "start" then
        if Sector:hasScript("data/scripts/sector/RegenerativeAsteroidsScript.lua") == false then
          print(ModInfo.ModPrefix..ModInfo.Version.."Starting sector asteroid regeneration for sector "..xy)
          Sector():addScript("data/scripts/sector/RegenerativeAsteroidsScript.lua")
        else
          print(ModInfo.ModPrefix..ModInfo.Version.."Sector "..xy.." is already regeneraterating asteroids, If you would like to stop asteroid regeneration use /regen stop")
        end
        terminate()
        return
      end
      if Command == "stop" then
        if Sector:hasScript("data/scripts/sector/RegenerativeAsteroidsScript.lua") == true then
          print(ModInfo.ModPrefix..ModInfo.Version.."Stopping sector asteroid regeneration for sector "..xy)
          Sector():removeScript("data/scripts/sector/RegenerativeAsteroidsScript.lua")
        else
          print(ModInfo.ModPrefix..ModInfo.Version.."Sector "..xy.." does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen start")
        end
        terminate()
        return
      end
      if Command == "now" then
        if Sector:hasScript("data/scripts/sector/RegenerativeAsteroidsScript.lua") == true then
          print(ModInfo.ModPrefix..ModInfo.Version.."Force Regenerating Asteroids for sector "..xy)
          RegenerateAsteroids()
        else
          print(ModInfo.ModPrefix..ModInfo.Version.."Sector "..xy.." does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen start")
        end
        terminate()
        return
      end
      if Command == "set" then
          print(ModInfo.ModPrefix..ModInfo.Version.."Setting Sector "..xy.." Regenerative limits to "..args[1])
          SetSecotrLimit(args[1])
          terminate()
          return
      end
      terminate()
      return
  end
end
