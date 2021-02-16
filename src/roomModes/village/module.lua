local shiftRoom = tfm.get.room.name:find("shift")

local player = { }

local consumables = {
	carnaval = "17199fa3a38.jpg",
	jigglypuff = "17199e5d230.jpg",
	marshmallow = "17199e61885.jpg",
	partyhorn = "17199fa8269.jpg",
	selfie = "17199e7dd05.jpg"
}
local totalConsumables = 0
for _ in next, consumables do
	totalConsumables = totalConsumables + 1
end
totalConsumables = (800 - totalConsumables*55)

eventNewPlayer = function(playerName)
	player[playerName] = {
		holdingShift = false,
		lastEmote = nil,
		displayingEmotes = false,
		images = { },
		imagesLen = 0,
		cooldown = 0,
		shamanToggle = false,
		hasCheese = false
	}
	system.bindMouse(playerName, true)
	system.bindKeyboard(playerName, 16, true, true) -- Shift
	system.bindKeyboard(playerName, 16, false, true)
	system.bindKeyboard(playerName, 80, false, true) -- P
	system.bindKeyboard(playerName, 76, false, true) -- L
	system.bindKeyboard(playerName, 75, false, true) -- K
	system.bindKeyboard(playerName, 74, false, true) -- J
	tfm.exec.chatMessage("<J>- <B>Click" .. (not shiftRoom and '' or " + Shift") .. "</B> to teleport\n- Press <B>L</B> to see/unsee custom emotes\n- Press <B>P</B> to replay the custom emote selected\n- Press <B>K</B> to toggle your shaman state\n- Press <B>J</B> to toggle cheese", playerName)
end

eventMouse = function(playerName, x, y)
	if not shiftRoom or player[playerName].holdingShift then
		tfm.exec.movePlayer(playerName, x, y)
	end
end

eventKeyboard = function(playerName, key, down)
	local data = player[playerName]

	if key == 16 then
		data.holdingShift = down
	elseif key == 80 then
		if not data.lastEmote then return end
		tfm.exec.playEmote(playerName, data.lastEmote)
	elseif key == 76 then
		local time = os.time()
		if data.cooldown > time then return end
		data.cooldown = time + 5000

		if data.displayingEmotes then
			for i = 1, data.imagesLen do
				tfm.exec.removeImage(data.images[i])
				ui.removeTextArea(i, playerName)
			end
			data.imagesLen = 0
			data.images = { }
		else
			local x
			for k, v in next, consumables do
				data.imagesLen = data.imagesLen + 1
				x = totalConsumables + data.imagesLen*45

				data.images[data.imagesLen] = tfm.exec.addImage(v, ":1", x, 25, playerName)
				ui.addTextArea(data.imagesLen, "<a href='event:" .. k .. "'>\n\n\n\n", playerName, x, 25, 40, 40, 1, 1, 0, true)
			end
		end

		data.displayingEmotes = not data.displayingEmotes
	elseif key == 75 then
		data.shamanToggle = not data.shamanToggle
		tfm.exec.setShaman(playerName, data.shamanToggle)
	elseif key == 74 then
		if data.hasCheese then
			tfm.exec.removeCheese(playerName)
		else
			tfm.exec.giveCheese(playerName)
		end
		data.hasCheese = not data.hasCheese
	end
end

eventTextAreaCallback = function(_, playerName, callback)
	callback = tfm.enum.emote[callback]
	tfm.exec.playEmote(playerName, callback)
	player[playerName].lastEmote = callback
end

eventSummoningEnd = function(_, _, _, _, _, objData)
	tfm.exec.removeObject(objData.id)
end

for playerName in next, tfm.get.room.playerList do
	eventNewPlayer(playerName)
end

tfm.exec.disableAllShamanSkills()