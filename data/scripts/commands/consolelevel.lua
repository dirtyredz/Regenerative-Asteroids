package.path = package.path .. ";mods/LogLevels/scripts/lib/?.lua"
local levels = require("LogLevels")

function execute(sender, commandName, level, ...)
  local args = {...}
  local Server = Server()
  local Player = Player(sender)


  if not level then
    return 0, "", ""
  end

  for levelName, logLevel in pairs(levels) do

    if level == levelName then

      if sender ~= nil then
        Player:sendChatMessage('Server', 0, 'console level set to: ' .. level)
      end

      if onServer() then
        print('-- console level set to: ' .. level ..' --')
      end

      Server():setValue('console_level',logLevel)
      return 0, "", ""
    end

  end

  if sender ~= nil then
    Player:sendChatMessage('Server', 0, 'Unkown consolelevel option, use: /help consolelevel')
  end
  return 0, "", ""
end

function getDescription()
    return "Sets the console level."
end

function getHelp()
    local availableOptions = ''
    for levelName, logLevel in pairs(levels) do
      if availableOptions == '' then
        availableOptions = levelName
      else
        availableOptions = availableOptions..'/'..levelName
      end
    end
    return "Sets the console level, use: /consolelevel ["..availableOptions.."]"
end
