--[[
    Script Name:        Tibiascape fishing
    Description:        Specific fishing, you need throw out your float, watching if it go under water then strike your firshing rod.
    Author:             Ascer - example
]]

local FISHING_ROD_ID = 3483                     -- fishing rod ID.
        
local FISHING_DELAY = {2000, 8000}              -- delay for strike it's random between 2,8s

local FISHING_POS = {                           -- where to fish, spots: x, y, z grab it from look on map and rifbot information box
    {x = 32373, y = 32178, z = 7},
    {x = 32372, y = 32178, z = 7},
    {x = 32374, y = 32178, z = 7},
}


-- DON'T EDIT BELOW THIS LINA

local selectedSpot, fishingStatus, fishingTime, fishingDelay = -1, 0, 0, 0

Module.New("Tibiascape fishing", function()
    if Self.isConnected() then
        if selectedSpot == -1 then
            selectedSpot = FISHING_POS[math.random(1, #FISHING_POS)]
        else    
            if fishingStatus == 0 then
                Self.UseItemWithGround(FISHING_ROD_ID, selectedSpot.x, selectedSpot.y, selectedSpot.z, 0)
                fishingStatus = 1
                fishingTime = os.clock()
                fishingDelay = math.random(FISHING_DELAY[1], FISHING_DELAY[2])
            elseif fishingStatus == 1 then
                if os.clock() - fishingTime >= fishingDelay/1000 then
                    Self.UseItemWithGround(FISHING_ROD_ID, selectedSpot.x, selectedSpot.y, selectedSpot.z, 0)
                    wait(1000)
                    fishingStatus = 0
                    selectedSpot = -1
                end    
            end     
        end
    end    
end)
