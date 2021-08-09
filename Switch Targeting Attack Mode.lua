--[[
    Script Name:        Switch Targeting Attack Mode
    Description:        Change mode attack from follow to any kind you set depent on monster attacking.
    Author:             Ascer - example
]]

local config = {
	mode = "3sqm",					-- mode we change if attacked monsers below
	monsters = {"dwarf", "rat"}		-- monsters list
}

-- DONT EDIT BELOW

config.monsters = table.lower(config.monsters)

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getAttackedMonster()
--> Description: 	Check for monsters names attacked to set different attack mode.s
--> Params:			
--> Return: 		true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getAttackedMonster()
	local target = Self.TargetID()
	if target <= 0 then return end
	target = Creature.getCreatures(target)
	if table.count(target) < 2 then return end
	if table.find(config.monsters, string.lower(target.name)) then
		return true
	end
	return false	
end


-- module to execute script
Module.New("Switch Targeting Attack Mode", function()

	-- when connected.
	if Self.isConnected() then

		-- get attacked monster
		if getAttackedMonster() then

			-- set attack mode
			Targeting.setAttackMode(config.mode)

		else
			
			-- set attack follow
			Targeting.setAttackMode("follow")

		end		

	end	

end)
