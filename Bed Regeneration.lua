--[[
    Script Name:        Bed Regeneration
    Description:        Relogin to game every some time for a couple of seconds for make runes and use bed (sleep)
    Author:             Ascer - example
]]

local BED_SLEEP_TIME = 90.0             -- mintues we are stay offline in bed.
local STAY_LOGGED_SECONDS = 15          -- amount of seconts we stay logged before use bed.
local BED_ID = {2489}                   -- IDs of clickable beds
local BED_POS = {                       -- positions of beds in house. 
    {32343, 32225, 7},
    {32341, 32225, 7}
}                      

-- DONT'T EDIT BELOW THIS LINE

local stayTime, sleepTime = 0, 0

function getBed()
    for _, pos in ipairs(BED_POS) do
        local map = Map.GetTopMoveItem(pos[1], pos[2], pos[3])
        if table.find(BED_ID, map.id) then
            return pos, map.id
        end 
    end
    return -1    
end    

Module.New("Bed Regeneration", function (mod)
    if Self.isConnected() then
        if stayTime == 0 then
            stayTime = os.clock()
            sleepTime = 0
        else
            if os.clock() - stayTime >= STAY_LOGGED_SECONDS then
                local bed, idOfSelectedBed = getBed()
                if bed ~= -1 then  
                    Map.UseItem(bed[1], bed[2], bed[3], idOfSelectedBed, 1, 3000) -- 3s delay between usages.
                    sleepTime = os.clock()
                end    
            end    
        end    
    else
        stayTime = 0
        if os.clock() - sleepTime > (BED_SLEEP_TIME * 60) then
            Rifbot.PressKey(13, 2000)  -- press enter key
        end    
    end    
    mod:Delay(200, 350)
end) 
