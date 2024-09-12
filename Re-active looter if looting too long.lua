--[[
    Script Name:        Re-active looter if looting too long
    Description:        Script will fast disable and enable looter module when you looting more than x miliseonds.
    Author:             Ascer - example
]]

local LOOTING_TIME = 4000	-- how many miliseconds (1000 = 1s) to stop looting (checking if character walking to creature to don't turn off looter in this case)

-- DONT EDIT BELOW THIS LINE

local t = 0

Module.New("Re-active looter if looting too long", function()
	if Looter.isLooting() then
		if t == 0 then
			t = os.clock()
		else
			if (os.clock() - t)*1000 > LOOTING_TIME and not Self.isWalking() then
				Looter.Enabled(false)
				Looter.Enabled(true)
				t = 0
			end
		end
	else
		t = 0
	end
end)