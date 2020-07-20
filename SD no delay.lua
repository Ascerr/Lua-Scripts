--[[
    Script Name:        SD no delay
    Description:        Execute lua script and shoot sd with target without delay.
    Required:			Set inside shortkeys command: EXECUTE sd no delay
    Author:             Ascer - example
]]

local RUNE_ID = 2268	-- set rune id here // 3155 new sd id

-- DON'T edit below.

-- load target id.
local t = Self.TargetID()

-- when target is above 0.
if t > 0 then

	-- load creatures
	local c = Creature.iCreatures(7, false)

	-- in loop for all players
    for i = 1, #c do
        
        -- load single player
        local creature = c[i]

        -- check for id.
        if creature.id == t then

        	-- shoot sd.
        	Self.UseItemWithCreature(creature, RUNE_ID, 0)

        end	

    end    

end