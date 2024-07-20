--[[
    Script Name: 		Pickup Bp Blanks Drop Bp Runes
    Description: 		Script will pickup bp blank runes from house door to main backpack, open it, create 20 runes and drop to x, y, z sqm.
    Author: 			Ascer - example
]]


local config = {
	blank_backpack_id = 2870, 						-- id of backpack with blank runes
	blank_rune_id = 3147, 							-- blank rune id
	blank_pos = {x = 32388, y = 32238, z = 6},		-- position of backpacks with blank runes (should be 1sqm from you)
	finish_pos = {x = 32386, y = 32238, z = 6}		-- position to drop finished backpack.
}

-- DON'T EDIT BELOW THIS LINE

function prepareBackpacks()
	
	-- when no main backpack open
	if table.count(Container.getInfo(0)) < 2 then

		-- when some other containers are opened
		if Container.Amount() > 0 then

			-- close all containers
			Container.CloseAll()

			-- wait some time
			wait(700, 1000)

		else

			-- open main backpack
			Self.OpenMainBackpack()

			-- wait some time
			wait(700, 1000)

		end

	else		


		-- when no second backpack opened
		if table.count(Container.getInfo(1)) < 2 then

			-- when amount of container is above 1
			if Container.Amount() > 1 then

				-- close all containers
				Container.CloseAll()

				-- wait some time
				wait(700, 1000)

			else	

				-- if we have blank backpack inside main
				if table.count(Container.FindItem(config.blank_backpack_id, 0)) > 2 then

					-- open backpack.
					Container.Open(0, config.blank_backpack_id, true, math.random(500, 700))

				else

					-- pickup one backpack from ground.
					Self.PickupItem(config.blank_pos.x, config.blank_pos.y, config.blank_pos.z, config.blank_backpack_id, 1)

					-- wait some time
					wait(700, 1000)

				end	

			end

		else		

			-- load count of blank runes inside backpacks 
			local count = Self.ItemCount(config.blank_rune_id, 1)

			-- load count self weapon slot.
			local weapon = Self.Weapon()

			-- when weapon is this same as blank id.
			if weapon.id == config.blank_rune_id then

				-- add count
				count = count + 1

			end	

			-- when count jest below or equal 0
			if count <= 0 then

				-- drop backpack to position.
				Self.DropItem(config.finish_pos.x, config.finish_pos.y, config.finish_pos.z, config.blank_backpack_id, 1, math.random(700, 1000))

			end	

		end	

	end	

end	


-- do action inside loop
Module.New("Pickup Bp Blanks Drop Bp Runes", function()

	prepareBackpacks()

end)