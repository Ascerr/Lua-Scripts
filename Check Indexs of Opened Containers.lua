--[[
    Script Name: 		Check Indexs of Opened Containers
    Description: 		Count avg mana regeneration per tick (results in Information Box).
    Author: 			Ascer - example
]]

local LOGS = "C:\\logs.txt"             -- path to file with logs.txt 
local BATCH = "C:\\batch.bat"           -- path to file with batch.bat to run logs.


-- DON'T EDIT BELOW THIS LINE
local data = ""


----------------------------------------------------------------------------------------------
--> Function:        createBatchFile(path)
--> Description:     Create batch file with command to run logs process.
-->
--> Returns:         void nothing.
----------------------------------------------------------------------------------------------
function createBatchFile()
    file = io.open(BATCH, 'w')
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


-- In loop for containers.
for i = 0, 15 do
	local cont = Container.getInfo(i)
	if table.count(cont) < 1 then
		data = data .. i .. " -> no backpack under this index\n" 
	else		
		data = data .. i .. " -> id: " .. cont.id .. ", items: " .. cont.amount .. ", name: " .. cont.name .. "\n"
	end	
end	


-- show logs
showLogs(data)

-- create batch file
createBatchFile()

-- run batch file
os.execute(BATCH)

