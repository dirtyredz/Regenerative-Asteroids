
package.path = package.path .. ";data/scripts/sector/?.lua"
package.path = package.path .. ";configs/?.lua"

-- this is so the script won't crash when executed in a context where there's no onServer() or onClient() function available -
-- naturally those functions should return false then
if not onServer then onServer = function() return false end end
if not onClient then onClient = function() return false end end
if onClient() then return end

-- namespace RegenerativeAsteroidsCmd
RegenerativeAsteroidsCmd = {}

-- Dirtyredz | David McClain
function RegenerativeAsteroidsCmd.print(message)
  if message ~= nil then
    print(RegenerativeAsteroidsModInfo.ModPrefix .. RegenerativeAsteroidsModInfo.Version .. message)
  else
    print(RegenerativeAsteroidsModInfo.ModPrefix .. RegenerativeAsteroidsModInfo.Version .. " nil")
  end
end

if onServer() then

  require("RegenerativeAsteroidsScript")
  require("RegenerativeAsteroidsConfig")

  function RegenerativeAsteroidsCmd.initialize(Command, ...)
    local args = {...}
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "["..x..", "..y.."]"
    local script = Sector:hasScript("RegenerativeAsteroidsScript.lua")

    if Command == "start" then
      if script == false then
        RegenerativeAsteroidsCmd.print("Starting sector asteroid regeneration for sector "..xy)
        Sector():addScript("RegenerativeAsteroidsScript.lua")
      else
        RegenerativeAsteroidsCmd.print("Sector "..xy.." is already regeneraterating asteroids, If you would like to stop asteroid regeneration use /regen stop")
      end
      terminate()
      return

    elseif Command == "stop" then
      if script == true then
        RegenerativeAsteroidsCmd.print("Stopping sector asteroid regeneration for sector "..xy)
        Sector():removeScript("RegenerativeAsteroidsScript.lua")
      else
        RegenerativeAsteroidsCmd.print("Sector "..xy.." does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen start")
      end
      terminate()
      return

    elseif Command == "now" then
      if script == true then
        RegenerativeAsteroidsCmd.print("Force Regenerating Asteroids for sector "..xy)
        RegenerativeAsteroidsScript.RegenerateAsteroids()
      else
        RegenerativeAsteroidsCmd.print("Sector "..xy.." does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen start")
      end
      terminate()
      return

    elseif Command == "set" then
      RegenerativeAsteroidsCmd.print("Setting Sector "..xy.." Regenerative limits to "..args[1])
      RegenerativeAsteroidsScript.SetSecotrLimit(args[1])
      terminate()
      return
    end

    terminate()
    return
  end
end
