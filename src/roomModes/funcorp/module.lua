local miceAlive, nextMap = 0

local funcorp = false
eventChatCommand = function(playerName, command)
	if not owners[playerName] then return end

	local cmd = string.split(command, "%S+")

	if cmd[1] == "funcorp" then
		if cmd[2] == "help" then
			tfm.exec.chatMessage([[<FC>!changesize [playerNames|*] [size|off] : Temporarily changes the size (between 0.1x and 5x) of players.

!colornick [playerNames|*] [color|off] : Temporarily changes the color of player nicknames.

!funcorp [on|off|help] : Enable/disable the funcorp mode, or show the list of funcorp-related commands

!linkmice [playerNames] [off] : Temporarily links players.

!meep [playerNames|*] [off] : Give meep to players.

!np [mapCode] : Starts a new map.

!npp [mapCode] : Plays the selected map after the current map is over.

!transformation [playerNames|*] [off] : Temporarily gives the ability to transform.
			]], playerName)
		else
			if cmd[2] then
				funcorp = (cmd[2] == "on" and true or cmd[2] == "off" and false)
			else
				funcorp = not funcorp
			end

			if funcorp then
				tfm.exec.chatMessage("<FC>The FunCorp mode has been activated in this room.")
			else
				tfm.exec.chatMessage("<FC>The FunCorp mode has been deactivated.")
			end
		end
	elseif funcorp and cmd[2] then
		if cmd[1] == "changesize" then
			local size = cmd[#cmd]

			size = tonumber(size) or (size == "off" and 1)
			if not size then
				return tfm.exec.chatMessage("<V>[•] <BL>Invalid size.", playerName)
			end
			size = (size < .1 and .1 or size > 5 and 5 or size)

			if cmd[2] == "*" then
				for player in next, tfm.get.room.playerList do
					tfm.exec.changePlayerSize(player, size)
				end
				tfm.exec.chatMessage("<V>[•] <BL>All the players now have " .. (size == 1 and "their regular size." or ("the size " .. size)), playerName)
			else
				local players, counter = { }, 0
				for i = 2, #cmd - 1 do
					counter = counter + 1
					players[counter] = string.nick(cmd[i])
					tfm.exec.changePlayerSize(players[counter], size)
				end
				tfm.exec.chatMessage("<V>[•] <BL>The following players now have " .. (size == 1 and "their regular size" or ("the size " .. size)) .. ": <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
			end
		elseif cmd[1] == "colornick" then
			if not cmd[3] then
				owners[playerName] = cmd[2]
				return ui.showColorPicker(0, playerName, 1, "Select a color")
			end

			local off, color = cmd[#cmd] == "off"
			if not off then
				if string.find(cmd[#cmd], '#') then
					cmd[#cmd] = tonumber(string.sub(cmd[3], 2), 16)
				end

				if not cmd[#cmd] then
					return tfm.exec.chatMessage("<V>[•] <BL>Invalid color.", playerName)
				end

				color = string.format("%x", cmd[#cmd])
			end

			if cmd[2] == "*" then
				for player in next, tfm.get.room.playerList do
					tfm.exec.setNameColor(player, (not off and cmd[#cmd] or false))
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>All the nickname colors have been removed.", playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>All the players now have the nickname color <font color='#" .. color .. "'>0x" .. color .. "</font>.", playerName)
				end
			else
				local players, counter = { }, 0
				for i = 2, #cmd - 1 do
					counter = counter + 1
					players[counter] = string.nick(cmd[i])
					tfm.exec.setNameColor(players[counter], (not off and cmd[#cmd] or false))
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>Nickname colors removed from players: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>New nickname color <font color='#" .. color .. "'>(0x" .. color .. ")</font> for players: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				end
			end
		elseif cmd[1] == "linkmice" then
			local off = cmd[#cmd] == "off"

			if cmd[2] == "*" then
				local lastPlayer
				for player in next, tfm.get.room.playerList do
					if lastPlayer then
						tfm.exec.linkMice(player, lastPlayer, not off)
					end
					lastPlayer = player
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>All the links have been removed.", playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>All the players are now linked.", playerName)
				end
			else
				if not cmd[(off and 4 or 3)] then
					return tfm.exec.chatMessage("<V>[•] <BL>There must be at least two players in order to " .. (off and "unlink" or "link") .. " them.", playerName)
				end

				local players, counter, lastPlayer = { }, 0
				for i = 2, #cmd - (off and 1 or 0) do
					counter = counter + 1
					players[counter] = string.nick(cmd[i])
					if lastPlayer then
						tfm.exec.linkMice(players[counter], lastPlayer, not off)
					end
					lastPlayer = players[counter]
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>The links involving the following players have been removed: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>The following players now linked: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				end
			end
		elseif cmd[1] == "meep" then
			local off = cmd[#cmd] == "off"

			if cmd[2] == "*" then
				for player in next, tfm.get.room.playerList do
					tfm.exec.giveMeep(player, not off)
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>All the meep powers have been removed.", playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>Meep powers given to all players in the room.", playerName)
				end
			else
				local players, counter = { }, 0
				for i = 2, #cmd - (off and 1 or 0) do
					counter = counter + 1
					players[counter] = string.nick(cmd[i])
					tfm.exec.giveMeep(players[counter], not off)
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>Meep powers removed from players: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>Meep powers given to players: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				end
			end
		elseif cmd[1] == "np" then
			tfm.exec.newGame(cmd[2])
		elseif cmd[1] == "npp" then
			nextMap = cmd[2]
			tfm.exec.disableAutoNewGame()
			tfm.exec.chatMessage("<V>[•] <BL>Next map: " .. tostring(nextMap), playerName)
		elseif cmd[1] == "transformation" then
			local off = cmd[#cmd] == "off"

			if cmd[2] == "*" then
				for player in next, tfm.get.room.playerList do
					tfm.exec.giveTransformations(player, not off)
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>All the transformations powers have been removed.", playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>Transformations powers given to all players in the room.", playerName)
				end
			else
				local players, counter = { }, 0
				for i = 2, #cmd - (off and 1 or 0) do
					counter = counter + 1
					players[counter] = string.nick(cmd[i])
					tfm.exec.giveTransformations(players[counter], not off)
				end

				if off then
					tfm.exec.chatMessage("<V>[•] <BL>Transformations powers removed from players: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				else
					tfm.exec.chatMessage("<V>[•] <BL>Transformations powers given to players: <BV>" .. table.concat(players, "<BL>, <BV>"), playerName)
				end
			end
		end
	end
end

eventColorPicked = function(id, playerName, color)
	eventChatCommand(playerName, "colornick " .. tostring(owners[playerName]) .. " " .. color)
	owners[playerName] = true
end

eventNewGame = function()
	if nextMap then
		nextMap = nil
		tfm.exec.disableAutoNewGame(false)
	end

	local counter = 0
	for _, data in next, tfm.get.room.playerList do
		counter = counter + 1
	end
	miceAlive = counter
end

local tentatives = 0
eventLoop = function(_, remainingTime)
	if nextMap and (remainingTime <= 500 or miceAlive <= 0) then
		tfm.exec.newGame(nextMap)
		tentatives = tentatives + 1

		if tentatives == 5 then
			eventNewGame()
		end
	end
end

eventPlayerDied = function()
	miceAlive = miceAlive - 1
end

eventPlayerWon = function()
	miceAlive = miceAlive - 1
end

eventPlayerLeft = function()
	local counter = 0
	for _, data in next, tfm.get.room.playerList do
		if not data.isDead then
			counter = counter + 1
		end
	end
	miceAlive = counter
end

system.disableChatCommandDisplay()
eventNewGame()

eventNewPlayer = function(n)
	if funcorp then
		tfm.exec.chatMessage("<FC>The FunCorp mode has been activated in this room.", n)
	end
end

local info = string.match(tfm.get.room.name, "#bolodefchoco%d+funcorp0(.+)")
if info then
	string.gsub(info, "%S+", function(value)
		owners[string.nick(value)] = true
	end)
end
