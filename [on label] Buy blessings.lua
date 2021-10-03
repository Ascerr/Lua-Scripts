--[[
    Script Name:        [on label] Buy blessings 
    Description:        It's lua side where you will do actions on label near npc, sail/buy bless.
    Author:             Ascer - example
]]


-- some params for later operations.
local alreadyBoughtBless = false
local speakTime = os.clock()

--> catch signals from labels
function signal(label)

    -- sail actions
    if label == "sail thais->carlin" then
        sail("thais", "carlin")
    elseif label == "sail carlin->thais" then
        sail("carlin", "thais")    
    elseif label == "sail kazordoon->cormaya" then
        sail("kazordoon", "cormaya")
    elseif label == "sail cormaya->eremo" then
        sail("cormaya2", "eremo")  
    elseif label == "sail eremo->cormaya" then
        sail("eremo", "cormaya2")       

    -- blessing actions    
    elseif label == "norf" then
        buyBless("norf")
    elseif label == "humphrey" then
        buyBless("humphrey") 
    elseif label == "edala" then
        buyBless("edala")   
    elseif label == "kawill" then
        buyBless("kawill")
    elseif label == "pydar" then
        buyBless("pydar")
    elseif label == "eremo" then
        buyBless("eremo")        
    end    

end
Walker.onLabel("signal")


--> catch messages on channels
function proxy(messages) 
    for i, msg in ipairs(messages) do 
        msg.speaker = string.lower(msg.speaker)
        if table.find({"norf", "humphrey", "edala", "kawill", "pydar", "eremo"}, msg.speaker) then
            if msg.message == "You have already this blessing." or string.find(msg.message, "So receive the") or string.find(msg.message, "Kneel down") then
                alreadyBoughtBless = true
            end    
        end    
    end 
end 
Proxy.New("proxy")


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       followCreature(name)
--> Description:    Walk near creature.
--> Params:         
-->                 @name - string creature name.
--> Return:         boolean true or false if we near creature.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function followCreature(name)
    local c = Creature.getCreatures(name)
    if table.count(c) < 2 then return false end
    if Creature.DistanceFromSelf(c) <= 1 then return true end
    Creature.Reach(c, "follow")
    return false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       delayedSay(message, delay)
--> Description:    Say message with delay.
--> Params:         
-->                 @message - string message to say.
-->                 delay - int time in miliseconds 
--> Return:         boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function delayedSay(message, delay)
    if delay == nil then delay = 2000 end
    if os.clock() - speakTime > (delay/1000) then
        Self.Say(message)
        speakTime = os.clock()
        return true
    end
    return false 
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       buyBless(npcName)
--> Description:    Action to buy bess from npc.
--> Params:         
-->                 @npcName - string name of npc. 
--> Return:         boolean true or void.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function buyBless(npcName)
    while true do
        wait(200) -- always use wait to prevents program hang.
        if followCreature(npcName) then
            local dialog = getBlessMessage(npcName)
            for i = 1, #dialog do
                delayedSay(dialog[i], 0)
                wait(2000)  
            end    
            if alreadyBoughtBless then 
                alreadyBoughtBless = false
                return true
            end    
        end
    end        
end 

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       sail(fromTown, toTown)
--> Description:    Action sail between towns.
--> Params:         
-->                 @fromTown - string name of town from we sail
-->                 @toTown - string name of town where we sail
--> Return:         void nothing.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function sail(fromTown, toTown)
    local setSails = {
        thais = {npc = "Captain Bluebear", x = 32311, y = 32210, z = 6},
        carlin = {npc = "Captain Greyhound", x = 32387, y = 31820, z = 6},
        kazordoon = {npc = "Brodrosch", x = 32660, y = 31957, z = 15},
        cormaya = {npc = "Gurbasch", x = 33311, y = 31989, z = 15}, -- dwarf ship
        cormaya2 = {npc = "Pemaret", x = 33287, y = 31956, z = 6}, -- standard ship
        eremo = {npc = "Eremo", x = 33314, y = 31883, z = 7}
    } 
    fromTown = string.lower(fromTown)
    toTown = string.lower(toTown)
    while true do
        wait(200)
        if Self.DistanceFromPosition(setSails[toTown].x, setSails[toTown].y, setSails[toTown].z) <= 20 then break end
        
        if followCreature(setSails[fromTown].npc) then
            local say = toTown 
            if string.find(say, "cormaya") then 
                say = "cormaya" 
            end
            if fromTown == "eremo" then
                local dialog = {"hi", "back", "yes"}
                for i = 1, #dialog do
                    delayedSay(dialog[i], 0)
                    wait(500)
                end
            else
                delayedSay("bring me to " .. say)
            end    
        end
    end    
end   

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getBlessMessage(npc)
--> Description:    Get speak table we need to talk with bless npc
--> Params:         
-->                 @npc - string name of npc
--> Return:         table.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getBlessMessage(npc)
    npc = string.lower(npc)
    if npc == "norf" then
        return {"instant The Spiritual Shielding"}
    elseif npc == "humphrey" then
        return {"instant The Embrace of Tibia"}
    elseif npc == "edala" then
        return {"instant The Fire of the Suns"}
    elseif npc == "kawill" or npc == "pydar" then
        return {"hi", "The Spark of the Phoenix", "yes"}
    elseif npc == "eremo" then
        return {"hi", "The Wisdom of Solitude", "yes"}           
    end   
end    