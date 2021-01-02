local totalGrounds = 200

tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.newGame('<C><P L="' ..  ((totalGrounds + 2) * 100) .. '" /><Z><S><S L="100" H="10" X="49" Y="77" T="0" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DS Y="57" X="67" /><F Y="65" X="25" /></D><O /></Z></C>')

eventNewGame = function()
    for i = 1, totalGrounds do
      tfm.exec.addPhysicObject(i, 100 + i*100, 0, { type = 0, width = 10, height = 200, friction = 0.3, restitution = 0.2 })
    end
end

local currentStage = { }
eventNewPlayer = function(n)
    eventPlayerDied(n)

    currentStage[n] = 0
end
for n in next, tfm.get.room.playerList do eventNewPlayer(n) end

local floor = math.floor
eventLoop = function()
    for n, p in next, tfm.get.room.playerList do
        local oldStage = currentStage[n]
        local x = floor(p.x/100 - 1)
        if oldStage ~= x then
            currentStage[n] = x
            tfm.exec.setPlayerScore(n, x)
        end
    end
end

eventPlayerDied = tfm.exec.respawnPlayer