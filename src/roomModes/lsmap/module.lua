local images = {
	lsmap = "165ddeefd5d.png",
	map_display = "165ddec178d.png",
	maps = {
		["@560778"] = "165dde71cd7.png",
		["@565330"] = "165dde7d970.png",
		["@574683"] = "165dde7ff14.png"
	}
}
table.sort(images.maps, function(m1, m2)
	return tonumber(m1:sub(2)) < tonumber(m2:sub(2))
end)

local info = { }
eventNewPlayer = function(playerName, skip)
	info[playerName] = { display = -1, map = -1 }

	if not skip then
		for k, v in next, images do
			if type(v) == "table" then
				for i, j in next, v do
					tfm.exec.addImage(j, "?0", -2000, -2000, playerName)
				end
			else
				tfm.exec.addImage(v, "?0", -2000, -2000, playerName)
			end
		end

		tfm.exec.addImage(images.lsmap, "!1", 55, 24, playerName)

		tfm.exec.chatMessage("<ROSE>Support <B>https://atelier801.com/topic?f=6&t=876691</B></ROSE>", playerName)
	end
	ui.addTextArea(0, "<font size='12'><V>" .. playerName .. "<N>'s maps: <BV>3", playerName, 65, 60, nil, nil, 1, 1, 0, true)

	local nick = playerName:gsub("#0000", "")

	local maps, counter = { }, 0
	for map in next, images.maps do
		counter = counter + 1
		maps[counter] = nick .. " - " .. map .. " - 0 - 100% - P" .. math.random(0, 1) .. " <BV><a href='event:display_" .. map .. "'>[Display map]</a>"
	end
	ui.addTextArea(1, "<font size='12'>" .. table.concat(maps, "\n<N>"), playerName, 65, 88, nil, nil, 1, 1, 0, true)
	ui.addTextArea(2, "<p align='center'><a href='event:close_lsmap'>Close\n", playerName, 55, 369, 684, nil, 1, 1, 0, true)
end

eventTextAreaCallback = function(id, playerName, callback)
	local cbk, counter = { }, 0
	string.gsub(callback, "[^_]+", function(w)
		counter = counter + 1
		cbk[counter] = w
	end)

	if cbk[1] == "display" then
		for i = 0, 2 do
			ui.removeTextArea(i, playerName)
		end

		info[playerName].display = tfm.exec.addImage(images.map_display, "!200", 190, 38, playerName)
		ui.addTextArea(0, "<p align='center'><font size='15'><B>" .. cbk[2], playerName, 200, 55, 400, nil, 1, 1, 0, true)

		info[playerName].map = tfm.exec.addImage(images.maps[cbk[2]], "!300", 200, 80, playerName)

		ui.addTextArea(1, "<p align='center'><a href='event:save_image_" .. cbk[2] .. "'>Save map image\n", playerName, 55, 304, 684, nil, 1, 1, 0, true)
		ui.addTextArea(2, "<p align='center'><a href='event:save_thumbnail_" .. cbk[2] .. "'>Save map thumbnail\n", playerName, 55, 328, 684, nil, 1, 1, 0, true)
		ui.addTextArea(3, "<p align='center'><a href='event:close_display'>Close\n", playerName, 55, 353, 684, nil, 1, 1, 0, true)
	elseif cbk[1] == "close" and cbk[2] == "display" then
		ui.removeTextArea(3, playerName)

		tfm.exec.removeImage(info[playerName].map, playerName)
		tfm.exec.removeImage(info[playerName].display, playerName)

		eventNewPlayer(playerName, true)
	end
end

eventNewGame = function()
	for playerName in next, tfm.get.room.playerList do
		eventNewPlayer(playerName)
	end
end

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()

tfm.exec.newGame('<C><P /><Z><S><S L="3000" H="72" X="401" Y="408" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="918" H="590" X="414" Y="93" T="12" P="0,0,9999,0.2,0,0,0,0" /></S><D><DS Y="373" X="410" /></D><O /></Z></C>')
