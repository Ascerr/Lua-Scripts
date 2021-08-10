--[[
    Script Name:        Keep 2sqm from Defencer monster
    Description:        Change mode attack from follow to any kind you set depent on monster attacking.
    Author:             Ascer - example
]]

local config = {
	normalMode = "follow",				-- standard used mode in targeting
	changeMode = "2sqm",				-- mode we change if attacked monsers below
	monsters = {"defencer", "cyclops"}	-- monsters list
}

-- DONT EDIT BELOW

config.monsters = table.lower(config.monsters)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getAttackedMonster()
--> Description: 	Check for monsters names attacked to set different attack mode
--> Params:			
--> Return: 		true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedMonster()
	local target = Self.TargetID()
	if target <= 0 then return -1 end
	target = Creature.getCreatures(target)
	if table.count(target) < 2 then return - 1 end
	if table.find(config.monsters, string.lower(target.name)) then
		return target
	end
	return -1	
end


-- module to execute script
Module.New("Keep 2sqm from Defencer monster", function()

	-- when connected.
	if Self.isConnected() then

		-- load attacked monster
		local attacked = getAttackedMonster()

		-- get attacked monster
		if attacked ~= -1 then

			-- set attack mode to none
			Targeting.setAttackMode("none")

			-- reach creature
			Creature.Reach(attacked, config.changeMode)

		else
			
			-- set attack normal
			Targeting.setAttackMode(config.normalMode)

		end		

	end	

end)
