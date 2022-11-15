--[[
    Script Name: 		Heal Combo UH + Exura Holy
    Description: 		When your character hpperc will below x value then in this same time use UH + Spell (its possible on some servers) 
    Author: 			Ascer - example
]]


local config = {
	hpperc = 60,										-- when hpperc below this value
	spell = "exura holy",								-- spell to cast
	rune = 3160,										-- rune id
	delay = 2000										-- delay between usages
}

-- DON'T EDIT BELOW THIS LINE
local castTime = 0

-- module loop
Module.New("Heal Combo UH + Exura Holy", function ()
	if Self.isConnected() then
		if os.clock() - castTime >= config.delay/1000 then
			if Self.HealthPercent() <= config.hpperc then
				Self.UseItemWithMe(config.rune, 0)
				Self.Say(config.spell)
				castTime = os.clock()
			end
		end		
	end	
end)
