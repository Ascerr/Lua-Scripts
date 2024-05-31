--[[
    Script Name:        Exit Game If Proxy Message DMG
    Description:        Close game process when appear message about hitpoints lost.
    Author:             Ascer - example
]]
 
 
local LOGS = "C:\\logs.txt"             -- path to file with logs.txt 
local BATCH = "C:\\batch.bat"           -- path to file with batch.bat to run kill process.
local DMG = 5                           -- amount of dmg received to exit game
 
-- DON'T EDIT BELOW THIS LINE.
 
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
 
function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        local hit = string.match(msg.message, "You lose (.+) hitpoints")
        if hit ~= nil then
            hit = tonumber(hit)
            if hit >= DMG then
                
                Rifbot.PlaySound("Default.mp3")

                -- show who entered to screen.
                showLogs(msg.message)
     
                -- load game client stats
                local client = Rifbot.getClientInfo()
                
                -- create batch file
                createBatchFile(client.pid)
     
                -- run batch file
                os.execute(BATCH)
     
                -- wait some time
                wait(1000)
                break
            end 
        end 
    end 
end 
Proxy.TextNew("proxyText") 
