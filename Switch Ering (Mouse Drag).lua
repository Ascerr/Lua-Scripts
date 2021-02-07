--[[
    Script Name:        Switch E ring (Mouse Drag)
    Description:        Drag energy ring from container to ring slot in eq.
    Required:			[Important]: 
    Author:             Ascer - example
]]

-- MOST IMPORTANT VALUESE
local slotRing = {x = 644, y = 285}				-- position of slot ring in equipment
local containerSlotPos = {x = 651, y = 435}		-- position of ring in container.


local ENABLE_SHOWS_MOUSE_POS = true				-- true/false shows mouse cursor pos inside Rifbot panel -> Information Box
local HPPERC = 50								-- equip only when hp below this percent.
local ENERGY_RING = {on = 3088, off = 3051} 	-- set id for ering on - equiped, off - not


-- DONT EDIT BELO

-- module to execute script
Module.New("Switch E ring (Mouse Drag)", function()

	-- when connected.
	if Self.isConnected() then

		-- load hpperc.
		local hp = Self.HealthPercent()

		-- load ring.
		local ring = Self.Ring()

		-- when hp is below or equal
		if hp <= HPPERC then	

			-- when ring is diff than on energy ring
			if ring.id ~= ENERGY_RING.on then
				
				-- drag mouse
				Rifbot.MouseClickDrag(containerSlotPos.x, containerSlotPos.y, slotRing.x, slotRing.y)

			end

		else
			
			-- when ring is diff than on energy ring
			if ring.id == ENERGY_RING.on then
				
				-- dequip ring to first opened container
				Self.DequipItem(SLOT_RING, nil, 0, 0)

			end	

		end

	end	

end)


-- module to check mouse pos
Module.New("Shows cursor pos", function()
	
	-- load cursor pos.
	local pos = Rifbot.GetMousePos()
	
	-- shows in Rifbot console
	printf("Mouse cursor pos: x = " .. pos.x .. ", y = " .. pos.y)

end, ENABLE_SHOWS_MOUSE_POS)