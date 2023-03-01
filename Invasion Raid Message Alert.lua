--[[
    Script Name:        Invasion Raid Message Alert
    Description:        Play Sound when message appear on screen.
    Author:             Ascer - example
]]

local raids = {
    "Something strange happen in Thais.",       -- messages to check, copy it direct from game client.
    "Rat plague in Rookgaard."
}

-- DON'T EDIT BELOW

raids = table.lower(raids)

function proxyText(messages) 
    for i, msg in ipairs(messages) do 
        if table.find(raids, string.lower(msg.message)) then
            Rifbot.PlaySound()
            print(msg.message, msg.mode)
        end     
    end
end
Proxy.TextNew("proxyText")