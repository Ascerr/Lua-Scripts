--[[
    Script Name: 		Players Detected - Ering
    Description: 		Play sound if any monster or player attack you. 
    Author: 			Ascer - example
]]
            
local PLAYERS = 1                           -- amount of players on screen to put ring
local RING = 3051                           -- ID of no-active ring.
local RING_ACTIVE = 3088                    -- id of active ring in eq.
local DEQUIP = true                         -- true/false dequip ring when players leave screen.
local SAFE_LIST = {"Friend1", "Friend2"}    -- add here friends to avoid.

-- DON'T EDIT BELOW THIS LINE

local friends = table.lower(SAFE_LIST)

Module.New("Players Detected - Ering", function ()
    local count = 0
    for i, player in pairs(Creature.iPlayers(7)) do
        if not table.find(friends, player.name) then
            count = count + 1
            if count >= PLAYERS then
                if not Self.isManaShielded() then
                    Self.EquipItem(SLOT_RING, RING, 1)
                    break -- break loop
                end    
            end    
        end
    end
    if DEQUIP then
        if count < PLAYERS then
            if Self.Ring().id == RING_ACTIVE then
                Self.DequipItem(SLOT_RING)
            end    
        end
    end        
end)
