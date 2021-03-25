--[[
    Script Name: 		Shutdow Pc at time
    Description: 		Turn off computer when time.
    Author: 			Ascer - example
]]

local SHUTDOWN_TIME = "09:55" 	-- turn off pc when this time
local SHUTDOWN_COMMAND = "shutdown /s /f /t 0" -- command to shutdown pc.
local BATCH = "C:\\batch.bat"   -- path to file with batch.bat to run kill process.


-- DONT'T EDIT BELOW THIS LINE

----------------------------------------------------------------------------------------------
--> Function:        createBatchFile()
--> Description:     Create batch file with command to shudown cpu.     
-->	Params:
-->					 @command - string command to execute.
--> Returns:         void nothing.
----------------------------------------------------------------------------------------------
function createBatchFile(command)
    file = io.open(BATCH, 'w')
    file:write(command)
    return file:close()
end


Module.New("Logout at time", function ()
	
	-- get time 
	local h, min = os.date("%H"), os.date("%M")

	-- when time is fine and not variable contains true
	if (h .. ":" .. min) == SHUTDOWN_TIME  then

		-- create batch file
		createBatchFile(command)

		-- execute command
		os.execute(BATCH)

		-- wait some time.
		wait(10000)

	end
	
end)	

