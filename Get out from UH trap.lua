--[[
    Script Name:        Get out from UH trap
    Description:        When you are in uh trap (creature on you) then this script will try get out.
    Author:             Ascer - example
]]

local config = {
    change_floor_use_id = {1948, 435},                      -- ids like ladders, sewer grate  
    change_floor_walk_id = {414, 434, 1947},                -- ids like stairs, trapdoor, holes
    allow_pass_ids = {123, 2118, 2119, 2123, 2125, 2124},   -- ids like fire, parcel etc to walk through.
    play_sound = true                                       -- play sound when you will in uh trap
}


-- DON'T EDIT BELOW THIS LINE
local mapDeep, mapTop

function isTrapped(self, creatures)
    for _, c in ipairs(creatures) do
        if self.x == c.x and self.y == c.y and self.z == c.z then
            return c
        end    
    end    
end --> returns creature trapped us or nil if not.    

function getTopMapFromDatabase(x, y, z)
    for i, sqm in ipairs(mapTop) do
        if sqm.x == x and sqm.y == y and sqm.z == z then
            return {id = sqm.id, count = sqm.count}
        end    
    end
    return 0 
end --> get top map id from database

function getCreatureFromPos(x, y, z, creatures)
    for _, c in ipairs(creatures) do
        if x == c.x and y == c.y and z == c.z then
            return c
        end    
    end  
end --> get creature by position   

function tileIsWalkable(x, y, z, pathable)
    local path = 0
    if pathable == nil then pathable = true end
    local items = Map.GetItems(x, y, z)
    for i, item in ipairs(items) do
        if item.id == 99 then return false end
        if Item.hasAttribute(item.id, ITEM_FLAG_NOT_WALKABLE) then return false end
        if Item.hasAttribute(item.id, ITEM_FLAG_NOT_PATHABLE) then
            if pathable and table.find(config.allow_pass_ids, item.id) then
                path = path + 1
                if path >= 2 then return false end
            else
                return false    
            end 
        end         
    end
    return true
end --> check if tile is walkable

function changeFloor(self)
    for i, sqm in ipairs(mapTop) do
        if table.find(config.change_floor_walk_id, sqm.id) then
            return Self.WalkTo(sqm.x, sqm.y, sqm.z)    
        end    
    end
    for i, sqm in ipairs(mapDeep) do
        for j, item in ipairs(sqm.items) do
            if table.find(config.change_floor_use_id, item.id) then
                local top = getTopMapFromDatabase(sqm.x, sqm.y, sqm.z)
                if Item.hasAttribute(top.id, ITEM_FLAG_NOT_MOVEABLE) or top.id == 99 then
                    return Map.UseItem(sqm.x, sqm.y, sqm.z, top.id, 0, math.random(500, 800))
                elseif not Item.hasAttribute(top.id, ITEM_FLAG_NOT_MOVEABLE) and not Item.hasAttribute(top.id, ITEM_FLAG_NOT_WALKABLE) then
                    if sqm.x == self.x and sqm.y == self.y and sqm.z == self.z then
                        return Map.MoveItem(sqm.x, sqm.y, sqm.z, self.x + math.random(-1, 1), self.y + math.random(-1, 1), self.z, top.id, top.count, 200)
                    else    
                        return Map.MoveItem(sqm.x, sqm.y, sqm.z, self.x, self.y, self.z, top.id, top.count, 200)
                    end     
                end      
            end    
        end   
    end    
end --> check for possible stairs or ladder to change floor.    

function takeFreeSpot(self)
    for x = -1, 1 do
        for y = -1, 1 do
            if x == 0 and y == 0 then
                -- our pos avoid.
            else
                if tileIsWalkable(self.x + x, self.y + y, self.z) then
                   return Self.Step(Self.getDirectionFromPosition(self.x + x, self.y + y, self.z))  
                end    
            end 
        end
    end        
end --> find free spot to step.    

function cleanPath(self, creatures)
    local walkable, delay, mob = false, 0, 0
    for i, top in ipairs(mapTop) do
        if top.x == self.x and top.y == self.y and top.z == self.z then
            -- our pos avoid.
        else    
            if not Item.hasAttribute(top.id, ITEM_FLAG_NOT_MOVEABLE) and not Item.hasAttribute(top.id, ITEM_FLAG_NOT_WALKABLE) and top.id ~= 99 then
                return Map.MoveItem(top.x, top.y, top.z, self.x, self.y, self.z, top.id, top.count, delay)       
            elseif top.id == 99 or (not Item.hasAttribute(top.id, ITEM_FLAG_NOT_MOVEABLE) and Item.hasAttribute(top.id, ITEM_FLAG_NOT_WALKABLE)) then
                for x = -1, 1 do
                    for y = -1, 1 do
                        if top.id == 99 then    
                            walkable = tileIsWalkable(top.x + x, top.y + y, top.z, false)
                            mob = getCreatureFromPos(top.x, top.y, top.z, creatures)
                            if table.count(mob) > 1 then
                                if Creature.isMonster(mob) then
                                    if Self.TargetID() ~= mob.id then
                                        Creature.Attack(mob.id) -- attack monsters only.
                                    end
                                    walkable = false
                                end        
                            end
                            delay = 1000
                        else       
                            walkable = tileIsWalkable(top.x + x, top.y + y, top.z)
                            delay = 200 
                        end
                        if walkable then
                            return Map.MoveItem(top.x, top.y, top.z, top.x + x, top.y + y, top.z, top.id, top.count, delay)
                        end    
                    end
                end
            end    
        end    
    end    
end --> move items blocking path.    

function updateMap(self)
    local area = {}
    local top = {}
    local object = 0
    for x = -1, 1 do
        for y = -1, 1 do
            table.insert(area, {x = self.x + x, y = self.y + y, z = self.z, items = Map.GetItems(self.x + x, self.y + y, self.z)})
            object = Map.GetTopMoveItem(self.x + x, self.y + y, self.z)
            table.insert(top, {x = self.x + x, y = self.y + y, z = self.z, id = object.id, count = object.count}) 
        end
    end
    mapDeep = area
    mapTop = top        
end --> read items around your character for later calculation.   


Module.New("Get out from UH trap", function()
    if Self.isConnected() then
        local creatures = Creature.iCreatures(2, false)
        local self = Self.Position()
        local trapped = isTrapped(self, creatures)
        if table.count(trapped) > 1 then
            updateMap(self)
            takeFreeSpot(self)
            cleanPath(self, creatures)
            changeFloor(self)
            
            if config.play_sound then
                Rifbot.PlaySound()
            end    
            print("[UH Trap] Creature: " .. trapped.name .. " on us!")
        end    
    end    
end)
