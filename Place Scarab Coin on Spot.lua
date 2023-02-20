--[[
    Script Name: 		Place Scarab Coin on Spot
    Description: 		When character reach position x, y, z and there is no scarab coin on spot then it will throw one.
    Author: 			Ascer - example
]]

local config = {
	scarab_coin = {x = 32348, y = 32218, z = 6, id = 3042},
	character_pos = {x = 32348, y = 32219, z = 6}
}

-- DON'T EDIT BELOW THIS LINE

Module.New("Place Scarab Coin on Spot", function (mod)
	if Self.DistanceFromPosition(config.character_pos.x, config.character_pos.y, config.character_pos.z) == 0 then
		if Map.GetTopMoveItem(config.scarab_coin.x, config.scarab_coin.y, config.scarab_coin.z).id ~= config.scarab_coin.id then
			Self.DropItem(config.scarab_coin.x, config.scarab_coin.y, config.scarab_coin.z, config.scarab_coin.id, 1, 1000)
			print("dropping scarab coin..")
		end	
	end	
end)
