--[[
    Script Name:        Connect to game typing password
    Description:        This script is designed for typing account and password then login to game. Character will always first.
    
    Required:           -> Rifbot 2.42+ (both updated Rifbot Lib.lua and Rifbot.exe)
                        -> valid position for enter_game_button_pos
    Author:             Ascer - example
]]

local config = {
    account = "1234567",                                -- account number
    password = "abcde23",                               -- account password
    enter_game_button_pos = {x = 120, y = 490},         -- position x and y of button Enter Game (use module checkMousePos to check what is this pos.) 
    key_press_delay = 2000                              -- delay in miliseconds between press key when you will on Character List window.
}

-- DON'T EDIT BELOW
local setDetails, firstLogin = false, false

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> Function:       enterGame()
--> Description:    Click Enter Game button, type account and password and click button Enter to login.
--> Class:          Self
--> Params:         
-->                 @direction - number 0-7 or NORTH, EAST etc.
--> Return:         boolean true or false
----------------------------------------------------------------------------------------------------------------------------------------------------------
function enterGame()
    wait(200)
    Rifbot.MouseClick(config.enter_game_button_pos.x, config.enter_game_button_pos.y+20)
    wait(500)
    Rifbot.WriteText(config.account)
    wait(500)
    Rifbot.PressKey(9, 0)
    wait(500)
    Rifbot.WriteText(config.password)
    wait(500)
    Rifbot.PressKey(13, 0)
end    

-- loop module
Module.New("Connect to game typing password", function()
    if not firstLogin then
        if not setDetails then
            enterGame()
            setDetails = true
        else
            if not Self.isConnected() then
                Rifbot.PressKey(13, config.key_press_delay)
            else    
                firstLogin = true  
            end    
        end
    end        
end)

-- Here is a module to check your mouse posx and posy to read Enter Game button. Disable ", false" and end to run this module. Text will be displayed in Rifbot Information Box.
Module.New("checkMousePos", function()
    local pos = Rifbot.GetMousePos()
    print("mouse pos = { x = " ..pos.x .. ", y =" .. pos.y .. "}")
end, false)