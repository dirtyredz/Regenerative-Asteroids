if onServer() then
  function initialize()
      local Sector = Sector()
      if Sector:hasScript("data/scripts/sector/RegenerativeAsteroidsScript.lua") == false then
        print("Starting sector asteroid regeneration!")
        Sector():addScript("data/scripts/sector/RegenerativeAsteroidsScript.lua")
      else
        print("The sector is already regeneraterating asteroids, If you would like to stop asteroid regeneration use /deregen")
      end
      terminate()
  end
end
