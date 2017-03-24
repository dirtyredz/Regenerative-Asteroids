if onServer() then
  package.path = package.path .. ";data/scripts/sector/?.lua"
  require ("RegenerativeAsteroidsScript")
  function initialize()
      local Sector = Sector()
      if Sector:hasScript("data/scripts/sector/RegenerativeAsteroidsScript.lua") == true then
        print("Regenerating Asteroids....")
        RegenerateAsteroids()
      else
        print("The sector does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen")
      end
      terminate()
  end
end
