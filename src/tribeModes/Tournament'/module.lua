local empty = function() end
_eventTextAreaCallback = empty
_eventNewPlayer = empty
_eventPlayerLeft = empty
_eventNewGame = empty
_eventPlayerWon = empty
_eventLoop = empty
_eventChatCommand = empty
_eventPlayerDied = empty

local x1eliminatoria = function()
	tfm.exec.setRoomMaxPlayers(100)
	local maps = { "#17" }
	local MAX_PLAYERS = 100
	local MAP_TIME = 60

	local enums = {
		selectedPlayers = 0,
		ownerHUD = 10,
		play = 15,
		eliminatory = 20,
		announce = 30,
		victory = 40,
	}

	local canStart = false

	local winner, first
	local isEliminating = false
	local deleteMessage, newGameTentative, skipMap, canChangeMap, nextMap = 0, -1, false, false

	local selectedPlayers, totalSelectedPlayers = { }, 0

	local splitByLine = function(content)
		local data = { }

		local current, tmp, counter, size = 1, { }, 0, 0
		for line in string.gmatch(content, "([^\n]*)[\n]?") do
			counter = counter + 1
			tmp[counter] = line
			size = size + #line + 1

			if size > 1900 then
				data[current] = table.concat(tmp, '\n')
				tmp, counter, size = { }, 0, 0
				current = current + 1
			end
		end
		if size > 0 then data[current] = table.concat(tmp, '\n') end

		return data
	end

	local pairsByIndexes = function(list, f)
		local out, counter = {}, 0
		for index in next, list do
			counter = counter + 1
			out[counter] = index
		end
		table.sort(out, f)

		local i = 0
		return function()
			i = i + 1
			if out[i] ~= nil then
				return out[i], list[out[i]]
			end
		end
	end

	local removeSelectedPlayers = function(vPlayerName)
		for id = 1, 4 do
			ui.removeTextArea(enums.selectedPlayers + id, vPlayerName)
		end
	end

	local displaySelectedPlayers = function(vPlayerName, display)
		removeSelectedPlayers(vPlayerName)

		local players, rawPlayers, counter = { }, { }, 0
		for playerName in pairsByIndexes(selectedPlayers) do
			counter = counter + 1
			players[counter] = "<a href='event:" .. playerName .. "'>" .. playerName .. "</a>"
			rawPlayers[counter] = playerName
		end

		local windows
		if display or not vPlayerName then
			windows = splitByLine(table.concat(rawPlayers, '\n'))
			for id = 1, math.min(#windows, 4) do
				ui.addTextArea(enums.selectedPlayers + id, (windows[id] or "") .. "\n", vPlayerName, 5 + (id - 1) * 200, 53, 190, 344, nil, nil, .5, true)
			end
		end

		if not display then
			windows = splitByLine(table.concat(players, '\n'))
			for id = 1, math.min(#windows, 4) do
				ui.addTextArea(enums.selectedPlayers + id, (windows[id] or "") .. "\n", (vPlayerName or tfm.get.room.owner), 5 + (id - 1) * 200, 80, 190, 317, nil, nil, .5, true)
			end
		end
	end

	local updateBar = function(info)
		ui.setMapName((tfm.get.room.xmlMapInfo and tfm.get.room.xmlMapInfo.author or "Tigrounette") .. " <BL>- " .. tfm.get.room.currentMap .. "  <G>|   <N>" .. (info or ("Competidores : <V>" .. totalSelectedPlayers .. " <N>/ <V>" .. MAX_PLAYERS)))
	end

	local ownerHUD = function()
		if canStart then
			if not canChangeMap then
				ui.addTextArea(enums.victory + 1, "<p align='center'><font size='20'><a href='event:new'>Novo torneio", tfm.get.room.owner, 5, 55, 790, nil, 1, 1, 1, true)
			end
		else
			ui.addTextArea(enums.ownerHUD, "<p align='center'><J><a href='event:start'>Começar</a>\n", tfm.get.room.owner, 120, 25, 105, 20, nil, nil, .5, true)
			ui.addTextArea(enums.ownerHUD + 1, "<p align='center'><J><a href='event:erase'>Remover todos</a>\n", tfm.get.room.owner, 235, 25, 105, 20, nil, nil, .5, true)
		end
	end

	local ini = function(playerName)
		tfm.exec.chatMessage("<BV>Bem-vindo ao <B>#x1eliminatoria</B>. Boa sorte aos participantes!", playerName)
		ui.banner("166d6fc96b2.png", 110, 130, playerName, 8)
	end

	local main = function()
		canStart = false
		canChangeMap = false

		selectedPlayers = { }
		totalSelectedPlayers = 0
		updateBar()

		ui.removeTextArea(enums.victory)
		ui.removeTextArea(enums.victory + 1)

		for playerName in next, tfm.get.room.playerList do
			tfm.exec.setPlayerScore(playerName, 0)
		end

		tfm.exec.newGame('<C><P /><Z><S><S i="5,2,166d7129da2.jpg" c="4" L="0" H="0" X="0" Y="0" T="14" P=",,,,,,," /><S L="3000" o="0" H="3000" X="-1500" Y="200" T="12" P=",,3,2,,,," /><S P=",,3,2,,,," L="3000" o="0" X="2300" Y="200" T="12" H="3000" /><S L="3000" o="0" X="400" H="3000" Y="1900" T="12" P=",,3,2,,,," /><S P=",,3,2,,,," L="3000" o="0" H="3000" Y="-1500" T="12" X="-400" /></S><D /><O /></Z></C>')

		displaySelectedPlayers()

		ui.addTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n", nil, 5, 25, 105, 20, nil, nil, .5, true)
		ownerHUD()

		ini()
	end

	local endChampionship = function()
		tfm.exec.newGame('<C><P /><Z><S><S i="-200,-250,16692e791eb.png" P=",,9999,,,,," L="400" H="10" Y="270" T="14" X="400" /><S P=",,9999,,,,," i="-66,-20,1669252905c.png" L="200" H="10" Y="300" T="14" X="400" /></S><D><DS Y="300" X="400" /></D><O /></Z></C>')
	end

	_eventTextAreaCallback = function(id, playerName, callback)
		if callback == "join" then
			if not selectedPlayers[playerName] then
				if totalSelectedPlayers < MAX_PLAYERS then
					totalSelectedPlayers = totalSelectedPlayers + 1
					ui.updateTextArea(enums.play, "<N>Participando", playerName)
					selectedPlayers[playerName] = true
					displaySelectedPlayers()
					updateBar()
				end
			end
		elseif callback == "erase" then
			selectedPlayers = { }
			totalSelectedPlayers = 0
			removeSelectedPlayers()
			ui.updateTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n")
		elseif callback == "start" then
			if totalSelectedPlayers > 1 then
				removeSelectedPlayers()
				ui.removeTextArea(enums.ownerHUD, tfm.get.room.owner)
				ui.removeTextArea(enums.ownerHUD + 1, tfm.get.room.owner)
				ui.removeTextArea(enums.play)

				canStart = true
				canChangeMap = true
			end
		elseif callback == "new" then
			main()
		elseif selectedPlayers[callback] then
			totalSelectedPlayers = totalSelectedPlayers - 1
			selectedPlayers[callback] = nil
			if canStart then
				removeSelectedPlayers(playerName)
				ui.addTextArea(enums.eliminatory, "<p align='center'><font size='20'><J>" .. playerName .. " <N>eliminou <R>" .. callback, nil, 5, 25, 790, nil, nil, nil, 1, true)
				isEliminating = false
			else
				ui.updateTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n", callback)
				displaySelectedPlayers()
			end
			updateBar()
		end
	end

	_eventNewPlayer = function(playerName)
		ini(playerName)
		if not canStart then
			ui.addTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n", playerName, 5, 25, 105, 20, nil, nil, .5, true)
			displaySelectedPlayers(playerName, true)
		end
		if playerName == tfm.get.room.owner then
			ownerHUD()
		end
	end

	_eventPlayerLeft = function(playerName)
		if selectedPlayers[playerName] then
			selectedPlayers[playerName] = nil
			totalSelectedPlayers = totalSelectedPlayers - 1
			if canStart then
				print(playerName .. " saiu da competição!")
				if totalSelectedPlayers == 1 then
					for w in next, selectedPlayers do
						winner = w
						break
					end
					endChampionship()
				else
					updateBar()
				end
			else
				displaySelectedPlayers()
			end
		end
	end

	_eventNewGame = function()
		skipMap = false
		nextMap = nil
		newGameTentative = -1

		if canStart then
			if winner then
				tfm.exec.setGameTime(0)
				canChangeMap = false

				for playerName in next, tfm.get.room.playerList do
					if playerName == winner then
						tfm.exec.playEmote(playerName, 0)
						tfm.exec.setNameColor(playerName, 0xF8FF00)
					else
						tfm.exec.killPlayer(playerName)
					end
				end
				ui.addTextArea(enums.victory, "<p align='center'><font size='20'><J>" .. winner .. "</J> é o vencedor!", nil, 5, 25, 790, 25, 1, 1, 1, true)
				ownerHUD()

				updateBar("Vencedor : <V>" .. winner)
			else
				tfm.exec.setGameTime(MAP_TIME + 3)

				if first then
					removeSelectedPlayers(first)
					if isEliminating then
						_eventTextAreaCallback(nil, first, first)
					end
					isEliminating = false
				end

				for playerName in next, tfm.get.room.playerList do
					if not selectedPlayers[playerName] then
						tfm.exec.killPlayer(playerName)
					else
						tfm.exec.setNameColor(playerName, 0xFFFFFF)
					end
				end
				updateBar()
			end
		else
			tfm.exec.setGameTime(0)
			for playerName in next, tfm.get.room.playerList do
				tfm.exec.killPlayer(playerName)
			end
			updateBar('-')
		end

		ui.removeTextArea(enums.eliminatory)
		winner = nil
		first = nil
	end

	_eventPlayerWon = function(playerName)
		if not first then
			first = playerName
			tfm.exec.setPlayerScore(first, 1, true)

			if totalSelectedPlayers < 3 then
				winner = first
			else
				tfm.exec.setGameTime(10)
				ui.addTextArea(enums.eliminatory, "<p align='center'><font size='20'>Selecione um jogador para sair da partida\n<font size='15'>Você será auto-eliminado caso deixe de selecionar um jogador.", first, 5, 25, 790, nil, nil, nil, 1, true)
				displaySelectedPlayers(first)
				isEliminating = true
			end
		end
	end

	_eventLoop = function(currentTime, remainingTime)
		if canStart then
			if winner then
				return endChampionship()
			elseif canChangeMap and (skipMap or remainingTime < 500) then
				if newGameTentative > -1 then
					newGameTentative = newGameTentative + 1
					if newGameTentative >= 3 then
						nextMap = nil
					end
				end
				tfm.exec.newGame(nextMap or maps[math.random(#maps)])
			end

			if deleteMessage > 0 and os.time() > deleteMessage then
				deleteMessage = 0
				ui.removeTextArea(enums.announce)
			end
		end
	end

	_eventChatCommand = function(playerName, command)
		if canStart and playerName == tfm.get.room.owner then
			local cmd, param = string.match(command, "^(%S+) (.+)$")
			if cmd == "npp" then
				nextMap = param
				newGameTentative = 0
				print("O próximo mapa será " .. tostring(param) .. "!")
			elseif command == "skip" then
				skipMap = true
			elseif cmd == "msg" then
				deleteMessage = os.time() + 10000
				ui.addTextArea(enums.announce, "<ROSE>[" .. playerName .. "] " .. param, nil, 5, 25, 790, 20, 1, 1, .6, true)
			elseif cmd == "win" then
				tfm.exec.giveCheese(param)
				tfm.exec.playerVictory(param)
				print("Você atribuiu a vitória para o jogador " .. playerName .. "!")
			end
		end
	end

	_eventPlayerDied = function()
		local alive = 0
		for _, playerData in next, tfm.get.room.playerList do
			if not playerData.isDead then
				alive = alive + 1
			end
		end

		if alive == 0 and not first then
			skipMap = true
		end
	end

	main()
end

local _15x1 = function()
	local maps = { "#17" }
	local MAX_PLAYERS = 16
	local MAP_TIME = 60

	local PONTOS_15 = 30
	--local PONTOS_1 = 5

	local enums = {
		selectedPlayers = 0,
		ownerHUD = 10,
		play = 15,
		eliminatory = 20,
		announce = 30,
		victory = 40,
	}

	local canStart = false

	local winner, first
	local isEliminating = false
	local deleteMessage, newGameTentative, skipMap, canChangeMap, nextMap = 0, -1, false, false

	local team = {
		{ { }, 0 }, -- 15
		{ { }, 0 } -- 1
	}

	local selectedPlayers, totalSelectedPlayers, INItotalSelectedPlayers = { }, 0, 0

	table.getRandomIndex = function(list)
		local tbl = { }
		for k in next, list do
			tbl[#tbl + 1] = k
		end
		return tbl[math.random(#tbl)]
	end

	table.setAsIndex = function(list, ignore)
		local tbl = { }
		for k in next, list do
			if k ~= ignore then
				tbl[#tbl + 1] = k
			end
		end
		return tbl
	end

	local splitByLine = function(content)
		local data = { }

		local current, tmp, counter, size = 1, { }, 0, 0
		for line in string.gmatch(content, "([^\n]*)[\n]?") do
			counter = counter + 1
			tmp[counter] = line
			size = size + #line + 1

			if size > 1900 then
				data[current] = table.concat(tmp, '\n')
				tmp, counter, size = { }, 0, 0
				current = current + 1
			end
		end
		if size > 0 then data[current] = table.concat(tmp, '\n') end

		return data
	end

	local pairsByIndexes = function(list, f)
		local out, counter = {}, 0
		for index in next, list do
			counter = counter + 1
			out[counter] = index
		end
		table.sort(out, f)

		local i = 0
		return function()
			i = i + 1
			if out[i] ~= nil then
				return out[i], list[out[i]]
			end
		end
	end

	local removeSelectedPlayers = function(vPlayerName)
		for id = 1, 4 do
			ui.removeTextArea(enums.selectedPlayers + id, vPlayerName)
		end
	end

	local displaySelectedPlayers = function(vPlayerName, display)
		removeSelectedPlayers(vPlayerName)

		local players, rawPlayers, counter = { }, { }, 0
		for playerName in pairsByIndexes(selectedPlayers) do
			if playerName ~= vPlayerName then
				counter = counter + 1
				players[counter] = "<a href='event:" .. playerName .. "'>" .. playerName .. "</a>"
				rawPlayers[counter] = playerName
			end
		end

		local windows
		if display or not vPlayerName then
			windows = splitByLine(table.concat(rawPlayers, '\n'))
			for id = 1, math.min(#windows, 4) do
				ui.addTextArea(enums.selectedPlayers + id, (windows[id] or "") .. "\n", vPlayerName, 5 + (id - 1) * 200, 53, 190, 344, nil, nil, .5, true)
			end
		end

		if not display then
			windows = splitByLine(table.concat(players, '\n'))
			for id = 1, math.min(#windows, 4) do
				ui.addTextArea(enums.selectedPlayers + id, (windows[id] or "") .. "\n", (vPlayerName or tfm.get.room.owner), 5 + (id - 1) * 200, 80, 190, 317, nil, nil, .5, true)
			end
		end
	end

	local updateBar = function(info)
		ui.setMapName("<N>" .. (info or ((canStart and "Pontuação" or "Competidores") .. " : " .. (canStart and ("[" .. (INItotalSelectedPlayers - 1) .. "] <V>" .. team[1][2] .. " <N>vs [" .. team[2][1][1] .. "] <V>-" .. (totalSelectedPlayers - 1)) or ("<V>" .. totalSelectedPlayers)))))
	end

	local ownerHUD = function()
		if canStart then
			if not canChangeMap then
				ui.addTextArea(enums.victory + 1, "<p align='center'><font size='20'><a href='event:new'>Novo torneio", tfm.get.room.owner, 5, 55, 790, nil, 1, 1, 1, true)
			end
		else
			ui.addTextArea(enums.ownerHUD, "<p align='center'><J><a href='event:start'>Começar</a>\n", tfm.get.room.owner, 120, 25, 105, 20, nil, nil, .5, true)
			ui.addTextArea(enums.ownerHUD + 1, "<p align='center'><J><a href='event:erase'>Remover todos</a>\n", tfm.get.room.owner, 235, 25, 105, 20, nil, nil, .5, true)
		end
	end

	local playerHUD = function(playerName)
		ui.addTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n", playerName, 5, 25, 105, 20, nil, nil, .5, true)
		ui.addTextArea(enums.play + 1, "<p align='center'><VP>15 x 1", playerName, 690, 25, 105, 20, nil, nil, .5, true)
	end

	local ini = function(playerName)
		tfm.exec.chatMessage("<BV>Bem-vindo ao <B>15 contra 1</B>. Boa sorte aos participantes!\nDigite <B>!help</B> para saber mais.", playerName)
	end

	local main = function()
		canStart = false
		canChangeMap = false

		selectedPlayers = { }
		totalSelectedPlayers = 0
		updateBar()

		ui.removeTextArea(enums.victory)
		ui.removeTextArea(enums.victory + 1)

		for playerName in next, tfm.get.room.playerList do
			tfm.exec.setPlayerScore(playerName, 0)
		end

		tfm.exec.newGame('<C><P /><Z><S><S i="5,2,167658dc287.png" c="4" L="0" H="0" X="0" Y="0" T="14" P=",,,,,,," /><S L="3000" o="0" H="3000" X="-1500" Y="200" T="12" P=",,3,2,,,," /><S P=",,3,2,,,," L="3000" o="0" X="2300" Y="200" T="12" H="3000" /><S L="3000" o="0" X="400" H="3000" Y="1900" T="12" P=",,3,2,,,," /><S P=",,3,2,,,," L="3000" o="0" H="3000" Y="-1500" T="12" X="-400" /></S><D /><O /></Z></C>')

		displaySelectedPlayers()

		playerHUD()
		ownerHUD()

		ini()
	end

	local endChampionship = function()
		tfm.exec.newGame('<C><P /><Z><S><S i="-200,-250,16692e791eb.png" P=",,9999,,,,," L="400" H="10" Y="270" T="14" X="400" /><S P=",,9999,,,,," i="-66,-20,1669252905c.png" L="200" H="10" Y="300" T="14" X="400" /></S><D><DS Y="300" X="400" /></D><O /></Z></C>')
	end

	_eventTextAreaCallback = function(id, playerName, callback)
		if callback == "join" then
			if not selectedPlayers[playerName] then
				if totalSelectedPlayers < MAX_PLAYERS then
					totalSelectedPlayers = totalSelectedPlayers + 1
					ui.updateTextArea(enums.play, "<N>Participando", playerName)
					selectedPlayers[playerName] = true
					displaySelectedPlayers()
					updateBar()
				end
			end
		elseif callback == "erase" then
			selectedPlayers = { }
			totalSelectedPlayers = 0
			removeSelectedPlayers()
			ui.updateTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n")
		elseif callback == "start" then
			if totalSelectedPlayers > 1 then
				removeSelectedPlayers()
				ui.removeTextArea(enums.ownerHUD, tfm.get.room.owner)
				ui.removeTextArea(enums.ownerHUD + 1, tfm.get.room.owner)
				ui.removeTextArea(enums.play)
				ui.removeTextArea(enums.play + 1)

				team[2][1][1] = table.getRandomIndex(selectedPlayers)
				team[1][1] = table.setAsIndex(selectedPlayers, team[2][1][1])
				INItotalSelectedPlayers = totalSelectedPlayers

				tfm.exec.chatMessage("<BV><B>" .. team[2][1][1] .. "</B> contra 15!")

				canStart = true
				canChangeMap = true
			end
		elseif callback == "new" then
			main()
		elseif selectedPlayers[callback] then
			totalSelectedPlayers = totalSelectedPlayers - 1
			selectedPlayers[callback] = nil
			if canStart then
				removeSelectedPlayers(playerName)
				ui.addTextArea(enums.eliminatory, "<p align='center'><font size='20'><J>" .. playerName .. " <N>eliminou <R>" .. callback, nil, 5, 25, 790, nil, nil, nil, 1, true)
				isEliminating = false
			else
				ui.updateTextArea(enums.play, "<p align='center'><J><a href='event:join'>Participar</a>\n", callback)
				displaySelectedPlayers()
			end
			updateBar()
		end
	end

	_eventNewPlayer = function(playerName)
		ini(playerName)
		if not canStart then
			playerHUD(playerName)
			displaySelectedPlayers(playerName, true)
		end
		if playerName == tfm.get.room.owner then
			ownerHUD()
		end
	end

	_eventPlayerLeft = function(playerName)
		if selectedPlayers[playerName] then
			selectedPlayers[playerName] = nil
			totalSelectedPlayers = totalSelectedPlayers - 1
			if canStart then
				print(playerName .. " saiu da competição!")
				if totalSelectedPlayers == 1 then
					for w in next, selectedPlayers do
						winner = w
						break
					end
					endChampionship()
				else
					updateBar()
				end
			else
				displaySelectedPlayers()
			end
		end
	end

	_eventNewGame = function()
		skipMap = false
		nextMap = nil
		newGameTentative = -1

		if canStart then
			if winner then
				tfm.exec.setGameTime(0)
				canChangeMap = false

				for playerName in next, tfm.get.room.playerList do
					if playerName == winner then
						tfm.exec.playEmote(playerName, 0)
						tfm.exec.setNameColor(playerName, 0xF8FF00)
					else
						tfm.exec.killPlayer(playerName)
					end
				end
				ui.addTextArea(enums.victory, "<p align='center'><font size='20'>" .. (team[2][1][1] == winner and ("<J>" .. winner .. "</J> venceu os 15!") or "<J>Os 15</J> venceram!"), nil, 5, 25, 790, 25, 1, 1, 1, true)
				ownerHUD()

				ui.setMapName("Vencedor : <V>" .. (team[2][1][1] == winner and winner or "Os 15") .. "<")
			else
				tfm.exec.setGameTime(MAP_TIME + 3)

				isEliminating = false

				for playerName in next, tfm.get.room.playerList do
					if not selectedPlayers[playerName] then
						tfm.exec.killPlayer(playerName)
					else
						tfm.exec.setNameColor(playerName, (playerName == team[2][1][1] and 0xF8FF00 or 0xFFFFFF))
					end
				end
				updateBar()
			end
		else
			tfm.exec.setGameTime(0)
			for playerName in next, tfm.get.room.playerList do
				tfm.exec.killPlayer(playerName)
			end
			updateBar('-')
		end

		ui.removeTextArea(enums.eliminatory)
		winner = nil
		first = nil
	end

	_eventPlayerWon = function(playerName)
		if not first then
			first = playerName
			tfm.exec.setPlayerScore(first, 1, true)

			local isOne = playerName == team[2][1][1]
			if isOne then
				team[2][2] = team[2][2] + 1
				if totalSelectedPlayers < 3 then -- or team[2][2] >= PONTOS_1
					winner = first
				else
					ui.addTextArea(enums.eliminatory, "<p align='center'><font size='20'>Selecione um jogador para sair da partida\n<font size='15'>Você será auto-eliminado caso deixe de selecionar um jogador.", first, 5, 25, 790, nil, nil, nil, 1, true)
					displaySelectedPlayers(first)
					isEliminating = true
				end
			else
				team[1][2] = team[1][2] + 1
				if team[1][2] >= PONTOS_15 then
					winner = ""
				else
					tfm.exec.chatMessage("<BV><B>Os 15</B> marcaram mais um ponto! (" .. team[1][2] .. " / " .. PONTOS_15 .. ")")
				end
			end

			updateBar()
			tfm.exec.setGameTime(10)
		end
	end

	_eventLoop = function(currentTime, remainingTime)
		if canStart then
			if winner then
				return endChampionship()
			elseif canChangeMap and (skipMap or remainingTime < 500) then
				if newGameTentative > -1 then
					newGameTentative = newGameTentative + 1
					if newGameTentative >= 3 then
						nextMap = nil
					end
				end

				if first and isEliminating then
					winner = ""
					removeSelectedPlayers(first)
					return endChampionship()
				end

				tfm.exec.newGame(nextMap or maps[math.random(#maps)])
			end

			if deleteMessage > 0 and os.time() > deleteMessage then
				deleteMessage = 0
				ui.removeTextArea(enums.announce)
			end
		end
	end

	_eventChatCommand = function(playerName, command)
		if command == "help" or command == "ajuda" or command == "?" then
			tfm.exec.chatMessage([[<BV>Objetivo: No jogo 15 contra 1 o objetivo de cada lado é o seguinte:

	Os 15 precisam chegar a determinado ponto para vencer o sozinho, e o sozinho precisa eliminar os 15 para vencer.
	- Se caso os 15 chegarem a pontuação definida antes do sozinho eliminar todos, eles ganharão;
	- Se o sozinho eliminar todos antes dos 15 chegarem a determinada pontuação, o sozinho vence.

	Boa sorte.]], playerName)
			return
		end
		if canStart and playerName == tfm.get.room.owner then
			local cmd, param = string.match(command, "^(%S+) (.+)$")
			if cmd == "npp" then
				nextMap = param
				newGameTentative = 0
				print("O próximo mapa será " .. tostring(param) .. "!")
			elseif command == "skip" then
				skipMap = true
			elseif cmd == "msg" then
				deleteMessage = os.time() + 10000
				ui.addTextArea(enums.announce, "<ROSE>[" .. playerName .. "] " .. param, nil, 5, 25, 790, 20, 1, 1, .6, true)
			elseif cmd == "win" then
				tfm.exec.giveCheese(param)
				tfm.exec.playerVictory(param)
				print("Você atribuiu a vitória para o jogador " .. playerName .. "!")
			end
		end
	end

	_eventPlayerDied = function()
		local alive = 0
		for _, playerData in next, tfm.get.room.playerList do
			if not playerData.isDead then
				alive = alive + 1
			end
		end

		if alive == 0 and not first then
			skipMap = true
		end
	end

	main()
end

ui.addTextArea(0, [[
<a href='event:x1'>#x1eliminatoria</a>
<a href='event:15x1'>#15x1</a>
]], tfm.get.room.owner, 5, 25, nil, nil, 1, 1, 1, true)

system.disableChatCommandDisplay()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAutoScore()
tfm.exec.disablePhysicalConsumables()

_eventTextAreaCallback = function(i, n, c)
	ui.removeTextArea(0)
	if c == "x1" then
		pcall(x1eliminatoria)
	else
		pcall(_15x1)
	end
end

-- Bug fix
eventTextAreaCallback = function(...)
	_eventTextAreaCallback(...)
end
eventNewPlayer = function(...)
	_eventNewPlayer(...)
end
eventPlayerLeft = function(...)
	_eventPlayerLeft(...)
end
eventNewGame = function(...)
	_eventNewGame(...)
end
eventPlayerWon = function(...)
	_eventPlayerWon(...)
end
eventLoop = function(...)
	_eventLoop(...)
end
eventChatCommand = function(...)
	_eventChatCommand(...)
end
eventPlayerDied = function(...)
	_eventPlayerDied(...)
end
