--[[
    Script Name: 		Exit Game If No Food
    Description: 		Close Game client when no more visible items (could be food) in containers and equimpent.
    Author: 			Ascer - example
]]


local FOOD = {3725, 3577}  -- ID of items you want check
local PATH = "C:\\batch.bat"           -- path to file with batch.bat to run kill process.

----------------------------------------------------------------------------------------------
--> Function:        setSignalToFile(path)
--> Description:     Create batch file with command to close specific process pid.
--> Params:          
-->                  @pid - number id of process to kill
--> Returns:         void nothing.
----------------------------------------------------------------------------------------------
function createBatchFile(pid)
    file = io.open(PATH, 'w')
    file:write("taskkill /F /PID " .. pid)
    return file:close()
end

function isFood()
    if table.count(Container.FindItem(FOOD)) > 1 then return true end
    local ammo, weapon, shield = Self.Ammo(), Self.Weapon(), Self.Shield()
    if table.find(FOOD, ammo.id) or table.find(FOOD, weapon.id) or table.find(FOOD, shield.id) then return true end
    return false
end  --> return true/false if found item in eq and containers


Module.New("Exit Game If No Food", function ()
    if not isFood() then
        local client = Rifbot.getClientInfo()
        createBatchFile(client.pid)
        os.execute(PATH)
    end    
end)
