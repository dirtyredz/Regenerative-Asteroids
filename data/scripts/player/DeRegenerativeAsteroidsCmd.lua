if onServer() then
  function initialize()
      local Sector = Sector()
      if Sector:hasScript("data/scripts/sector/RegenerativeAsteroidsScript.lua") == true then
        print("Stopping sector asteroid regeneration!")
        Sector():removeScript("data/scripts/sector/RegenerativeAsteroidsScript.lua")
      else
        print("The sector does not have asteroids regenerating, If you would like to start a steroid regeneration use /regen")
      end
      terminate()
  end
end
