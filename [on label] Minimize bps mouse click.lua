--[[
    Script Name:        [on label] Minimize bps mouse click
    Description:        Minimize backpacks using mouse click, when walker reach label "minimize"
    
    Required:           Valid positions of first container minimize button and offset (posy) to next button.

    Execute:            here is raw walker code:

                        node: 33455, 34455, 7
                        restart bps: 2854, 2854
                        minimize
                        node: 33455, 34454, 7

    Author:             Ascer - example
]]

local config = {
    label = "minimize",
    first_container_minimize_button_pos = {x = 1336, y = 104},       -- position of first container minimize button (x, y). You can check this executing this lua: Module.New("check mouse pos", function() local mouse = Rifbot.GetMousePos() print("x = " .. mouse.x .. ", y = " .. mouse.y) end)
    offset = 20,                                                     -- difference between position y in next container button, pos x is always this same.
    amount = 3,                                                      -- amount backpacks to minimize.
}

-- END CONFIG HERE.


function signal(label)

    if label == config.label then

        -- inside loop click on minimize button in containers
        for i = 0, config.amount - 1 do

            -- left click (we adding + 20 due some error in mouse pos connected with game window bar)
            Rifbot.MouseClick(config.first_container_minimize_button_pos.x, config.first_container_minimize_button_pos.y + (config.offset * i) + 20)

            -- wait some time.
            wait(500, 800)

        end 

    end   

end

Walker.onLabel("signal")


--> here you can check pos of mouse on screen
--Module.New("check mouse pos", function() local mouse = Rifbot.GetMousePos() print("x = " .. mouse.x .. ", y = " .. mouse.y) end)

