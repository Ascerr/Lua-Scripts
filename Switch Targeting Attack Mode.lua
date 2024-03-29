--[[
    Script Name:        Switch Targeting Attack Mode
    Description:        Change mode attack from follow to any kind you set depent on monster attacking.
    Author:             Ascer - example
]]

local config = {
	mode = {from = "follow", to = "3sqm"},		-- mode we change if attacked monsers below [from] - standard mode we use, [to] - mode to change if current monster is our target.
	monsters = {"dwarf", "rat", "warlock"},		-- monsters list
	amount = 2,									-- amount of monsters around you in range.
	range = 7,									-- range we checking for creatures 7 = full screen.
	hpperc = {min = 0, max = 100}				-- monsters hpperc, in this range between min and max we will change attack mode [min] - minimal hpperc, [max] - maximum hpperc
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
	if target <= 0 then return end
	target = Creature.getCreatures(target)
	if table.count(target) < 2 then return end
	if table.find(config.monsters, string.lower(target.name)) and (target.hpperc >= config.hpperc.min and target.hpperc <= config.hpperc.max) then
		return true
	end
	return false	
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		getTotalMonsters()
--> Description: 	Check for monsters names and count them all inside specific range on screen
--> Params:			
--> Return: 		number amount of monsters.
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getTotalMonsters()
	local count = 0
	for _, mob in ipairs(Creature.iMonsters(config.range)) do
		if table.find(config.monsters, string.lower(mob.name)) then
			count = count + 1
		end	
	end
	return count	
end


-- module to execute script
Module.New("Switch Targeting Attack Mode", function()

	-- when connected.
	if Self.isConnected() then

		-- get attacked monster
		if getAttackedMonster() and getTotalMonsters() >= config.amount then

			-- set attack mode
			Targeting.setAttackMode(config.mode.to)

		else
			
			-- set attack follow
			Targeting.setAttackMode(config.mode.from)

		end		

	end	

end)
