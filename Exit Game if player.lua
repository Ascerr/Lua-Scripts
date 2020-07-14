--[[
    Script Name: 		Exit Game If Player
    Description: 		Close game process when player detected on screen.
    Author: 			Ascer - example
]]


local FRIENDS = {"friend1","friend2"}   -- list of friends we avoid.
local LOGS = "C:\\logs.txt"             -- path to file with logs.txt 
local BATCH = "C:\\batch.bat"           -- path to file with batch.bat to run kill process.


-- DON'T EDIT BELOW THIS LINE.


-- convert table to lower strings.
FRIENDS = table.lower(FRIENDS) 

---------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       getCreature()
--> Description:    Get creature monster or player on screen.
--> Class:          Self
--> Params:         None              
--> Return:         boolean false or string name
----------------------------------------------------------------------------------------------------------------------------------------------------------
function getCreature()

    -- inside loop for all found creatures on multiple floors do:
    for i, c in pairs(Creature.iPlayers(7, false)) do

        -- when we can not find a friends..
        if not table.find(FRIENDS, c.name) then
            
            -- return creature.    
            return os.date("%X") .. " " .. c.name .. " just appear on screen."

        end        
        
    end

    -- return false noone player found.
    return false

end 

----------------------------------------------------------------------------------------------
--> Function:        createBatchFile(path)
--> Description:     Create batch file with command to close specific process pid.
--> Params:          
-->                  @pid - number id of process to kill
--> Returns:         void nothing.
----------------------------------------------------------------------------------------------
function createBatchFile(pid)
    file = io.open(BATCH, 'w')
    file:write("taskkill /F /PID " .. pid .. "\n")
    file:write("start " .. LOGS)
    return file:close()
end

----------------------------------------------------------------------------------------------
--> Function:        showLogs(path, data)
--> Description:     Creates Logs.txt file and display it.
--> Params:          
-->                  @data - what we write to file.
--> Returns:         void nothing.
----------------------------------------------------------------------------------------------
function showLogs(data)
    file = io.open(LOGS, 'w')
    file:write(data)
    file:close()
end


-- mod execute delay.
Module.New("Exit Game If Player", function ()
    
    -- load creature
    local player = getCreature()

    -- when creature detected.
    if player ~= false then

        -- show who entered to screen.
        showLogs(player)

        -- load game client stats
        local client = Rifbot.getClientInfo()
        
        -- create batch file
        createBatchFile(client.pid)

        -- run batch file
        os.execute(BATCH)

        -- wait some time
        wait(1000)

    end 
       
end)
