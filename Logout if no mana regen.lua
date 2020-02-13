--[[
    Script Name: 		Logout if no mana regen
    Description: 		Logout from game if no mana regeneration for some time.
    Author: 			Ascer - example
]]

local NO_REGEN_FOR = 60  -- sec / when you don't gain any mana points for 60 sec script force logout.


-- DONT'T EDIT BELOW THIS LINE 
local lastMana, regenTime = -1, 0


Module.New("Logout if no mana regen", function ()
	
    -- load mana points.
    local mana = Self.Mana()

    -- when mana is above or equal 0.
    if mana >= 0 then

        -- when current mana is different than lastMana and or we have full mana.
        if mana ~= lastMana or mana >= Self.ManaMax() then
            
            -- set last time.
            regenTime = os.clock()

            -- set last mana
            lastMana = mana

        end

    end
    
    -- when time we are no regen is longer than param
    if os.clock() - regenTime > NO_REGEN_FOR then

        -- logout.
        Self.Logout()

        -- reset time
        regenTime = os.clock()

    end    

end)