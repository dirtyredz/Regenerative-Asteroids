function execute(sender, commandName, ...)
    local Server = Server()
    local Player = Player(sender)
    if Server:hasAdminPrivileges(Player) then
        Player:addScriptOnce("RegenerativeAsteroidsCmd.lua", action, ...)
    else
        print('Only Administrators can use this cmd.')
    end
    return 0, "", ""
end

function getDescription()
    return "Sets the sector to regenerate astoroids"
end

function getHelp()
    return "Sets the current sector to regenerate asteroids, Messages will be outputed to the console. Usage /regen"
end
