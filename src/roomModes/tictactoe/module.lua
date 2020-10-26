---------------------------
-- Script: Tic Tac Toe
-- Author: Natsmiro#0000
---------------------------

lang = tfm.get.room.community

---------------------------------------------

local lower, upper, format, gsub, match, nick = string.lower, string.upper, string.format, string.gsub, string.match, string.nick

languages = {
	["br"] = {
		["player"] = "Jogador %d",
		["start"] = "Iniciar",
		["restart"] = "Reiniciar",
		["win"] = "O vencedor foi %s!",
		["welcome"] = "<J>Bem-vindo ao Tic Tac Toe. Veja a lista de comandos disponíveis digitando</J> <BL>!help</BL><J>.</J>",
		["notroomowner"] = "<J>Você não é um dono da sala. Para criar sua própria sala digite:</J> <BL>/room #bolodefchoco0tictactoe %s</BL>",
		["help"] = "!help: mostra os comandos disponíveis.\n!reset: reinicia a partida.\n!admin: adiciona ou remove um administrador."
	},
	["en"] = {
		["player"] = "Player %d",
		["start"] = "Start",
		["restart"] = "Restart",
		["win"] = "The winner was %s!",
		["welcome"] = "<J>Welcome to Tic Tac Toe. See available commands by typing</J> <BL>!help</BL><J>.</J>",
		["notroomowner"] = "<J>You are not a room owner. To create your own room type:</J> <BL>/room #bolodefchoco0tictactoe %s</BL>",
		["help"] = "!help: shows available commands.\n!reset: restart the match.\n!admin: add or remove an administrator."
	},
	["es"] = {
		["player"] = "Jugador %d",
		["start"] = "Comenzar",
		["restart"] = "Reiniciar",
		["win"] = "El ganador fue %s!",
		["welcome"] = "<J>Bienvenido a Tic Tac Toe. Vea la lista de comandos disponibles escribiendo</J> <BL>!help</BL><J>.</J>",
		["notroomowner"] = "<J>No eres el dueño de la sala. Para crear la tuya escribe:</J> <BL>/room #bolodefchoco0tictactoe %s</BL>",
		["help"] = "!help: muestra los comandos disponibles.\n!reset: reiniciar el partido.\n!admin: agrega o elimina un administrador."
	},
}

languages["pt"] = languages["br"]

if not languages[lang] then
	lang = "en"
end

local players = {
	["x"] = nil,
	["o"] = nil
}

local winner = nil

tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoTimeLeft(true)

local mapxml = '<C><P F="0" /><Z><S><S L="800" H="49" X="400" Y="376" T="6" P="0,0,0.3,0.2,0,0,0,0" /><S L="19" X="-10" H="403" Y="200" T="0" m="" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="19" H="403" Y="200" T="0" m="" X="810" /></S><D><P P="0,0" Y="355" T="4" X="758" /><P P="0,0" Y="353" T="12" X="59" /><P P="0,0" Y="355" T="11" X="586" /><P P="0,0" Y="352" T="0" X="367" /><P P="0,0" Y="353" T="0" X="410" /><DS Y="333" X="400" /></D><O /></Z></C>'

tfm.exec.newGame(mapxml)
ui.setMapName("Tic Tac Toe")

-----------------
local tttGUI = {}
local selected = 0

local possibilities = {
	{1, 2, 3},
	{4, 5, 6},
	{7, 8, 9},
	{1, 5, 9},
	{3, 5, 7},
	{1, 4, 7},
	{2, 5, 8},
	{3, 6, 9}
}

local gametie = false
local turn = nil
local outsideTheRoom = {}
local nextPlay = os.time() + 500 -- Avoid duplicate clicks

function eventTextAreaCallback (textareaid, p, event)
	if not turn then
		if match(event, "select(%a)%-([%w+_%d#]+)") then
			local xo, player = match(event, "select(%a)%-([%w+_%d#]+)")

			if players[xo] ~= lower(player) then
				players[xo] = lower(player)
			else
				players[xo] = nil
			end

			playerSelector()
		end

		if event == "start" then
			ui.removeTextArea(9)
			ui.removeTextArea(10)
			ui.removeTextArea(11)
			ui.removeTextArea(12)

			turn = math.random(1,2)
			if turn == 1 then
				turn = players.x
			else
				turn = players.o
			end

			tttDisplay()
			tfm.exec.setGameTime(300)
		end
	else
		if not winner and not gametie then
			if match(event, "pos%d") then
				local pos = tonumber(match(event, "%d"))

				if not tttGUI[pos] and (nextPlay and os.time() > nextPlay) then
					if turn == players.x then
						tttGUI[pos] = "<font color='#101010'>X</font>"
					else
						tttGUI[pos] = "<font color='#101010'>O</font>"
					end

					selected = selected + 1
					nextPlay = os.time() + 500

					if turn == players.x then
						turn = players.o
					else
						turn = players.x
					end
				end
			end

			for k, v in next, possibilities do
				local found = {}

				for _k, _v in next, v do
					found[#found + 1] = tttGUI[_v]
				end

				local values = table.concat(found, ""):gsub("<.->", "")

				if values == "XXX" then
					winner = players.x
					break
				elseif values == "OOO" then
					winner = players.o
					break
				end
			end

			if selected == 9 and not winner and not gametie then
				gametie = true
				restartGameButton()
			end

			tttDisplay()
		end

		if event == "reset" then
			restart()
		end
	end
end

function eventChatCommand(p, cmd)
	p = lower(p)
	local args = {}

	for v in string.gmatch(cmd, "%S+") do
		args[#args + 1] = v
	end

	args[1] = lower(args[1])

	if args[1] == "help" then
		tfm.exec.chatMessage(languages[lang]["help"], p)
	end

	if owners[p] then
		if args[1] == "reset" or args[1] == "r" then
			restart()
		elseif args[1] == "admin" and args[2] then
			if not owners[nick(args[2])] then
				owners[nick(args[2])] = true
			else
				if nick(args[2]) ~= nick(owners[1]) then
					owners[nick(args[2])] = nil
				end
			end
		end
	end
end

function eventNewPlayer(p)
	tfm.exec.respawnPlayer(p)
	outsideTheRoom[lower(p)] = nil

	if turn then
		tttDisplay()
	else
		playerSelector()
	end

	tfm.exec.chatMessage(languages[lang]["welcome"], p)
	if not owners[p] then
		tfm.exec.chatMessage(format(languages[lang]["notroomowner"], p), p)
	end
end

function eventPlayerLeft(p)
	outsideTheRoom[lower(p)] = true

	if not turn then
		if lower(p) == players.x then
			players.x = nil
		elseif lower(p) == players.o then
			players.o = nil
		end

		playerSelector()
	else
		if lower(p) == players.x then
			winner = players.o
		elseif lower(p) == players.o then
			winner = players.x
		end
		tttDisplay()
	end
end

function mainText(t)
	ui.updateTextArea(3, "<font size='28' color='#000000'><p align='center'>"..t.."</p></font>")
	ui.updateTextArea(4, "<font size='28'><p align='center'>"..t.."</p></font>")
	ui.removeTextArea(5, nil)
	ui.removeTextArea(6, nil)
	ui.removeTextArea(7, nil)
	ui.removeTextArea(8, nil)
end

function playerSelector()
	local players1, players2 = "", ""
	local px, po = players.x, players.o

	for k, v in next, tfm.get.room.playerList do
		local p = lower(k)
		if p ~= po and not outsideTheRoom[p] then
			if p == px then
				players1 = players1 .. "\n<a href='event:selectx-" .. k .. "'><J>" .. k .. "</J></a>"
			else
				players1 = players1 .. "\n<a href='event:selectx-" .. k .. "'>" .. k .. "</a>"
			end
		end
		if p ~= px and not outsideTheRoom[p] then
			if p == po then
				players2 = players2 .. "\n<a href='event:selecto-" .. k .. "'><J>" .. k .. "</J></a>"
			else
				players2 = players2 .. "\n<a href='event:selecto-" .. k .. "'>" .. k .. "</a>"
			end
		end
	end

	for adm, v in next, owners do
		if px and po then
			ui.addTextArea(9, "<font size='20' color='#000000'><p align='center'>" .. languages[lang]["start"] .. "</p></font>", adm, 400-83/2, 182, 80, 30, nil, nil, 0, true)
			ui.addTextArea(10, "<font size='20'><p align='center'><a href='event:start'>" .. languages[lang]["start"] .. "</a></p></font>", adm, 400-85/2, 180, 80, 30, nil, nil, 0, true)
		else
			ui.removeTextArea(9)
			ui.removeTextArea(10)
		end
		ui.addTextArea(11, "<p align='center'>\n<font size='16'>" .. format(languages[lang]["player"], 1) .. "</font>\n" .. players1 .. "</p>", adm, 400-130/2-200, 40, 130, 310, 0x323250, nil, 1, true)
		ui.addTextArea(12, "<p align='center'>\n<font size='16'>" .. format(languages[lang]["player"], 2) .. "</font>\n" .. players2 .. "</p>", adm, 400-130/2+200, 40, 130, 310, 0x503232, nil, 1, true)
	end
end

function tttDisplay()
	local px = players.x
	local po = players.o
	ui.setMapName("Tic Tac Toe")

	ui.addTextArea(0, "", nil, 400-200/2, 300-200/2-125, 200, 200)
	ui.addTextArea(1, "<font size='20'color='#009D9D'><p align='center'>Tic Tac Toe</p></font>", nil, 400-150/2, 80, 150, 0, nil, nil, 0)
	ui.addTextArea(3, "<font size='28' color='#000000'><p align='center'>x</p></font>", nil, 400-800/2, 25, 800, nil, nil, nil, 0)
	ui.addTextArea(4, "<font size='28'><p align='center'><R>x</R></p></font>", nil, 400-802/2, 24, 800, nil, nil, nil, 0)
	ui.addTextArea(5, "<font size='18' color='#000000'><p align='right'>" .. gsub(px, "%a", function(a) return upper(a) end, 1) .. "</p></font>", nil, 400-300+156/2, 36, 200, nil, nil, nil, 0)
	ui.addTextArea(6, "<font size='18' color='#000000'><p align='left'>" .. gsub(po, "%a", function(a) return upper(a) end, 1) .. "</p></font>", nil, 400-300+656/2, 36, 200, nil, nil, nil, 0)
	if turn == px then
		ui.addTextArea(7, "<font size='18'><p align='right'><J>" .. gsub(px, "%a", function(a) return upper(a) end, 1) .. "</J></p></font>", nil, 400-300+155/2, 35, 200, nil, nil, nil, 0)
		ui.addTextArea(8, "<font size='18'><p align='left'>" .. gsub(po, "%a", function(a) return upper(a) end, 1) .. "</p></font>", nil, 400-300+655/2, 35, 200, nil, nil, nil, 0)
	else
		ui.addTextArea(7, "<font size='18'><p align='right'>" .. gsub(px, "%a", function(a) return upper(a) end, 1) .. "</p></font>", nil, 400-300+155/2, 35, 200, nil, nil, nil, 0)
		ui.addTextArea(8, "<font size='18'><p align='left'><J>" .. gsub(po, "%a", function(a) return upper(a) end, 1) .. "</J></p></font>", nil, 400-300+655/2, 35, 200, nil, nil, nil, 0)
	end

	if winner then
		mainText(format(languages[lang]["win"], gsub(winner, "%a", function(a) return upper(a) end, 1)))
		tfm.exec.setPlayerScore(winner, 1, true)
    	restartGameButton()
	end

	local x = 400 - 105/2
	local y = 200 - 155/2
	for i = 1, 9 do
		ui.addTextArea(12+i, "<font size='26'>" .. (tttGUI[i] or "-") .. "</font>", nil, ((i-1)%3)*40 + x, math.floor((i-1)/3)*40 + y, nil, nil, nil, nil, 0)

		if not tttGUI[i] and (not winner or not gametie) then
			ui.addTextArea(12+i, "<font size='26'><a href='event:pos" .. i .. "'>-</a></font>", turn, ((i-1)%3)*40 + x, math.floor((i-1)/3)*40 + y, nil, nil, nil, nil, 0)
		end
	end
end

function restart()
	ui.setMapName("Tic Tac Toe")
	tfm.exec.setGameTime(300)
	turn = nil
	winner = nil
	gametie = false
	players.x = nil
	players.o = nil
	tttGUI = {}
	selected = 0
	nextPlay = os.time() + 500

	for i = 0, 25 do
		ui.removeTextArea(i)
	end

	playerSelector()
end

function restartGameButton()
	for adm, v in next, owners do
		ui.addTextArea(2, "<font size='15'><p align='center'><a href='event:reset'>" .. languages[lang]["restart"] .. "</a></p></font>", adm, 400-65/2, 300-20/2+5, 60 + string.len(languages[lang]["restart"]), 20)
	end
end

function eventLoop(elapsed, remaining)
	if remaining <= 0 and (players.x and players.o) then
		gametie = true
		restartGameButton()
	end
end

playerSelector()
