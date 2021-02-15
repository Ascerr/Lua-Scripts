--[[
    Script Name:        Make SDs on fluids house near shop
    Description:        Script will talk with npcs, buy blanks na mfs, make sds from from panel.

    Required:           1. Open main backpack e.g. yellow
                        2. Inside main backpack you need to have backpack for mana fluids example purple and cash for balnks and mfs. Open this bp as second
                        3. Bot will buy full backpack of blank runes and you need to set id of this backpack below near SD_BACKPACK_ID

    Author:             Ascer - example
]]

local SD_BACKPACK_ID = 2870 -- id of backpack with sds.
local MF_BACKPACK_ID = 2868 -- id of backpack with mana fluids
local DROP_FINISHED_BP_POS = {x = 32311, y = 31139, z = 7} -- place where we drop full bps of sds.
local DROP_EMPTY_BP_MF_POS = {x = 32311, y = 31140, z = 7} -- place where we drop empty bp after using mana fluids.
local SD_ID = 3155      -- id of sd rune


-- DON'T EDIT BELOW THIS LINE
local sayTime = 0


function delayedSay(text)
    if os.clock() - sayTime > 2.5 then
        Self.Say(text)
        sayTime = os.clock()
    end        
end 


----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       backpackIsOpen(id)
--> Description:    Check if backpack is opened by id.
--> Params:         
-->                 @id - number id of backpack.
--> Return:         boolean true or false.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function backpackIsOpen(id)
    for i = 0, 15 do
        local cont = Container.getInfo(i)
        if table.count(cont) > 1 then
            if cont.id == id then
                return true
            end    
        end    
    end
    return false    
end 


-- run module (loop)
Module.New("Make SDs on fluids house near shop", function()

    -- check for connection.
    if Self.isConnected() then

        -- check for amount backpack with sd.
        if Self.ItemCount(SD_BACKPACK_ID) <= 0 then

            -- buy one backpack with balnk runes.
            delayedSay("instant bp blank runes")

        else
            
            -- check if is opened backpack with blank runes.
            if not backpackIsOpen(SD_BACKPACK_ID) then

                -- find backpack with blanks.
                local cont = Container.FindItem(SD_BACKPACK_ID)

                -- open backpack with blanks to make sds.
                Container.UseItem(cont.index, cont.slot, SD_BACKPACK_ID, true, 1000)

            else    

                -- check for backpacks with mana
                if Self.ItemCount(MF_BACKPACK_ID) <= 0 then

                    -- buy mana fluids.
                    delayedSay("instant bp mana fluids")

                else 

                    -- check 
                    if not backpackIsOpen(MF_BACKPACK_ID) then

                        -- find backpack with mf.
                        local cont = Container.FindItem(MF_BACKPACK_ID)

                        -- open backpack with mmf.
                        Container.UseItem(cont.index, cont.slot, MF_BACKPACK_ID, true, 1000)

                    else    

                        -- when no more mfs.
                        if Self.ItemCount(MANA_FLUID.id) <= 0 then

                            -- drop empty bp to spot
                            Self.DropItem(DROP_EMPTY_BP_MF_POS.x, DROP_EMPTY_BP_MF_POS.y, DROP_EMPTY_BP_MF_POS.z, MF_BACKPACK_ID, 1, math.random(1000, 1500))

                        else

                            -- check for amount sds.
                            if Self.ItemCount(SD_ID) >= 20 then

                                -- drop backpack to ground pos.
                                Self.DropItem(DROP_FINISHED_BP_POS.x, DROP_FINISHED_BP_POS.y, DROP_FINISHED_BP_POS.z, SD_BACKPACK_ID, 1, math.random(1000, 1500))

                            end

                        end

                    end    
                  
                end    

            end    

        end        

    end
        
end)
