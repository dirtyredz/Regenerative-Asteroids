if onServer() then

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/mods/Regenerative-Asteroids/?.lua"
SectorGenerator = require ("SectorGenerator")
Placer = require ("placer")
require ("randomext")
require ("stringutility")
require("Config")
  function initialize()
      Sector():registerCallback("onPlayerEntered", "onPlayerEntered")
  end

  function onPlayerEntered(playerIndex)
      local Sector = Sector()
      local player = Player(playerIndex)
      local msg = "You have entered a regenerative asteroid field. Asteroids will regenerate if a min number of minable asteroids is not available."%_T
      local x, y = Sector:getCoordinates()
      local xy = "["..x..", "..y.."]"
      local SectorDiscovered = "A player has discovered a regenerative asteroid sector, mark your maps. "..xy
      local SectorReVisit = "You have detected a players presence inside a regenerative asteroid field at sector. "..xy
      local SectorVisited = Sector:getValue("RegenerativeAsteroidsVisited")
      local VisitedBool = "true"
      if SectorVisited == nil then
        VisitedBool = "false"
      end
      if Config.announcment == true and VisitedBool == "false" then
        Sector:setValue("RegenerativeAsteroidsVisited",true)
        Sector:broadcastChatMessage("Server", 0, SectorDiscovered)
        if ModInfo.Debug then
          print(ModInfo.ModPrefix..ModInfo.Version..player.name.." has discovered a regenerative asteroid field at sector "..xy)
        end
      end
      if Config.RepeatedSectorEntryAlerts == true then
        Sector:broadcastChatMessage("Server", 0, SectorReVisit)
      end
      player:sendChatMessage("Server", 3, msg)
      RegenerateAsteroids()
  end
  function GetSectorLimit()
    return Sector():getValue("RegenerativeAsteroids")
  end
  function SectorHasLimit()
    local SectorValue = Sector():getValue("RegenerativeAsteroids")
    if SectorValue == nil then
      return false
    end
    return true
  end
  function SetSecotrLimit(Num)
    if Num == nil then
      Num = Config.MinableAsteroidLimit
    end

    Sector():setValue("RegenerativeAsteroids",tonumber(Num))
  end

  function GetNumberMinableAsteroids()
    local MinableAsteroids = 0
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "["..x..", "..y.."]"
  	--------
  	-- loop over all the mineable asteroids.
  	--------
  	local Asteroids = {Sector:getEntitiesByType(EntityType.Asteroid)}

  	for Iter,Asteroid in pairs(Asteroids)
  	do
      local Roid = Asteroid:getMineableResources()
  		if Roid ~= nil and Roid > 0  then
  			MinableAsteroids = MinableAsteroids + 1
  		end
  	end
    if ModInfo.Debug then
      print(ModInfo.ModPrefix..ModInfo.Version.."Found "..MinableAsteroids.." minable asteroids at sector "..xy)
    end
    return MinableAsteroids
  end

  function RegenerateAsteroids()
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "["..x..", "..y.."]"

    local MaxMinable = 0
    local CurrentMinableAsteroids = GetNumberMinableAsteroids()
    if SectorHasLimit() then
      MaxMinable = GetSectorLimit()
      if ModInfo.Debug then
        print(ModInfo.ModPrefix..ModInfo.Version.."Using sector asteroid limit value: "..MaxMinable..", for sector "..xy)
      end
    elseif Config.MaintainNaturalAsteroidLimit then
      MaxMinable = CurrentMinableAsteroids
      SetSecotrLimit(CurrentMinableAsteroids)
      if ModInfo.Debug then
        print(ModInfo.ModPrefix..ModInfo.Version.."Using MaintainNaturalAsteroidLimit: "..MaxMinable..", for sector "..xy.." (If you wany yo force this region to have more manual set that limit with /regen set x)")
      end
    else
      MaxMinable = Config.MinableAsteroidLimit
      if ModInfo.Debug then
        print(ModInfo.ModPrefix..ModInfo.Version.."Using config option MinableAsteroidLimit: "..MaxMinable..", for sector "..xy)
      end
    end

    if CurrentMinableAsteroids < MaxMinable then
      local AsteroidsToGenerate = MaxMinable - CurrentMinableAsteroids
      local generator = SectorGenerator(Sector:getCoordinates())
      local size = getFloat(0.5, 1.0)
      local asteroid = generator:createAsteroidFieldEx(AsteroidsToGenerate * 2,1800 * size, 5.0, 25.0, 1, 0.5)
      Placer.resolveIntersections()
      if ModInfo.Debug then
        print(ModInfo.ModPrefix..ModInfo.Version.."Created "..MaxMinable.." Minable Asteroids in sector "..xy)
      end
    end
  end
end
