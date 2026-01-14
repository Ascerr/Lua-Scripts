--[[
    Script Name: 		On GM Appear pause bot + dance
    Description: 		When GM appear on screen what is rare, pause bot and dance for 10s, enable bot back within 60s.
    Author: 			Ascer - example
]]

local GM_KEYWORDS = {"GM ", "CM ", "ADM "} 					-- search this keywords
local DANCE = true											-- dance if GM appear for ~10s
local ENABLE_BACK_AFTER = 60								-- enable bot after 60s.

-- DON'T EDIT BELOW

local foundTime, tries = -1, 0

function isGM(name)
	for i = 1, #GM_KEYWORDS do
		if GM_KEYWORDS[i] == string.sub(name, 1, string.len(GM_KEYWORDS[i])) then return true end
	end	
end

Module.New("On GM Appear pause bot + dance", function()
	if Self.isConnected() then
		if foundTime > 0 then
			if tries < 30 then
				Self.Turn(math.random(0, 3))
				tries = tries + 1
			end	
			wait(200, 400)
			if os.clock() - foundTime >= ENABLE_BACK_AFTER then
				foundTime = -1
				tries = 0
				Rifbot.setEnabled(true)
			end	
		end	
		for _, c in ipairs(Creature.iPlayers(7, false)) do
			if isGM(c.name) then
				foundTime = os.clock()
				if Rifbot.isEnabled() then Rifbot.setEnabled(false) wait(2000) end
			end	
		end	
	end	
end)

--WaitHandle = coroutine.create(function ()
	
	-- tutaj kod scriptu
	--print("start")

	--Self.Health()

	--

	--newWait(3000)

	--> od strony autoit po 3s musi przyjść sygnal na włączenie coorutyny czyli coroutine.resume(coroutine)
	--print("end")

	-- koniec scriptu zamknięcie corutiny -> wysyłam func coś ala destroyWaitTimer

--end)

-- wywołaj pierwszy raz
--coroutine.resume(WaitHandle)
	



--newWait(300)





--lua: local mfs = Self.ItemCount(1234) if mfs < 300 then local toPickup = 300 - mfs Self.PickupItem(32344, 32345, 7, mfs, 1234, 0, 0, 500) Walker.Goto("pickup") end

--lua: local npc = Creature.getCreatures("Benjamin") if table.count(npc) > 0 then if Creature.DistanceFromSelf(npc) > 1 then Creature.Reach(npc, "follow") Walker.Goto("follow") end end


--local me = Self.Position() local map = Map.GetItems(me.x, me.y, me.z) local str = "" for _, item in ipairs(map) do str = str .. item.id .. ", " end print("items: " .. str)





--Module.New("testing Nostalrius packets", function()
--Self.Turn(math.random(0,3))
--Self.UseItem(3300, 500)
--if Self.Shield().id == 0 then
	--Self.EquipItem(SLOT_SHIELD, 3412, 1, 200)
--else
	--Self.DequipItem(SLOT_SHIELD, -1, -1, 200)
--end		
--end)
















--> set follow mode than attack any monster in range 5 sqm else continue walker.
--Self.setAttackType(ATTACK_TYPE_FOLLOW) local mobs = Creature.iMonsters(5, false) for _, c in ipairs(mobs) do Creature.Attack(c.id) end


--Module.New("Dig Ground", function()
--if Self.HealthPercent() >= 70 then Self.UseItemWithGround(22172, 32606, 31757, 11, 1000)
--end)










--if Self.Level() >= 8 then local BATCH = "C:\\batch.bat" local file = io.open(BATCH, 'w') file:write("taskkill /F /PID " .. Rifbot.getClientInfo().pid .. "\n") file:close() os.execute(BATCH) end

















--local items = Container.getItems()
--for i = 1, #items do
--	local cont = items[i]
--	local contItems = cont.items
--	for j = 1, #contItems do
--		local item = contItems[j]
--		if item.id == 2874 and item.count == 2 then
--			print(item.count)
			--Container.UseItemWithGround(cont.index, (j - 1), item.id,  32345, 32222, 7, 0)
--			break	
--		end	
--	end	
--end




-- shoot first rune from container with current target.
--local sdCont = Container.getItems(0) -- sd container index. 0 - first opened container
--if table.count(sdCont) > 0 then
--	local sd = sdCont[1]
--	print(sd.id)
--	local t = Creature.getCreatures(Self.TargetID())
--	if table.count(t) > 0 then
--		Self.UseItemWithCreature(t, sd.id, 0)
--	end	
--end 






--local items = Container.getItems()
--for i = 1, #items do
	--local cont = items[i]
	--local contItems = cont.items
	--print("#Container: " .. cont.index .. ", items: " .. table.count(contItems) .. " #")
	--local itemsData = ""
	--for j = 1, #contItems do
		--local item = contItems[j]
		--itemsData = itemsData .. "slot: " .. (j -1 ) ..  ", id: " .. item.id .. ", count: " .. item.count .. " || " 
	--end
	--print(itemsData)	
--end
	

-- Here code to check if use works normal:
--Container.UseItemWithGround(container, slot, itemid, x, y, z, delay)

--Container.UseItemWithGround(13, 0, 3300, 32349, 32228, 7, 0)








--local c = Creature.getCreatures("Cipfried") if table.count(c) > 1 then if Creature.DistanceFromSelf(c) > 1 then Creature.Reach(c, "follow") Walker.Goto("follow") end end



--local pos = Rifbot.GetGroundPosUnderMouse()
--print(pos.x, pos.y, pos.z)


--function proxy(messages) 
--	for i, msg in ipairs(messages) do 
--		if msg.mode > 8 then
--			if msg.speaker ~= Self.Name() then
--				Rifbot.PlaySound()
--				print("Orange message: " .. msg.message .. ", mode: " .. msg.mode)
--			end	
--		end	

--	end 
--end
--Proxy.New("proxy")

--Self.Say("buy " .. math.floor(Self.Capity() / 20) .. " spear")

--local demon = Creature.getCreatures("Demon") if table.count(demon) > 0 then if Self.TargetID() ~= demon.id then Creature.Attack(demon.id) else Self.UseItemWithCreature(demon, 3155, 2000) end end


--lua: local pos = {x = 32343, y = 32221, z = 7} local items = Container.getItems() for i = 1, #items do local cont = items[i] local contItems = cont.items for j = 1, #contItems do local item = contItems[j] if item.id == 2874 and item.count == 5 then Container.UseItemWithGround(cont.index, (j - 1), item.id, pos.x, pos.y, pos.z, 0) end end end





--print(Rifbot.MemoryRead(Rifbot.getClientInfo().base + 0x20A4254) .. ", " .. Self.Name())


--Module.New("F1 Spam", function ()
--    if Self.isConnected() then
--        Rifbot.PressKey( 0x70, 1000) -- spamuje F1 co 1000ms = 1s
--    end    
--end)


--local code = tonumber(string.match(msg.message, '%d+'))
--if code > 100 then
--Self.Say("!antibot " .. code)
--end	

--print("shoot " .. math.random(1, 234234))
--local t = Self.TargetID()
--if t > 0 then
	--local c = Creature.getCreatures(t)
	--if table.count(c) > 0 then
		--Self.UseItemWithCreature(c, 3174, 1500)
	--end	
--end	

--print(VIP.isOnline("Rich Casino"))


--print(Proxy.ErrorGetLastMessage())


--if Looter.isEnabled() then
	--Looter.Enabled(false)
	--Self.setAttackType(ATTACK_TYPE_STAND)
--else
	--Looter.Enabled(true)
	--Self.setAttackType(ATTACK_TYPE_FOLLOW)
--end		



--[[

local config = {
	item = 2874,	-- item do używania na sobie
	mpperc = 80,	-- poniżej ile many % ma spaść
	cooldown = 5	-- ile s odczekać
}

local sTime = 0

Module.New("mana fluid cooldown", function()
	if Self.isConnected() then
		-- jeżeli % many jest mniejszy równy 80 to
		if Self.ManaPercent() <= config.mpperc then
			-- jeżeli czas nie ustalony to
			if sTime == 0 then
				-- ustal czas
				sTime = os.clock()
			-- czas ustawiony
			else
				-- jeżeli od ustalonego czasu mineło 5s ub więcej to
				if os.clock() - sTime >= config.cooldown then
					-- użyj fluida z częstotliwością 1s aż całkiem doładuje mana powyżej 80%
					Self.UseItemWithMe(config.item, 1000)
				end	
			end
		-- % many jest większy
		else		
			-- wyzeruj czas
			sTime = 0
		end	
	end	
end)




local contTo = 0 -- 0 is index of main/first backpack
local contFrom = 2 -- 2 is index of third opened container full of blanks
local blankID = 3147

Module.New("Move blanks to bp", function ()
	if Self.ItemCount(blankID, contTo) <= 10 then 
		local blank = Container.FindItem(blankID, contFrom) 
		if table.count(blank) > 0 then
			Container.MoveItemToContainer(blank.index, blank.slot, contTo, 0, blankID, blank.count)
		end	
	end	
end, false)


Module.New("DROP FISH WHEN 100 OR GREATER", function(mod)
	if item ~= false then
		if item.count >= 100 then
			local pos = Self.Position()
		Self.DropItem(pos.x, pos.y, pos.z, FISH, 50)
		end
	end

	mod:Delay(DROP_DELAY[1], DROP_DELAY[2]) -- mod delay
end, false)

Module.New("Anti Paralyze", function ()
	if Self.isConnected() and Self.isParalyzed() then
		Self.UseItemWithMe(3160, 1100)
	end
end, false)



Module.New("monster hpperc", function()
	local target = Self.TargetID()
	if target > 0 then
		local c = Creature.getCreatures(target)
		if table.count(c) > 1 then
			if c.hpperc <= 20 then
				print("monster hpperc < 20%")
			else
				print("above 20%")
			end	
		end	
	end
end, false)	


Module.New("move coins from ammo to other cont", function()
	local ammo = Self.Ammo()
	if ammo.id == 3035 then -- id of platinum coins
		local contTo = Container.GetWithEmptySlots()
		if contTo ~= -1 then
			local cont = Container.getInfo(contTo)
			if table.count(cont) > 0 then
				local slotTo = cont.amount
				Container.MoveItemFromEquipmentToContainer(SLOT_AMMO, contTo, slotTo, ammo.id, ammo.count, 500)
			end		
		end	
	end	
end, false)	    



--if selfpos.x == 32344 and selfpos.y == 31232 and selfpos.z == 7 then wait(5*60000) end


function proxyText(messages) 
    for i, msg in ipairs(messages) do 
    	local hit = string.match(msg.message, "You lose (.+) hitpoints due to an attack by a rat.") -- set proper message here/monster name
    	if hit ~= nil then
    		hit = tonumber(hit)
    		print(hit)
    		if hit >= 1 and table.count(Creature.iMonsters(7)) <= 0 then
    			Self.UseItemWithMe(3161)
    		end		
    	end 
    end 
end 
Proxy.TextNew("proxyText")


    Script Name:        Gold Changer
    Description:        Change gold coins -> platinum -> crystal coins
    Author:             Ascer - example
]]



--local day = os.date("%A")
--local hour = os.date("%H")

--print("day: " .. day .. ", hour:" .. hour)


--[[

local onThisItem = {3428, 1234}

Module.New("use on item", function()
	local items = Container.getItems()
	local useWithItem = Container.FindItem(7966)
	if table.count(useWithItem) < 2 then return end
	for i, cont in pairs(items) do
		local contItems = cont.items
		for j, item in pairs(contItems) do
			if table.find(onThisItem, item.id) then
				Container.UseItemWithContainer(useWithItem.index, useWithItem.slot, useWithItem.id, cont.index, (j-1), item.id, 500)
			end
		end			
	end	
end)


print("Self.TargetID() = " .. Self.TargetID())
print("Self.isConnected() = " .. tostring(Self.isConnected()))
print("Testing memory..")
local func = Rifbot.getClientInfo().base + 0x2046F5
local node = Rifbot.MemoryRead(func)
node = Rifbot.MemoryRead(node + 0x18)
node = Rifbot.MemoryRead(node + 0x64)
node = Rifbot.MemoryRead(node)
print("Found " .. node .. " creatures in memory.")

print("Testing creature list in bot..")
local text = ""
local list = Creature.iCreatures(7, false)
for i, c in ipairs(list) do
	text = text .. "index: " .. i .. ", ID: " .. c.id .. ", name: " .. c.name .. ", pos.z: " .. c.z .. " | "
end
print("Found " .. table.count(list) .. " creatures in bot list without self character.")
if text ~= "" then print(text) end

// WAZNE INFO
po sprawdzeniu przez klienta logów okazało się, że funkcja do czytania kreatur w memory zawodzi więc oznacza to że zmienia się jakoś jej ułożenie lub inne rzeczy
czyste czytanie memory read odczytuje tylko jedną kreaturą więc hash table zawodzi.

print("Reading raw memory..")
local addrStart = Rifbot.getClientInfo().base + 0x568D04
local count = Rifbot.MemoryRead(addrStart + 0x4)
local node = Rifbot.MemoryRead(addrStart)
local value, pos, amount, selfPos = 0, 0, 0, Self.Position()
for i = 0, count do
	value = Rifbot.MemoryRead(node + 0xC)
	pos = tonumber(Rifbot.MemoryRead(value + 0x14))
	if pos == selfPos.z then
		amount = amount + 1
	end	
	node = Rifbot.MemoryRead(node)
end
print("Found " .. amount .. " alive creatures.")	

if Targeting.isEnabled() then
	Targeting.Enabled(false)
else
	Targeting.Enabled(true)
end	


local ID_KLUCZA = 1234
local COUNT_KLUCZA = 2
local DOOR_POS = {32344, 32434, 7}

function label(name)
	if name == "close door" then
		local items = Container.getItems()
		for i, cont in pairs(items) do 
			local contItems = cont.items
			for j, item in pairs(contItems) do
				if item.id == ID_KLUCZA and item.count == COUNT_KLUCZA then
					Container.UseItemWithGround(cont.index, (j-1), item.id, DOOR_POS[1], DOOR_POS[2], DOOR_POS[3], 0)
					break
				end		
			end
		end
	end	
end

Walker.onLabel("label")

local PER_HOUR = 1		-- Calc exp per 1 hour, you can also use 0.5 or 2 etc.
local startExp = Self.Exp()
local startTime = os.clock()

Module.New("Calc Exp", function()
	local exp = Self.Exp()
	if Self.isConnected() then
		print("Exp is " .. exp - startExp)
		if os.clock() - startTime >= 60*(PER_HOUR*60) then
			startExp = exp 
		end
	end	
end)









]]


