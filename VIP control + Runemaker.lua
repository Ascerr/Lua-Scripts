--[[
    Script Name: 		VIP control
    Description: 		Check up for buddies from vip list and logout when all are offline.
    Author: 			Ascer - example
]]

local LIST = {"def character", "def char2"} 	-- list of players from vip list to search.
local RELOGIN = {enabled = true, delay = 5} -- relogin to game when lost connection or after specific delay. enabled = true/false, delay = 6 min or immediately when lost connection

local MAIN_DELAY = {400, 1700} 	-- delay in milisecond random actions
local MANA_ABOVE = 50			-- MANA POINTS above this cast spell
local SPELL = "adori" 			-- spell to cast

local NO_BLANKS = { 			-- when no blank runes:
	logout = true 				-- logout true/false
}


-- DONT'T EDIT BELOW THIS LINE 

local list, logoutTime, printfTime, rec, noBlanks = table.lower(LIST), 0, 0, false, false


Module.New("VIP control", function ()
	
	-- when we are connected.
	if Self.isConnected() then

		-- when rec is true then wait to avoid multiple logouts.
		if rec then

			-- wait 5000ms
			wait(5000)

			-- set rec false
			rec = false

		end	
		
		-- check if vip is online and is not in fight
		if not VIP.isOnline(list) and not Self.isInFight() then
			
			-- logout
			Self.Logout()
			
			-- set message to Rifbot console
			printf("Logged out due a no players in vip list.")

			-- set time.
			logoutTime = os.clock()

		end

	else

		-- when relogin is enabled and is not disabled by proxy error from blank runes.
		if RELOGIN.enabled and not noBlanks then
        	
			-- check for time 
	        if os.clock() - logoutTime > (60 * RELOGIN.delay) then

	        	-- press enter key
	            Rifbot.PressKey(13, 3000)

	            -- set status for rec.
	            rec = true

	        else

		        -- check for time to avoid spam
	        	if os.clock() - printfTime > 1 then 

	        		-- set message to console
			        printf("Successfully logged out due a VIP offline. Relogin for " .. math.floor((RELOGIN.delay * 60) - (os.clock() - logoutTime)) .. "s.")
		        	
		        	-- set new time
		        	printfTime = os.clock()

		        end	

	        end

	    end 

	end	

end)

Module.New("Runemaker", function (mod)
	
	-- when noBlanks pram cointain true
	if noBlanks then

		-- if logout.enabled and pz 
		if NO_BLANKS.logout and not Self.isInFight() then
			
			-- logout 
			Self.Logout()
			
			 -- set message to Rifbot Console.
			Rifbot.ConsoleWrite("[" .. os.date("%X") .. "] logged due a no more blank runes")

		end

	else
		
		-- load proxy
		local proxy = string.instr(Proxy.ErrorGetLastMessage(), "magic item to cast")

		-- if proxy contains true
		if proxy then 

			-- set param on true
			noBlanks = true

		else
			
			-- when mana above limit
			if Self.Mana() >= MANA_ABOVE then
				
				-- cast spell
				Self.CastSpell(SPELL)
						
			end

		end	

		-- we need to clear message manually.	
		Proxy.ErrorClearMessage() 

	end

	-- set random delay				
	mod:Delay(MAIN_DELAY[1], MAIN_DELAY[2])

end)