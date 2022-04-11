--[[
    Script Name: 		Player attack equip e ring
    Description: 		When player attack you equip energy ring.
    Author: 			Ascer - example
]]

local config = {
	ering = {on = 3088, off = 3051},		-- ering id on off
	dequip_after = 60						-- dequip ring when player stop attack after x seconds.	
}

-- DONT EDIT BELOW THIS LINE.

local attackTime = 0


-- module to run function
Module.New("Player attack equip e ring", function ()

	-- when we are connected
	if Self.isConnected() then
        
	    -- in loop for creatures.
	    for i, player in ipairs(Creature.iPlayers(7, false)) do

	    	-- when player attack.
	    	if player.attack > 0 then -- to check for skull also use player.skull >= 3

	    		-- load ring id
	    		local ring = Self.Ring()

	    		-- when ring id is different than equiped e ring.
	    		if ring.id ~= config.ering.on then

	    			-- equip ring.
	    			Self.EquipItem(SLOT_RING, config.ering.off, 1, 0)

	    		end	

	    		-- show message
	    		print(player.name .. " attacked you!")

	    		-- update time
	    		attackTime = os.clock()

	    		-- destroy lop
	    		break

	    	end	
	    	
	    end

	    if attackTime > 0 and os.clock() - attackTime > config.dequip_after then

	    	-- load ring id
	    	local ring = Self.Ring()

    		-- when ring id is this same as equiped e ring.
    		if ring.id == config.ering.on then

    			-- equip ring.
    			Self.DequipItem(SLOT_RING)

    			-- reset params
    			attackTime = 0

    		end	

	    end	

	end

end)
