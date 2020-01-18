local texts = {
	br = {
		title = "Perguntas",
		displayAnswer = "A resposta da pergunta era <B>%s</B>.",
		choosing = "Escolhendo Shaman...",
		welcome = "<J>Bem vindo ao module Corrida de Perguntas! Digite !help para mais informações.",
		introShaman = "<J>Você é o shaman! Digite <B>!q</B> para fazer a pergunta",
		newShaman = "<CEP>%s estará fazendo as perguntas agora",
		help = "<CEP>O minigame consiste em um Shaman que irá realizar perguntas para os demais jogadores responder. O primeiro jogador a acertar 5 perguntas ganha o jogo e se torna o próximo Shaman. Digite !q para fazer uma pergunta quando for sua vez de ser o Shaman.",
		enterQuestion = "Digite sua pergunta",
		skip = "<R>%s pulou a vez",
		seeQuestion = "Sua pergunta: %s",
		enterAnswer = "Digite a resposta da sua pergunta",
		seeAnswer = "A resposta para sua pergunta: %s",
		win = "<VP>%s acertou!"
	},
	es = {
		title = "Preguntas",
		displayAnswer = "La respuesta a la pregunta era <B>%s</B>.",
		choosing = "Eligiendo el Chamán...",
		welcome = "<J>Bienvenido al module Carrera de preguntas! Escribe !help para más información.",
		introShaman = "<J>Eres el Chamán! Escribe <B>!q</B> para hacer la pregunta",
		newShaman = "<CEP>%s hará las preguntas ahora",
		help = "<CEP>El minijuego consiste en un Chamán que hará preguntas para que otros jugadores respondan. El primer jugador en acertar 5 preguntas gana el juego y se convierte en el próximo chamán. Escribe !q para hacer una pregunta cuando sea su turno como chamán.",
		enterQuestion = "Escriba su pregunta",
		skip = "<R>%s saltó su turno",
		seeQuestion = "Su pregunta: %s",
		enterAnswer = "Escribe la respuesta para su pregunta",
		seeAnswer = "La respuesta para su pregunta: %s",
		win = "<VP>%s obtuvo la respuesta correcta!"
	}
}
local translation = tfm.get.room.community
translation = texts[translation] or texts.br

local initModuleTimer = 1000

local playerData = { }

local stageNames = { "I", "II", "III", "IV", "V" }
local totalStages = #stageNames

local chooseShaman = true
local newShaman, nextShaman
local currentQuestion, currentAnswer
--local skip = 0
--local hasSkipped = { }

local displayStageNames = function(playerName)
	for i = 1, totalStages do
		ui.addTextArea(i, "<p align='center'><font size='30' color='#000000'><B>" .. stageNames[i], playerName, 390 + (i - 1) * 200, 180, 200, nil, 1, 1, 0, false)
	end

	ui.setMapName(translation.title)
	if newShaman then
		ui.setShamanName(newShaman)
	end
end

do
	local setPlayerScore = tfm.exec.setPlayerScore
	tfm.exec.setPlayerScore = function(playerName, score, add)
		playerData[playerName].score = (add and (playerData[playerName].score + score) or score)
		setPlayerScore(playerName, score, add)
	end
end

local setPlayerData = function(playerName)
	playerData[playerName] = {
		currentStage = 0,
		score = 0,
		isInRoom = true
	}

	tfm.exec.setPlayerScore(playerName, 0)
end

local getNewShaman = function()
	if nextShaman and playerData[nextShaman] and playerData[nextShaman].isInRoom then
		return nextShaman
	end

	local scores, counter = { }, 0
	local hasMoreThanZeroPoints = false

	local score
	for playerName, data in next, playerData do
		if data.isInRoom and string.sub(playerName, -5, -5) == '#' then -- Not souris
			counter = counter + 1
			scores[counter] = {
				playerName = playerName,
				score = data.score
			}

			if data.score > 0 then
				hasMoreThanZeroPoints = true
			end
		end
	end

	if hasMoreThanZeroPoints then
		table.sort(scores, function(p1, p2)
			return p1.score > p2.score
		end)

		return scores[1].playerName
	else
		return scores[math.random(counter)].playerName
	end
end

local resetAllPlayerData = function()
	local gc, counter = { }, 0

	for playerName, data in next, playerData do
		data.currentStage = 0
		tfm.exec.setPlayerScore(playerName, 0)
		if not data.isInRoom then
			counter = counter + 1
			gc[counter] = playerName
		end
	end

	for player = 1, counter do
		playerData[gc[player]] = nil
	end
end

local movePlayerToStage = function(playerName)
	tfm.exec.movePlayer(playerName, 300 + playerData[playerName].currentStage * 200, 365)
end

local moveAllToSpawnPoint = function()
	for playerName in next, tfm.get.room.playerList do
		tfm.exec.movePlayer(playerName, 125, 365)
	end
end

local displayAnswer = function()
	if not currentAnswer then return end
	tfm.exec.chatMessage(string.format(translation.displayAnswer, currentAnswer))
end

local startChooseFlow = function(ignoreAnswer)
	if newShaman then
		tfm.exec.respawnPlayer(newShaman)
		newShaman = nil
	end
	if not ignoreAnswer then
		displayAnswer()
	end

	currentQuestion = nil
	currentAnswer = nil
	--skip = 0
	--hasSkipped = { }
	chooseShaman = true

	moveAllToSpawnPoint()

	ui.removeTextArea(0)
	tfm.exec.setGameTime(5)
	tfm.exec.chatMessage(translation.choosing)
end

local displayQuestion = function(playerName)
	if not currentAnswer then return end
	ui.addTextArea(0, "<p align='center'><font size='20'>" .. currentQuestion, playerName, 5, 50, 400, nil, nil, nil, .75, true)
end

eventNewPlayer = function(playerName)
	tfm.exec.respawnPlayer(playerName)
	if chooseShaman or not playerData[playerName] then
		setPlayerData(playerName)
	else
		playerData[playerName].isInRoom = true
		if playerData[playerName].currentStage > 0 then
			movePlayerToStage(playerName)
			tfm.exec.setPlayerScore(playerName, playerData[playerName].score)
		end
	end

	displayQuestion(playerName)
	displayStageNames(playerName)
	tfm.exec.chatMessage(translation.welcome, playerName)
end

eventNewGame = function()
	for playerName in next, tfm.get.room.playerList do
		setPlayerData(playerName)
	end
	displayStageNames()

	startChooseFlow()
end

eventLoop = function(currentTime, remainingTime)
	if initModuleTimer > 0 then
		initModuleTimer = initModuleTimer - 500
		return
	end

	if chooseShaman then
		if remainingTime > 0 then return end
		chooseShaman = false

		newShaman = getNewShaman()
		nextShaman = nil
		resetAllPlayerData()

		tfm.exec.setShaman(newShaman)
		tfm.exec.killPlayer(newShaman)
		tfm.exec.chatMessage(translation.introShaman, newShaman)

		ui.setShamanName(newShaman)
		tfm.exec.chatMessage(string.format(translation.newShaman, newShaman))

		tfm.exec.setGameTime(60)
	else
		if remainingTime <= 0 then
			startChooseFlow()
		end
	end
end

eventChatCommand = function(playerName, command)
	if chooseShaman then return end

	if command == "help" then
		tfm.exec.chatMessage(translation.help, playerName)
	--elseif command == "skip" then
		--if hasSkipped[playerName] then return end
		--hasSkipped[playerName] = true

		--local half = math.ceil(tfm.get.room.uniquePlayers / 2)

		--skip = skip + 1
		--if skip >= half then
		--	tfm.exec.chatMessage("<R>".. newShaman .. " perdeu a vez")
		--	startChooseFlow()
		--else
		--	tfm.exec.chatMessage("Skip", playerName)
		--end
	elseif playerName == newShaman then
		if command == 'q' then
			ui.addPopup(0, 2, translation.enterQuestion, newShaman, 200, 170, 400, true)
		elseif command == "skip" then
			tfm.exec.chatMessage(string.format(translation.skip, playerName))
			startChooseFlow()
		end
	end
end

eventPopupAnswer = function(id, playerName, answer)
	if chooseShaman then return end
	if playerName ~= newShaman then return end

	answer = string.trim(answer)
	if answer == '' then return end

	if id == 0 then -- Pergunta
		currentAnswer = nil
		currentQuestion = answer

		tfm.exec.chatMessage(string.format(translation.seeQuestion, answer), playerName)
		ui.addPopup(1, 2, translation.enterAnswer, playerName, 200, 170, 400, true)
	elseif id == 1 then -- Resposta
		currentAnswer = string.lower(answer)

		displayQuestion()
		tfm.exec.setGameTime(60)

		tfm.exec.chatMessage(string.format(translation.seeAnswer, currentAnswer), playerName)
	end
end

eventChatMessage = function(playerName, message)
	if chooseShaman then return end
	if string.lower(message) ~= currentAnswer then return end
	if playerName == newShaman then
		return startChooseFlow()
	end
	tfm.exec.chatMessage(string.format(translation.win, playerName))
	displayAnswer()

	currentAnswer = nil

	playerData[playerName].currentStage = playerData[playerName].currentStage + 1
	movePlayerToStage(playerName)

	tfm.exec.setPlayerScore(playerName, 1, true)

	if playerData[playerName].currentStage == totalStages then
		nextShaman = playerName
		startChooseFlow(true)
	else
		tfm.exec.setGameTime(60)
		ui.removeTextArea(0)
	end
end

eventPlayerLeft = function(playerName)
	playerData[playerName].isInRoom = false

	if chooseShaman then return end
	if playerName ~= newShaman and playerName ~= nextShaman then return end

	startChooseFlow()
end

eventPlayerRespawn = function(playerName)
	tfm.exec.setShaman(playerName, false)
end

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAfkDeath()
tfm.exec.disableMortCommand()
tfm.exec.disableAutoScore()
tfm.exec.disablePhysicalConsumables()

system.disableChatCommandDisplay()

local xml = '<C><P DS="m;45,365,65,365,85,365,105,365,125,365,145,365,165,365,185,365,205,365,225,365,245,365,265,365,285,365,305,365,325,365,345,365" L="1400" /><Z><S><S L="400" H="20" X="1390" Y="200" T="10" P=",,.3,,270,,," /><S L="400" X="10" H="20" Y="200" T="10" P=",,.3,,90,,," /><S L="400" X="390" H="20" Y="200" T="10" P=",,.3,,270,,," /><S L="400" H="20" X="400" Y="200" T="10" P=",,.3,,90,,," /><S L="400" H="20" X="590" Y="200" T="10" P=",,.3,,270,,," /><S L="400" X="790" H="20" Y="200" T="10" P=",,.3,,270,,," /><S L="400" H="20" X="990" Y="200" T="10" P=",,.3,,270,,," /><S L="400" X="1190" H="20" Y="200" T="10" P=",,.3,,270,,," /><S L="400" X="600" H="20" Y="200" T="10" P=",,.3,,90,,," /><S L="400" H="20" X="800" Y="200" T="10" P=",,.3,,90,,," /><S L="400" X="1000" H="20" Y="200" T="10" P=",,.3,,90,,," /><S L="400" H="20" X="1200" Y="200" T="10" P=",,.3,,90,,," /><S L="1400" X="700" H="20" Y="10" T="10" P=",,.3,,180,,," /><S L="1400" H="20" X="700" Y="390" T="10" P=",,.3,,,,," /></S><D /><O /></Z></C>'
local groundId = table.random({ 6, 17, 11, 10 })
xml = string.gsub(xml, "T=\"10\"", "T=\"" .. groundId .. "\"")
tfm.exec.newGame(xml)