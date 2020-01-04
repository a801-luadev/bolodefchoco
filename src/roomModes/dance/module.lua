tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.disableAfkDeath(true)

players = {}
timerList = {}
moves = {
	[1] = {direction = -90; key = 39, key_ = 68}, --right
	[2] = {direction = 90; key = 37, key_ = 65}, -- left
	[3] = {direction = -180; key = 38, key_ = 87}, -- up
	[4] = {direction = 0; key = 40, key_ = 83}, -- down
}
waves = {
	[1] = {seconds = 1800, loops = 38},
	[2] = {seconds = 1500, loops = 50},
	[3] = {seconds = 1000, loops = 55},
}
default = {
	stats = {
		waves = 0,
		wins = 0,
		deaths = 0,
		right = 0,
		wrong = 0,
	},
}
keys = {
	68,
	65,
	87,
	83,
	39,
	37,
	38,
	40,
	72,
}
messages = {
	_help = '<p align=\'center\'><font color=\"#009d9d\"><b><font size=\"20\">#dance</font></b></font></p><br>Move in the right directions. If you do movement right, you get <font color=\"#92d64d\">3 points</font>! If you don\'t, you get <font color=\"#d64d4d\">-2 points</font>!<br><br>Every round <span>consists of</span> 3 waves (<i>1 wave per minute!</i>). With every new wave you have to move faster and faster. If you make mistakes too much, you\'re going to be killed.<br><br><div>Use arrows or WASD to move and have fun in our <V>#DANCE<N>-PARTY!</div><br>',
	_start = '<J>Հ[#DANCE] <N>You have <V>10 seconds<N> to get ready!',
	_go = '<J>Հ[#DANCE] <N>GO!',
	_newWave = '<J>Հ[#DANCE] <V>Wave %x<N> starts right now!',
	_win = '<J>Հ[#DANCE] <V>%s <N>won!',
	_welcome = '<J>Հ[#DANCE] <N>Welcome to our <V>#dance<N>-party! Press <V>[H]<N> to learn more. Report any issues to <V>Aviener#0000',
	_right = '<BL>Right! +3',
	_wrong = '<BL>Wrong! -2',
	_draw = '<N>Nobody has won! :['
}

module = {
	start = function()
		for name,player in pairs(tfm.get.room.playerList) do
			-- module.players.getData(name)
			players[name] = {lock = true, opennedPopup = false}
			for i, key in ipairs(keys) do
				system.bindKeyboard(name, key, true, true)
			end
		end
		tfm.exec.setGameTime(10)
		--print('<J>## <BL>Game is loaded!')
	end,
	addMove = function()
		if started == true then
			points = points + 1
			for name,player in pairs(tfm.get.room.playerList) do
				if not player.isDead then
					players[name].lock = false
				end
			end
			i = math.random(1, 4)
			tfm.exec.addShamanObject(0, 400, 200, moves[i].direction)
			return moves[i].key, moves[i].key_, points
		end
	end,
	newWave = function()
		if started == true then
			wave = wave + 1
			module.UI.changeStatusBar(wave)
		end
		for name,player in pairs(tfm.get.room.playerList) do
			if player.score < points then
				tfm.exec.killPlayer(name)
			end
		end
		module.timers.addTimer(module.addMove, waves[wave].seconds, waves[wave].loops, i)
		module.UI.message(string.format(messages._newWave, wave))
	end,
	timers = {
		addTimer = function(callback, time, loops, label, ...)
			local id = #timerList + 1
			timerList[id] = {
			callback = callback,
			time = time,
			loops = loops or 1,
			label = label,
			arguments = {...},
			isComplete = false,
			currentTime = 0,
			currentLoop = 0,
			}
			return id
		end,
		removeTimer = function(id)
			if timer[id] then
				timerList[id] = 0
				return true
			end
		return false
		end,
		removeAll = function()
			timerList = {}
		end,
	},
	--User Interface
	UI = {
		changeStatusBar = function(wave)
			if wave <= 3 then
				local code = tfm.get.room.currentMap
				local author = tfm.get.room.xmlMapInfo.author
				tfm.exec.setUIMapName('<J>'..author..'<BL> - '..code..'   <font color="#5a5f6e">|</font>   <N>Wave: <V>'..wave..'/3')
			end
		end,
		message = function(message, name)
			tfm.exec.chatMessage(message, name)
			--print (message)
		end,
		addPopup = function(id, text, n, x, y, width, height)
			players[n].opennedPopup = true
			ui.addTextArea(id, "", n, x +  - 2, y + 18, width + 24, height + 14, 0x2E221B, 0x2E221B, 1, true)
			ui.addTextArea(id + 1, "", n, x + - 1, y + 19, width + 22, height + 12, 0x986742, 0x986742, 1, true)
			ui.addTextArea(id + 2, "", n, x + 2, y + 22, width + 16, height + 6, 0x171311, 0x171311, 1, true)
			ui.addTextArea(id + 3, "", n, x + 3, y + 23, width + 14, height + 4, 0x0C191C, 0x0C191C, 1, true)
			ui.addTextArea(id + 4, "", n, x + 4, y + 24, width + 12, height + 2, 0x24474D, 0x24474D, 1, true)
			ui.addTextArea(id + 5, "", n, x + 5, y + 25, width + 10, height + 0, 0x183337, 0x183337, 1, true)
			ui.addTextArea(id + 6, text, n, x + 6, y + 26, width + 8, height + - 2, 0x324650, 0x324650, 1, true)
			ui.addTextArea(id + 7, "", n, x + 12, y + height - 20 + 25, width - 5, 15, 0x5D7D90, 0x5D7D90, 1, true)
			ui.addTextArea(id + 8, "", n, x + 12, y + height - 20 + 27, width - 5, 15, 0x11171C, 0x11171C, 1, true)
			ui.addTextArea(id + 9, "<p align='center'><a href='event:close'><N>Close</a>", n, x + 12, y + height - 20 + 26, width - 5, 15, 0x3C5064, 0x3C5064, 1, true)
		end,
		removePopup = function(id, n)
			for id = id, (id + 9) do
				ui.removeTextArea(id, n)
			end
			players[n].opennedPopup = false
		end;
	},
	--Players settings, data and etc
	players = {
		--[[getData = function(name)
				local data = system.loadPlayerData(name)
				if data == nil then
					set default 0/0/0/0
				end
				return data end
			end,]]
	},

}
eventNewGame = function()
	started = false
	wave = 1
	points = 0
	module.timers.removeAll()
	for name,player in pairs(tfm.get.room.playerList) do
		players[name].lock = true
		tfm.exec.setPlayerScore(name, 0, false)
	end
	tfm.exec.setGameTime(220)
	module.UI.message(messages._start)
	module.UI.changeStatusBar(wave)
	module.timers.addTimer(module.addMove, waves[wave].seconds, waves[wave].loops, i)
	module.timers.addTimer(module.newWave, 60000, 2)
end
eventNewPlayer = function (name)
	if started == true then
		players[name].lock = true;
	end;
	module.UI.message(messages._welcome, n);
end;
function eventKeyboard(name, key, down, x, y)
	if key~= 72 and players[name].lock == false and started == true then
		if key == moves[i].key or key == moves[i].key_ then
			module.UI.message(messages._right, name)
			tfm.exec.setPlayerScore(name, 3, true)
			players[name].lock = true
		else
			module.UI.message(messages._wrong, name)
			tfm.exec.setPlayerScore(name, -2, true)
			players[name].lock = true
		end
	end
	if key == 72 and not players[name].opennedPopup then
		module.UI.addPopup(1, messages._help, name, 230, 100, 327, 210)
	elseif key == 72 and players[name].opennedPopup then
		module.UI.removePopup(1, name)
	end
end
function eventTextAreaCallback(textAreaID, name, callback)
	if callback == 'close' then
		module.UI.removePopup(1, name)
	end
end
eventPlayerDied = function(name)
	local i = 0
	n = name
	for name,player in pairs(tfm.get.room.playerList) do
		if not player.isDead then
			i = i + 1
		end
	end
	if i == 1 then
		n = name
		tfm.exec.playerVictory(name)
		module.UI.message(string.format(messages._win, name))
	end
	if i == 0 then
		tfm.exec.setGameTime(0)
		module.UI.message(messages._draw)
	end
end
eventLoop = function(time, remain)
	-- timer
	local timersToRemove = {}
	for id = 1, #timerList do
		local timer = timerList[id]
		if type(timer) == 'table' then
			if not timer.isComplete then
				timer.currentTime = timer.currentTime + 500
				if timer.currentTime >= timer.time then
					timer.currentTime = 0
					timer.currentLoop = timer.currentLoop + 1
					if timer.loops > 0 then
						if timer.currentLoop >= timer.loops then
							timer.isComplete = true
						end
					end
					if type(timer.callback) == 'function' then
						timer.callback(timer.currentLoop, table.unpack(timer.arguments))
					end
				end
			end
			if timer.isComplete then
				if type(eventTimerComplete) == 'function' then
					eventTimerComplete(id, timer.label)
				end
				timersToRemove[#timersToRemove+1] = id
			end
		end
	end
	if time >= 10000 and started == false then
		started = true
		module.UI.message(messages._go)
	end
	if remain <= 0 then
		tfm.exec.newGame(6680501)
	elseif remain <= 40 then
		started = false
		for name,player in pairs(tfm.get.room.playerList) do
			if player.score < points then
				tfm.exec.killPlayer(name)
			end
		end
	end
end


module.start()