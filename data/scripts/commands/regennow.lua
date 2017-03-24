function execute(sender, commandName, ...)
    local Server = Server()
    local Player = Player(sender)
    if Server:hasAdminPrivileges(Player) then
        Player(sender):addScriptOnce("NowRegenerativeAsteroidsCmd.lua", action, ...)
    else
        print('Only Administrators can use this cmd.')
    end
    
    return 0, "", ""
end

function getDescription()
    return "Runs the RegenerativeAsteroids Script now"
end

function getHelp()
    return "Runs the RegenerativeAsteroids Script now, Messages will be outputed to the console. Usage /regennow"
end
