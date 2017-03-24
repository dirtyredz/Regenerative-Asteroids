function execute(sender, commandName, ...)
    local Server = Server()
    local Player = Player(sender)
    if Server:hasAdminPrivileges(Player) then
        Player(sender):addScriptOnce("DeRegenerativeAsteroidsCmd.lua", action, ...)
    else
        print('Only Administrators can use this cmd.')
    end
    
    return 0, "", ""
end

function getDescription()
    return "Removes the current sectors asteroid regeneration"
end

function getHelp()
    return "Removes the current sectors asteroid regeneration, Messages will be outputed to the console. Usage /deregen"
end
