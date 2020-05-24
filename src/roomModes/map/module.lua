local mapWidth, mapHeight = 800, 400
local getCoordinates = function(x, y)
	return 600 + (200 * x / mapWidth), 300 + (100 * y / mapHeight)
end
local getScale = function(w, h)
	return 200 * w / mapWidth, 100 * h / mapHeight
end

eventNewPlayer = function(playerName)
	tfm.exec.lowerSyncDelay(playerName)
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)

local O = 0
eventNewGame = function()
	loadNewMap = false

	for t = O, -1 do
		ui.removeTextArea(t)
	end
	O = 0

	local xml = tfm.get.room.xmlMapInfo
	if xml then
		string.gsub(xml.xml, "<P (.-)/>", function(settings)
			mapWidth = math.max(tonumber(string.match(settings, "L=\"(%d+)\"")) or 800)
			mapHeight = math.max(tonumber(string.match(settings, "H=\"(%d+)\"")) or 400)
		end, 1)

		local Z = 0
		tfm.exec.addPhysicObject(Z, 700, 350, {
			type = 12,
			width = 200,
			height = 100,
			miceCollision = false,
			groundCollision = false,
			color = 0x6A7495,
			foreground = true,
		})

		string.gsub(xml.xml, "<S (.-)/>", function(groundContent)
			local X = tonumber(string.match(groundContent, "X=\"(%-?%d+%.?%d*)\"")) or 10
			local Y = tonumber(string.match(groundContent, "Y=\"(%-?%d+%.?%d*)\"")) or 10
			local L = tonumber(string.match(groundContent, "L=\"(%-?%d+%.?%d*)\"")) or 10
			local H = tonumber(string.match(groundContent, "H=\"(%-?%d+%.?%d*)\"")) or 10
			local T = tonumber(string.match(groundContent, "T=\"(%d+)\"")) or 0
			local A = tonumber(string.match(groundContent, "P=\".-,.-,.-,.-,(%-?%d+%.?%d*),.-\"")) or 0
			local O = string.match(groundContent, "o=\"(%x+)\"")
			O = O and tonumber("0x" .. O, 16)

			X, Y = getCoordinates(X, Y)
			L, H = getScale(L, H)

			Z = Z + 1
			tfm.exec.addPhysicObject(Z, X, Y, {
				type = T,
				width = L,
				height = H,
				angle = A,
				miceCollision = false,
				groundCollision = false,
				color = O,
				foreground = true,
			})
		end)

		string.gsub(xml.xml, "<([FT]) (.-)/>", function(objectType, objectContent)
			local X = tonumber(string.match(objectContent, "X=\"(%d+)\"")) or 10
			local Y = tonumber(string.match(objectContent, "Y=\"(%d+)\"")) or 10

			X, Y = getCoordinates(X, Y)

			local color = (objectType == "F" and 0xFFFA00 or 0xFF5E4C)

			O = O - 1
			ui.addTextArea(O, "", nil, X, Y, 1, 1, color, color, .4, false)
		end)
	else
		loadNewMap = true
	end
end

system.looping(function()
	for playerName, playerData in next, tfm.get.room.playerList do
		if not playerData.isDead then
			local color = playerData.isShaman and 0x00E3FF or 0xFFFFFF
			local x, y = getCoordinates(playerData.x, playerData.y)
			ui.addTextArea(playerData.id, "", nil, x, y, 1, 1, color, color, .4, false)
		end
	end
end, 4)

eventLoop = function()
	if loadNewMap then
		tfm.exec.newGame()
	end
end

eventPlayerDied = function(playerName)
	ui.removeTextArea(tfm.get.room.playerList[playerName].id)
end
eventPlayerWon = eventPlayerDied

eventChatCommand = function(n, c)
	if owners[n] and c:sub(1, 2) == "np" then
		tfm.exec.newGame(c:sub(4))
	end
end