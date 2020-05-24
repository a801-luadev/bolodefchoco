translations = {
    {"RO",
    "Sari",
    "Dash",
    "<p align='center'><b>Cum să joci ninjaMouse!</b></p>\nTermină mapa <b>cât mai rapid posibil</b> folosindu-ți puterile de ninja!\nPentru a folosi puterile, <b>apasă de două ori pe săgeți</b> în orice direcție (stânga, dreapta, sus) și vei face un dash în acea direcție (în afară de jos).\nAi un timp de reîncărcare de 1 secundă la dash-urile pentru stânga și dreapta și un timp de reîncărcare de 3 secunde la dash-ul pentru sus (le poți vedea în colțul ecranului).\nDe asemenea, când apeși pe <b>Spațiu</b> vei fi teleportat înapoi în timp, unde erai acum 3 secunde.\nDacă ai terminat mapa, numele tău va avea această <b><font color='#BABD2F'>culoare</font></b>. Dacă ai terminat mapa cel mai rapid, numele tău va avea această <b><font color='#EB1D51'>culoare</font></b>.\nDacă vei vrea să recitești asta, apasă <b>H</b>.\nPentru a accesa setările, apasă <b>G</b>.",
    "<font size='8'><b>Instrucțiuni: </b>Dash/Sari - apasă de două ori orice săgeată. Poți da dash la fiecare 1s și sări la fiecare 3s. Apasă H pentru a înlătura.</font>",
	"Ultimul timp",
	"Cel mai bun timp",
	"CEL MAI RAPID NINJA",
	"Nimeni nu a terminat mapa încă.",
	"<p align='center'>Apasă <b>H</b> pentru ajutor.</p>",
    "Rewind",
    "<font color='#53ba58'>Da</font>", -- 12
    "<font color='#ba5353'>Nu</font>",  -- 13
	"Activezi particulele de rewind", -- 14
	"Activezi particulele de dash", -- 15
    "Activezi panourile de timp", -- 16
    "Opțiuni", -- 17
    " a inițiat un vot pentru a trece la următoarea mapă. Scrie !yes pentru a vota pozitiv."
    },
    {"EN",
	 "Jump",
	 "Dash",
	 "<p align='center'><b>How to play ninjaMouse!</b></p>\nFinish the map <b>as fast as possible</b> by using your ninja powers!\nTo use the powers, <b>double-tap the arrow keys</b> in any direction (left, right, up) and you will dash in the desired direction (except for down).\nYou have a 1 second cooldown on left and right dashes and a 3 second cooldown on up dashes (you can see them in the corner of your screen).\nAlso, if you press on <b>Space</b> you will be teleported back in time where you were 3 seconds ago.\nIf you finished the map, your name will have this <b><font color='#BABD2F'>color</font></b>. If you finished with the fastest time, your name will be this <b><font color='#EB1D51'>color</font></b>.\nIf you want to read this again at any time, press <b>H</b>.\nTo access the settings, press <b>G</b>.",
	 "<font size='10'><b>Instructions: </b>Dash/Jump - double tap any arrow keys. Cooldown on dash is 1s and on jump is 3s. Press H to remove this.</font>",
	 "Your last time",
	 "Your best time",
	 "FASTEST NINJA",
	 "Nobody finished the map yet.",
	 "<p align='center'>Press <b>H</b> for help.</p>",
	 "Rewind",
	 "<font color='#53ba58'>Yes</font>", --12
	 "<font color='#ba5353'>No</font>",   --13
	"Enable rewind particles", --14
	"Enable dash/jump particles", --15
    "Enable time panels", --16
    "Options", --17
    " started a vote to skip the current map. Type !yes to vote positively." --18
    }
}

n = 2
mapcode = {"@7725753", "@7726015", "@7726744"}
spawnpos = {{130, 738}}
currentspawnpos = {0, 0}

--CONSTANTS
MAPTIME = 3600
DASHCOOLDOWN = 1000
JUMPCOOLDOWN = 3000
REWINDCOOLDONW = 10000

function randomMap()
    choice = math.random(1, n)
    --currentspawnpos = {spawnpos[choice][1], spawnpos[choice][2]}
    currentspawnpos = {0, 0}
    return mapcode[choice]
end

function randomFlip()
    number = math.random()
    if number < 0.4 then
        return true
    else
        return false
    end
end

tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.setAutoMapFlipMode(randomFlip())
tfm.exec.newGame(randomMap())
tfm.exec.disablePhysicalConsumables(true)
system.disableChatCommandDisplay()
tfm.exec.setGameTime(MAPTIME, true)
ui.setShamanName("Welcome to ninjaMouse!")

keys = {32, 37, 39, 38, 65, 68, 71, 72, 84, 87}
besttime = 99999
globalplayercount = 0
lastkeypressed = {}
lastkeypressedtime = {}
lastdashusedtime = {}
lastjumpusedtime = {}
lastkeypressedtimeleft = {}
lastkeypressedtimeright = {}
lastkeypressedtimejump = {}
lastrewindused = {}
rewindpos = {}
-- SCORE OF PLAYER
fastestplayer = -1
playerbesttime = {}
playerlasttime = {}
playerlanguage = {}
playeroptions = {}
playerpreferences = {}
playerloaded = {}
-- TRUE/FALSE
playerfinished = {}
playerCount = 0
playerWon = 0
globalid = 0
mapfinished = false
skipvotes = 0
admin = ""
customroom = false

function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)
    local id = tfm.get.room.playerList[playerName].id
    if playerloaded[id] == false then
        return
    end
    -- DOUBLE PRESS --
    if os.time() - lastdashusedtime[id] > DASHCOOLDOWN then
        dashUsed = false
        if os.time() - lastkeypressedtimeright[id] < 200 and tfm.get.room.playerList[playerName].isDead == false then
            -- DASHES textarea = 2--
            if keyCode == 39 or keyCode == 68  then
                lastkeypressedtimeright[id] = os.time()
                --if lastkeypressed[id] == keyCode then
                --tfm.exec.displayParticle(35, xPlayerPosition + 60, yPlayerPosition, 0, 0, 0, 0, nil)
                if playerpreferences[id][2] == true then
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), math.random(), 0, 0, nil)
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), -math.random(), 0, 0, nil)
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), -math.random(), 0, 0, nil)
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), -math.random(), 0, 0, nil)
                end
                tfm.exec.movePlayer(playerName, 0, 0, true, 150, 0, false)
                dashUsed = true;
                --end
            end
        end
        if os.time() - lastkeypressedtimeleft[id] < 200 and tfm.get.room.playerList[playerName].isDead == false then
            if keyCode == 37 or keyCode == 65 then
                lastkeypressedtimeleft[id] = os.time()
                --if lastkeypressed[id] == keyCode then
                --tfm.exec.displayParticle(35, xPlayerPosition - 60, yPlayerPosition, 0, 0, 0, 0, nil)
                if playerpreferences[id][2] == true then
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), math.random(), 0, 0, nil)
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), -math.random(), 0, 0, nil)
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), -math.random(), 0, 0, nil)
                    tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), -math.random(), 0, 0, nil)
                end
                tfm.exec.movePlayer(playerName, 0, 0, true, -150, 0, false)
                dashUsed = true;
                --end
            end
        end

        if dashUsed == true then
            -- tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), math.random(), 0, 0, nil)
            -- tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), -math.random(), 0, 0, nil)
            -- tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), -math.random(), 0, 0, nil)
            -- tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), math.random(), 0, 0, nil)
            lastdashusedtime[id] = os.time()
            ui.removeTextArea(2, playerName)
            ui.addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, 745, 330, 46, 23, 0xff5151, 0xaf3131, 0.8, true)
        end
    end
    if os.time() - lastkeypressedtimejump[id] < 200 and tfm.get.room.playerList[playerName].isDead == false then
        -- JUMP textarea = 1--
        if (keyCode == 38 or keyCode == 87) and os.time() - lastjumpusedtime[id] > JUMPCOOLDOWN then
            lastkeypressedtimejump[id] = os.time()
            --if lastkeypressed[id] == keyCode then
            tfm.exec.movePlayer(playerName, 0, 0, true, 0, -60, false)
            if playerpreferences[id][2] == true then
                tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), -math.random()*4, 0, 0, nil)
                tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), -math.random()*3, 0, 0, nil)
                tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, -math.random(), -math.random()*2, 0, 0, nil)
                tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, math.random(), -math.random()*2, 0, 0, nil)
            end
            lastjumpusedtime[id] = os.time()
            ui.removeTextArea(1, playerName)
            ui.addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, 745, 365, 46, 23, 0xff5151, 0xaf3131, 0.8, true)
            --end
        end
    end

    if os.time() - lastrewindused[id] > REWINDCOOLDONW and tfm.get.room.playerList[playerName].isDead == false then
        if keyCode == 32 then
            lastrewindused[id] = os.time()
            tfm.exec.displayParticle(36, xPlayerPosition, yPlayerPosition, 0, 0, 0, 0, nil)
            tfm.exec.movePlayer(playerName, rewindpos[id][1][1], rewindpos[id][1][2], false, 0, 0, 0)
            if rewindpos[id][1][3] == false then
                tfm.exec.removeCheese(playerName)
            end
            ui.removeTextArea(7, playerName)
            ui.addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, 670, 365, 63, 23, 0xff5151, 0xaf3131, 0.8, true)
        end
    end
    -- OPEN GUIDE
    if keyCode == 72 then
        ui.addPopup(1, 0, translations[playerlanguage[id]][4], playerName, 212, 92, 368, true)
    end

    -- HIDE/SHOW OPTIONS PANEL
    if keyCode == 71 then
        if playeroptions[id] == false then
            ui.addTextArea(9, remakeOptions(playerName), playerName, 283, 165, 233, 95, 0x324650, 0x000000, 1, true)
            playeroptions[id] = true
        else
            ui.removeTextArea(9, playerName)
            playeroptions[id] = false
        end
    end

    --lastkeypressed[id] = keyCode
    lastkeypressedtime[id] = os.time()
    if keyCode == 39 or keyCode == 68  then
        lastkeypressedtimeright[id] = os.time()
    end

    if keyCode == 37 or keyCode == 65 then
        lastkeypressedtimeleft[id] = os.time()
    end

    if keyCode == 38 or keyCode == 87 then
        lastkeypressedtimejump[id] = os.time()
    end
end

-- UI UPDATER & PLAYER RESPAWNER & REWINDER

time = 0

function eventPlayerDied(playerName)
    local id = tfm.get.room.playerList[playerName].id
    rewindpos[id] = {{0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}}
end

function eventLoop(timeRemaining, timeRemaining)
    time = time + 0.5
    print(time)

    if time == MAPTIME then
        print("Attempting to reset.")
        tfm.exec.setAutoMapFlipMode(randomFlip())
        tfm.exec.newGame(randomMap())
        resetAll()
    else
        for playerName in pairs(tfm.get.room.playerList) do
            local id = tfm.get.room.playerList[playerName].id
            if tfm.get.room.playerList[playerName].isDead == true then
                tfm.exec.respawnPlayer(playerName)
                lastrewindused[id] = os.time() - 6000
                lastjumpusedtime[id] = os.time() - JUMPCOOLDOWN
                lastdashusedtime[id] = os.time() - DASHCOOLDOWN
                ui.removeTextArea(1, playerName)
                ui.addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, 745, 365, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
                ui.removeTextArea(2, playerName)
                ui.addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, 745, 330, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
            else
                --BUG, EXECUTES EVEN WHEN DEAD BECAUSE OF SYNC ISSUES
                playerx = tfm.get.room.playerList[playerName].x
                playery = tfm.get.room.playerList[playerName].y
                table.remove(rewindpos[id], 1)
                table.insert(rewindpos[id], {playerx, playery, tfm.get.room.playerList[playerName].hasCheese})
                rewindx = rewindpos[id][1][1]
                rewindy = rewindpos[id][1][2]
                --print(rewindx.." "..rewindy.." "..playerName)
                --print(currentspawnpos[1])
                if playerpreferences[id][1] == true then
                    tfm.exec.displayParticle(13, rewindx, rewindy, 0, 0, 0, 0, playerName)
                end
            end
            if os.time() - lastjumpusedtime[id] > JUMPCOOLDOWN then
                ui.removeTextArea(1, playerName)
                ui.addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, 745, 365, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
            end
            if os.time() - lastdashusedtime[id] > DASHCOOLDOWN then
                ui.removeTextArea(2, playerName)
                ui.addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, 745, 330, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
            end

            if os.time() - lastrewindused[id] > REWINDCOOLDONW then
                ui.removeTextArea(7, playerName)
                ui.addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, 670, 365, 63, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
            else
                ui.removeTextArea(7, playerName)
                ui.addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, 670, 365, 63, 23, 0xff5151, 0xaf3131, 0.8, true)
            end
        end
    end
end

-- PLAYER COLOR SETTER
function eventPlayerRespawn(playerName)
    id = tfm.get.room.playerList[playerName].id
    if playerloaded[id] == false then
        tfm.exec.freezePlayer(playerName, true)
    end
    local color = 0x40a594
    -- IF BEST TIME
    if playerName == fastestplayer then
        color = 0xEB1D51
    -- ELSEIF FINISHED
    elseif playerfinished[id] == true then
        color = 0xBABD2F
    end
    tfm.exec.setNameColor(playerName, color)
end

-- PLAYER WIN
function eventPlayerWon(playerName, timeElapsed, timeElapsedSinceRespawn)
    id = tfm.get.room.playerList[playerName].id
    if playerfinished[id] == false then
        playerWon = playerWon + 1
    end
    tfm.exec.setPlayerScore(playerName, 1, true)
    -- RESET TIMERS
    playerlasttime[id] = timeElapsedSinceRespawn
    playerfinished[id] = true
    lastjumpusedtime[id] = 0
    lastdashusedtime[id] = 0
    playerbesttime[id] = math.min(playerbesttime[id], timeElapsedSinceRespawn)
    -- UPDATE "YOUR TIME"
    ui.updateTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": "..(timeElapsedSinceRespawn/100).."s", playerName)
    ui.updateTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": "..(playerbesttime[id]/100).."s", playerName)
    if timeElapsedSinceRespawn < besttime then
        -- CHECK IF FASTEST PLAYER IS IN ROOM
        for playerName in pairs(tfm.get.room.playerList) do
            if playerName == fastestplayer then
                tfm.exec.setNameColor(fastestplayer, 0xBABD2F)
            end
        end
        besttime = timeElapsedSinceRespawn
        fastestplayer = playerName
        ui.updateTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font>\n<font face='Lucida Console' color='#EB1D51'>"..playerName.."</font> <font face='Lucida Console' color='#ffffff'>- "..(timeElapsedSinceRespawn/100).."s</font></p>", nil)
    end
    -- if playerWon == playerCount and MAPTIME - time > 20 and mapfinished == false then
    --     print("Resetting game, all players finished.")
    --     print("pc = "..playerCount.." pw = "..playerWon)
    --     tfm.exec.setGameTime(20, true)
    --     time = MAPTIME - 20
    --     mapfinished = true
    -- end

end

function eventPlayerLeft(playerName)
    playerCount = playerCount - 1
    -- if playerWon == playerCount and MAPTIME - time > 20 and mapfinished == false then
    --     print("Resetting game because player left and all players in the room finished.")
    --     tfm.exec.setGameTime(20, true)
    --     time = MAPTIME - 20
    --     mapfinished = true
    -- end
end

function pitagora(x1,y1,x2,y2,r)
    local x=x2-x1
    local y=y2-y1
    local r=r+r
    return x*x+y*y<r*r
end

function playerId(playerName)
    return tfm.get.room.playerList[playerName].id
end

-- CALL THIS WHEN A PLAYER FIRST JOINS A ROOM
function initPlayer(playerName)
    globalplayercount = globalplayercount + 1
    if globalplayercount == 1 then
        admin = playerName
    end
    playerCount = playerCount + 1
    globalid = tfm.get.room.playerList[playerName].id
    tfm.exec.setPlayerScore(playerName, 0)
    print(playerName)
    table.insert(lastkeypressed, globalid, 0)
    table.insert(lastrewindused, globalid, 0)
    table.insert(lastkeypressedtime, globalid, 0)
    table.insert(lastdashusedtime, globalid, 0)
    table.insert(lastjumpusedtime, globalid, 0)
    table.insert(lastkeypressedtimeleft, globalid, 0)
    table.insert(lastkeypressedtimeright, globalid, 0)
    table.insert(lastkeypressedtimejump, globalid, 0)
    table.insert(playerbesttime, globalid, 999999)
    table.insert(playerlasttime, globalid, 999999)
    table.insert(playerfinished, globalid, false)
    table.insert(playerlanguage, globalid, 2)
    table.insert(playerloaded, globalid, false)
    table.insert(playeroptions, globalid, false)
    table.insert(playerpreferences, globalid, {false, true, true})
    --table.insert()
    table.insert(rewindpos, globalid, {{0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}})
    tfm.exec.setNameColor(playerName, 0x40a594)
    for index, key in pairs(keys) do
        --print("assigning "..playerName.." key "..key)
        system.bindKeyboard(playerName, key, true, true)
    end
    -- tfm.exec.freezePlayer(playerName, true)
    -- ui.addTextArea(8, "\n<p align='center'><b><a href=\"event:#clear,EN\">English</a></b>\n<b><a href=\"event:#clear,RO\">Română</a></b></p>", playerName, 356, 173, 88, 53, 0x324650, 0x000000, 0.8, true)
    chooselang(playerName)
end

function chooselang(playerName)
    local id = tfm.get.room.playerList[playerName].id
    local community = tfm.get.room.playerList[playerName].community
    if community == "ro" then
        playerlanguage[id] = 1
    else
        playerlanguage[id] = 2
    end
    playerloaded[id] = true
    -- tfm.exec.freezePlayer(playerName, false)
    -- ui.removeTextArea(8, playerName)
    --print(playerName.." selected "..eventName)
    ui.addTextArea(6, translations[playerlanguage[id]][10], playerName, 267, 382, 265, 18, 0x324650, 0x000000, 0, true)
    ui.addPopup(1, 0, translations[playerlanguage[id]][4], playerName, 212, 92, 368, true)
    --ui.addTextArea(0, translations[playerlanguage[id]][5], playerName, 551, 343, 241, 46, 0x454545, 0x000000, 0.8, true)
    -- ui.addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, 745, 365, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
    -- ui.addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, 745, 330, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
    -- ui.addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, 670, 365, 63, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
    ui.addTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": N/A", playerName, 10, 80, 200, 21, 0xffffff, 0x000000, 0, true)
    ui.addTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": N/A", playerName, 10, 65, 200, 21, 0xffffff, 0x000000, 0, true)
    if fastestplayer == -1 then
        ui.addTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font> \n<font face='Lucida Console' color='#EB1D51'>"..translations[playerlanguage[tfm.get.room.playerList[playerName].id]][9].."</font></p>", playerName, 10, 28, 230, 33, 0x111111, 0x000000, 0.3, true)
    else
        ui.addTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font>\n<font face='Lucida Console' color='#EB1D51'>"..fastestplayer.."</font> <font face='Lucida Console' color='#ffffff'>- "..(besttime/100).."s</font></p>", playerName, 10, 28, 230, 33, 0x111111, 0x000000, 0.3, true)
    end
end

function eventTextAreaCallback(textAreaId, playerName, eventName)
    local id = tfm.get.room.playerList[playerName].id
    --unused
    if textAreaId == 8 then
        if eventName == "RO" then
            playerlanguage[id] = 1
        elseif eventName == "EN" then
            playerlanguage[id] = 2
        end
        playerloaded[id] = true
        tfm.exec.freezePlayer(playerName, false)
        ui.removeTextArea(8, playerName)
        print(playerName.." selected "..eventName)
        ui.addTextArea(6, translations[playerlanguage[id]][10], playerName, 267, 382, 265, 18, 0x324650, 0x000000, 0, true)
        ui.addPopup(1, 0, translations[playerlanguage[id]][4], playerName, 212, 92, 368, true)
        --ui.addTextArea(0, translations[playerlanguage[id]][5], playerName, 551, 343, 241, 46, 0x454545, 0x000000, 0.8, true)
        -- ui.addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, 745, 365, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
        -- ui.addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, 745, 330, 46, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
        -- ui.addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, 670, 365, 63, 23, 0x5bff5b, 0x3ebc3e, 0.8, true)
        ui.addTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": N/A", playerName, 10, 80, 200, 21, 0xffffff, 0x000000, 0, true)
        ui.addTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": N/A", playerName, 10, 65, 200, 21, 0xffffff, 0x000000, 0, true)
        if fastestplayer == -1 then
            ui.addTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font> \n<font face='Lucida Console' color='#EB1D51'>"..translations[playerlanguage[tfm.get.room.playerList[playerName].id]][9].."</font></p>", playerName, 10, 28, 230, 33, 0x111111, 0x000000, 0.3, true)
        else
            ui.addTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font>\n<font face='Lucida Console' color='#EB1D51'>"..fastestplayer.."</font> <font face='Lucida Console' color='#ffffff'>- "..(besttime/100).."s</font></p>", playerName, 10, 28, 230, 33, 0x111111, 0x000000, 0.3, true)
        end
    end
    --unused
    if textAreaId == 9 then
        if eventName == "CloseOptions" then
            playeroptions[id] = false
            ui.removeTextArea(9, playerName)
            print(playerName.." closed options.")
        end
        if eventName == "ToggleRewindPart" then
            if playerpreferences[id][1] == true then
                playerpreferences[id][1] = false
            else
                playerpreferences[id][1] = true
            end

            print(playerName.." toggled rewind.")
        end
        if eventName == "ToggleDashPart" then
            if playerpreferences[id][2] == true then
                playerpreferences[id][2] = false
            else
                playerpreferences[id][2] = true
            end

            print(playerName.." toggled dash.")
        end
        if eventName == "ToggleTimePanels" then
            if playerpreferences[id][3] == true then
                playerpreferences[id][3] = false
                ui.removeTextArea(5, playerName)
                ui.removeTextArea(4, playerName)
                ui.removeTextArea(3, playerName)
            else
                playerpreferences[id][3] = true
                ui.addTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": N/A", playerName, 10, 80, 200, 21, 0xffffff, 0x000000, 0, true)
                ui.addTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": N/A", playerName, 10, 65, 200, 21, 0xffffff, 0x000000, 0, true)
                if playerfinished[id] == true then
                    ui.updateTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": "..(playerlasttime[id]/100).."s", playerName)
                    ui.updateTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": "..(playerbesttime[id]/100).."s", playerName)
                end
                if fastestplayer == -1 then
                    ui.addTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font> \n<font face='Lucida Console' color='#EB1D51'>"..translations[playerlanguage[id]][9].."</font></p>", playerName, 10, 28, 230, 33, 0x111111, 0x000000, 0.3, true)
                else
                    ui.addTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font>\n<font face='Lucida Console' color='#EB1D51'>"..fastestplayer.."</font> <font face='Lucida Console' color='#ffffff'>- "..(besttime/100).."s</font></p>", playerName, 10, 28, 230, 33, 0x111111, 0x000000, 0.3, true)
                end
            end

            print(playerName.." toggled time panels.")
        end

        ui.updateTextArea(9, remakeOptions(playerName), playerName)
    end
end

function remakeOptions(playerName)
    local id = tfm.get.room.playerList[playerName].id
    toggles = {translations[playerlanguage[id]][12], translations[playerlanguage[id]][12], translations[playerlanguage[id]][12]}
    if playerpreferences[id][1] == false then
        toggles[1] = translations[playerlanguage[id]][13]
    end
    if playerpreferences[id][2] == false then
        toggles[2] = translations[playerlanguage[id]][13]
    end
    if playerpreferences[id][3] == false then
        toggles[3] = translations[playerlanguage[id]][13]
    end
    return "<p align='center'><b>"..translations[playerlanguage[id]][17].."</b>\n\n<a href=\"event:ToggleRewindPart\">"..translations[playerlanguage[id]][14].."?</a> "..toggles[1].."\n<a href=\"event:ToggleDashPart\">"..translations[playerlanguage[id]][15].."?</a> "..toggles[2].."\n<a href=\"event:ToggleTimePanels\">"..translations[playerlanguage[id]][16].."?</a> "..toggles[3].."\n\n<a href=\"event:CloseOptions\"><font color='#ba5353'>Close</font></a>"

end

-- WHEN SOMEBODY JOINS
function eventNewPlayer(playerName)
    initPlayer(playerName)
end

-- INIT ALL EXISTING PLAYERS
for playerName in pairs(tfm.get.room.playerList) do
    initPlayer(playerName)
end

function resetAll()
    time = 0
    rewindpos = {}
    skipvotes = 0
    for playerName in pairs(tfm.get.room.playerList) do
        local id = tfm.get.room.playerList[playerName].id
        print("Resetting stats")
        tfm.exec.setPlayerScore(playerName, 0)
        if playerloaded[id] == false then
            tfm.exec.freezePlayer(playerName, true)
        end
        lastrewindused[id] = os.time() - 6000
        lastkeypressed[id] = 0
        lastkeypressedtime[id] = os.time() - DASHCOOLDOWN
        lastkeypressedtimeleft[id] = 0
        lastkeypressedtimeright[id] = 0
        lastkeypressedtimejump[id] = 0
        lastdashusedtime[id] = 0
        lastjumpusedtime[id] = os.time() - JUMPCOOLDOWN
        playerbesttime[id] = 999999
        playerfinished[id] = false
        table.insert(rewindpos, id, {{currentspawnpos[1], currentspawnpos[2]}, {currentspawnpos[1], currentspawnpos[2]}, {currentspawnpos[1], currentspawnpos[2]}, {currentspawnpos[1], currentspawnpos[2]}, {currentspawnpos[1], currentspawnpos[2]}, {currentspawnpos[1], currentspawnpos[2]}})
        --playertimeoptions[id] = false
        fastestplayer = -1
        besttime = 99999
        playerWon = 0
        tfm.exec.setNameColor(playerName, 0x40a594)
        mapfinished = false
        -- UPDATE THE TEXT
        if playerpreferences[id][3] == true then
            ui.updateTextArea(3, "<p align='center'><font face='Lucida Console' color='#ffffff'><b>"..translations[playerlanguage[id]][8]..": </b> </font> \n<font face='Lucida Console' color='#EB1D51'>"..translations[playerlanguage[id]][9].."</font></p>", playerName)
            ui.updateTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": N/A", playerName)
            ui.updateTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": N/A", playerName)
        end
    end
    tfm.exec.setGameTime(MAPTIME, true)
    ui.setShamanName("Welcome to ninjaMouse!")
end

-- DEBUGGING
function aCap(pn)
    local n = string.lower(pn)
    for name,attr in pairs(tfm.get.room.playerList) do
        if string.lower(name):find(n) then
            return name
        end
    end
end

function eventChatCommand(playerName, message)
    local arg = {}
    for argument in message:gmatch("[^%s]+") do
        table.insert(arg,string.lower(argument))
    end

    -- if arg[1]=="p" then
    --     tfm.exec.displayParticle(arg[2], tfm.get.room.playerList[playerName].x, tfm.get.room.playerList[playerName].y, 0, 0, 0, 0, nil)
    -- end

    -- if arg[1]=="r" then
    --     tfm.exec.newGame(mapcode)
    --     resetAll()
    -- end

    if arg[1]=="m" and customroom == true and admin == playerName then
        tfm.exec.newGame(arg[2])
        resetAll()
    end

    if arg[1]=="m" then
        tfm.exec.newGame(arg[2])
        resetAll()
    end

    if arg[1] == "pw" and arg[2] and playerName == admin then
        customroom = true
        --tfm.exec.setRoomPassword(arg[2])
        print("Password: "..arg[2])
    end
end