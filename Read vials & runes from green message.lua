--[[
    Script Name:        Read vials & runes from green message
    Description:        Using proxy messages for get current amount of vials and "ultimate healing runes" this message may be different depend on server.
    
    Code practice:      When you receive message then walker go to label "back" and set @param received = true
                        Best way will add this function to script with Walker.onLabel function and there in depot when you refill supplies
                        just on label set @param received = false to enable reading messages about vials/runes.

    Author:             Ascer - example
]]

local config = {
	vials = {enabled = true, amount = 50},     -- read vials: true/false, when amount will below go to label  
    runes = {enabled = true, amount = 20},     -- read runes: true/false, when amount will below go to label   
	label = "back"		                       -- label where to go if vials below
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
                end
            end    
        end

    end 
end 

-- register function
Proxy.TextNew("proxyText")