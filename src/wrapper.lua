local isTribeHouse = string.byte(tfm.get.room.name, 2) == 3

local getMode = function(modes, modeName)
	if modeName then
		if isTribeHouse then
			tribeModes(modeName)
		else
			modeName = string.lower(modeName) -- Tribe houses won't be lowered to avoid conflicts
			roomModes(modeName)
		end
	else
		modeName = "main"
	end

	return modes[modeName] or modules["main"], modeMetaInfo[modeName] or modeMetaInfo["main"]
end

local startMode = function(gameMode)
	xpcall(gameMode, function(err)
		print(err)
		print(debug.traceback())
	end)

	if gameMode ~= modules.main then
		modeMetaInfo = nil
	end
	modules = nil
	tribeModule = nil
end

local checkOwners = function(owners)
	for playerName in next, tfm.get.room.playerList do
		if owners[playerName] then
			return true
		end
	end
	return false
end

local roomAdmins = function(pos)
	local list = string.split(string.sub(tfm.get.room.name, (pos or 1)), "%+?%a[%w_][%w_][%w_]*#%d%d%d%d")
	for playerName = 1, #list do
		playerName = string.nick(list[playerName])

		owners[playerName] = true

		tfm.exec.chatMessage("<N2>[#bolodefchoco] You are now a room admin.", playerName)
	end
end

local loadTeams = function()
	system.loadFile(3)

	eventFileLoaded = function(id, data)
		for team, data in string.gmatch(data, "(%a+){(.-)}") do
			_TEAM[team] = { }
			team = _TEAM[team]

			list = string.split(data, "[^;]+")

			for i = 1, #list, 2 do -- name;community
				team[list[i]] = list[i + 1]
			end
		end

		_TEAM._loaded = true
	end
end

if isTribeHouse then -- Is tribe house
	local gameMode, meta = getMode(tribeModule, tfm.get.room.name)

	if meta.owners then
		if not checkOwners(meta.owners) then
			gameMode, meta = getMode(modes) -- default
		end
	end

	if meta.loadTeams then
		loadTeams(gameMode)
	end

	startMode(gameMode)
else
	local modeName, argsPos = string.match(tfm.get.room.name, "%d+([%a_]+)()")
	local gameMode, meta = getMode(modules, modeName)

	if meta.hasAdmin then
		roomAdmins(argsPos)
	end

	if meta.loadTeams then
		loadTeams(gameMode)
	end

	startMode(gameMode)
end