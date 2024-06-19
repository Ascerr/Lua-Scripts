--[[
    Script Name: 		Turn on off torch if player
    Description: 		When player detected (even 1-2 sqm off the screen) character will turn on torch else off.
    Author: 			Ascer - example
]]
            
local config = {
    torchEnabledIDs = {2921, 2923, 2925},       -- all stages of enabled torch
    torchDisabledIDs = {2920, 2922, 2924},      -- all stages of disabled torch, [1] item is also used as brand new not used torch. Don't put last stage (2926) full used torch!
    ignoreOnFloorLevel = 7,                     -- don't turn on torch on specific ground pos.z level (7 is default thais depot 0)                      
    safeList = {"Friend1", "Friend2"}           -- add here friends to avoid.
}

-- DON'T EDIT BELOW THIS LINE

local friends = table.lower(config.safeList)

function getPlayers()
    for i, player in pairs(Creature.iPlayers(9)) do
        if not table.find(friends, player.name) then
           return true
        end
    end
    return false
end --> return boolean true/false if player not from friends list on screen.   

Module.New("Turn on off torch if player", function ()
    if Self.isConnected() then
        local torch = Self.Ammo().id
        if getPlayers() and Self.Position().z ~= config.ignoreOnFloorLevel then
            if not table.find(config.torchEnabledIDs, torch) and not table.find(config.torchDisabledIDs, torch) then 
                Self.EquipItem(SLOT_AMMO, config.torchDisabledIDs[1], 1)
            else    
                if not table.find(config.torchEnabledIDs, torch) then
                    Self.UseItemFromEquipment(SLOT_AMMO)
                end    
            end
        else      
            if table.find(config.torchEnabledIDs, torch) then
                Self.UseItemFromEquipment(SLOT_AMMO)
            end   
        end
    end        
end)