--[[
    Script Name:        Pickup Spears (old map)
    Description:        Pickup spears based on classic tibia old map both with rifbot old version
    Author:             Ascer - example
]]


local SPEARS = {3277}     			-- Spears ids to pickup
local DELAY = {500, 1000}			-- delay for pickup object
local PICKUP_AFTER_KILL = false		-- pick only when last attacked monster died or when no more spear in EQ.
local RANGE = 1						-- search sqms around

-- DON'T EDIT BELOW

local lastT = 0

function rememberTarget()
	local t = Self.TargetID()
	if t > 0 and lastT == 0 then
		lastT = t
	end	
end	--> Store last target id

function targetDied()
	if lastT > 0 then
		local c = Creature.getCreatures(lastT)
		if table.count(c) > 0 then return false end
		return true 
	end	
end	--> check if last target died (exisits or not)


Module.New("Pickup Spears (old map)", function (mod)
	if Self.isConnected() then
		rememberTarget() -- remember last target
		local var = (not PICKUP_AFTER_KILL) or (PICKUP_AFTER_KILL and (targetDied() or (not table.find(SPEARS, Self.Weapon().id) and not table.find(SPEARS, Self.Shield().id)) ))
		if var then
			local map = Map.getArea(RANGE) -- load map with 1 sqm range
			for i, square in pairs(map) do
				local sqareItems = square.items
				for j, item in pairs(sqareItems) do
					if table.find(SPEARS, item.id) then
						Self.EquipItemFromGround(SLOT_WEAPON, square.x, square.y, square.z, item.id, item.count, 0)
						break
					end
				end			
			end
			lastT = Self.TargetID()
		end	
	end
	mod:Delay(DELAY[1], DELAY[2])		
end) 

