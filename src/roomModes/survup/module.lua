admin = { ["Blank#3495"] = true, ["Thewarsnipe#0000"] = true, ["Tocutoeltuco#0000"]= true, ["Bolodefchoco#0015"] = true, ["Meltedfruit#0000"] = true }
banlist = { }
lang = { }
t = {false , 17}
tp = { }
pid = { 0, 1, 2, 9, 11, 13 }
cp = { }
skills = false

translation = {
	en = {
		help = [[<N>!map &lt;code> <BL>- Loads a given code, or a new P10 (survivor) map.
<N>&lt;Shift> + &lt;Ctrl> <BL>- Toggles Shaman mode.
<N>&lt;Ctrl> + &lt;Left Click> <BL>- Teleports you
<N>Confetti <BL>- Sets checkpoint
<J>(In shaman mode) <N>Spawning Arrow <BL>- Sets cannon spawn point
<N>!credits <BL>- Know the people who helped this module.
<N>!lang (lang) <BL>- Know the languages the module is available in (or change your language).

<BL>If you have/face any issues, don't hesitate to <N>/c Blank#3495.
		]],
		credits = [[<N>Code: <R>Blank#3495
<N>Translations: Guns_and_roses#6742 <J>(BG)<N>, Tocutoeltuco#0000 <J>(ES)<N>, Bolodefchoco#0015 <J>(BR)<N>, Shadiiii#5522 <J>(TR)<N>.]]
	},
	bg = {
		help = [[<N>!map <код> <BL>- Зарежда даден код или нова P10 (survivor) карта.
<N>&lt;Shift> + &lt;Ctrl> <BL>- Превключва формата на шаман.
<N>&lt;Ctrl> + &lt;Left Click> <BL>- Телепортира те.
<N> Конфети <BL>-  Поставя точка за връщане на мястото, където умираш.
<J>(In shaman mode) <N>Изстрелва стрела <BL>- Поставя точка за изстрелване на канона.
<N>!credits <BL>- Да знаете хората, които помогнаха на този модул.
<N>!lang (lang) <BL>-  Да знаете езиците, които са валидни в (или да промените на вашия език).

<BL>Ако имате/видите проблеми, не се колебайте, пишете на <N>/c Blank#3495.
		]],
		credits = [[<N>Код: <R>Blank#3495
<N>превод: Guns_and_roses#6742 <J>(BG)<N>, Tocutoeltuco#0000 <J>(ES)<N>, Bolodefchoco#0015 <J>(BR)<N>, Shadiiii#5522 <J>(TR)<N>.]]
	},
	es = {
		help = [[<N>!map &lt;código> <BL>- Carga el mapa dado, o un mapa P10 (survivor).
<N>&lt;Shift> + &lt;Ctrl> <BL>- Te transforma entre ratón y chamán
<N>&lt;Ctrl> + &lt;Click Izquierdo> <BL>- Te teletransporta
<N>Confeti <BL>- Establece un checkpoint
<J>(Siendo chamán) <N>Invocar Flechas <BL>- Establece el punto de invocación de cañones.
<N>!credits <BL>- Muestra las personas que ayudaron con el módulo.
<N>!lang (lang) <BL>- Saber los idiomas en el que el módulo está disponible (o cambia tu idioma).

<BL>Si tenés algún problema, no dudes en susurrar a <N>/c Blank#3495.
		]],
		credits = [[<N>Código: <R>Blank#3495
<N>Traducciones: Guns_and_roses#6742 <J>(BG)<N>, Tocutoeltuco#0000 <J>(ES)<N>, Bolodefchoco#0015 <J>(BR)<N>, Shadiiii#5522 <J>(TR)<N>.]]
	},
	pt = {
		help = [[<N>!map &lt;código> <BL>- Carrega um código dado, ou um mapa P10 (survivor).
<N>&lt;Shift> + &lt;Ctrl> <BL>- Alterna o modo Shaman.
<N>&lt;Ctrl> + &lt;Click Esquerdo> <BL>- Teleporta você
<N>Confete <BL>- Define um checkpoint
<J>(Como Shaman) <N>Invocando Seta <BL>- Define um ponto de invocação para os canhões
<N>!credits <BL>- Veja as pessoas que ajudaram neste módulo.
<N>!lang (idioma) <BL>- Veja os idiomas em que o módulo está disponível (ou altere seu idioma).

<BL>Se você encontrar qualquer problema, não hesite em entrar contato com <N>/c Blank#3495.
		]],
		credits = [[<N>Código: <R>Blank#3495
<N>Traduções: Guns_and_roses#6742 <J>(BG)<N>, Tocutoeltuco#0000 <J>(ES)<N>, Bolodefchoco#0015 <J>(BR)<N>, Shadiiii#5522 <J>(TR)<N>.]]
	},
	tr = {
		help = [[<N>!map <code> <BL>- Yazılan harita kodunu açar, ya da yeni bir P10 (survivor) haritası.
<N>&lt;Shift Key> + &lt;Ctrl Key> <BL>- Şaman modunu değiştirir.
<N>&lt;Ctrl> + &lt;Sol tık> <BL>- Işınlar.
<N> Konfeti <BL>- Denetim noktasını ayarlar
<J>(Şaman modunda) <N>Ok yaratmak <BL>- Top yaratma noktası ayarlar

<BL>Eğer bir probleminiz/bir sorunuz olursa, Çekinmeden <N>/c Blank#3495.
		]],
		credits = [[<N>Cod: <R>Blank#3495
<N>Çeviriler: Guns_and_roses#6742 <J>(BG)<N>, Tocutoeltuco#0000 <J>(ES)<N>, Bolodefchoco#0015 <J>(BR)<N>, Shadiiii#5522 <J>(TR)<N>.]]
	}
}
translation.br = translation.pt

cs = 0
tm = 2

translate = function(name, command)
	return translation[lang[name]] and translation[lang[name]][command] or translation.en[command]
end

eventSummoningEnd = function(n, id, x, y, a)
	if id == 0 then
		t[1], t[3], t[4], t[5] = true, x, y, a - 180
	end
end

eventLoop = function(ct, tr)
	if cs >= tm then
		if t[1] then
			tfm.exec.addShamanObject(t[2], t[3], t[4], t[5])
		end
		cs = 0
	end
	cs = cs + 0.5

	for n in next, cp do
		tfm.exec.displayParticle(pid[math.random(#pid)], cp[n].x, cp[n].y, 0, 0, 0, 0, n)
	end
end

eventChatCommand = function(n, m)
	args, c = {}, 0
	for v in m:gmatch("%S+") do
		c = c + 1
		args[c] = v
	end

	if args[1] == "timer" and admin[n] then
		args[2] = tonumber(args[2]) or 2
		tm = args[2]
	elseif args[1] == "map" then
		if banlist[n] then
			tfm.exec.chatMessage("<R>You are not allowed to use this command.",n)
		else
			if args[2] then
				tfm.exec.newGame(args[2])
			else
				tfm.exec.newGame('#10')
			end
		end
	elseif args[1] == "shaman" and admin[n] then
		tfm.exec.setShaman(args[2], not tfm.get.room.playerList[args[2]].isShaman)
	elseif args[1] == "stop" and admin[n] then
		t[1] = false
	elseif args[1] == "!" and admin[n] then
		tfm.exec.chatMessage("<N>[<R>#Survup<N>] "..table.concat(args,' ',2))
	elseif args[1] == "ban" and admin[n] then
		banlist[args[2]] = not banlist[args[2]]
	elseif args[1] == "skills" and admin[n] then
		local m = tfm.get.room.currentMap
		skills = not skills
		tfm.exec.disableAllShamanSkills(skills)
		tfm.exec.chatMessage("Skills have been " .. (skills and "enabled." or "disabled."))
		tfm.exec.newGame(m)
	elseif args[1] == "cmds" and admin[n] then
		local cmd = {"shaman, stop, !, ban, skills, cmd"}
		tfm.exec.chatMessage("<J>" .. table.concat(cmd, "<N>, <J>"), n)
	elseif args[1] == "help" then
		tfm.exec.chatMessage(translate(n, "help"), n)
	elseif args[1] == "credits" then
		tfm.exec.chatMessage(translate(n, "credits"), n)
	elseif args[1] == "lang" then
		if args[2] then
			lang[n] = args[2]
		else
			local l, c = { }, 0
			for i in next, translation do
				c = c + 1
				l[c] = i
			end
			tfm.exec.chatMessage("<N>Available languages: <J>"..table.concat(l, "<N>, <J>"),n)
		end
	end

	if not admin[n] then
		for an in next, admin do
			tfm.exec.chatMessage("<BL>• ["..n.."] !"..m, an)
		end
	end

end

eventNewGame = function()
	t[1] = false
	cp = { }
end

eventPlayerDied = function(n)
	tfm.exec.respawnPlayer(n)
	if cp[n] then
		tfm.exec.movePlayer(n, cp[n].x, cp[n].y)
	end
end

eventNewPlayer = function(n)
	lang[n] = tfm.get.room.playerList[n].community
	tfm.exec.chatMessage(translate(n, "help"), n)
	system.bindKeyboard(n, 17, true)
	system.bindKeyboard(n, 17, false)
	system.bindKeyboard(n, 16, true)
	system.bindKeyboard(n, 69, true)
	system.bindMouse(n)
	tfm.exec.respawnPlayer(n)

	if tfm.get.room.uniquePlayers == 1 then
		tfm.exec.newGame('#10')
	end

	for a in next, admin do
		tfm.exec.chatMessage("<BL>" .. n .. " (" .. tfm.get.room.playerList[n].community .. ")", a)
	end
end

eventKeyboard = function(n, k, d, x, y)
	if k == 17 then
		tp[n] = d
	elseif k == 16 and tp[n] then
		if banlist[n] then
			tfm.exec.chatMessage("<R>You are not allowed to be shaman.",n)
			return
		end
		if not tfm.get.room.playerList[n].isShaman then
			for p in next, tfm.get.room.playerList do
				if tfm.get.room.playerList[p].isShaman then
					tfm.exec.chatMessage("<R>There is already a shaman!", n)
				return
				end
			end
		end
		tfm.exec.setShaman(n, not tfm.get.room.playerList[n].isShaman)
	elseif k == 69 then
		cp[n] = { x = x, y = y }
	end
end

eventMouse = function(n, x, y)
	if tp[n] then
		tfm.exec.movePlayer(n, x, y)
	end
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)

for _,v in next,{'disableAfkDeath', 'disableAutoNewGame', 'disableAutoShaman'} do
	tfm.exec[v]()
end

system.disableChatCommandDisplay()
tfm.exec.newGame('#10')