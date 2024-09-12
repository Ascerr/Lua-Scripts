--[[
    Script Name:        Mining Ores
    Description:        Search ores id around the map screen and mine then using special pick.
    Author:             Ascer - example
]]

local config = {
    pick = 20495,                   -- id of mining pick
    rock = {34812, 34813, 34831, 34833, 34834, 34835, 34800, 34814, 34815, 34817, 34818, 34819, 34820, 34810, 34809, 34780, 34778, 34776, 34802}, -- id of rocks with ores, cannot be empty rocks
    stopIfTarget = false,           -- don't mine if currently targeting some creature.
    disableWalker = true,           -- true/false disable walker if found ore, later enable it back.
    maxTimeIfCannotReach = 20000,   -- max time in miliseconds to bot ignore ore location if cannot stand near to mine. It will remove ignore ore after 5 mins possible to edit in function removeOreFromIgnored
    delay = 1500,                    -- delay between usage of pick
    just_use_vein = false           -- true/false if we use map position instead use pick with ground.
}

-- DONT'T EDIT BELOW THIS LINE

local ignoredOres = {} -- you can optionally add there perm locations to ignore like this = {{x = 32344, y = 32355, z = 7, time = 9999999999999999}}
local currentOre, oreTime = -1, 0


function oreLocationIsIgnored(x, y, z)
    for _, loc in ipairs(ignoredOres) do
        if loc.x == x and loc.y == y and loc.z == z then return true end
    end
    return false    
end --> check if ore is ignored at location x, y, z    

function removeOreFromIgnored(selfPos)
    for i, loc in ipairs(ignoredOres) do
        if ((selfPos.z == loc.z and math.abs(selfPos.x-loc.x) <= 1 and  math.abs(selfPos.y-loc.y) <= 1) or os.clock() - loc.time >= 300) then
            return table.remove(ignoredOres, i)
        end    
    end    
end --> remove ignored ores after character stands near or 5min

function getOreLocation()
    local pos = Self.Position()
    removeOreFromIgnored(pos)
    for x = -7, 7 do
        for y = -5, 5 do
            if not oreLocationIsIgnored(pos.x+x, pos.y+y, pos.z) then
                local map = Map.GetTopMoveItem(pos.x+x, pos.y+y, pos.z)
                if table.find(config.rock, map.id) then
                    oreTime = os.clock()
                    return {x = pos.x+x, y = pos.y+y, z = pos.z} 
                end
            end 
        end
    end
    return -1        
end --> get ore to mine, return table if true else -1    

function mine()
    if config.stopIfTarget and Self.TargetID() > 0 then 
        oreTime = os.clock()
        return 
    end
    if currentOre == -1 then
        currentOre = getOreLocation()
        if currentOre ~= -1 and config.disableWalker then Walker.Enabled(false) end
    else
        local pos = Self.Position()
        if pos.z ~= currentOre.z then 
            currentOre = -1
            if config.disableWalker then Walker.Enabled(true) end
            return
        end
        local map = Map.GetTopMoveItem(currentOre.x, currentOre.y, currentOre.z)
        if not table.find(config.rock, map.id) then 
            if config.disableWalker then Walker.Enabled(true) end
            currentOre = -1 
            return
        end   
        if Self.DistanceFromPosition(currentOre.x, currentOre.y, currentOre.z) > 1 then
            Self.WalkTo(currentOre.x, currentOre.y, currentOre.z)
            if os.clock() - oreTime >= config.maxTimeIfCannotReach/1000 then 
                print("Ignore mining ore at location: " .. currentOre.x .. ", " .. currentOre.y .. ", " .. currentOre.z .. " due max reach time.")
                table.insert(ignoredOres, {x = currentOre.x, y = currentOre.y, z = currentOre.z, time = os.clock()})
                if config.disableWalker then Walker.Enabled(true) end
                currentOre = -1
                return
            end 
        else
            if config.just_use_vein then
                Map.UseItem(currentOre.x, currentOre.y, currentOre.z, map.id, 1, config.delay)
            else    
                Self.UseItemWithGround(config.pick, currentOre.x, currentOre.y, currentOre.z, config.delay)
            end    
        end    
    end    
end --> general mine function    

Module.New("Mining Ores", function ()
    if Self.isConnected() then
        mine()
    end    
end)
