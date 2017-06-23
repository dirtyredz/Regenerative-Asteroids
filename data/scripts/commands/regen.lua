if onServer() then
  function execute(sender, commandName, ...)
      local args = {...}
      local Server = Server()
      local Player = Player(sender)
      if Server:hasAdminPrivileges(Player) then
          local Cmd2 = args[1]
          if Cmd2 == "start" or Cmd2 == "stop" or Cmd2 == "now" or Cmd2 == "count" then
              Player:addScriptOnce("RegenerativeAsteroidsCmd.lua",Cmd2)
          elseif Cmd2 == "set" then
              if args[2] == null then
                  print('Cmd usage: /regen set [number of asteroids]')
                  return 0, "", ""
              end
              Player:addScriptOnce("RegenerativeAsteroidsCmd.lua",Cmd2,args[2])
          else
              print(getHelp())
          end
      else
          print('Only Administrators can use this cmd.')
      end
      return 0, "", ""
  end

  function getDescription()
      return "Sets the sector to regenerate astoroids"
  end

  function getHelp()
      return "Sets the current sector to regenerate asteroids, Messages will be outputed to the console. Usage /regen [start/stop/now/count/set]"
  end
end
