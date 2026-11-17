--[[
    Script Name:        Look on players
    Description:        Look on new players enter screen, if player moving fast then it won't works good.
    Author:             Ascer - example
]]

local LOOK_DELAY_SECONDS = 1            -- look every 1s


-- DON'T EDIT BELOW THIS LINE

local players = {}
local looktime, lookname = 0, ""

Module.New("Look players", function ()
    if Self.isConnected() then
        for _, c in ipairs(Creature.iPlayers(7, false)) do
            if not table.find(players, c.name) then
                if os.clock() - looktime >= LOOK_DELAY_SECONDS then
                    Self.LookItem("map", c.x, c.y, c.z, c.id)
                    lookname = c.name
                    looktime = os.clock()
                end    
            end    
        end    
    end
end)


function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        if lookname ~= "" and string.find(msg.message, lookname) then
            table.insert(players, lookname)
            lookname = ""
            print(msg.message)
        end
    end 
end 
Proxy.TextNew("proxyText")