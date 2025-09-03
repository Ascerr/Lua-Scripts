--[[
    Script Name: 		Exiva Players
    Description: 		Exiva selected nicks and perform action if player is far or close, ignore very far.
    Author: 			Ascer - example
]]


local config = {
    names = {"Enemy1", "Enemy2"},                                            -- character names to exiva
    action = "logout",                                                       -- action: "logout", "exit", "label" -> will go to default label: escape
    delay = 2.5,                                                             -- minimal delay seconds to execute exiva message in loop for finding players
    repeatExivaEvery = 120,                                                  -- seconds repeat exiva every example 120 s
    hpperc = 60,                                                             -- cast only if selfHpperc >= 60%
    mana = 20                                                                -- min mana points to cast spell. Set higher value to avoid problems with healing                               
}


-- DON'T EDIT BELOW
local exivaGlobalTime, exivaTime, exivaIndex, exivaFoundPlayer, exivaCanSwitchLabel = 0, 0, 1, "", true

config.names = table.lower(config.names)
config.action = config.action:lower()

function findPlayers()
    if exivaFoundPlayer ~= "" then return false end
    if os.clock() - exivaGlobalTime >= config.repeatExivaEvery then
        if os.clock() - exivaTime >= config.delay and Self.Mana() >= config.mana and Self.HealthPercent() >= config.hpperc then
            if exivaIndex > #config.names or exivaIndex < 1 then
                exivaIndex = 1
                exivaGlobalTime = os.clock()
                return
            end
            Self.Say("exiva \"" .. config.names[exivaIndex], config.mana)
            exivaIndex = exivaIndex + 1
            exivaTime = os.clock()
        end
    end        
end 

function playerInMessage(msg)
    msg = msg:lower()
    for _, name in ipairs(config.names) do
        if string.sub(msg, 1, string.len(name)) == name then -- checking if nick is at the first position of message.
            return name
        end
    end
    return ""
end

function exitGameClient()
    print("exit")
    os.execute("taskkill /PID " .. Rifbot.getClientInfo().pid .. " /F")
    wait(5000)
end 

function logoutGameClient()
    if Walker.isEnabled() then
        Walker.Enabled(false)
    end
    if Looter.isEnabled() then
        Looter.Enabled(false)
    end
    if not Self.isInFight() then    -- leave targeting on to be able kill monsters, here is also place to perform some actions leading to go specific place
        return Self.Logout()
    end    
end 

-- loop function
Module.New("Exiva Players", function()
    if Self.isConnected() then
        findPlayers()
        if exivaFoundPlayer ~= "" then
            if config.action == "exit" then
                exitGameClient()
            elseif config.action == "logout" then
                logoutGameClient()
            elseif config.action == "label" then
                if exivaCanSwitchLabel then
                    Walker.Goto("escape")
                    exivaCanSwitchLabel = false
                    print("Goto label: escape due exiva close player detected: " .. exivaFoundPlayer)
                end    
            end    
        end
    else        
        if exivaFoundPlayer ~= "" then
            print("Logout due exiva close player detected: " .. exivaFoundPlayer)
            exivaFoundPlayer = "" -- reset found player while offline.
        end
        exivaCanSwitchLabel = true    
    end    
end)

-- green message checking
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        local isPlayer = playerInMessage(msg.message)
        if isPlayer ~= "" then
            if not string.find(msg.message:lower(), "is very far to") then -- here ignoring green messages with very var actions
                Rifbot.PlaySound()
                print(msg.message)
                exivaFoundPlayer = isPlayer
            end    
        end    
    end 
end
Proxy.TextNew("proxyText")
