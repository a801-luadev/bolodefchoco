local secToDate = function(s)
	local m = (s / 60) % 60
	local h = (s / 3600) % 24

	s = s % 60

	return string.format("%02dh%02dm%02ds", h, m, s)
end

local info = { }

local genData
do
	genData = function()
		local numbers = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

		local number, n = { _set = { } }
		for i = 1, 4 do
			n = table.remove(numbers, math.random((i == 1 and 2 or 1), #numbers))
			number[i] = n
			number._set[n] = true
		end

		return {
			time = 0,
			tentative = 1,
			digit = 1,
			sequence = { _set = { } },
			number = number,
			restart = false
		}
	end
end

local input = function(playerName, id, highlighted)
	ui.addTextArea(id, "<p align='center'><font size='20'>" .. (type(highlighted) ~= "boolean" and highlighted or ''), playerName, 243 + ((id - 1) * 60), 60, 40, 30, (highlighted == true and 0x323232 or 1), 1, .7, true)
end

local str = "<p align='center'><font size='20'>"

local displayInterface = function(playerName)
	ui.addTextArea(-2, "<p align='center'><font size='16'>  Guessed    Exist   Match", playerName, 5, 25, 220, 365, 1, 1, .5, true)
	ui.addTextArea(-1, "<p align='center'><font size='16'>Enter number [0-9]", playerName, 233, 25, 243, 365, 1, 1, .5, true)
	ui.addTextArea(0, str, playerName, 233, 100, 243, nil, 1, 1, 0, true)

	local displayFields, y = 4
	for i = 1, 4 do
		input(playerName, i, (i == 1))
	end
	for i = 0, 6 do
		displayFields = displayFields + 3
		y = 60 + (i * 48)
		ui.addTextArea(displayFields - 2, str, playerName, 15, y, 80, 30, 1, 1, .7, true)
		ui.addTextArea(displayFields - 1, str, playerName, 115, y, 40, 30, 1, 1, .7, true)
		ui.addTextArea(displayFields    , str, playerName, 175, y, 40, 30, 1, 1, .7, true)
	end
end

local newPlayer = function(playerName)
	info[playerName] = genData()
	displayInterface(playerName)
end

local bytes = { 16, 46, string.byte(" 0123456789abcdefghij`", 1, -1) }
eventNewPlayer = function(playerName)
	newPlayer(playerName)

	for i = 1, #bytes do
		system.bindKeyboard(playerName, bytes[i], true, true)
	end
	tfm.exec.setPlayerScore(playerName, 0)

	tfm.exec.chatMessage("<O>Type <B>!help</B> to learn how play.</O>\n<D>Thanks to <O><B>Blank#3495</B></O> and his great ideas</D>", playerName)
end
for playerName in next, tfm.get.room.playerList do
	eventNewPlayer(playerName)
end

eventNewGame = function()
	for playerName in next, tfm.get.room.playerList do
		tfm.exec.killPlayer(playerName)
	end
end

eventLoop = function()
	for playerName, data in next, info do
		if not data.restart then
			data.time = data.time + .5
			if data.time % 1 == 0 then
				ui.updateTextArea(0, "<D><B>" .. secToDate(data.time) .. "</B></D>\n\n\nPress <D><B>Space</B></D> to send the number;\n\nPress <D><B>Shift</B></D> to erase the last number;\n\nPress <D><B>Delete</B></D> to start a new game.", playerName)
			end
		end
	end
end

eventKeyboard = function(playerName, key)
	local k = key
	key = tonumber(string.char(key))

	if k == 46 then
		return newPlayer(playerName)
	elseif k == 32 then
		if info[playerName].restart then
			return newPlayer(playerName)
		end

		if info[playerName].digit < 5 then return end

		local exist, match = 0, 0
		for i = 1, 4 do
			if info[playerName].number._set[info[playerName].sequence[i]] then
				exist = exist + 1
			end
			if info[playerName].number[i] == info[playerName].sequence[i] then
				match = match + 1
			end
		end

		local tentative = info[playerName].tentative * 3
		ui.updateTextArea(4 + tentative - 2, table.concat(info[playerName].sequence, ''), playerName)
		ui.updateTextArea(4 + tentative - 1, exist, playerName)
		ui.updateTextArea(4 + tentative, match, playerName)

		info[playerName].tentative = info[playerName].tentative + 1
		if info[playerName].tentative < 8 then
			info[playerName].digit = 1
			info[playerName].sequence = { _set = { } }
			for i = 1, 4 do
				input(playerName, i, (i == 1))
			end
		end

		if match == 4 then
			tfm.exec.chatMessage("<O>You <B>won</B> (<B>" .. secToDate(info[playerName].time) .. "</B>)! The number was <D><B>" .. table.concat(info[playerName].number, '') .. "</B></D>. Press <B>Space</B> to play again.</O>", playerName)
			tfm.exec.setPlayerScore(playerName, 1, true)
			info[playerName].restart = true
		else
			if info[playerName].tentative == 8 then
				tfm.exec.chatMessage("<O>You <B>lose</B>! The number was <D><B>" .. table.concat(info[playerName].number, '') .. "</B></D>. Press <B>Space</B> to play again.</O>", playerName)
				info[playerName].restart = true
			end
		end
	else
		if info[playerName].restart then return end
		if k == 16 then
			info[playerName].digit = math.max(1, info[playerName].digit - 1)
			if not info[playerName].sequence[info[playerName].digit] then return end

			info[playerName].sequence._set[info[playerName].sequence[info[playerName].digit]] = nil
			info[playerName].sequence[info[playerName].digit] = nil

			input(playerName, math.min(4, info[playerName].digit + 1))
			input(playerName, info[playerName].digit, true)
		else
			if not tonumber(key) then
				key = tonumber(string.char(k - 48))
			end
			if info[playerName].digit == 1 and key == 0 then return end
			if info[playerName].sequence._set[key] then return end
			if info[playerName].digit == 5 then return end

			info[playerName].sequence._set[key] = true
			info[playerName].sequence[info[playerName].digit] = key
			input(playerName, info[playerName].digit, key)

			info[playerName].digit = info[playerName].digit + 1
			if info[playerName].digit < 5 then
				input(playerName, info[playerName].digit, true)
			end
		end
	end
end

eventChatCommand = function(playerName, command)
	if command == "help" then
		tfm.exec.chatMessage("<O>Computer selects a four digit number [0-9], all four digits are different. Number may not begin with 0. Any number can be guessed in 7 tries or less.\n\t- <B>Exist</B> column displays total number of digits you guessed right.\n\t- <B>Match</B> shows how many of those that exists were placed at the right spots.</O>", playerName)
	end
end

eventPlayerLeft = function(playerName)
	info[playerName] = nil
end

system.disableChatCommandDisplay()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoScore()
tfm.exec.disableAutoShaman()
tfm.exec.newGame('<C><P /><Z><S /><D /><O /></Z></C>')