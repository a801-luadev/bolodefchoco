eventNewPlayer = system.bindMouse
eventMouse = tfm.exec.movePlayer

for playerName in next, tfm.get.room.playerList do eventNewPlayer(playerName) end