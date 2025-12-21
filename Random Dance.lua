--[[
    Script Name:        Random Dance
    Description:        Just auto random dancing all time! Best way is execute this on shortkey then press first = load, press second = unload
    Author:             Ascer - example
]]

-- DON'T EDIT BELOW THIS LINE

local danceTime, danceType, danceTick = 0, 0, 0

function dance(state)
    local dir, nextDir = Self.Direction(), 0
    if state == 0 then
        nextDir = dir + 1
        if nextDir > 3 then dir = 0 end
    elseif state == 1 then
        if dir == 0 then nextDir = 2 end
        if dir == 2 then nextDir = 0 end
    elseif state == 2 then    
        nextDir = 1
        if dir == 1 then nextDir = 3 end
        if dir == 3 then nextDir = 1 end
    elseif state == 3 then    
        for i = 0, 3 do
            if dir ~= i then nextDir = i break end    
        end    
    end
    Self.Turn(nextDir)         
end --> dance in 4 differerent ways. 

Module.New("Random Dance", function(mod)
    if Self.isConnected() then
        if os.clock() - danceTime >= danceTick then
            danceTime = os.clock()
            danceType = math.random(0, 3)
            danceTick = math.random(1, 3)
        end 
        dance(danceType)       
    end    
end)
