eventNewPlayer = function(n)
	tfm.exec.chatMessage("<N>Welcome, " .. n .. ".\nYour Transformice ID is '<ROSE><B>" .. tfm.get.room.playerList[n].id .. "</B></ROSE>'", n)
end
for n in next, tfm.get.room.playerList do eventNewPlayer(n) end
