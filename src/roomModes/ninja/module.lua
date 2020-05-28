-- LOCALS FOR SPEED
local room = tfm.get.room
local displayParticle = tfm.exec.displayParticle 
local movePlayer = tfm.exec.movePlayer 
local setNameColor = tfm.exec.setNameColor
local addImage = tfm.exec.addImage
local bindKeyboard = system.bindKeyboard
local chatMessage = tfm.exec.chatMessage
local removeImage = tfm.exec.removeImage
local killPlayer = tfm.exec.killPlayer
local setPlayerScore = tfm.exec.setPlayerScore
local setMapName = ui.setMapName
local random = math.random
local addTextArea = ui.addTextArea
local removeTextArea = ui.removeTextArea

-- addImage = function() end
-- removeImage = function() end

translations = {
    {"RO",
    "<p align='center'>^\n^</p>",
    "<p align='center'>\n>></p>",
    "<p align='center'><b>Cum să joci ninjaMouse!</b></p>\nTermină harta <b>cât mai rapid posibil</b> folosindu-ți puterile de ninja!\nPentru a folosi puterile, <b>apasă de două ori pe săgeți</b> în orice direcție (stânga, dreapta, sus) și vei face un dash în acea direcție (în afară de jos).\nAi un timp de reîncărcare de 1 secundă la dash-urile pentru stânga și dreapta și un timp de reîncărcare de 3 secunde la dash-ul pentru sus (le poți vedea în colțul ecranului).\nDe asemenea, când apeși pe <b>Spațiu</b> vei fi teleportat înapoi în timp, unde erai acum 3 secunde.\nDacă ai terminat harta, numele tău va avea această <b><font color='#BABD2F'>culoare</font></b>. Dacă ai terminat harta cel mai rapid, numele tău va avea această <b><font color='#EB1D51'>culoare</font></b>.\nDacă vei vrea să recitești asta, apasă <b>H</b>.\nPentru a accesa setările, apasă <b>G</b>.",
    "<font color='#E68D43'><B>Instrucțiuni: </B></font><font color='#EDCC8D'>Dash/Sari - apasă de două ori orice săgeată. Poți da dash la fiecare 1s și sări la fiecare 3s.\nApasă H pentru mai multe detalii. Modul codat de </font><font color='#2E72CB'>Extremq#0000</font><font color='#EDCC8D'>, mape făcute de </font><font color='#2E72CB'>Railysse#0000.</font>",
	"Ultimul timp",
	"Cel mai bun timp",
	"CEL MAI RAPID NINJA",
	"Nimeni nu a terminat harta încă.",
	"<p align='center'>Apasă <b>H</b> pentru ajutor.</p>",
    "<p align='center'>\nR</p>",
    "<font color='#53ba58'>Da</font>", -- 12
    "<font color='#ba5353'>Nu</font>",  -- 13
	"Activezi particulele de rewind", -- 14
	"Activezi particulele de dash", -- 15
    "Activezi panourile de timp", -- 16
    "Opțiuni", -- 17
    " a inițiat un vot pentru a trece la următoarea mapă. Scrie !yes pentru a vota pozitiv.", -- 18
    " a terminat harta cel mai rapid!", --19
    "<font color='#CB546B'>Acest modul este în construcție. Raportează orice problemă lui Extremq#0000 sau Railysse#0000.</font>", -- 20
    "Bine ai venit pe <font color='#E68D43'>#ninja</font>! Apasă <font color='#E68D43'>H</font> pentru ajutor.", -- 21
    "Ai terminat harta! Timp: " --22
    },
    {"EN",
    "<p align='center'>^\n^</p>",
	 "<p align='center'>\n>></p>",
	 "<p align='center'><b>How to play ninjaMouse!</b></p>\nFinish the map <b>as fast as possible</b> by using your ninja powers!\nTo use the powers, <b>double-tap the arrow keys</b> in any direction (left, right, up) and you will dash in the desired direction (except for down).\nYou have a 1 second cooldown on left and right dashes and a 3 second cooldown on up dashes (you can see them in the corner of your screen).\nAlso, if you press on <b>Space</b> you will be teleported back in time where you were 3 seconds ago.\nIf you finished the map, your name will have this <b><font color='#BABD2F'>color</font></b>. If you finished with the fastest time, your name will be this <b><font color='#EB1D51'>color</font></b>.\nIf you want to read this again at any time, press <b>H</b>.\nTo access the settings, press <b>G</b>.",
     "<font color='#E68D43'><B>Instructions: </B></font><font color='#EDCC8D'>Dash/Jump - double tap any arrow keys. Cooldown on dash is 1s and on jump is 3s.\nPress H for more details. Module coded by </font><font color='#2E72CB'>Extremq#0000</font><font color='#EDCC8D'>, maps made by </font><font color='#2E72CB'>Railysse#0000.</font>",
	 "Your last time",
	 "Your best time",
	 "FASTEST NINJA",
	 "Nobody finished the map yet.",
	 "<p align='center'>Press <b>H</b> for help.</p>",
	 "<p align='center'>\nR</p>",
	 "<font color='#53ba58'>Yes</font>", --12
	 "<font color='#ba5353'>No</font>",   --13
	"Enable rewind particles", --14
	"Enable dash/jump particles", --15
    "Enable time panels", --16
    "Options", --17
    " started a vote to skip the current map. Type !yes to vote positively.", --18
    " finished the map in the fastest time!", --19
    "<font color='#CB546B'>This module is in development. Please report any bugs to Extremq#0000 or Railysse#0000.</font>", -- 20
    "Welcome to <font color='#E68D43'>#ninja</font>! Press <font color='#E68D43'>H</font> for help.", -- 21
    "You finished the time! Time: " --22
    }
}

mapcodes = {{"@7725753", "Railysse#0000"}, {"@7726015", "Railysse#0000"}, {"@7726744", "Railysse#0000"}, {"@7728063", "Railysse#0000"}}
mapsleft = {{"@7725753", "Railysse#0000"}, {"@7726015", "Railysse#0000"}, {"@7726744", "Railysse#0000"}, {"@7728063", "Railysse#0000"}}

currentspawnpos = {0, 0}
modlist = {"Extremq#0000", "Railysse#0000"}
modroom = {}
oplist = {}
lastmap = ""
lastmaparr = {"", ""}
currentmapcode = "-"
currentmapauthor = "Custom"
mapwasskipped = false
mapstarttime = 0

--CONSTANTS
MAPTIME = 6 * 60
DASHCOOLDOWN = 1 * 1000
JUMPCOOLDOWN = 3 * 1000
REWINDCOOLDONW = 10 * 1000
GRAFFITICOOLDOWN = 60 * 1000
DASH_BTN_X = 675
DASH_BTN_Y = 340
JUMP_BTN_X = 740
JUMP_BTN_Y = 340
REWIND_BTN_X = 740
REWIND_BTN_Y = 275

DASH_BTN_OFF = "172514f110f.png"
DASH_BTN_ON = "172514f2882.png"
JUMP_BTN_OFF = "172514f3ff1.png"
JUMP_BTN_ON = "172514f9089.png"
REWIND_BTN_OFF = "1725150689b.png"
REWIND_BTN_ON = "1725150800e.png"
REWIND_BTN_ACTIVE = "17257e94902.png"
HELP_IMG = "172533e3f7b.png"
CHECKPOINT_MOUSE = "17257fd86f3.png"

-- CHOOSE MAP
function randomMap()  
    -- DELETE THE CHOSEN MAP
    if #mapsleft == 0 then
        for key, value in pairs(mapcodes) do
            table.insert(mapsleft, value)
        end
    end
    local pos = random(1, #mapsleft)
    local newMap = mapsleft[pos][1]
    local newArr = {newMap, mapsleft[pos][2]}
    -- IF THE MAPS ARE THE SAME, PICK AGAIN
    if newMap == lastmap then
        table.remove(mapsleft, pos)
        pos = random(1, #mapsleft)
        newMap = mapsleft[pos][1]
        table.insert(mapsleft, lastmap)
    end
    currentmapauthor = newArr[2]
    currentmapcode = newArr[1]
    table.remove(mapsleft, pos)
    currentspawnpos = {0, 0}
    lastmap = newMap
    lastmaparr = {newArr[1], newArr[2]}
    return newMap
end

-- CHOOSE FLIP
function randomFlip()
    local number = random()
    mapstarttime = os.time()
    if number < 0.5 then
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

keys = {32, 37, 39, 38, 65, 67, 68, 71, 72, 77, 84, 87, 88}
besttime = 99999
-- TIME
globalplayercount = 0
lastkeypressed = {}
lastkeypressedtime = {}
lastdashusedtime = {}
lastjumpusedtime = {}
lastkeypressedtimeleft = {}
lastkeypressedtimeright = {}
lastkeypressedtimejump = {}
lastrewindused = {}
lastgraffititime = {}
canrewind = {}
rewindpos = {}
jumpbtnid = {}
dashbtnid = {}
rewindbtnid = {}
helpimgid = {}
mouseimgid = {}
checkpointtime = {}
jumpstate = {}
dashstate = {}
rewindstate = {}
-- SCORE OF PLAYER
fastestplayer = -1
playerbesttime = {}
playerlasttime = {}
playerlanguage = {}
playeroptions = {}
playerpreferences = {}
playerloaded = {}
playerwelcome = {}
-- TRUE/FALSE
playerfinished = {}
playerCount = 0
playerWon = 0
globalid = 0
mapfinished = fals
admin = ""
customroom = false

function checkMod(playerName)
    for index, name in pairs(modlist) do
        if name == playerName then
            return true
        end
    end
    return false
end

function checkRoomMod(playerName)
    for index, name in pairs(modroom) do
        if name == playerName then
            return true
        end
    end
    return false
end

-- MOUSE POWERS
function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)
    local id = room.playerList[playerName].id
    local ostime = os.time()
    if playerloaded[id] == false then
        return
    end
    -- DOUBLE PRESS --
    if ostime - lastdashusedtime[id] > DASHCOOLDOWN then
        dashUsed = false
        if ostime - lastkeypressedtimeright[id] < 200 and room.playerList[playerName].isDead == false then
            -- DASHES textarea = 2--
            if keyCode == 39 or keyCode == 68  then
                lastkeypressedtimeright[id] = ostime
                --if lastkeypressed[id] == keyCode then
                --displayParticle(35, xPlayerPosition + 60, yPlayerPosition, 0, 0, 0, 0, nil)
                for name, data in pairs(room.playerList) do
                    if playerpreferences[room.playerList[name].id][2] == true then
                        displayParticle(3, xPlayerPosition, yPlayerPosition, random(), random(), 0, 0, name)
                        displayParticle(3, xPlayerPosition, yPlayerPosition, random(), -random(), 0, 0, name)
                        displayParticle(3, xPlayerPosition, yPlayerPosition, random(), -random(), 0, 0, name)
                        displayParticle(3, xPlayerPosition, yPlayerPosition, random(), -random(), 0, 0, name)
                    end
                end
                movePlayer(playerName, 0, 0, true, 150, 0, false)
                dashUsed = true;
                --end
            end
        end
        if ostime - lastkeypressedtimeleft[id] < 200 and room.playerList[playerName].isDead == false then
            if keyCode == 37 or keyCode == 65 then
                lastkeypressedtimeleft[id] = ostime
                for name, data in pairs(room.playerList) do
                    if playerpreferences[room.playerList[name].id][2] == true then
                        displayParticle(3, xPlayerPosition, yPlayerPosition, -random(), random(), 0, 0, name)
                        displayParticle(3, xPlayerPosition, yPlayerPosition, -random(), -random(), 0, 0, name)
                        displayParticle(3, xPlayerPosition, yPlayerPosition, -random(), -random(), 0, 0, name)
                        displayParticle(3, xPlayerPosition, yPlayerPosition, -random(), -random(), 0, 0, name)
                    end
                end
                movePlayer(playerName, 0, 0, true, -150, 0, false)
                dashUsed = true;
            end
        end

        if dashUsed == true then
            lastdashusedtime[id] = ostime
            dashstate[id] = false
            -- removeTextArea(2, playerName)
            -- addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, DASH_BTN_X, DASH_BTN_Y, 50, 50, 0xff5151, 0xaf3131, 0.8, true)
            removeImage(dashbtnid[id])
            dashbtnid[id] = addImage(DASH_BTN_OFF, "&1", DASH_BTN_X, DASH_BTN_Y, playerName)
        end
    end
    if ostime - lastkeypressedtimejump[id] < 200 and room.playerList[playerName].isDead == false then
        -- JUMP textarea = 1--
        if (keyCode == 38 or keyCode == 87) and ostime - lastjumpusedtime[id] > JUMPCOOLDOWN then
            lastkeypressedtimejump[id] = ostime
            --if lastkeypressed[id] == keyCode then
            movePlayer(playerName, 0, 0, true, 0, -60, false)
            for name, data in pairs(room.playerList) do
                if playerpreferences[room.playerList[name].id][2] == true then
                    displayParticle(3, xPlayerPosition, yPlayerPosition, random(), -random()*4, 0, 0, name)
                    displayParticle(3, xPlayerPosition, yPlayerPosition, -random(), -random()*3, 0, 0, name)
                    displayParticle(3, xPlayerPosition, yPlayerPosition, -random(), -random()*2, 0, 0, name)
                    displayParticle(3, xPlayerPosition, yPlayerPosition, random(), -random()*2, 0, 0, name)
                end
            end
            jumpstate[id] = false
            lastjumpusedtime[id] = ostime
            -- removeTextArea(1, playerName)
            -- addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, JUMP_BTN_X, JUMP_BTN_Y, 50, 50, 0xff5151, 0xaf3131, 0.8, true)
            removeImage(jumpbtnid[id])
            jumpbtnid[id] = addImage(JUMP_BTN_OFF, "&1", JUMP_BTN_X, JUMP_BTN_Y, playerName)
            --end
        end
    end

    if keyCode == 32 then
        if canrewind[id] == true then
            movePlayer(playerName, rewindpos[id][1], rewindpos[id][2], false, 0, 0, false)
            lastrewindused[id] = ostime
            canrewind[id] = false

            removeImage(rewindbtnid[id])
            rewindbtnid[id] = addImage(REWIND_BTN_ACTIVE, "&1", REWIND_BTN_X, REWIND_BTN_Y, playerName)

            -- removeTextArea(7, playerName)
            -- addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, REWIND_BTN_X, REWIND_BTN_Y, 50, 50, 0xff5151, 0xaf3131, 0.8, true)
            removeImage(mouseimgid[id])

            displayParticle(36, xPlayerPosition, yPlayerPosition, 0, 0, 0, 0, nil)
            displayParticle(2, xPlayerPosition, xPlayerPosition, -random(), random(), 0, 0, playerName)
            displayParticle(2, xPlayerPosition, xPlayerPosition, -random(), -random(), 0, 0, playerName)
            displayParticle(2, xPlayerPosition, xPlayerPosition, -random(), -random(), 0, 0, playerName)
            displayParticle(2, xPlayerPosition, xPlayerPosition, random(), -random(), 0, 0, playerName)
            if rewindpos[id][3] == false then
                tfm.exec.removeCheese(playerName)
            end
        elseif ostime - lastrewindused[id] > REWINDCOOLDONW and room.playerList[playerName].isDead == false then
            canrewind[id] = true
            checkpointtime[id] = ostime
            rewindpos[id] = {xPlayerPosition, yPlayerPosition, room.playerList[playerName].hasCheese}

            mouseimgid[id] = addImage(CHECKPOINT_MOUSE, "_100", xPlayerPosition - 59/2, yPlayerPosition - 73/2, playerName)       
            removeImage(rewindbtnid[id])
            rewindbtnid[id] = addImage(REWIND_BTN_OFF, "&1", REWIND_BTN_X, REWIND_BTN_Y, playerName)

            -- removeTextArea(7, playerName)
            -- addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, REWIND_BTN_X, REWIND_BTN_Y, 50, 50, 0x808700, 0xfbff14, 0.8, true)
            
            displayParticle(2, rewindpos[id][1], rewindpos[id][2], -random(), random(), 0, 0, playerName)
            displayParticle(2, rewindpos[id][1], rewindpos[id][2], -random(), -random(), 0, 0, playerName)
            displayParticle(2, rewindpos[id][1], rewindpos[id][2], -random(), -random(), 0, 0, playerName)
            displayParticle(2, rewindpos[id][1], rewindpos[id][2], random(), -random(), 0, 0, playerName)
        end
    end 
    -- OPEN GUIDE
    if keyCode == 72 then
        ui.addPopup(1, 0, translations[playerlanguage[id]][4], playerName, 212, 92, 368, true)
    end

    -- MORT ON X
    if keyCode == 88 then
        killPlayer(playerName)
    end

    -- HIDE/SHOW OPTIONS PANEL
    if keyCode == 71 then
        if playeroptions[id] == false then
            addTextArea(9, remakeOptions(playerName), playerName, 283, 165, 233, 95, 0x324650, 0x000000, 1, true)
            playeroptions[id] = true
        else
            removeTextArea(9, playerName)
            playeroptions[id] = false
        end
    end

    -- GRAFFITI
    if keyCode == 67 and ostime - lastgraffititime[id] > GRAFFITICOOLDOWN  then
        lastgraffititime[id] = ostime
        removeTextArea(id, nil)
        addTextArea(id, "<p align='center'><font face='Soopafresh' size='16' color='#ffffff'>"..playerName, nil, xPlayerPosition - 300/2, yPlayerPosition - 25/2, 300, 25, 0x324650, 0x000000, 0, false)   
    end

    lastkeypressedtime[id] = ostime
    if keyCode == 39 or keyCode == 68  then
        lastkeypressedtimeright[id] = ostime
    end

    if keyCode == 37 or keyCode == 65 then
        lastkeypressedtimeleft[id] = ostime
    end

    if keyCode == 38 or keyCode == 87 then
        lastkeypressedtimejump[id] = ostime
    end
end

-- UPDATE REWIND ARRAY
function eventPlayerDied(playerName)
    local id = room.playerList[playerName].id
    rewindpos[id] = {{0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}, {0, 0, false}}
    if mouseimgid[id] ~= nil then
        removeImage(mouseimgid[id])
    end
end

-- UPDATE MAP NAME
function updateMapName(timeRemaining)
    local floor = math.floor
    print(timeRemaining.." time remaining")
    if timeRemaining == nil then
        timeRemaining = 0
    end
    print(timeRemaining.." time remaining after")
    local minutes = floor((timeRemaining/1000)/60)
    local seconds = (floor(timeRemaining/1000)%60)
    if seconds < 10 then
        seconds = "0"..tostring(seconds)
    end

    local name = currentmapauthor.." <G>-</G><N> "..currentmapcode.."</N> <G>|<G> <N>Mice:</N> <J>"..playerCount.."</J> <G>|<G> <N>"..minutes..":"..seconds.."</N>"
    -- APPEND FASTEST
    if fastestplayer ~= -1 then
        local record = (besttime / 100)
        name = name.." <G>|<G> <N2>Record: </N2><R>"..fastestplayer.." - "..record.."s</R>"
    end

    name = name.."<"
    setMapName(name)
end

-- UI UPDATER & PLAYER RESPAWNER & REWINDER
function eventLoop(elapsedTime, timeRemaining)
    local ostime = os.time()

    updateMapName(MAPTIME * 1000 - (ostime - mapstarttime))
    --print(elapsedTime / 1000)
    
    -- WHEN TIME REACHES 0 CHOOSE ANOTHER MAP
    if elapsedTime >= MAPTIME * 1000 or mapwasskipped == true then
        mapwasskipped = false
        print("Attempting to reset.")
        tfm.exec.setAutoMapFlipMode(randomFlip())
        tfm.exec.newGame(randomMap())
        resetAll()
    else
        for playerName in pairs(room.playerList) do
            local id = room.playerList[playerName].id
            if room.playerList[playerName].isDead == true then
                -- RESPAWN PLAYER
                tfm.exec.respawnPlayer(playerName)
                -- UPDATE COOLDOWNS
                lastrewindused[id] = ostime - 5000
                lastjumpusedtime[id] = ostime - JUMPCOOLDOWN
                lastdashusedtime[id] = ostime - DASHCOOLDOWN
                -- WHEN RESPAWNED, MAKE THE ABILITIES GREEN
                -- removeTextArea(1, playerName)
                -- addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, JUMP_BTN_X, JUMP_BTN_Y, 50, 50, 0x5bff5b, 0x3ebc3e, 0.8, true)
                removeImage(jumpbtnid[id])
                jumpbtnid[id] = addImage(JUMP_BTN_ON, "&1", JUMP_BTN_X, JUMP_BTN_Y, playerName)


                lastrewindused[id] = 0
                checkpointtime[id] = 0
                canrewind[id] = false

                -- removeTextArea(2, playerName)
                -- addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, DASH_BTN_X, DASH_BTN_Y, 50, 50, 0x5bff5b, 0x3ebc3e, 0.8, true)
                removeImage(dashbtnid[id])
                dashbtnid[id] = addImage(DASH_BTN_ON, "&1", DASH_BTN_X, DASH_BTN_Y, playerName)
            end
            -- UPDATE UI
            if jumpstate[id] == false and ostime - lastjumpusedtime[id] > JUMPCOOLDOWN then
                jumpstate[id] = true
                removeImage(jumpbtnid[id])
                jumpbtnid[id] = addImage(JUMP_BTN_ON, "&1", JUMP_BTN_X, JUMP_BTN_Y, playerName)
                -- removeTextArea(1, playerName)
                -- addTextArea(1, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][2].."</font>", playerName, JUMP_BTN_X, JUMP_BTN_Y, 50, 50, 0x5bff5b, 0x3ebc3e, 0.8, true)
            end
            if dashstate[id] == false and ostime - lastdashusedtime[id] > DASHCOOLDOWN then
                dashstate[id] = true
                removeImage(dashbtnid[id])
                dashbtnid[id] = addImage(DASH_BTN_ON, "&1", DASH_BTN_X, DASH_BTN_Y, playerName)
                -- removeTextArea(2, playerName)
                -- addTextArea(2, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][3].."</font>", playerName, DASH_BTN_X, DASH_BTN_Y, 50, 50, 0x5bff5b, 0x3ebc3e, 0.8, true)
            end

            if canrewind[id] == true and ostime - checkpointtime[id] > 3000 then
                canrewind[id] = false
                lastrewindused[id] = ostime
                removeImage(mouseimgid[id])
                displayParticle(2, rewindpos[id][1], rewindpos[id][2], -random(), random(), 0, 0, playerName)
                displayParticle(2, rewindpos[id][1], rewindpos[id][2], -random(), -random(), 0, 0, playerName)
                displayParticle(2, rewindpos[id][1], rewindpos[id][2], -random(), -random(), 0, 0, playerName)
                displayParticle(2, rewindpos[id][1], rewindpos[id][2], random(), -random(), 0, 0, playerName)
            end

            if canrewind[id] == true and rewindstate[id] ~= 2 then
                rewindstate[id] = 2
                -- removeTextArea(7, playerName)
                -- addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, REWIND_BTN_X, REWIND_BTN_Y, 50, 50, 0x808700, 0xfbff14, 0.8, true)    
                removeImage(rewindbtnid[id])
                rewindbtnid[id] = addImage(REWIND_BTN_ACTIVE, "&1", REWIND_BTN_X, REWIND_BTN_Y, playerName)
            elseif canrewind[id] == false and rewindstate[id] ~= 1 and ostime - lastrewindused[id] > REWINDCOOLDONW then
                rewindstate[id] = 1
                -- removeTextArea(7, playerName)
                -- addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, REWIND_BTN_X, REWIND_BTN_Y, 50, 50, 0x5bff5b, 0x3ebc3e, 0.8, true)
                removeImage(rewindbtnid[id])
                rewindbtnid[id] = addImage(REWIND_BTN_ON, "&1", REWIND_BTN_X, REWIND_BTN_Y, playerName)
            elseif rewindstate[id] ~= 3 and ostime - lastrewindused[id] <= REWINDCOOLDONW then
                rewindstate[id] = 3
                -- removeTextArea(7, playerName)
                -- addTextArea(7, "<font size='14' align='center' color='#000000'><b>"..translations[playerlanguage[id]][11].."</font>", playerName, REWIND_BTN_X, REWIND_BTN_Y, 50, 50, 0xff5151, 0xaf3131, 0.8, true)
                removeImage(rewindbtnid[id])
                rewindbtnid[id] = addImage(REWIND_BTN_OFF, "&1", REWIND_BTN_X, REWIND_BTN_Y, playerName)
            end
        end
    end
end

-- PLAYER COLOR SETTER
function eventPlayerRespawn(playerName)
    id = room.playerList[playerName].id
    setColor(playerName)
end

function setColor(playerName)
    id = room.playerList[playerName].id
    local color = 0x40a594
    -- IF BEST TIME
    if playerName == fastestplayer then
        color = 0xEB1D51
    -- ELSEIF FINISHED
    elseif playerfinished[id] == true then
        color = 0xBABD2F
    end

    if checkRoomMod(playerName) == true then
        color = 0x2E72CB
    end

    setNameColor(playerName, color)
end

-- PLAYER WIN
function eventPlayerWon(playerName, timeElapsed, timeElapsedSinceRespawn)
    local id = room.playerList[playerName].id

    lastjumpusedtime[id] = 0
    lastdashusedtime[id] = 0

    if checkRoomMod(playerName) == true then
        return
    end

    -- SEND CHAT MESSAGE FOR PLAYER
    chatMessage(translations[playerlanguage[id]][22]..(timeElapsedSinceRespawn/100).."s", playerName)

    if playerfinished[id] == false then
        playerWon = playerWon + 1
    end
    setPlayerScore(playerName, 1, true)
    -- RESET TIMERS
    playerlasttime[id] = timeElapsedSinceRespawn
    playerfinished[id] = true
    playerbesttime[id] = math.min(playerbesttime[id], timeElapsedSinceRespawn)
    -- UPDATE "YOUR TIME"
    ui.updateTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": "..(timeElapsedSinceRespawn/100).."s", playerName)
    ui.updateTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": "..(playerbesttime[id]/100).."s", playerName)
    
    if timeElapsedSinceRespawn < besttime then
        -- CHECK IF FASTEST PLAYER IS IN ROOM
        for playerName in pairs(room.playerList) do
            if playerName == fastestplayer then
                setNameColor(fastestplayer, 0xBABD2F)
            end
        end
        besttime = timeElapsedSinceRespawn
        fastestplayer = playerName
        local message = "<font color='#CB546B'>"..fastestplayer..translations[playerlanguage[id]][19].." Time: "..(besttime/100).."s</font>"
        chatMessage(message, nil)
        print(message)
    end
end

function eventPlayerLeft(playerName)
    playerCount = playerCount - 1
end

-- RETURN PLAYER ID
function playerId(playerName)
    return room.playerList[playerName].id
end

-- CALL THIS WHEN A PLAYER FIRST JOINS A ROOM
function initPlayer(playerName)
    -- NUMBER OF THE PLAYER SINCE MAP WAS CREATED
    globalplayercount = globalplayercount + 1
    -- IF FIRST PLAYER, (NEW MAP) MAKE ADMIN
    if globalplayercount == 1 then
        admin = playerName
    end

    -- BIND MOUSE
    system.bindMouse(playerName, true)

    -- CURRENT PLAYERCOUNT
    playerCount = playerCount + 1
    -- ID USED FOR PLAYER ARRAYS
    globalid = room.playerList[playerName].id
    -- RESET SCORE
    setPlayerScore(playerName, 0)

    -- INIT ALL PLAYER TABLES
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
    table.insert(playerpreferences, globalid, {false, true, false})
    table.insert(lastgraffititime, globalid, 0)
    table.insert(rewindpos, globalid, {0, 0, false})
    table.insert(canrewind, globalid, false)
    table.insert(jumpstate, globalid, true)
    table.insert(dashstate, globalid, true)
    table.insert(rewindstate, globalid, 1)
    local jmpid = addImage(JUMP_BTN_ON, "&1", JUMP_BTN_X, JUMP_BTN_Y, playerName)
    table.insert(jumpbtnid, globalid, jmpid)
    local dshid = addImage(DASH_BTN_ON, "&1", DASH_BTN_X, DASH_BTN_Y, playerName)
    table.insert(dashbtnid, globalid, dshid)
    local rwdid = addImage(REWIND_BTN_ON, "&1", REWIND_BTN_X, REWIND_BTN_Y, playerName)
    table.insert(rewindbtnid, globalid, rwdid)
    local hlpid = addImage(HELP_IMG, ":100", 114, 23, playerName)
    table.insert(helpimgid, globalid, hlpid)
    ui.addTextArea(10, "<a href='event:CloseWelcome'><font color='transparent'>\n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n \n <font></a>", playerName, 129, 29, 541, 342, 0x324650, 0x000000, 0, true)
    table.insert(helpimgid, globalid, hlpid)
    table.insert(mouseimgid, globalid, nil)
    table.insert(checkpointtime, globalid, 0)

    -- SET DEFAULT COLOR
    setColor(playerName)
    -- BIND KEYS
    for index, key in pairs(keys) do
        bindKeyboard(playerName, key, true, true)
    end
    -- AUTOMATICALLY CHOOSE LANGUAGE
    chooselang(playerName)
end

function chooselang(playerName)
    local id = room.playerList[playerName].id
    local community = room.playerList[playerName].community
    -- FOR NOW, ONLY RO HAS TRANSLATIONS
    if community == "ro" then
        playerlanguage[id] = 1
    else
        playerlanguage[id] = 2 -- 2 = EN
    end
    playerloaded[id] = true
    -- GENERATE UI
    addTextArea(6, translations[playerlanguage[id]][10], playerName, 267, 382, 265, 18, 0x324650, 0x000000, 0, true)
    
    -- SEND HELP message
    chatMessage(translations[playerlanguage[id]][21].."\n"..translations[playerlanguage[id]][20], playerName)
    print(translations[playerlanguage[id]][21])
    print(translations[playerlanguage[id]][20])
end

-- WHEN SOMEBODY JOINS, INIT THE PLAYER
function eventNewPlayer(playerName)
    initPlayer(playerName)
end

-- INIT ALL EXISTING PLAYERS (NOT SURE IF WORKS)
for playerName in pairs(room.playerList) do
    initPlayer(playerName)
end

function eventMouse(playerName, xMousePosition, yMousePosition)
    local id = room.playerList[playerName].id
    if checkRoomMod(playerName) then
        movePlayer(playerName, xMousePosition, yMousePosition, false, 0, 0, false)
    end
end

function eventTextAreaCallback(textAreaId, playerName, eventName)
    local id = room.playerList[playerName].id
    -- OPTIONS
    if textAreaId == 9 then
        if eventName == "CloseOptions" then
            playeroptions[id] = false
            removeTextArea(9, playerName)
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
                removeTextArea(5, playerName)
                removeTextArea(4, playerName)
            else
                -- REGENERATE PANELS
                playerpreferences[id][3] = true
                addTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": N/A", playerName, 10, 45, 200, 21, 0xffffff, 0x000000, 0, true)
                addTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": N/A", playerName, 10, 30, 200, 21, 0xffffff, 0x000000, 0, true)
                if playerfinished[id] == true then
                    ui.updateTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": "..(playerlasttime[id]/100).."s", playerName)
                    ui.updateTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": "..(playerbesttime[id]/100).."s", playerName)
                end
            end

            print(playerName.." toggled time panels.")
        end
        ui.updateTextArea(9, remakeOptions(playerName), playerName)
    end
    if eventName == "CloseWelcome" then
        if helpimgid[id] ~= 0 then 
            removeImage(helpimgid[id])
        end
        removeTextArea(10, playerName)
    end
end

function remakeOptions(playerName)
    -- REMAKE OPTIONS TEXT (UPDATE YES - NO)
    local id = room.playerList[playerName].id
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

-- RESET ALL PLAYERS
function resetAll()
    local ostime = os.time()
    rewindpos = {}
    for playerName in pairs(room.playerList) do
        local id = room.playerList[playerName].id
        print("Resetting stats for"..playerName)
        setPlayerScore(playerName, 0)
        lastrewindused[id] = 0
        canrewind[id] = false
        
        lastkeypressed[id] = 0
        lastkeypressedtime[id] = ostime - DASHCOOLDOWN
        lastkeypressedtimeleft[id] = 0
        lastkeypressedtimeright[id] = 0
        lastkeypressedtimejump[id] = 0
        lastdashusedtime[id] = 0
        lastjumpusedtime[id] = ostime - JUMPCOOLDOWN
        playerbesttime[id] = 999999
        playerfinished[id] = false
        checkpointtime[id] = 0
        jumpstate[id] = true
        dashstate[id] = true


        rewindpos[id] = {0, 0, false}
        fastestplayer = -1
        besttime = 99999
        playerWon = 0
        setColor(playerName)
        -- REMOVE GRAFFITIS
        removeTextArea(id)
        lastgraffititime[id] = 0
        -- UPDATE THE TEXT
        if playerpreferences[id][3] == true then
            ui.updateTextArea(4, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][7]..": N/A", playerName)
            ui.updateTextArea(5, "<p align='center'><font face='Lucida console' color='#ffffff'>"..translations[playerlanguage[id]][6]..": N/A", playerName)
        end
    end
    tfm.exec.setGameTime(MAPTIME, true)
    updateMapName(MAPTIME)
end

-- DEBUGGING
function eventChatCommand(playerName, message)
    local ostime = os.time()
    local arg = {}
    for argument in message:gmatch("[^%s]+") do
        table.insert(arg, argument)
    end

    local isOp = false
    local isMod = false

    if checkMod(playerName) == true then
        isMod = true
        isOp = true
    end

    for index, name in pairs(oplist) do
        if name == playerName then
            isOp = true
        end
    end

    if admin == playerName and customroom == true then
        isOp = true
    end

    -- OP ONLY ABILITIES (INCLUDES MOD)
    if isOp == true then
        if arg[1] == "m" then
            if arg[2] ~= nil then
                tfm.exec.newGame(arg[2])
                tfm.exec.setAutoMapFlipMode(randomFlip())
                currentmapcode = "-"
                currentmapauthor = "Custom map"
                resetAll()
            end
        end

        if arg[1] == "n" then
            mapwasskipped = true
        end
    end

    -- MOD ONLY ABILITIES
    if isMod == true then
        if arg[1] == "mod" then
            if checkRoomMod(playerName) == false then
                table.insert(modroom, playerName)
                local message = "You are a mod!"
                print(message)
                chatMessage(message, playerName)
            else
                for index, name in pairs(modroom) do
                    if name == playerName then
                        table.remove(modroom, index)
                        local message = "You are no longer a mod!"
                        print(message)
                        chatMessage(message, playerName)
                        break
                    end
                end
            end
            setColor(playerName)
        end

        

        if arg[1] == "op" then
            if arg[2] ~= nil then
                table.insert(oplist, arg[2])
                local message = arg[2].." is an operator!"
                print(arg[2].." is an operator!")
                chatMessage(message, playerName)
            end
        end

        if arg[1] == "unop" then
            if arg[2] ~= nil then
                for index, name in pairs(oplist) do
                    if name == arg[2] then
                        table.remove(oplist, index)
                        local message = arg[2].." is no longer an operator."
                        print(arg[2].." is no longer an operator.")
                        chatMessage(message, playerName)
                        break
                    end
                end
            end
        end

        if arg[1] == "a" then
            if arg[2] ~= nil then
                for i = 3, #arg do
                    arg[2] = arg[2].." "..arg[i]
                end
                local message = "<font color='#2E72CB'>#ninja Owner "..playerName..": "..arg[2].."</font>"
                print(message)
                chatMessage(message)
            end
        end
    end

    if arg[1] == "pw" and arg[2] and playerName == admin then
        customroom = true
        tfm.exec.setRoomPassword(arg[2])
        print("Password: "..arg[2])
    end
end

