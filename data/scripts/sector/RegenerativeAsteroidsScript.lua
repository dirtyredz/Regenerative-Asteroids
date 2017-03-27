if onServer() then

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/mods/Regenerative-Asteroids/?.lua"
SectorGenerator = require ("SectorGenerator")
Placer = require ("placer")
require ("stringutility")
require("Config")
  function initialize()
      Sector():registerCallback("onPlayerEntered", "onPlayerEntered")
  end

  function onPlayerEntered(playerIndex)
      local player = Player(playerIndex)
      local msg = "You have entered a regenerative asteroid field. Asteroids will regenerate if a min number of minable asteroids is not available."%_T
      local x, y = Sector():getCoordinates()
      local servermsg = "A player has discovered a regenerative asteroid sector, mark your maps. "..x..", "..y
      if Config.announcment == true then
        Server():broadcastChatMessage("Server", 0, servermsg)
      end
      player:sendChatMessage("Server", 3, msg)
      RegenerateAsteroids()
  end

  function RegenerateAsteroids()
    local sector = Sector()
    local num = 0
    local asteroids = {sector:getEntitiesByType(EntityType.Asteroid)}
    for _, a in pairs(asteroids) do
        local resources = a:getMineableResources()
        if resources ~= nil and resources > 0 then
           num = num + 1
        end
    end
    print("Number of minable asteroids:  "..num)
    if num < Config.minableasteroidlimit then
      local generator = SectorGenerator(Sector():getCoordinates())
      local asteroid = generator:createAsteroidField(0.8)

      Placer.resolveIntersections()
      print("Created Rich Asteroid Field")
      num = 0
      asteroids = {sector:getEntitiesByType(EntityType.Asteroid)}
      for _, a in pairs(asteroids) do
          local resources = a:getMineableResources()
          if resources ~= nil and resources > 0 then
             num = num + 1
          end
      end
      print("There are now "..num.." asteroids available for mining.")
    end
  end
end
