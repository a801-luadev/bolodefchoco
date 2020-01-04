local PAGE_LINES = 20

ui.menu = function(text, playerName, x, y, w, h)
	local id = 300 - 8

	x = x + 6
	y = y + 6

	ui.addTextArea(0, "", playerName, -1500, -1500, 5000, 5000, 1, 1, .2)

	ui.addTextArea(id, "", playerName, x, y, w, h, 0x78462B, 0x78462B, 1)

	ui.addTextArea(id - 1, "", playerName, x, y, 20, 20, 0xBEB17D, 0xBEB17D, 1)
	ui.addTextArea(id - 2, "", playerName, x + w - 20, y, 20, 20, 0xBEB17D, 0xBEB17D, 1)
	ui.addTextArea(id - 3, "", playerName, x, y + h - 20, 20, 20, 0xBEB17D, 0xBEB17D, 1)
	ui.addTextArea(id - 4, "", playerName, x + w - 20, y + h - 20, 20, 20, 0xBEB17D, 0xBEB17D, 1)

	ui.addTextArea(id - 5, "", playerName, x, y + (h + 40) / 4, w, ((h - 40) / 2), 0x9D7043, 0x9D7043, 1)
	ui.addTextArea(id - 6, "", playerName, x + (w + 40) / 4, y, ((w - 40) / 2), h, 0x9D7043, 0x9D7043, 1)

	ui.addTextArea(id - 7, text, playerName, x + 3, y + 3, w - 6, h - 6, 0x1C3A3E, 0x0E1619, 1)
end
ui.button = function(id, text, eventName, playerName, x, y, w, h)
	id = 200 + id * 2

	ui.addTextArea(id, "", playerName, x + 1, y + 2, w, h, 1, 1, 1)
	ui.addTextArea(id - 1, "<p align='center'><font size='13'><a href='event:" .. eventName .. "'>" .. text .. "\n", playerName, x, y, w, h, 0x142A2D, 0x142A2D, 1)
end

local playerData = { }
local lastUpdate

local infoName, totalPages, info = { "Name", "Rounds", "Cheese", "First", "Normal Saves", "Hard Mode", "Divine Mode" }, 0

local displayData = function(playerName)
	local page = (((playerName and playerData[playerName] or 1) - 1) * PAGE_LINES) + 1

	local numbers, counter, data, color = { }, 0, { }
	for i = page, page + (PAGE_LINES - 1) do
		if not info[i] then break end
		color = (i % 2 == 1 and "<N>" or "<N2>")

		counter = counter + 1
		numbers[counter] = color .. "#" .. i

		for j = 1, #infoName do
			if not data[j] then
				data[j] = { }
			end
			data[j][counter] = color .. tostring(info[i][j])
		end
	end

	ui.updateTextArea(0, "<p align='center'>" .. table.concat(numbers, "\n"), playerName)
	for i = 1, #infoName do
		ui.updateTextArea(i, "<p align='center'>" .. table.concat(data[i], '\n'), playerName)
	end
end

local showLastUpdated = function()
	ui.setMapName("Last updated: " .. os.date("%Y-%m-%d", lastUpdate))
end

ui.leaderboard = function(playerName, ignore)
	ui.menu("<textformat leading='-20'><p align='center'><font size='20'>Transformice Leaderboard\n<G>_______________________", playerName, 0, 21, 908, 365)
	ui.addTextArea(0, '', playerName, 15, 110, 34, 272, 0x142A2D, 0x142A2D, 1)

	local x, w = -60
	for i = 1, #infoName do
		w = (i == 1 and 140 or 105)
		x = x + (i == 1 and 121 or i == 2 and 152 or 117)
		ui.addTextArea(i, '', playerName, x, 110, w, 272, 0x142A2D, 0x142A2D, 1)
		ui.addTextArea(-i, "<p align='center'>" .. infoName[i], playerName, x, 78, w, 20, 0x142A2D, 0x142A2D, 1)
	end

	ui.button(1, "&lt; Previous page", "left", playerName, 15, 36, 200, 20)
	ui.button(2, "Next page >", "right", playerName, 705, 36, 200, 20)

	if not ignore then
		displayData(playerName)
	end
end

local dotNumber = function(number)
	number = tostring(number)
	local isT = #number % 3 == 0
	number = string.reverse(number)
	number = string.gsub(number, "%d%d%d", "%1,")
	number = string.reverse(number)
	if isT then
		number = string.sub(number, 2)
	end
	return number
end

eventTextAreaCallback = function(id, playerName, callback, ignore)
	if callback == "right" then
		ui.removeTextArea(-201, playerName)
		playerData[playerName] = playerData[playerName] + 1
		if playerData[playerName] >= totalPages then
			playerData[playerName] = totalPages
			ui.addTextArea(-203, "<p align='center'><font size='13'><N2>Next page >", playerName, 705, 36, 200, 20, 0x142A2D, 0x142A2D, 1)
		end

		displayData(playerName)
	elseif callback == "left" then
		ui.removeTextArea(-203, playerName)
		playerData[playerName] = playerData[playerName] - 1
		if playerData[playerName] <= 1 then
			playerData[playerName] = 1
			ui.addTextArea(-201, "<p align='center'><font size='13'><N2>&lt; Previous page", playerName, 15, 36, 200, 20, 0x142A2D, 0x142A2D, 1)
		end

		if not ignore then
			displayData(playerName)
		end
	end
end

eventNewPlayer = function(playerName, ignore)
	playerData[playerName] = 2
	if info then
		ui.leaderboard(playerName, true)
		eventTextAreaCallback(nil, playerName, "left", ignore)
		showLastUpdated()
	end
end

eventFileLoaded = function(_, data)
	lastUpdate, data = string.match(data, "^(%d+)(.+)")
	lastUpdate = lastUpdate * 1000

	local ranking = string.split(data, "[^\002]+")
	local len = #ranking
	for i = 1, len do
		ranking[i] = string.split(ranking[i], "[^\001]+")
		for k = 1, #infoName do
			if k == 1 then
				ranking[i][k] = string.gsub(ranking[i][k], "#%d+", "<G><font size='10'>%1</font></G>", 1)
			elseif k ~= 2 then
				ranking[i][k] = dotNumber(ranking[i][k]) .. " <BL><font size='8'>" .. (math.ceil((ranking[i][k] / ranking[i][2]) * 1000) / 10) .. "%</font></BL>"
			end
		end
		ranking[i][2] = dotNumber(ranking[i][2])
	end
	info = ranking
	totalPages = math.ceil(len / PAGE_LINES)

	for playerName in next, tfm.get.room.playerList do
		eventNewPlayer(playerName, true)
	end
	displayData()
	showLastUpdated()
end
system.loadFile(4)

tfm.exec.disableAutoNewGame()
tfm.exec.disableMortCommand()
tfm.exec.disableAutoShaman()
tfm.exec.newGame('<C><P L="920" /><Z><S><S L="920" H="136" X="460" Y="446" T="6" P="0,0,0.3,0.2,0,0,0,0" /><S L="10" H="10" X="-5" Y="360" T="12" P="0,0,0,0,0,0,0,0" /><S L="10" X="925" H="10" Y="360" T="12" P="0,0,0,0,0,0,0,0" /><S L="920" X="460" H="10" Y="334" T="12" P="0,0,0,0,0,0,0,0" /></S><D><DS Y="360" X="460" /></D><O /></Z></C>')