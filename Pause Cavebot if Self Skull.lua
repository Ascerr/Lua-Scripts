--[[
    Script Name: 		Pause Cavebot if Self Skull
    Description: 		Check if self character have skull white, red or black then disable walker and play sound.
    Author: 			Ascer - example
]]

local ALERT = true      -- true/false play sound if sell skull

-- DON'T EDIT BELOW THIS LINE

Module.New("Pause Cavebot if Self Skull", function ()
    if Self.isConnected() then
        local me = Creature.getCreatures(Self.ID())
        if table.count(me) > 1 then
            if me.skull >= 3 then
                if Walker.isEnabled() then Walker.Enabled(false) end
                if Targeting.isEnabled() then Targeting.Enabled(false) end
                if Looter.isEnabled() then Looter.Enabled(false) end
                if ALERT then Rifbot.PlaySound() end    
            end    
        end    
    end    
end)
