--[[
    Script Name:        Drink MF from ground container
    Description:        Open backpack with mf and put on ground, will drink up to end of fluids and open next bp.
   
    Author:             Ascer - example
]]

local BP_MF_ID = 2854	-- id of backpack with mana fluids.
local MPPERC = 80		-- drink if mana percent below

-- DONT EDIT BELOW

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		drink()
--> Description: 	Drink mana fluid using direct from opened container
--> Params:			None
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function drink()

	-- find cont
	local mf = Container.FindItem(MANA_FLUID.id)

	-- when not found return false
	if not mf then return false end

	-- load self position
	local self = Self.Position()

	-- drink mf.
	Container.UseItemWithGround(mf.index, mf.slot, mf.id, self.x, self.y, self.z, 1000)

	-- return true mf found
	return true

end	

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:		openNextBp(id)
--> Description: 	Open next backpack by id.
--> Params:			
-->					@id - number id of backpack to open
--> Return: 		boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function openNextBp(id)

	-- load new cont
	local newCont = Container.FindItem(id) 
	
	-- when not found return false
	if not newCont then return false end
	
	-- open new container in this same index
	Container.UseItem(newCont.index, newCont.slot, newCont.id, false, 700)

	-- used
	return true 
	
end	

Module.New("Drink MF from ground container", function(mod)

	-- when connected.
	if Self.isConnected() then

		-- when mana percent below.
		if Self.ManaPercent() < MPPERC then

			-- when cant drink
			if not drink() then

				-- open next backpack.
				openNextBp(BP_MF_ID)

			end	

		end	

	end

end)

