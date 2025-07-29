--[[
    Script Name:        Bed Runemaker
    Description:        Login to character, cast spell, use bed -> repeat for all chars.
    Required:           1. Valid mouse x, y of first character index on select window and nextIndex difference in pixels. On servers with huge icons inside select character window this script won't works. 
                        2. You can't have any Settings saved to character name logged becuase bot will autoload it on login. Just login first character -> run this lua script + set what you want else in bot, don't save.
                        3. Remove Startup Settings.txt from Rifbot Project Folder\Settings
    Author:             Ascer - example
]]

local start = {
    x = 368,                -- position x first character select window index to read proper x, y use lua: Module.New("read mouse", function() local mouse = Rifbot.GetMousePos() print(mouse.x, mouse.y) end)
    y = 198,                -- position y first character select window index
    nextIndex = 14,         -- difference in pixels between first and any other index
    maxIndex = 5            -- max characters indexs to process until switch again to index 0
}

local bed = {x = 33333, y = 44444, z = 7, id = 1234}    -- x, y, z and id of house bed.

local spell = "exura"                                   -- spell to cast

local sleepTime = 90.0                                  -- how many minutes we will sleep when all char beeing logged.

-- DON'T EDIT BELOW THIS LINE

local index = 0
local logout = true
local click = false
local sleept = 0

Module.New("Bed Runemaker", function()
    if Self.isConnected() then
        wait(1000)
        Self.Say(spell)
        wait(500)
        Map.UseItem(bed.x, bed.y, bed.z, bed.id, 1, 0)
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
