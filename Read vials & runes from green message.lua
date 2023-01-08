--[[
    Script Name:        Read vials & runes from green message
    Description:        Using proxy messages for get current amount of vials and "ultimate healing runes" this message may be different depend on server.
    Author:             Ascer - example
]]

local config = {
	vials = {enabled = true, amount = 50, alert = true},     -- read vials: true/false, when amount will below go to label, alert: play sound true/false
    runes = {enabled = true, amount = 20, alert = true},     -- read runes: true/false, when amount will below go to label, alert: play sound true/false
	label = "back",		                                     -- label where to go if vials below
    resetLabel = "reset"                                     -- label where you reset current amount of vials (example after refill)
}

-- DONT EDIT BELOW THIS LINE

local received = false

-- proxy text
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        
        -- vials
        if config.vials.enabled then
            local vials = string.match(msg.message, "Using one of (.+) vials..")
            if vials ~= nil then 
                print(tonumber(vials))
                if tonumber(vials) <= config.vials.amount then 
                    if not received then
    	                Walker.Goto(config.label)
    	                received = true
    	                print("We have " .. vials .. " vials go to label: " .. config.label)
    	                break
    	            end
                    if config.vials.alert then
                        Rifbot.PlaySound("Low Mana.mp3")
                    end    
                end
            end    
        end
        
        -- runes
        if config.runes.enabled then
            local runes = string.match(msg.message, "Using one of (.+) ultimate healing runes...")
            if runes ~= nil then 
                print(tonumber(runes))
                if tonumber(runes) <= config.runes.amount then 
                    if not received then
                        Walker.Goto(config.label)
                        received = true
                        print("We have " .. runes .. " runes go to label: " .. config.label)
                        break
                    end
                    if config.runes.alert then
                        Rifbot.PlaySound("Low Health.mp3")
                    end     
                end
            end    
        end

    end 
end 

-- register function
Proxy.TextNew("proxyText")


function label(name) 
    if name == config.resetLabel then
        received = false
    end 
end 

-- walker label function
Walker.onLabel("label")
