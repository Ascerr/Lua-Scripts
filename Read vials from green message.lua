--[[
    Script Name:        Read vials from green message
    Description:        Using proxy messages you can get amount of vials left and manage this situation
    Author:             Ascer - example
]]

local config = {
	vials = 50,			-- when amount of vials below 50 goto label
	label = "back"		-- label where to go if vials below
}

-- DONT EDIT BELOW THIS LINE
local received = false


-- proxy text
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        local vials = string.match(msg.message, "Using one of (.+) vials..")
        if vials ~= nil then 
            if tonumber(vials) <= config.vials then 
                if not received then
	                Walker.Goto(config.label)
	                received = true
	                print("We have " .. vials .. " vials go to label: " .. config.label)
	                break
	            end    
            else
            	if received then
            		print("Enable checking for low vials due current amount: " .. vials)
            	end	
            	-- enable checking
            	received = false    
            end      
        end 
    end 
end 

-- register function
Proxy.TextNew("proxyText")