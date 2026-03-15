--[[
    Script Name:        Bed Runemaker
    Description:        Login to character, cast spell, use bed -> repeat for all chars.
    Required:           1. Valid mouse x, y of first character index on select window and nextIndex difference in pixels. On servers with huge icons inside select character window this script won't works. 
                        2. You can't have any Settings saved to character name logged becuase bot will autoload it on login. Just login first character -> run this lua script + set what you want else in bot, don't save.
                        3. Re-name Startup Settings.txt from Rifbot Project Folder\Settings to different name.
    Author:             Ascer - example
]]

local start = {
    x = 368,                -- position x first character select window index to read proper x, y use lua: Module.New("read mouse", function() local mouse = Rifbot.GetMousePos() print(mouse.x, mouse.y) end)
    y = 198,                -- position y first character select window index
    nextIndex = 14,         -- difference in pixels between first and any other index
    maxIndex = 5            -- max characters indexs to process until switch again to index 0
}

local BED_ID = {2489}                   -- IDs of clickable beds
local BED_POS = {                       -- positions of beds in house. 
    {32343, 32225, 7},
    {32341, 32225, 7}
}                      

local spell = "exura"                                   -- spell to cast

local sleepTime = 90.0                                  -- how many minutes we will sleep when all char beeing logged.

-- DON'T EDIT BELOW THIS LINE

local index = 0
local logout = true
local click = false
local sleept = 0

function getBed()
    for _, pos in ipairs(BED_POS) do
        local map = Map.GetTopMoveItem(pos[1], pos[2], pos[3])
        if table.find(BED_ID, map.id) then
            return pos, map.id
        end 
    end
    return -1    
end    


Module.New("Bed Runemaker", function()
    if Self.isConnected() then
        wait(1000)
        Self.Say(spell)
        wait(500)
        local bed, idOfSelectedBed = getBed()
        if bed ~= -1 then  
            Map.UseItem(bed[1], bed[2], bed[3], idOfSelectedBed, 1, 3000) -- 3s delay between usages.
            sleepTime = os.clock()
        end    
        logout = true
        if index == (start.maxIndex - 1) then
            sleept = os.clock()
        end 
    else
        if sleept <= 0 or (os.clock() - sleept) >= (sleepTime * 60) then
            if logout then 
                index = index + 1
                if index >= start.maxIndex then 
                    index = 0 
                end
                logout = false
                click = true
            end
            wait(1000)
            if click then
                Rifbot.MouseClick(start.x, start.y + (index * start.nextIndex)+20, 0) -- left mouse click for next character index (+20 on osy due game window bar)
                click = false
            end
            wait(1000)  
            Rifbot.PressKey(13, 2000)  -- press enter key
        end 
    end 
end)
