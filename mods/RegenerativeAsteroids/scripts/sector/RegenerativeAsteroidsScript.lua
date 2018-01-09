-- this is so the script won't crash when executed in a context where there's no onServer() or onClient() function available -
-- naturally those functions should return false then
if not onServer then onServer = function() return false end end
if not onClient then onClient = function() return false end end
if onClient() then return end

--Custom logging
package.path = package.path .. ";mods/LogLevels/scripts/lib/?.lua"
local logLevels = require("PrintLog")

-- namespace RegenerativeAsteroidsScript
RegenerativeAsteroidsScript = {}

if onServer() then

  package.path = package.path .. ";data/scripts/lib/?.lua"
  SectorGenerator = require ("SectorGenerator")
  Placer = require ("placer")
  require ("randomext")
  require ("stringutility")

  --For EXTERNAL configuration files
  exsist, RegenerativeAsteroidsConfig = pcall(require, 'mods.RegenerativeAsteroids.config.RegenerativeAsteroidsConfig')

    if not exsist then
      local msg = RegenerativeAsteroidsConfig
      RegenerativeAsteroidsConfig = {}
      RegenerativeAsteroidsConfig.announcment = true
      RegenerativeAsteroidsConfig.RepeatedSectorEntryAlerts = false
      RegenerativeAsteroidsConfig.MinableAsteroidLimit = 50
      RegenerativeAsteroidsConfig.MaintainNaturalAsteroidLimit = true
      RegenerativeAsteroidsConfig.MaxNonMinableAsteroids = 1500
      RegenerativeAsteroidsConfig.print = function (...) print(...) end
      RegenerativeAsteroidsConfig.FieldSize = 1800;
      RegenerativeAsteroidsConfig.MinAsteroidSize = 5;
      RegenerativeAsteroidsConfig.MaxAsteroidSize = 25;
      RegenerativeAsteroidsConfig.print("Failed to initialize config file...",msg,logLevels.fatal)
    end


  function RegenerativeAsteroidsScript.initialize()
    Sector():registerCallback("onPlayerEntered", "onPlayerEntered")
  end

  function RegenerativeAsteroidsScript.onPlayerEntered(playerIndex)
    local Sector = Sector()
    local player = Player(playerIndex)
    local msg = "You have entered a regenerative asteroid field. Asteroids will regenerate if a min number of minable asteroids is not available."%_T
    local x, y = Sector:getCoordinates()
    local xy = "\\s("..x..", "..y..")"
    local SectorDiscovered = "A player has discovered a regenerative asteroid sector, mark your maps. "..xy
    local SectorReVisit = "You have detected a players presence inside a regenerative asteroid field at sector. "..xy
    local SectorVisited = Sector:getValue("RegenerativeAsteroidsVisited")
    local VisitedBool = "true"
    if SectorVisited == nil then
      VisitedBool = "false"
    end
    if RegenerativeAsteroidsConfig.announcment == true and VisitedBool == "false" then
      Sector:setValue("RegenerativeAsteroidsVisited",true)
      Server():broadcastChatMessage("Server", 0, SectorDiscovered)
      RegenerativeAsteroidsConfig.print(player.name.." has discovered a regenerative asteroid field at sector ",xy,logLevels.info)
    end
    if RegenerativeAsteroidsConfig.RepeatedSectorEntryAlerts == true then
      Sector:broadcastChatMessage("Server", 0, SectorReVisit)
    end
    player:sendChatMessage("Server", 3, msg)
    RegenerativeAsteroidsScript.RegenerateAsteroids()
  end

  function RegenerativeAsteroidsScript.GetSectorLimit()
    return Sector():getValue("RegenerativeAsteroids")
  end

  function RegenerativeAsteroidsScript.SectorHasLimit()
    local SectorValue = Sector():getValue("RegenerativeAsteroids")
    if SectorValue == nil then
      return false
    end
    return true
  end

  function RegenerativeAsteroidsScript.SetSecotrLimit(Num)
    if Num == nil then
      Num = RegenerativeAsteroidsConfig.MinableAsteroidLimit
    end

    Sector():setValue("RegenerativeAsteroids",tonumber(Num))
  end

  function RegenerativeAsteroidsScript.GetNumberMinableAsteroids()
    local MinableAsteroids = 0
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "\\s("..x..", "..y..")"
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
    RegenerativeAsteroidsConfig.print("Found "..MinableAsteroids.." minable asteroids at sector ",xy,logLevels.debug)
    return MinableAsteroids
  end

  function RegenerativeAsteroidsScript.GetNumberNonMinableAsteroids()
    local NonMinableAsteroids = 0
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "\\s("..x..", "..y..")"
      --------
      -- loop over all the Non mineable asteroids.
      --------
      local Asteroids = {Sector:getEntitiesByType(EntityType.Asteroid)}

      for Iter,Asteroid in pairs(Asteroids) do
          if not Asteroid:hasComponent(ComponentType.FactionNotifier) and not Asteroid:hasComponent(ComponentType.Owner) then
              local Roid = Asteroid:getMineableResources()
              if Roid == nil or Roid == 0 then
                  NonMinableAsteroids = NonMinableAsteroids + 1
              end
          end
      end
    RegenerativeAsteroidsConfig.print("Found "..NonMinableAsteroids.." non-minable asteroids at sector ",xy,logLevels.debug)
    return NonMinableAsteroids
  end

  function RegenerativeAsteroidsScript.RegenerateAsteroids()
    local Sector = Sector()
    local x, y = Sector:getCoordinates()
    local xy = "\\s("..x..", "..y..")"

    local MaxMinable = 0
    local CurrentMinableAsteroids = RegenerativeAsteroidsScript.GetNumberMinableAsteroids()

    if RegenerativeAsteroidsScript.SectorHasLimit() then
      MaxMinable = RegenerativeAsteroidsScript.GetSectorLimit()
      RegenerativeAsteroidsConfig.print("Using sector asteroid limit value: "..MaxMinable..", for sector ",xy,logLevels.debug)
    elseif RegenerativeAsteroidsConfig.MaintainNaturalAsteroidLimit then
        RegenerativeAsteroidsConfig.print('MaintainNaturalAsteroidLimit',RegenerativeAsteroidsConfig.MaintainNaturalAsteroidLimit)
      MaxMinable = CurrentMinableAsteroids
      RegenerativeAsteroidsScript.SetSecotrLimit(CurrentMinableAsteroids)
      RegenerativeAsteroidsConfig.print("Using MaintainNaturalAsteroidLimit: "..MaxMinable..", for sector "..xy.." (If you wany yo force this region to have more manual set that limit with /regen set x)",logLevels.info)
    else
      MaxMinable = RegenerativeAsteroidsConfig.MinableAsteroidLimit
      RegenerativeAsteroidsConfig.print("Using config option MinableAsteroidLimit: "..MaxMinable..", for sector ",xy,logLevels.debug)
    end

    if CurrentMinableAsteroids < MaxMinable then
      local AsteroidsToGenerate = MaxMinable - CurrentMinableAsteroids
      local generator = SectorGenerator(Sector:getCoordinates())
      local size = getFloat(0.5, 1.0)

      if RegenerativeAsteroidsConfig.MinAsteroidSize >= RegenerativeAsteroidsConfig.MaxAsteroidSize then
          RegenerativeAsteroidsConfig.print("Config option: MinAsteroidSize, is larger then MaxAsteroidSize, setting both to default values.",logLevels.warning)
          RegenerativeAsteroidsConfig.MinAsteroidSize = 5;
          RegenerativeAsteroidsConfig.MaxAsteroidSize = 25;
      end

      local asteroid = generator:createAsteroidFieldEx(AsteroidsToGenerate * 2,RegenerativeAsteroidsConfig.FieldSize * size, RegenerativeAsteroidsConfig.MinAsteroidSize, RegenerativeAsteroidsConfig.MaxAsteroidSize, 1, 0.5)

      Placer.resolveIntersections()
      RegenerativeAsteroidsConfig.print("Created "..MaxMinable.." Minable Asteroids in sector ",xy,logLevels.info)
    end

    local NonMinable = RegenerativeAsteroidsScript.GetNumberNonMinableAsteroids()
    local NonMinableNow = NonMinable
    if NonMinable > RegenerativeAsteroidsConfig.MaxNonMinableAsteroids then
        local Asteroids = {Sector:getEntitiesByType(EntityType.Asteroid)}

        for Iter,Asteroid in pairs(Asteroids) do
            if not Asteroid:hasComponent(ComponentType.FactionNotifier) and not Asteroid:hasComponent(ComponentType.Owner) then
                local Roid = Asteroid:getMineableResources()
                if Roid == nil or Roid == 0 then
                    NonMinable = NonMinable - 1
                    Sector:deleteEntity(Asteroid)
                end
            end
            if NonMinable < RegenerativeAsteroidsConfig.MaxNonMinableAsteroids then break end
        end
        local Removed = NonMinableNow - NonMinable
        RegenerativeAsteroidsConfig.print("Removed "..Removed.." excess Non-Minable Asteroids in sector ",xy,logLevels.info)
    end
  end
end

return RegenerativeAsteroidsScript
