--[[
    Script Name: 		Close Game If No Runes
    Description: 		Close Game client when no more blank runes (error proxy check)
    Author: 			Ascer - example
]]


local PATH = "C:\\batch.bat" -- path to file with batch.bat to run kill process.

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


Module.New("Close Game If No Runes", function ()
    if string.instr(Proxy.ErrorGetLastMessage(), "magic item to cast") then
        Proxy.ErrorClearMessage() -- we need to clear message manually.
        local client = Rifbot.getClientInfo()
        createBatchFile(client.pid)
        os.execute(PATH)
    end    
end)
