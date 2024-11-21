--[[
    Script Name:        Pause Bot on DMG Health Calc
    Description:        Stop bot when you get DMG % and no monsters on screen.
    Author:             Ascer - example
]]

local CHECK_FOR_HEALTH_DMG = {
    percent = 10,                                       -- minimal hpperc decreased by GM.                  
    pauseLua = false                                     -- true/false pause lua scripts too
}

local lastHealth, isDMG = Self.Health(), false

function checkForHealthDmg()
    local hp = Self.Health()	
    if hp < lastHealth then
        local dmg = lastHealth - hp
        dmg = math.floor((dmg / Self.HealthMax()) * 100)
        if dmg >= CHECK_FOR_HEALTH_DMG.percent then
            Rifbot.PlaySound("Default.mp3")
            local pauseLuaScripts = false
            if CHECK_FOR_HEALTH_DMG.pauseLua then 
            	pauseLuaScripts = true
            end	
            Rifbot.setEnabled(false, pauseLuaScripts)
            isDMG = true
            print("Health dmg over " .. dmg .. "%")
        end    
    end
    lastHealth = hp 
end 

Module.New("Pause Bot on DMG Health Calc", function ()
    if Self.isConnected() then
        if isDMG then
    		Rifbot.PlaySound("Default.mp3")
    	end
        local mobs = Creature.iMonsters(7)
        if table.count(mobs) <= 0 then
        	checkForHealthDmg()
        end	
    end 
end)