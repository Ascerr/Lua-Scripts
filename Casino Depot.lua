--[[
    Script Name:        Casino Depot
    Description:        High & Low Dice casino balance script inside depot.
    
    Required:           1. Rifbot version 2.41+ (2022-10-11).
                        2. Dice + cash in main backpack       
                        3. Valid ids for dice, depot, counter, backpack and cash.

    Extra Info:         Script works only with single one coin type: gold, platinum, crystal! You can set inside config: GAME.coin
                        Commands on default chat:
                        /start -> starts script
                        /stop  -> stops script (player balance don't dissapear)

    Author:             Ascer - example
]]

----------------------------------------------------------------------------------------------------------------------------------------------------------
--> CONFIG SECTION: start - read it carefully becaue it's important!
----------------------------------------------------------------------------------------------------------------------------------------------------------

local IDS = {
    backpack = 2853,                                -- [!IMPORTANT] it's main backpack id from equipment slot. Don't use other id inside main backpack for next cash bp
    depot = {3497, 3498, 3499, 3500},               -- depots id
    counter = {2321},                               -- counters is (it's table near depot)
    dice = {5560, 5561, 5562, 5563, 5564, 5565},    -- dice id (every number has different id)
    gold = 3031,                                    -- id of gold coin
    platinum = 3035,                                -- id of platinum coin
    crystal = 3043,                                 -- id of crystal coin
}

local GAME = {
    bet = {min = 5, max = 25},                      -- bet amount between min and max coins you accept
    coin = IDS.crystal,                             -- [!IMPORTANT] {IDS.gold, IDS.platinum, IDS.crystal} coins you accept. The best way is Crystal Coin with min bet 5cc or Platinum Coins with 5 platinums min. This is no possible to accept both at once.
    cash_shortcut = "cc",                           -- [!IMPORTANT] shortcut for message about bet or balance. default "cc" for crystl coins could be "pc" for platinum coins or "gp" for gold coinds
    payout = 80,                                    -- % payout player win extra to his balance when win bet.
    dice_mode = {43, 44}                            -- [!IMPORTANT] mode to read dice signal this my change on different servers. Tested(Retrocores = 44, ShadowIllusion = 43) (function Proxy.New, channel = 0, mode = GAME.dice_mode).
}

local DELAYS = {
    pickup = 1000,                                  -- amount of miliseconds we max wait for successful pickup cash after this time character will try again.
    payout = 1000,                                  -- amount of miliseconds we max wait for successful drop cash after this time character will try again. 
    dice = 800,                                     -- ms between dice usage.
    open = 1000,                                    -- delay for opening containers.
    move = 300,                                     -- move items delay.
    antiidle = 1000 * 60 * 5,                       -- every this time turn. (default 5min)
    advertising = 1000 * 60 * 1,                    -- send advert message every 1 min on default channel.
}

local MESSAGE = {
    welcome = "Hi, play?",                          -- welcome message when player enter casino spot.
    balance = "balance:",                            -- balance message at end script will auto add space and amount example: balance 100
    info = "High&Low min " .. GAME.bet.min .. " max " .. GAME.bet.max .. " " .. GAME.cash_shortcut .. " payout " .. GAME.payout .. "%", -- info message when player say: info
    min_bet = "min is " .. GAME.bet.min .. GAME.cash_shortcut, -- info about player low cash for minimal bet
    full_bp = "Sorry, my backpack if currently full.",  -- message when your container for cash is full.
    payout = "your cash",                            -- message about after payout. default = "your cash 100 gp"
    low_cash = "Sorry, im out of cash.",             -- message no more cash to payout
    advertising = "Casino High-Low min " .. GAME.bet.min .. " max " .. GAME.bet.max .. " " .. GAME.cash_shortcut .. " payout " .. GAME.payout .. "%", -- mesage you advert on default channel.
    wrong_coin = "I accept only"                     -- when player put on counter wrong coin and say h or l then bot will send msg: "I accept only crystal coins."
}

local SIGNAL = {
    info = {"bet", "info", "information", "%", "offer", "min", "max", "minimal", "maximal", "play"},    -- keywords we accept for info
    balance = {"balance", "account", "deposit", "bal"},                                                 -- keywords we accept for balanace
    high = {"h", "high"},                                                                               -- keywords we accept for high game 
    low = {"l", "low"},                                                                                 -- keywords we accept for low game   
    payout = {"pay", "<", ">", "^", "V", "thief", "cash", "payout", "withdraw", "money", ">>", "<<"},   -- keywords we accept for payout cash    
}

local COMMANDS = {
    start = {"!start", "/start", "\\start", "! start"},                                                  -- keywords said on default chat by our char to start casino
    stop = {"!stop", "/stop", "\\stop", "! stop"},                                                       -- stop casino script, balance will saved.
}
----------------------------------------------------------------------------------------------------------------------------------------------------------
--> CONFIG SECTION: end
----------------------------------------------------------------------------------------------------------------------------------------------------------

-- DON'T EDIT BELOW THIS LINE WITHOUT KNOWLEDGE, IT'S NO CONFIG BUT SCRIPT ENGINE CODE.
--> if you make changes below to expand your casino and script start sucessfuly but don't do nothing then make sure name of variables are valid in last your edited function.

-- enter critical mode to allow faster script execution.
Rifbot.setCriticalMode(true)

local gameSpot = {
    depot = {x = 0, y = 0, z = 0},
    counter = {x = 0, y = 0, z = 0},
    player = {x = 0, y = 0, z = 0},
    self = {x = 0, y = 0, z = 0},
    dir = {turn = 0, default = 0}
}

local balance = {}

local initProc = 0
local sayStartTime, sayLastTime, sayMessageCount = 0, 0, 0
local lastPlayer = {name = ""}
local lastMyCash = 0
local pickupCash = false
local acceptBet = false
local acceptGame = ""
local useDice = false
local playerBet = 0
local antiidleTime = os.clock()
local payoutCash, payout, payoutText, payoutCashTime, payoutWaitForPlayerTakeCash, payoutContainerBackTries = false, false, "", 0, false, 0
local advertTime = 0
local stopCasino = false
local startCasino = false
local logTime = 0
local openTime = 0

function isItemOnMapPos(itemid, x, y, z)
    if table.count(itemid) < 1 then
        itemid = {itemid}
    end    
    local map = Map.GetItems(x, y, z)
    for i, item in ipairs(map) do
        if table.find(itemid, item.id) then
            return true
        end    
    end
    return false    
end --> check if item (id or table) is on position x, y, z (searching deep up to 10 items)   

function stringNoNumbersAndSpaces(msg)
    msg = msg:gsub(' ', '')
    msg = msg:gsub('%d', '')
    return msg
end --> remove from message numbers and spaces    

function log(text, delay)
    if not delay then delay = 0 end
    if os.clock() - logTime > (delay/1000) then
        print(text)
        logTime = os.clock()
    end    
end --> send message to Rifbot InformationBox with delay

function balanceUpdate(name, currentAmount)
    for i, item in ipairs(balance) do
        if item.name == name then
            if currentAmount < 0 then currentAmount = 0 end
            item.cash = currentAmount
            balance[i] = item
            return true
        end    
    end
    table.insert(balance, {name = name, cash = currentAmount})
    return true    
end --> update player balance.

function balanceGet(name)
    for i, item in ipairs(balance) do
        if item.name == name then
            return item.cash
        end    
    end
    table.insert(balance, {name = name, cash = 0})
    return 0
end --> get current player balance  

function say(text, delay)
    if not delay then delay = 2000 end
    if os.clock() - sayStartTime >= 10 then
        sayMessageCount = 0
        sayStartTime = 0
    end        
    if sayMessageCount < 6 and os.clock() - sayLastTime >= (delay/1000) then
        Self.Say(text)
        sayMessageCount = sayMessageCount + 1
        sayLastTime = os.clock()
        if sayMessageCount == 1 then
            sayStartTime = os.clock()
        end
        return true        
    end
    return false    
end --> say text on default chat avoiding beeing muted   

function getGamePlayer()
    for i, player in ipairs(Creature.iPlayers(7, false)) do
        if player.x == gameSpot.player.x and player.y == gameSpot.player.y and player.z == gameSpot.player.z then
            return player
        end    
    end
    return nil
end --> return info about player in game spot or nil if not found    

function advert()
    if os.clock() - advertTime >= (DELAYS.advertising/1000) then
        say(MESSAGE.advertising, 1000)
        advertTime = os.clock()
    end    
end --> send message about casino on default chat   

function antiidle()
    if payout or acceptBet or pickupCash then return end
    if os.clock() - antiidleTime > (DELAYS.antiidle/1000) then
        local dir = Self.Direction()
        if gameSpot.dir.turn ~= gameSpot.dir.default then
            if dir == gameSpot.dir.turn then
                Self.Turn(gameSpot.dir.default)
            else
                Self.Turn(gameSpot.dir.turn)
            end

        else    
            for i = 0, 3 do
                if i ~= dir then
                   Self.Turn(gameSpot.dir.default)
                   break
                end    
            end    
        end 
        antiidleTime = os.clock()        
    end    
end --> turn in random directions to avoid beeing logged out.    

function getPickupSlot()
    local cont = Container.getInfo(0)
    local items = Container.getItems(0)
    for i, item in ipairs(items) do
        if item.id == GAME.coin and item.count < 100 then
            return (i - 1)
        end    
    end
    if cont.size == cont.amount then return -1 end
    return cont.amount    
end --> get container slot where we will pickup cash. return -1 if cont is full   

function untrash(force)
    if (pickupCash or acceptBet) and not force then return end
    if initProc ~= 3 then return end
    local top = Map.GetTopMoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z)
    if not table.find(IDS.dice, top.id) and not table.find(IDS.depot, top.id) then
        if top.id == IDS.gold or top.id == IDS.platinum or top.id == IDS.crystal then
            Map.MoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z, top.id, top.count, DELAYS.move)
        else
            Map.MoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, gameSpot.self.x, gameSpot.self.y, gameSpot.self.z, top.id, top.count, DELAYS.move)
        end    
    end
end --> untrash depot spot.

function wrongCoin()
    local top = Map.GetTopMoveItem(gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z)
    if table.find({IDS.gold, IDS.crystal, IDS.platinum}, top.id) and top.id ~= GAME.coin then
        local text = "gold"
        if GAME.coin == IDS.platinum then
            text = "platinum"
        elseif GAME.coin == IDS.crystal then
            text = "crystl"
        end        
        say(MESSAGE.wrong_coin .. " " .. text .. " coins.", 2000)
    end    
end --> return info about wrong coin put on counter.

function getGameSpot()
    local self = Self.Position()
    if isItemOnMapPos(IDS.depot, self.x, self.y - 1, self.z) and isItemOnMapPos(IDS.counter, self.x - 1, self.y - 1, self.z) then
        gameSpot = {
            depot = {x = self.x, y = self.y - 1, z = self.z},
            counter = {x = self.x - 1, y = self.y -1, z = self.z},
            player = {x = self.x - 2, y = self.y, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 3, default = 0}
        }
        return true
    elseif isItemOnMapPos(IDS.depot, self.x, self.y - 1, self.z) and isItemOnMapPos(IDS.counter, self.x + 1, self.y - 1, self.z) then
        gameSpot = {
            depot = {x = self.x, y = self.y - 1, z = self.z},
            counter = {x = self.x + 1, y = self.y -1, z = self.z},
            player = {x = self.x + 2, y = self.y, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 1, default = 0}
        }
        return true
    elseif isItemOnMapPos(IDS.depot, self.x, self.y + 1, self.z) and isItemOnMapPos(IDS.counter, self.x + 1, self.y + 1, self.z) then
        gameSpot = {
            depot = {x = self.x, y = self.y + 1, z = self.z},
            counter = {x = self.x + 1, y = self.y +1, z = self.z},
            player = {x = self.x + 2, y = self.y, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 1, default = 2}
        }
        return true 
    elseif isItemOnMapPos(IDS.depot, self.x, self.y + 1, self.z) and isItemOnMapPos(IDS.counter, self.x - 1, self.y + 1, self.z) then
        gameSpot = {
            depot = {x = self.x, y = self.y + 1, z = self.z},
            counter = {x = self.x - 1, y = self.y +1, z = self.z},
            player = {x = self.x - 2, y = self.y, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 3, default = 2}
        }
        return true 

    -->
    
    elseif isItemOnMapPos(IDS.depot, self.x - 1, self.y, self.z) and isItemOnMapPos(IDS.counter, self.x - 1, self.y + 1, self.z) then
        gameSpot = {
            depot = {x = self.x - 1, y = self.y, z = self.z},
            counter = {x = self.x - 1, y = self.y +1, z = self.z},
            player = {x = self.x, y = self.y + 2, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 2, default = 3}
        }
        return true     
    elseif isItemOnMapPos(IDS.depot, self.x - 1, self.y, self.z) and isItemOnMapPos(IDS.counter, self.x - 1, self.y - 1, self.z) then
        gameSpot = {
            depot = {x = self.x - 1, y = self.y, z = self.z},
            counter = {x = self.x - 1, y = self.y -1, z = self.z},
            player = {x = self.x, y = self.y - 2, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 0, default = 3}
        }
        return true     
    
    elseif isItemOnMapPos(IDS.depot, self.x - 1, self.y, self.z) and isItemOnMapPos(IDS.counter, self.x + 1, self.y + 1, self.z) then
        gameSpot = {
            depot = {x = self.x + 1, y = self.y, z = self.z},
            counter = {x = self.x + 1, y = self.y +1, z = self.z},
            player = {x = self.x, y = self.y + 2, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 2, default = 1}
        }
        return true     
    elseif isItemOnMapPos(IDS.depot, self.x + 1, self.y, self.z) and isItemOnMapPos(IDS.counter, self.x + 1, self.y - 1, self.z) then
        gameSpot = {
            depot = {x = self.x + 1, y = self.y, z = self.z},
            counter = {x = self.x +1, y = self.y -1, z = self.z},
            player = {x = self.x, y = self.y - 2, z = self.z},
            self = {x = self.x, y = self.y, z = self.z},
            dir = {turn = 0, default = 1}
        }
        return true        

    end 
    return false    
end --> set new position for depot, counter, player, self and turn direction.

function acceptPlayerBet(amount, game)
    if pickupCash or acceptBet then return end
    local playerCash = balanceGet(lastPlayer.name)
    if not amount or amount > playerCash then amount = playerCash end
    amount = math.floor(amount)
    if playerCash < GAME.bet.min then
        wrongCoin()
        return say(MESSAGE.min_bet, 200)
    elseif amount < GAME.bet.min then
        amount = GAME.bet.min        
    elseif amount > GAME.bet.max then
        amount = GAME.bet.max
    end
    acceptBet = true
    acceptGame = game 
    playerBet = amount   
end --> check for balance and accept or don't player bet

function resetParams()
    initProc = 0
    lastPlayer = {name = ""}
    lastMyCash = 0
    pickupCash = false
    acceptBet = false
    useDice = false
    payoutCash = false 
    payout = false
    payoutWaitForPlayerTakeCash = false 
    payoutContainerBackTries = 0 
end --> restart key casino params.

function readDiceResult(number)
    local sum, bal = 0, 0
    if acceptGame == "high" then
        if number >= 4 and number < 7 then
            sum = math.floor(playerBet * (GAME.payout/100))
            bal = balanceGet(lastPlayer.name) + sum
            balanceUpdate(lastPlayer.name, bal)
            say("+" .. sum .. ", balance " ..  bal, 400)
            log("[Casino->readDiceResult]: player: " .. lastPlayer.name .. ", +" .. sum .. ", balance " ..  bal)
        elseif number > 0 and number < 4 then
            sum = playerBet
            bal = balanceGet(lastPlayer.name) - sum
            balanceUpdate(lastPlayer.name, bal)
            say("-" .. sum .. ", balance " ..  bal, 400)
            log("[Casino->readDiceResult]: player: " .. lastPlayer.name .. ", -" .. sum .. ", balance " ..  bal)
        end    
    elseif acceptGame == "low" then
        if number >= 4 and number < 7 then
            sum = playerBet
            bal = balanceGet(lastPlayer.name) - sum
            balanceUpdate(lastPlayer.name, bal)
            say("-" .. sum .. ", balance " ..  bal, 400)
            log("[Casino->readDiceResult]: player: " .. lastPlayer.name .. ", -" .. sum .. ", balance " ..  bal)
        elseif number > 0 and number < 4 then
            sum = math.floor(playerBet * (GAME.payout/100))
            bal = balanceGet(lastPlayer.name) + sum
            balanceUpdate(lastPlayer.name, bal)
            say("+" .. sum .. ", balance " ..  bal, 400)
            log("[Casino->readDiceResult]: player: " .. lastPlayer.name .. ", +" .. sum .. ", balance " ..  bal)
        end    
    end    
    acceptBet = false
    acceptGame = ""
    playerBet = 0
end --> final check if player won or lost.    

function stop()
    if not stopCasino then return end
    local cont = Container.getInfo(0)
    resetParams()
    if gameSpot.depot.x == 0 then 
        stopCasino = false
        return
    end    
    if table.count(cont) > 1 then
        local top = Map.GetTopMoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z)
        if not table.find(IDS.depot, top.id) then
            if top.id == IDS.gold or top.id == IDS.platinum or top.id == IDS.crystal then
                Map.MoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z, top.id, top.count, DELAYS.move)
            elseif table.find(IDS.dice, top.id) then
                if cont.amount < cont.size then
                    Self.PickupItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, top.id, top.count, 0, cont.amount, DELAYS.move)
                else
                    local nextBp = Container.FindItem(IDS.backpack, 0)
                    if table.count(nextBp) > 1 then
                        Container.Open(0, IDS.backpack, false, DELAYS.open)
                    else    
                        return log("[Casino->stop]: There is no more space in backpack to put back dice.", 2000)
                    end    
                end 
            else
                Map.MoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, gameSpot.self.x, gameSpot.self.y, gameSpot.self.z, top.id, top.count, DELAYS.move)
            end
        else
            if Self.Direction() ~= gameSpot.dir.default then
                Self.Turn(gameSpot.dir.default)
            else
                log("[Casino->stop]: Script stopped.")
                stopCasino = false
                startCasino = false
            end           
        end  
    else    
        Self.UseItemFromEquipment(SLOT_BACKPACK, DELAYS.open)
    end    
end --> stop casino script.    

function initialize()
    if initProc == 3 or not startCasino then return true end
    if initProc == 0 then
        local spot = getGameSpot()
        if not spot then
            return log("[Casino->initialize]: Cannot find game spot, check for depot and counter ids or untrash pos.", 1000)
        end 
        if Container.Amount() > 0 then
            local conts = Container.getItems()
            if table.count(conts) > 0 then
                for i, cont in ipairs(conts) do
                    Container.Close(cont.index, 0)
                end
            end        
            openTime = 0
        else    
            initProc = 1
        end
    end    
    if initProc == 1 then
        local cont = Container.getInfo(0)
        local contAmount = Container.Amount() 
        if table.count(cont) > 0 and cont.id == IDS.backpack and contAmount == 1 then
            initProc = 2
        else
            if contAmount == 0 then
                local bp = Self.Backpack()
                if bp.id == IDS.backpack then
                    if os.clock() - openTime > (DELAYS.open/1000) then
                        Self.UseItemFromEquipment(SLOT_BACKPACK, 0)
                        openTime = os.clock()
                    end    
                else
                    return log("[Casino->initialize]: invalid id for main backpack. Should be " .. IDS.backpack .. " while current is " .. bp.id .. ".", 1000)
                end     
            else
                initProc = 0
            end    
        end
    end            
    if initProc == 2 then
        if Container.Amount() == 0 then 
            initProc = 0
            return
        end    
        local top = Map.GetTopMoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z)
        if table.find(IDS.dice, top.id) then
            initProc = 3
            startCasino = false
            stopCasino = false
            log("[Casino->initialize]: Succesfuly started casino.")
        elseif not table.find(IDS.depot, top.id) then
            if top.id == IDS.gold or top.id == IDS.platinum or top.id == IDS.crystal then
                Map.MoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z, top.id, top.count, DELAYS.move)
            else
                Map.MoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, gameSpot.self.x, gameSpot.self.y, gameSpot.self.z, top.id, top.count, DELAYS.move)
            end    
        else
            local dice = Container.FindItem(IDS.dice, 0)
            if table.count(dice) > 1 then
                Self.DropItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, dice.id, 1, DELAYS.payout) 
            else
                local nextBp = Container.FindItem(IDS.backpack, 0)
                if table.count(nextBp) > 1 then
                    Container.Open(0, IDS.backpack, false, DELAYS.open)
                else    
                    return log("[Casino->initialize]: Cannot find dice item inside backpack " .. IDS.backpack .. ".", 1000)
                end    
            end 
        end          
    end    
end --> start casino script. 

function game()
    if initProc ~= 3 then return end
    local player = getGamePlayer()
    if table.count(player) > 1 then
        
        if  Self.Direction() ~= gameSpot.dir.turn then
            Self.Turn(gameSpot.dir.turn)
        end  

        if not payout and not acceptBet and not pickupCash then
            if lastPlayer.name ~= player.name then
                say(MESSAGE.welcome, 2000)
                lastPlayer = player
            end
        end        
    
        if payout then
            if payoutCash then
                local currCash = Self.ItemCount(GAME.coin)
                if currCash < lastMyCash then
                    log("[Casino->game]: player: " .. lastPlayer.name .. ", payout->dropped: " .. (lastMyCash - currCash))
                    balanceUpdate(lastPlayer.name, balanceGet(lastPlayer.name) - (lastMyCash - currCash))
                    payoutCash = false
                    if balanceGet(lastPlayer.name) <= 0 then
                        say(MESSAGE.payout .. " " .. payoutText .. GAME.cash_shortcut, 100)
                        log("[Casino->game]: player: " .. lastPlayer.name .. ", " .. MESSAGE.payout .. " " .. payoutText .. GAME.cash_shortcut)
                        payoutText = ""
                        payout = false
                        payoutWaitForPlayerTakeCash = true
                    end 
                    if player.name ~= lastPlayer.name then
                        payout = false
                    end   
                end
                if os.clock() - payoutCashTime > (DELAYS.payout/1000) then
                    payoutCash = false
                end    
            else    
                local playerCash = balanceGet(lastPlayer.name)
                if playerCash < 1 then
                    payout = false
                else
                    if Self.ItemCount(GAME.coin) > 0 then
                        if Map.GetTopMoveItem(gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z).id ~= GAME.coin then
                            lastMyCash = Self.ItemCount(GAME.coin)
                            payoutCash = true
                            payoutCashTime = os.clock()
                            payoutContainerBackTries = 0
                            Self.DropItem(gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z, GAME.coin, playerCash, 0)
                        end    
                    else
                        Container.Back(0, DELAYS.open)
                        payoutContainerBackTries = payoutContainerBackTries + 1
                        if payoutContainerBackTries > 200 then -- each tries take ~50ms so 10s
                            log("[Casino->game]: player: " .. lastPlayer.name .. ", " .. "not enough cash for payout.")
                            say(MESSAGE.low_cash, 100)
                            payout = false
                            playerCash = false
                            payoutWaitForPlayerTakeCash = true
                        end    
                    end    
                end
            end        
        end   

        if acceptBet then
            local dice = Map.GetTopMoveItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z) 
            if not table.find(IDS.dice, dice.id) then
                untrash(true)
            else
                useDice = true
                Map.UseItem(gameSpot.depot.x, gameSpot.depot.y, gameSpot.depot.z, 1, 2, DELAYS.dice)
            end    
        end    
        
        if pickupCash then    
            local currCash = Self.ItemCount(GAME.coin)
            if currCash > lastMyCash then
               balanceUpdate(lastPlayer.name, balanceGet(lastPlayer.name) + (currCash - lastMyCash))
               say(MESSAGE.balance .. " " .. balanceGet(lastPlayer.name), 2000)
               pickupCash = false
               log("[Casino->game]: player: " .. lastPlayer.name .. ", pickup: " .. (currCash - lastMyCash)) 
            end
            if pickupCash and os.clock() - pickupCashTime > (DELAYS.pickup/1000) then
                pickupCash = false
            end
        end    

        local top = Map.GetTopMoveItem(gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z)
        if top.id == GAME.coin and not payoutWaitForPlayerTakeCash and not payout and not acceptBet and not pickupCash then
            if not pickupCash and not acceptBet then
                local toSlot = getPickupSlot()
                if toSlot == -1 then
                    -- open next container
                    local nextBp = Container.FindItem(IDS.backpack, 0)
                    if table.count(nextBp) > 1 then
                        Container.Open(0, IDS.backpack, false, DELAYS.open)
                    else    
                        log("[Casino->game]: player: " .. lastPlayer.name .. ", backpack for cash is full.", 1000)
                        say(MESSAGE.full_bp, 6000)
                    end    
                else        
                    pickupCash = true
                    pickupCashTime = os.clock()
                    lastMyCash = Self.ItemCount(GAME.coin)
                    Self.PickupItem(gameSpot.counter.x, gameSpot.counter.y, gameSpot.counter.z, GAME.coin, top.count, 0, toSlot, 0)
                end    
            end
        else        
            if top.id ~= GAME.coin then
                payoutWaitForPlayerTakeCash = false
            end    
        end

    else
        if Self.Direction() ~= gameSpot.dir.default then
            Self.Turn(gameSpot.dir.default)        
        end
        advert()   
    end    
end --> actions related to game like: accept cash, use dice, turn to player, payout etc.    

function proxy(messages) 
    for i, msg in ipairs(messages) do 
        if msg.channel == 0 and table.find(GAME.dice_mode, msg.mode) and useDice and not payout and initProc == 3 then
            local me = Self.Name()
            if msg.speaker == me then
                local nr = string.match(msg.message, me .. " rolled a (.+)") 
                if nr ~= nil then
                    useDice = false
                    return readDiceResult(tonumber(nr))
                end    
            end       
        elseif msg.channel == 0 and msg.speaker == Self.Name() then
            msg.message = string.lower(msg.message)
            if table.find(COMMANDS.start, msg.message) and initProc == 0 then
                startCasino = true
            elseif table.find(COMMANDS.stop, msg.message) then
                stopCasino = true
            end       
        elseif msg.speaker == lastPlayer.name and msg.channel == 0 and not acceptBet and not payout and not pickupCash and initProc == 3 then
            local player = getGamePlayer()
            if table.count(player) > 1 and player.name == msg.speaker then 
                msg.message = string.lower(msg.message)
                if table.find(SIGNAL.high, stringNoNumbersAndSpaces(msg.message)) then
                    payoutWaitForPlayerTakeCash = false
                    local number = tonumber(string.match(msg.message, '%d+'))
                    return acceptPlayerBet(number, "high")
                elseif table.find(SIGNAL.low, stringNoNumbersAndSpaces(msg.message)) then
                    payoutWaitForPlayerTakeCash = false
                    local number = tonumber(string.match(msg.message, '%d+'))
                    return acceptPlayerBet(number, "low")
                elseif table.find(SIGNAL.info, msg.message) then
                    return say(MESSAGE.info, 3000)
                elseif table.find(SIGNAL.balance, msg.message) then
                    return say(MESSAGE.balance .. " " .. balanceGet(lastPlayer.name), 500)
                elseif table.find(SIGNAL.payout, msg.message) then
                    local bal = balanceGet(lastPlayer.name)    
                    if bal > 0 then
                        payout = true
                        payoutText = bal
                    end    
                end
            end
        end    
    end 
end 
Proxy.New("proxy") --> Default messages signals

Module.New("Casino Depot", function()
    if not Self.isConnected() then 
        resetParams()
        startCasino = true
        return 
    end
    stop()
    untrash()
    initialize()    
    game()
    antiidle()
end) --> run function in loop