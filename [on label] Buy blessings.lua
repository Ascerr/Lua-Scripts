--[[
    Script Name:        [on label] Buy blessings 
    Description:        It's lua side where you will do actions on label near npc, sail/buy bless.
    Author:             Ascer / Escalibur - example
]]


-- some params for later operations.
local speakTime = os.clock()

-- here main config table
local CONFIG = {
    actions = {"sail", "buyBless"},     -- walker label names for sail and buy bless                   
    actions_CONFIG = {
        buyBless = {
            blesssers = {"norf", "humphrey", "edala", "kawill", "pydar", "eremo"},  -- bless npc names
            alreadyBoughtBless = false                                              -- don't edit
        },
        sail = {
            cities = {"thais", "carlin", "kazordoon", "cormaya", "eremo", "edron", "ankrahmun", "darashia", "kastah", "folda", "tibia"},    -- sail cities
            setSails = {
                thais = {npc = "Captain Bluebear", x = 32311, y = 32210, z = 6},    
                carlin = {npc = "Captain Greyhound", x = 32387, y = 31820, z = 6},
                kazordoon = {npc = "Brodrosch", x = 32660, y = 31957, z = 15},
                cormaya = {npc = "Gurbasch", x = 33311, y = 31989, z = 15}, -- dwarf ship
                cormaya2 = {npc = "Pemaret", x = 33287, y = 31956, z = 6}, -- standard ship
                eremo = {npc = "Eremo", x = 33314, y = 31883, z = 7},
                edron = {npc = "Captain Seahorse", x = 33178, y = 31766, z = 7},
                ankrahmun = {npc = "Captain Sinbeard", x = 33091, y = 32885, z = 7},
                darashia = {npc = "Petros", x = 33290, y = 32479, z = 7},
                folda = {npc = "Svenson", x = 32046, y = 31580, z = 7},
                tibia = {npc = "Nielson", x = 32234, y = 31674, z = 7}
            }
        }
    }
}

--> catch signals from labels
function signal(label)
    action = stringSplit(label, ";")

    if(contains(CONFIG["actions"], action[1])) then
        if action[1] == "sail" then
            sail(action[2])
        elseif action[1] == "blessing" then
            buyBless(action[2])
        end
    end 
end

Walker.onLabel("signal")


--> catch messages on channels
function proxy(messages) 
    for i, msg in ipairs(messages) do 
        msg.speaker = string.lower(msg.speaker)
        if table.find({"norf", "humphrey", "edala", "kawill", "pydar", "eremo"}, msg.speaker) then
            if msg.message == "You have already this blessing." or string.find(msg.message, "So receive the") or string.find(msg.message, "Kneel down") then
                CONFIG["actions_CONFIG"]["buyBless"]["alreadyBoughtBless"] = true
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
    if(contains(CONFIG["actions_CONFIG"]["buyBless"]["blesssers"], npcName)) then
        while true do
            wait(200) -- always use wait to prevents program hang.
            if followCreature(npcName) then
                local dialog = getBlessMessage(npcName)
                for i = 1, #dialog do
                    delayedSay(dialog[i], 0)
                    wait(2000)  
                end    
                if CONFIG["actions_CONFIG"]["buyBless"]["alreadyBoughtBless"] then 
                    CONFIG["actions_CONFIG"]["buyBless"]["alreadyBoughtBless"] = false
                    return true
                end    
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
function sail(route)

    cities = stringSplit(route, "->")
    fromTown = cities[1]
    toTown = cities[2]

    fromTown = string.lower(fromTown)
    toTown = string.lower(toTown)

    if(contains(CONFIG["actions_CONFIG"]["sail"]["cities"], fromTown) and contains(CONFIG["actions_CONFIG"]["sail"]["cities"], toTown)) then
        while true do
            wait(200)
            if Self.DistanceFromPosition(CONFIG["actions_CONFIG"]["sail"]["setSails"][toTown].x, CONFIG["actions_CONFIG"]["sail"]["setSails"][toTown].y, CONFIG["actions_CONFIG"]["sail"]["setSails"][toTown].z) <= 20 then break end
            
            if followCreature(CONFIG["actions_CONFIG"]["sail"]["setSails"][fromTown].npc) then
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

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+
--+                             888  d8b 888             .d8888b.                            888 d8b 888
--+                             888  Y8P 888            d88P  Y88b                           888 Y8P 888
--+                             888      888            888                                  888      888 
--+                             888  888 88888b.        88888b.    .d8888b  .d888b.   8888b. 888 888 88888b.  888  888 888d888
--+                             888  888 888 "88b       88888P"    88K      d88"        "88b 888 888 888 "88b 888  888 888P"
--+                             888  888 888  888       888        "Y8888b. 888     .d888888 888 888 888  888 888  888 888
--+                             888  888 888 d88P d8b   Y88b  d88P      X88 Y88.    888  888 888 888 888 d88P Y88..88P 888
--+                             888  888 88888P"  Y8P    "Y8888P"  88888P'  "Y888P" "Y888888 888 888 88888P"   "Y88P"  888
--+
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       stringSplit(inputstr, sep)
--> Description:    return an array based into an string and a separator
--> Params:         
-->                 @inputstr - string to split
-->                 @sep - optional is null then default will be blank space
--> Return:         table. / array
----------------------------------------------------------------------------------------------------------------------------------------------------------
function stringSplit (inputstr, sep)
   if sep == nil then
      sep = "%s"
   end
   local t={}
   for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
   end
   return t
end
----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       contains(table, val)
--> Description:    return a boolean(true) if value exists in array, otherwise (false)
--> Params:         
-->                 @table - array of values
-->                 @val - actual value to check
--> Return:         bool 
----------------------------------------------------------------------------------------------------------------------------------------------------------
function contains(table, val)
    for i=1,#table do
       if table[i] == val then 
          return true
       end
    end
    return false
 end
