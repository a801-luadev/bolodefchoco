local objects = {
	sbox = { -32/2, -32/2, "17586411471.png" },
	bbox = { -62/2, -62/2, "17586378d04.png" },
	splank = { -100/2, -12/2, "175863cfb88.png" },
	bplank = { -200/2, -12/2, "175863e854a.png" },
	ball = { -30/2, -30/2, "17586559f9a.png" },
	anv = { -52/2, -25/2, "1758656b838.png" },
	cn = { -32/2, -32/2, "1758657eb3c.png" },
	ba = { -32/2, -46/2, "175865981b8.png" },
}

local objectsById = {
	[01] = "sbox",
	[02] = "bbox",
	[03] = "splank",
	[04] = "bplank",
	[06] = "ball",
	[10] = "anv",
	[17] = "cn",
	[28] = "ba"
}

eventSummoningEnd = function(_, _, _, _, _, obj)
	local imgObj = objectsById[obj.baseType]
	if imgObj then
		imgObj = objects[imgObj]
		tfm.exec.addImage(imgObj[3], "#" .. obj.id, imgObj[1], imgObj[2])
	end
end

eventChatCommand = function(_, c)
	local map = c:match("^np (.+)$")
	if map then
		return tfm.exec.newGame(map)
	end

	local name, img, x, y = c:match("^i (%S+) (%S+) ?(%d*) ?(%d*)$")
	if not objects[name] then return end

	x = tonumber(x)
	y = tonumber(y)

	if x then
		objects[name][1] = -x/2
	end
	if y then
		objects[name][2] = -y/2
	end

	objects[name][3] = img
end

tfm.exec.chatMessage("<PS>Commands:\n\t<O>!i [object name] [image] (image width) (image height)\n\n<PS>Example:\n\t<BL><font size='10'>Small box →</font> <O>!i sbox 17586411471.png 32 32\n\t<BL><font size='10'>Big Box →</font> <O>!i bbox 17586378d04.png 62 62\n\t<BL><font size='10'>Small Plank →</font> <O>!i splank 175863cfb88.png 100 12\n\t<BL><font size='10'>Big Plank →</font> <O>!i bplank 175863e854a.png 200 12\n\t<BL><font size='10'>Ball →</font> <O>!i ball 17586559f9a.png 30 30\n\t<BL><font size='10'>Anvil →</font> <O>!i anv 1758656b838.png 52 25\n\t<BL><font size='10'>Cannon (270°) →</font> <O>!i cn 1758657eb3c.png 32 32\n\t<BL><font size='10'>Balloon →</font> <O>!i ba 175865981b8.png 32 46")

tfm.exec.disableAutoNewGame()
tfm.exec.newGame(0)


eventNewPlayer = function(p)
	tfm.exec.setShaman(p)
end

eventNewGame = function()
	for p in next, tfm.get.room.playerList do
		eventNewPlayer(p)
	end
end
eventNewGame()