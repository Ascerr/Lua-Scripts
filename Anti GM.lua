--[[
    Script Name:        Anti GM
    
    Description:        Advanced script to stops bot when GM detected or intereacting with as.                
    Author:             Ascer - example 
]]

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> CONFIG SECTION: start
----------------------------------------------------------------------------------------------------------------------------------------------------------

local CHECK_IF_TELEPORTED = {
    enabled = true,                                     -- true/false check if you character was teleported
    sqms = 3,                                           -- minimal amount of sqms to check.
    pauseBot = true,                                     -- true/false pause bot or not (default alarm will play)
    respond = true                                      -- respond short after character will teleported. Messages used here are this same as CHECK_FOR_PM_DEFAULT_MESSAGE. respond
}

local CHECK_IF_GM_ON_SCREEN = {
    enabled = true,                                     -- true/false check for gm on screen
    keywords = {"GM ", "CM ", "Admin ", "ADM ", "Gamemaster"}, -- table of keywords in gm nick
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play)    
}

local CHECK_FOR_PM_DEFAULT_MESSAGE = {
    enabled = true,                                     -- true/false check if gm send to as pm or default message, #IMPORTANT respond only to nicks from CHECK_IF_GM_ON_SCREEN.keywords
    pauseBot = true,                                    -- true/false pause bot or not (default alarm will play)
    respond = {
        enabled = false,                                -- true/false respond fo default message
        randomMsg = {"yoyo", ":)", "^^", ":D", "?"}     -- messages to respond only once
    } 
}

local CHECK_FOR_MANA_INCREASED = {
    enabled = false,                                     -- true/false check if mana gained fast in one tick.
    points = 100,                                       -- minimal mana points gained to module works
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play)
}

local CHECK_FOR_HEALTH_DMG = {
    enabled = false,                                     -- true/false check for hp decarese by percent
    percent = 60,                                       -- minimal hpperc decreased by GM.                  
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play)
}

local CHECK_FOR_SPECIAL_MONSTER = {
    enabled = false,                                    -- true/false check if on screen appear special monster that normal don't appear in this place
    names = {"Demon", "Black Sheep"},                   -- monster names
    useAboveListAsSafe = false,                         -- true/false if true then above list will contains safe monsters and any other will be mark as danger. If false then monsters from list will mark as danger
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play)
}

local CHECK_FOR_RARE_ITEM = {
    enabled = false,                                    -- true/false check for rare item droped on ground. 
    ids = {3079, 3319},                                 -- ids of items to check
    range = 7,                                          -- distance from our character we checking
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play)
}

local CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR = {
    enabled = false,                                    -- true/false check if GM creating monster and destroy it in short time.
    names = {"Hero", "Dragon"},                         -- name of monsters
    isAliveLessThan = 1,                                 -- mark monsters that are alive less than 1s. (it won't works for monsters with low HP died on headshoot)
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play) 
}

local CHECK_FOR_MONSTERS_CREATION = {
    enabled = false,                                    -- [!IMPORTANT: works only on servers that don't spawn monsters when player on screen] true/false check if monsters spawn on screen. 
    pauseBot = true                                     -- true/false pause bot or not (default alarm will play)
}


local PAUSE_CAVEBOT_ONLY = {
    enabled = false                                     -- while GM detected pause only Cavebot (targeting, walker, looter)
}

local RESUME = {
    enabled = false,                                    -- true/false resume bot after some time paused
    time = 180                                          -- time in seconds to unpause bot
}

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> CONFIG SECTION: end
----------------------------------------------------------------------------------------------------------------------------------------------------------


-- DONT'T EDIT BELOW THIS LINE 

CHECK_FOR_SPECIAL_MONSTER.names = table.lower(CHECK_FOR_SPECIAL_MONSTER.names)
CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR.names = table.lower(CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR.names)

local detectTime = 0
local teleported, old = false, {x=0, y=0, z=0}
local lastMana = Self.Mana()
local lastHealth = Self.Health()
local responders, respond, respondTime = {}, false, 0
local checkItemTime = 0
local resumeTime = 0
local pausedTriger = false
local mobDisappear, mobDisappearTime, disappear = -1, 0, false
local allowCheckMobCreation, mobsCreationLevel, appearMob, appear = false, {x=0,y=0,z=0}, -1, false

-- reset teleported pos
Self.GetTeleported()

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       init()
--> Description:    Params initialization.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function init()
    if Rifbot.isEnabled() then 
        if pausedTriger then
            pausedTriger = false
            disappear = false
            mobDisappear = -1
            appear = false
            allowCheckMobCreation = false
            teleported = false
            mobsCreationLevel = {x=0,y=0,z=0}
            old = Self.Position()
            lastMana = Self.Mana()
            lastHealth = Self.Health()
        end    
    else
        pausedTriger = true
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       customPause()
--> Description:    Pause whole bot (*without lua scripts) or pause cavebot only (targeting, walker, looter)
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function customPause()
    if PAUSE_CAVEBOT_ONLY.enabled then
        if Targeting.isEnabled() then Targeting.Enabled(false) end
        if Walker.isEnabled() then Walker.Enabled(false) end
        if Looter.isEnabled() then Looter.Enabled(false) end
    else
        if Rifbot.isEnabled() then Rifbot.setEnabled(false) end
    end    
end    

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkIfTeleported()
--> Description:    Check for character current position and play sound and stops bot when pos quick change.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkIfTeleported()
    if not CHECK_IF_TELEPORTED.enabled then return end
    if CHECK_IF_TELEPORTED.sqms <= 2 then Rifbot.setCriticalMode(true) end
    if teleported then
        Rifbot.PlaySound("Default.mp3")
        if CHECK_IF_TELEPORTED.pauseBot then
            customPause()
        end 
    end    
    local dist = Self.DistanceFromPosition(old.x, old.y, old.z)
    local getTeleported = Self.GetTeleported()
    if old.x ~= 0 and (dist >= CHECK_IF_TELEPORTED.sqms and (dist > 2 or old.z == Self.Position().z)) or (table.count(getTeleported) > 1 and getTeleported.z == old.z) then
        if CHECK_IF_TELEPORTED.respond and not teleported then
            respond = true
        end
        teleported = true    
        Rifbot.PlaySound("Default.mp3")
        if CHECK_IF_TELEPORTED.pauseBot then
            customPause()
        end 
        print("Your character has been teleported " .. dist .. " sqms.")
    end
    old = Self.Position()
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForVisibleGM(creatures)
--> Description:    Check for gms on screen and play sound.
--> Params:         
-->                 @creatures table with creatures.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForVisibleGM(creatures)
    if not CHECK_IF_GM_ON_SCREEN.enabled then return end
    local mypos = Self.Position()
    for i = 1, #creatures do
        local player = creatures[i]
        if Creature.isPlayer(player) then
            for j = 1, #CHECK_IF_GM_ON_SCREEN.keywords do
                if string.instr(player.name, CHECK_IF_GM_ON_SCREEN.keywords[j]) and mypos.z == player.z then
                    Rifbot.PlaySound("Default.mp3")
                    if CHECK_IF_GM_ON_SCREEN.pauseBot then
                        customPause()
                    end
                    print("Detected player " .. player.name .. " on screen.")
                    break    
                end    
            end    
        end    
    end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForManaIncreased()
--> Description:    Check for mana increased.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForManaIncreased()
    if not CHECK_FOR_MANA_INCREASED.enabled then return end
    local mp = Self.Mana()
    if mp > lastMana then
        local gain = mp - lastMana
        if gain >= CHECK_FOR_MANA_INCREASED.points then
            Rifbot.PlaySound("Default.mp3")
            if CHECK_FOR_MANA_INCREASED.pauseBot then
                customPause()
            end
            print("Mana increased by " .. gain .. " points")
        end    
    end
    lastMana = mp 
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForHealthDmg()
--> Description:    Check for health dmg.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForHealthDmg()
    if not CHECK_FOR_HEALTH_DMG.enabled then return end
    local hp = Self.Health()
    if hp < lastHealth then
        local dmg = lastHealth - hp
        dmg = math.floor((dmg / Self.HealthMax()) * 100)
        if dmg >= CHECK_FOR_HEALTH_DMG.percent then
            Rifbot.PlaySound("Default.mp3")
            if CHECK_FOR_HEALTH_DMG.pauseBot then
                customPause()
            end
            print("Health dmg over " .. dmg .. "%")
        end    
    end
    lastHealth = hp 
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForSpecialMonsters(creatures)
--> Description:    Check for special creatures screen and play sound.
--> Params:         
-->                 @creatures table with creatures.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForSpecialMonsters(creatures)
    if not CHECK_FOR_SPECIAL_MONSTER.enabled then return end
    local mypos = Self.Position()
    for i = 1, #creatures do
        local mob = creatures[i]
        if Creature.isMonster(mob) and mob.z == mypos.z then
            local var = table.find(CHECK_FOR_SPECIAL_MONSTER.names, string.lower(mob.name))
            if CHECK_FOR_SPECIAL_MONSTER.useAboveListAsSafe then
                var = not table.find(CHECK_FOR_SPECIAL_MONSTER.names, string.lower(mob.name))
            end    
            if var then
                Rifbot.PlaySound("Default.mp3")
                if CHECK_FOR_SPECIAL_MONSTER.pauseBot then
                    customPause()
                end
                print("Detected monster " .. mob.name .. " on screen.")
                break    
            end        
        end    
    end
end    

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForMonstersCreationAndDisappear(creatures)
--> Description:    Check if example monster you attacked appear on screen and fast disapper then play sound.
--> Params:         
-->                 @creatures table with creatures.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForMonstersCreationAndDisappear(creatures)
    if not CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR.enabled then return end
    local target = Self.TargetID()
    for i = 1, #creatures do
        local mob = creatures[i]
        if Creature.isMonster(mob) then
            if table.find(CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR.names, string.lower(mob.name)) then
                if mob.id == target then
                    if mobDisappear == -1 or mobDisappear.id ~= target then
                        mobDisappear = mob
                        mobDisappearTime = os.clock()
                    end
                    return    
                end
                if table.count(mobDisappear) > 1 and mob.id == mobDisappear.id then return end 
            end        
        end    
    end
    if table.count(mobDisappear) > 1 and ((Creature.isOnScreen(mobDisappear) and mobDisappear.hpperc > 20 and os.clock() - mobDisappearTime < CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR.isAliveLessThan) or disappear) then
        disappear = true
        Rifbot.PlaySound("Default.mp3")
        if CHECK_FOR_MONSTERS_CREATION_AND_DISAPPEAR.pauseBot then
            customPause()
        end
        print("Detected monster creation and disappear " .. mobDisappear.name .. " on screen.")
    else
        mobDisappear = -1    
    end        
end    

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForMonstersCreation(creatures)
--> Description:    Check if monster was spawned on screen. Works only for servers that don't spawn it when player is on screen
--> Params:         
-->                 @creatures table with creatures.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForMonstersCreation(creatures)
    if not CHECK_FOR_MONSTERS_CREATION.enabled then return end
    local pos = Self.Position()
    if mobsCreationLevel.z ~= pos.z or math.abs(mobsCreationLevel.x - pos.x) > 7 or math.abs(mobsCreationLevel.y - pos.y) > 5 then 
        allowCheckMobCreation = false
    end   
    mobsCreationLevel = pos
    local count = 0
    for i = 1, #creatures do
        local mob = creatures[i]
        if Creature.isMonster(mob) and mob.z == pos.z and math.abs(mob.x - pos.x) <= 7 and math.abs(mob.y - pos.y) <= 5 then
            count = count + 1
            if allowCheckMobCreation then
                if Creature.DistanceFromSelf(mob) < 4 then
                    appear = true
                    appearMob = mob
                    break
                end    
            end    
        end    
    end
    if count > 0 then
        allowCheckMobCreation = false
    else
        allowCheckMobCreation = true
    end    
    if appear then
        Rifbot.PlaySound("Default.mp3")
        if CHECK_FOR_MONSTERS_CREATION.pauseBot then
            customPause()
        end
        print("Detected monster creation " .. appearMob.name .. " on screen.")
    end     
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       checkForRareItems(range)
--> Description:    Check rare items on ground in range and play sound/pause bot.
--> Params:         None
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function checkForRareItems()
    if not CHECK_FOR_RARE_ITEM.enabled then return end
    if os.clock() - checkItemTime < 1 then return end
    local pos = Self.Position()
    checkItemTime = os.clock()
    local range = CHECK_FOR_RARE_ITEM.range
    local rangex, rangey = range, range
    if range > 7 then rangex = 7 end
    if range > 5 then rangey = 5 end

    for x = -rangex, rangex do
        for y = -rangey , rangey do
            local map = Map.GetTopMoveItem(pos.x + x, pos.y + y, pos.z)
            if table.find(CHECK_FOR_RARE_ITEM.ids, map.id) then
                Rifbot.PlaySound("Default.mp3")
                print("Found rare item on screen: " .. map.id)
                if CHECK_FOR_RARE_ITEM.pauseBot then
                    customPause()
                end
                break
            end    
        end    
    end         
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       resume()
--> Description:    Resume bot after beeing paused for x time.
--> Params:         None
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function resume()
    if not RESUME.enabled then return end
    if not Rifbot.isEnabled() or (PAUSE_CAVEBOT_ONLY and not Walker.isEnabled()) then
        if resumeTime <= 0 then
            resumeTime = os.clock()
        else    
            if os.clock() - resumeTime > RESUME.time then
                if PAUSE_CAVEBOT_ONLY then
                    if not Targeting.isEnabled() then Targeting.Enabled(true) end
                    if not Walker.isEnabled() then Walker.Enabled(true) end
                    if not Looter.isEnabled() then Looter.Enabled(true) end
                end    
                Rifbot.setEnabled(true)
                teleported = false
                old = Self.Position()
                lastMana = Self.Mana()
                lastHealth = Self.Health()
                disappear = false
                mobDisappear = -1
            end         
        end
    else
        resumeTime = 0     
    end        
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       respondForMessage()
--> Description:    Execute message respond.
-->                 
--> Return:         nil - nothing
----------------------------------------------------------------------------------------------------------------------------------------------------------
function respondForMessage()
    if respond then
        local msg = CHECK_FOR_PM_DEFAULT_MESSAGE.respond.randomMsg[math.random(1, #CHECK_FOR_PM_DEFAULT_MESSAGE.respond.randomMsg)]
        wait(500 + 90 * #msg)
        Self.Say(msg)
        respond = false
        respondTime = os.clock()
        print("Responded this message: " .. msg)
    end
    if os.clock() - respondTime > 10 * 60 then -- reset list to respond
        responders = {}
    end     
end    

-- proxy messages
function proxy(messages) 
    if not CHECK_IF_GM_ON_SCREEN.enabled then return end
    for i, msg in ipairs(messages) do 
        for j = 1, #CHECK_IF_GM_ON_SCREEN.keywords do
            if string.instr(msg.speaker, CHECK_IF_GM_ON_SCREEN.keywords[j]) then
                Rifbot.PlaySound("Default.mp3")
                if CHECK_FOR_PM_DEFAULT_MESSAGE.respond.enabled then
                    if not table.find(responders, msg.speaker) then
                        table.insert(responders, msg.speaker)
                        respond = true
                    end
                end    

                if CHECK_FOR_PM_DEFAULT_MESSAGE.pauseBot then
                    if Rifbot.isEnabled() then
                        Rifbot.setEnabled(false)
                    end 
                end

                print("Recived message from: " .. msg.speaker .. ", message: " .. msg.message)
                break    
            end    
        end    
    end 
end 
Proxy.New("proxy")

-- module 200ms or faster if teleported enabled
Module.New("Anti GM", function ()
    
    -- when connected.
    if Self.isConnected() then

        -- load creatures.
        local creatures = Creature.getCreatures()

        init()
        checkIfTeleported()
        checkForVisibleGM(creatures)
        checkForManaIncreased()
        checkForHealthDmg()
        respondForMessage()
        checkForSpecialMonsters(creatures)
        checkForRareItems()
        checkForMonstersCreationAndDisappear(creatures)
        checkForMonstersCreation(creatures)
        resume()

    end 

end)

