local questions = {
	-- Question
	-- Option1
	-- Option2
	-- Answer (1 / 2)
	{
		"What is the color of the Sky?",
		"Blue",
		"Pink",
		1
	},
	{
		"Are there trees in the Hell?",
		"Yes",
		"No",
		2
	},
}

local gameTimer, newGameTimer, respawn = -1, -1, false

local question
local displayQuestion = function()
	for i = 3, 4 do
		ui.removeTextArea(i)
	end

	for player, data in next, tfm.get.room.playerList do
		tfm.exec.movePlayer(player, 400, 320)
	end

	question = questions[math.random(#questions)]

	ui.addTextArea(0, "<p align='center'><font size='20'><CEP>" .. question[1], nil, 5, 25, 790, nil, 1, 1, 1, true)
	for i = 0, 1 do
		ui.addTextArea(i + 1, "<p align='center'><font size='20' color='#FFFFFF'>" .. question[i + 2], nil, 5 + (i * 420), 120, 370, nil, 1, 1, 0, true)
	end

	gameTimer = 10.5
end

local displayAnswer = function()
	local add = 0

	for i = 1, 2 do
		if question[4] == i then
			local x = 5 + ((i - 1) * 420)

			ui.updateTextArea(i, "<p align='center'><font size='20'><VP>" .. question[i + 1])

			local counter, alivePlayer = 0
			for player, data in next, tfm.get.room.playerList do
				if not data.isDead then
					if data.x > (x + 370) or data.x < x then
						tfm.exec.killPlayer(player)
					else
						counter = counter + 1
						alivePlayer = player
					end
				end
			end

			if counter == 0 then
				tfm.exec.chatMessage("<J>No winners.")
			elseif counter == 1 then
				tfm.exec.setPlayerScore(alivePlayer, 5, true)
				tfm.exec.chatMessage("<G>" .. alivePlayer .. " <J>wins.")
			end

			if counter < 2 then
				add = 3
				respawn = true
			end
		end
	end

	newGameTimer = 4.5 + add
end

eventNewGame = function()
	newGameTimer = 4.5
end

eventLoop = function()
	if respawn then
		for player, data in next, tfm.get.room.playerList do
			if data.isDead then
				tfm.exec.respawnPlayer(player)
			end
			tfm.exec.movePlayer(player, 400, 320)
		end
	end

	if newGameTimer >= 0 then
		newGameTimer = newGameTimer - .5
		if newGameTimer == 0 then
			respawn = false
			displayQuestion(true)
		else
			ui.setMapName("Quiz   <G>|   <N>New game in : <V>" .. math.max(0, math.floor(newGameTimer)) .. "<")
		end
	elseif gameTimer >= 0 then
		gameTimer = gameTimer - .5
		if gameTimer == 0 then
			ui.setMapName("Quiz<")
			displayAnswer()
		else
			ui.setMapName("Quiz   <G>|   <N>Time left to choose a side : <V>" .. math.max(0, math.floor(gameTimer)) .. "<")
		end
	end
end

eventNewPlayer = function(player)
	tfm.exec.lowerSyncDelay(player)
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoScore()

for player, data in next, tfm.get.room.playerList do
	tfm.exec.setPlayerScore(player, 0)
end

tfm.exec.newGame('<C><P /><Z><S><S L="40" H="100" X="400" Y="380" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="800" X="400" H="40" Y="400" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="40" X="400" H="100" Y="380" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="800" H="40" X="400" Y="406" T="0" P="0,0,0.3,0.2,180,0,0,0" /><S L="800" H="40" X="400" Y="413" T="0" P="0,0,0.3,0.2,0,0,0,0" /><S L="40" H="310" X="400" Y="160" T="1" P="0,0,0,0.2,180,0,0,0" /><S L="40" X="400" H="310" Y="160" T="1" P="0,0,0,0.2,180,0,0,0" /><S L="10" X="0" H="380" Y="190" T="12" P="0,0,0,0,0,0,0,0" /><S L="10" H="380" X="800" Y="190" T="12" P="0,0,0,0,0,0,0,0" /></S><D><DS Y="320" X="400" /></D><O /></Z></C>')