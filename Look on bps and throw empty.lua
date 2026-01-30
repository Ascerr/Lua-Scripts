--[[
    Script Name: 		Look on bps and throw empty
    Description: 		Look in game on backpacks ids in specific indexs, wait for green message signal "It weighs 18.00 oz" or other you can add your then thow out this bp.
    Author: 			Ascer - example
]]


local BPS_IDS = {2854, 2868}				-- look only on this bps ids
local INDEXS = {0, 1}						-- check only in this containers index 0 - first opened, 1 - second.
local KEYWORDS = {"It weighs 18.00 oz"}		-- if this keyword found throw item.
local WAIT_FOR_GREEN_MESSAGE = 1000			-- time in ms we waiting for message.

-- DONT EDIT BELOW THIS LINE

local lastLook = {index = 0, slot = 0, id = 0, count = 0}
local destroyLoop = false

function lookOnBps()
	local items = Container.getItems()
	for i = 1, #items do
		local cont = items[i]
		local contItems = cont.items
		if table.find(INDEXS, cont.index) then
			for j = 1, #contItems do
				local item = contItems[j]
				if table.find(BPS_IDS, item.id) then
					lastLook = {index = cont.index, slot = cont.slot, id = item.id, count = (j-1)}
					Self.LookItem("cont", cont.index, (j-1), item.id) 			-- looks on container index: 0, slot: 0, item.id: 3031 - gold coin.
					wait(WAIT_FOR_GREEN_MESSAGE)
					if destroyLoop then
						destroyLoop = false
						return
					end	
				end
			end
		end	
	end			
end	--> check look on bp, waits for green message if true then restart loop to avoid throwning non bps items.

-- loop module
Module.New("Look on bps and throw empty", function()
	if Self.isConnected() then
		lookOnBps()
	end	
end)

-- proxy get green message.
function proxyText(messages) 
	for i, msg in ipairs(messages) do 
		for j = 1, #KEYWORDS do
			if string.find(msg.message, KEYWORDS[j]) then
				local me = Self.Position()
				destroyLoop = true
				Container.MoveItemToGround(lastLook.index, lastLook.slot, me.x, me.y, me.z, lastLook.id, lastLook.count, 0)
				break
			end
		end	 
	end 
end 
Proxy.TextNew("proxyText")
