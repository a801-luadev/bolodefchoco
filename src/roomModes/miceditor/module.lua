------------- Constants -------------
local botName = "Entibot#5692"

------------- State -------------

local lastXML = nil
local loadMapWhenBotLeaves = false
local playerData = {}
local powersEnabled = true

function initPlayerData(name)
    playerData[name] = {
        spawnPoint = nil,
        lastClick = nil,
        cooldowns = {speed = 0},
        facing = 0
    }
end

------------- Util -------------

function playerCount()
    local count = 0
    for _ in pairs(tfm.get.room.playerList) do count = count + 1 end
    return count
end

function isShaman(name)
    return tfm.get.room.playerList[name] and
               tfm.get.room.playerList[name].isShaman
end

function truthy(str)
    return str == "true" or str == "yes" or str == "1" or str == "on"
end
function falsy(str)
    return str == "false" or str == "no" or str == "0" or str == "off"
end

------------- Events -------------

function eventNewPlayer(name)
    if name == botName then
        ui.addPopup(5692, 2, "xml", botName)
    else
        initPlayerData(name)
        bindMouseAndKeyboard(name)
        tfm.exec.respawnPlayer(name)
        tfm.exec.chatMessage("<VP>Type <B>!help</B> to see commands and powers!", name)
        tfm.exec.chatMessage("<T>Feedback: <B>https://atelier801.com/topic?f=6&t=884238</B>", name)
    end
end

function eventNewGame()
    for name, data in pairs(playerData) do
        data.spawnPoint = nil
        data.lastClick = nil
    end
end

function eventPlayerDied(name) tfm.exec.respawnPlayer(name) end

function eventPlayerWon(name) tfm.exec.respawnPlayer(name) end

function eventPlayerRespawn(name)
    local data = playerData[name]
    if data.spawnPoint then
        tfm.exec.movePlayer(name, data.spawnPoint.x, data.spawnPoint.y)
        return
    end
end

function eventPlayerLeft(name)
    if loadMapWhenBotLeaves and name == botName then
        loadMapWhenBotLeaves = false
        tfm.exec.newGame(lastXML)
    end
    playerData[name] = nil
end

function eventChatCommand(name, cmd)
    if cmd == "restart" then
        if lastXML then tfm.exec.newGame(lastXML) end
    elseif cmd == "help" then
        tfm.exec.chatMessage( --
        "<VP>Powers:\n" .. --
        "<CEP>" .. --
        "\t<B>M</B> - mort\n" .. --
        "\t<B>SHIFT</B> - speed\n" .. --
        "\t<B>SPACE</B> - fly\n" .. --
        "\t<B>CLICK</B> - teleport\n" .. --
            "\t<B>DOUBLE CLICK</B> - set spawnpoint", name)
        tfm.exec.chatMessage( --
        "<VP>Commands:\n" .. --
        "<CEP>" .. --
        "\t!shaman <yes/no>\n" .. --
        "\t!flip <yes/no>\n" .. --
        "\t!skills <yes/no>\n" .. --
        "\t!powers <yes/no>\n" .. --
        "\t!np <@code>\n" .. --
        "\t!restart", name)
    elseif cmd:sub(1, 6) == "shaman" then
        local arg = cmd:sub(8):lower()
        if arg == "" then
            tfm.exec.setShaman(name)
        elseif truthy(arg) then
            tfm.exec.disableAutoShaman(false)
        elseif falsy(arg) then
            tfm.exec.disableAutoShaman(true)
        else
            tfm.exec.setShaman(arg)
        end
    elseif cmd:sub(1, 4) == "flip" then
        local arg = cmd:sub(6):lower()
        if truthy(arg) then
            tfm.exec.setAutoMapFlipMode(true)
        else
            tfm.exec.setAutoMapFlipMode(nil)
        end
    elseif cmd:sub(1, 6) == "skills" then
        local arg = cmd:sub(8):lower()
        if truthy(arg) then
            tfm.exec.disableAllShamanSkills(false)
        else
            tfm.exec.disableAllShamanSkills(true)
        end
    elseif cmd:sub(1, 6) == "powers" then
        local arg = cmd:sub(8):lower()
        powersEnabled = truthy(arg)
    elseif cmd:sub(1, 2) == "np" then
        local arg = cmd:sub(4)
        tfm.exec.newGame(arg)
    end
end

function bindMouseAndKeyboard(name)
    system.bindMouse(name, true)
    tfm.exec.bindKeyboard(name, 16, true, true)
    tfm.exec.bindKeyboard(name, 32, true, true)
    tfm.exec.bindKeyboard(name, 77, true, true)
    tfm.exec.bindKeyboard(name, 67, true, true)
    tfm.exec.bindKeyboard(name, 0, true, true)
    tfm.exec.bindKeyboard(name, 2, true, true)
end

function eventMouse(name, x, y)
    if isShaman(name) or not powersEnabled then return end
    local data = playerData[name]
    local time = os.time()
    if not data.lastClick then data.lastClick = {time = 0} end
    if time - data.lastClick.time < 500 then
        data.lastClick = {time = 0}
        data.spawnPoint = {x = data.lastClick.x or x, y = data.lastClick.y or y}
        tfm.exec.killPlayer(name)
        return
    end
    data.lastClick = {time = time, x = x, y = y}
    tfm.exec.movePlayer(name, x, y)
end

function eventKeyboard(name, keyCode, down, x, y)
    local data = playerData[name]
    local time = os.time()
    if keyCode == 0 or keyCode == 2 then -- Left/right
        data.facing = keyCode == 2
    elseif keyCode == 16 then -- Shift
        if isShaman(name) or not powersEnabled then return end
        if time - data.cooldowns.speed < 1000 then return end
        data.cooldowns.speed = time
        tfm.exec
            .movePlayer(name, 0, 0, true, data.facing and 60 or -60, 0, true)
    elseif keyCode == 32 then -- Spacebar
        if isShaman(name) or not powersEnabled then return end
        tfm.exec.movePlayer(name, 0, 0, true, 0, -50, false)
    elseif keyCode == 77 then -- M
        tfm.exec.killPlayer(name)
    end
end

function eventPopupAnswer(id, name, str)
    if id == 5692 and name == botName then
        lastXML = str
        if playerCount() == 2 then
            loadMapWhenBotLeaves = true
        else
            tfm.exec.newGame(str)
        end
    end
end

------------- Main -------------

system.disableChatCommandDisplay("np")
system.disableChatCommandDisplay("restart")
system.disableChatCommandDisplay("shaman")
system.disableChatCommandDisplay("flip")
system.disableChatCommandDisplay("skills")
system.disableChatCommandDisplay("powers")
system.disableChatCommandDisplay("help")
system.disableChatCommandDisplay("You")

for name, _ in pairs(tfm.get.room.playerList) do eventNewPlayer(name) end

tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAfkDeath(true)

tfm.exec.disableAutoShaman(true)
tfm.exec.newGame(
    [[<C><P DS="y;385"/><Z><S><S T="12" X="400" Y="497" L="800" H="200" P="0,0,0.3,0.2,0,0,0,0" o="324650" m=""/></S><D/><O/><L/></Z></C>]])
tfm.exec.disableAutoShaman(false)
