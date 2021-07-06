
--[[
    Script Name:        Cast Spell When Friend cast too.
    Description:        Cast spell if specific player say keyword on default channel.
    Author:             Ascer - example
]]

local config = {
    speaker = "Player Name",
    keyword = "exevo gran mas vis",
    mana = 600,
    spell = "exevo gran mas vis"
}

-- DONT EDIT BELOW THIS LINE
	
function proxy(messages) 
	for i, msg in ipairs(messages) do 
		if msg.speaker == config.speaker then
            if string.lower(msg.message) == string.lower(config.keyword) then
                if Self.Mana() >= config.mana then
                    Self.Say(config.spell)
                end    
            end     
        end
	end 
end 
Proxy.New("proxy")



