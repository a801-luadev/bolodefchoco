table.encrypt=function(a,b,c)if not a or not b or not c or type(a)~='table'or b==''or c==''then return end;local d,e,f,g='','','',''for h in b:gmatch('.')do d=d..h:byte()end;for h in c:gmatch('.')do g=g..h:byte()end;math.randomseed(d)otherSeed=math.random(1000000)local i=pcall(function()for h,j in next,a do if type(j)=='string'or type(j)=='number'then if type(j)=='string'then j=[[']]..j..[[']]end;f=f..' '..j..' '..h:upper()else return end end;f=f..' '..g;for h in f:gmatch('.')do local k=h:byte()+68+math.random(5)otherSeed=otherSeed+h:byte()math.randomseed(otherSeed)if k>=65 and k<=122 and not(k>=91 and k<=96)then k=string.char(k)end;e=e..k end end)math.randomseed(os.time())if not i then return else return e end end;table.decrypt=function(l,b,c)if not l or not b or not c or type(l)~='string'or b==''or c==''then return end;local d,e,m,g='','','',''for h in b:gmatch('.')do d=d..h:byte()end;for h in c:gmatch('.')do g=g..h:byte()end;math.randomseed(d)otherSeed=math.random(1000000)local i=pcall(function()for h in l:gmatch('.')do if h:byte()>=65 and h:byte()<=122 then local k=h:byte()-68-math.random(5)otherSeed=otherSeed+k;math.randomseed(otherSeed)e=e..string.char(k)else m=m..h;if m:len()>=3 then local k=tonumber(m)-68-math.random(5)otherSeed=otherSeed+k;math.randomseed(otherSeed)e=e..string.char(k)m=''end end end end)math.randomseed(os.time())if not i then return else local n,o,p,q,r={},0,0;for h,j in string.gmatch(e,'[^%s]+')do p=p+1 end;for h,j in string.gmatch(e,'[^%s]+')do o=o+1;if o==p and h~=g then return elseif q then if q:sub(-1)==[[']]then n[h:lower()]=q:gsub([[']],'')q=nil else q=q..' '..h end elseif r then n[h:lower()]=r;r=nil elseif h:sub(1,1)==[[']]then q=h else r=h end end;return n end end

for _, v in next, {'AutoShaman', 'AutoNewGame', 'PhysicalConsumables', 'AutoScore'} do
	tfm.exec['disable' .. v]()
end

for _, v in next, {'help', 'load', 'save'} do
	system.disableChatCommandDisplay(v, true)
end

local db, dbPassword, key, playersAlive, timer, warnTimer, object, firsted = {}, 'yPYn5Du8asdQCa0Sau789ydu9A78SadQC', 'vnuj83Wg'

local grounds = {
	{ type = 1, friction = 0, restitution = 0.2, miceCollision = true },
	{ type = 2, friction = 0, restitution = 1.2, miceCollision = true },
	{ type = 3, friction = 0, restitution = 9999, miceCollision = true },
	{ type = 4, friction = 9999, restitution = 0.2, miceCollision = true }
}

local textLangue = {
	br = {
		welcomeMessage = '<N2>Bem-vindo ao <B>#mess</B>! Digite <B>!help</B> para mais informações!\n\tDesenvolvido por Mescouleur<font color="#525267" size="9">#0000</font> e Nettoork<font color="#525267" size="9">#0000</font>',
		help = '<N2>• De tempo em tempo os pisos em sua volta se modificarão, deixando o mapa uma bagunça, e logo depois voltarão ao normal. Seu objetivo é levar o queijo até a toca passando pelos obstáculos, isso inclui os pisos e o meep dos outros jogadores.</N2>\n<VP>Para salvar seus pontos, digite !save\nPara carregar seus pontos, digite !load + código',
		saveMsg = "Guarde seu save em um local seguro",
		waitCmd = "Por favor, aguarde para utilizar esse comando novamente.",
		loadMsg = "Seu save foi carregado com sucesso.",
		wrongAccount = "Esse save não pertence a essa conta",
		wrongSave = "Esse save está incorreto."
	},
	en = {
		welcomeMessage = '<N2>Welcome to <B>#mess</B>! Type <B>!help</B> for more informations!\n\tDeveloped by Mescouleur<font color="#525267" size="9">#0000</font> and Nettoork<font color="#525267" size="9">#0000</font>',
		help = "<N2>• Temporarily the grounds in the map will change theirselves, making a big mess in the map and after of some seconds they will back to their original form. Your main objective is  to collect the cheese and get back to the hole, trying to survive the players' meep and the grounds changing constantly.</N2>\n<VP>To save your points, type !save\nTo load your points, type !load + code",
		saveMsg = "Save your code in a safe local",
		waitCmd = "Please wait to execute this command again.",
		loadMsg = "Your save was successfully uploaded.",
		wrongAccount = "This save doesn't belong to this account",
		wrongSave = "This save is incorrect."
	},
}

translate = function(msg)
	return (textLangue[tfm.get.room.community] and textLangue[tfm.get.room.community][msg]) or textLangue.en[msg]
end

eventNewPlayer = function(name)
	db[name] = {
		timer = os.time(),
		save = {
			id = tfm.get.room.playerList[name].id,
			points = 0
		}
	}
	tfm.exec.setPlayerScore(name, 0, false)
	ui.addTextArea(0, '<p align="center"><font size="20"><D>...', name, 5, 28, 790, 0, 0, 0, 0, true)
	tfm.exec.chatMessage(translate('welcomeMessage'), name)
end

addGrounds = function(warn)
	local id = 0
	if warn then
		objects = {}
		tfm.exec.addPhysicObject (1, 0, 0, {type = 14, width = 10, height = 10, miceCollision = false, groundCollision = false, dynamic = false})
	end
	for i in tfm.get.room.xmlMapInfo.xml:match('<S>(.-)</S>'):gmatch('<S(.-)/>') do
		id = id + 1
		local info = {}
		for o in getXmlInfo('P', i):gmatch("[^,]+") do
			info[#info + 1] = o
		end
		if not (getXmlInfo('T', i) == '9' or getXmlInfo('T', i) == '14' or getXmlInfo('T', i) == '12' or getXmlInfo('c', i) == '2') then
			if not warn then
				for a, o in next, objects do
					if o == id then
						tfm.exec.removeJoint(id)
						local rg = grounds[math.random(1, #grounds)]
						tfm.exec.addPhysicObject(id, getXmlInfo('X', i)- 2, getXmlInfo('Y', i) -2, {type = rg['type'], foreground = true, restitution = rg['restitution'], miceCollision = rg['miceCollision'], friction = rg['friction'], width = getXmlInfo('L', i) + 4, height = getXmlInfo('H', i) + 4, angle = info[5]})
					end
				end
			elseif math.random(0, 1) == 1 then
				objects[#objects + 1] = id
				tfm.exec.addJoint(id, 1, 1, {type = 0, color = '0xC55E4A', line = 10, foreground = true, alpha = 0.7, point1 = getXmlInfo('X', i)..','..getXmlInfo('Y', i), point2 = 1 + getXmlInfo('X', i)..','..getXmlInfo('Y', i)})
			end
		end
	end
	updateInformation('<D>!')
end

removeGrounds = function()
	local id = 0
	for i in tfm.get.room.xmlMapInfo.xml:match('<S>(.-)</S>'):gmatch('<S(.-)/>') do
		id = id + 1
		tfm.exec.addJoint(id, 1, 1, {type = 0, color = '0x4892D9', line = 10, foreground = true, alpha = 0, point1 = '0,0', point2 = '1,0'})
		tfm.exec.removePhysicObject(id)
	end
	timer = nil
	updateInformation('<D>...')
end

eventLoop = function(currentTime, timeRemaining)
	if timeRemaining <= 0 then
		tfm.exec.newGame('#17')
	elseif timer then
		timer = timer - 0.5
		if timer == -0.5 then
			addGrounds()
		elseif timer < -3 then
			removeGrounds()
		elseif timer > 0 then
			if warnTimer then
				addGrounds(true)
				warnTimer = false
			end
			updateInformation('<D>'..math.modf(timer))
		end
	elseif currentTime > 3000 then
		if math.random(1, 10) == 5 then
			warnTimer = true
			timer = math.random(1.5, 4.5)
		end
	end
end

updateInformation = function(text)
	ui.updateTextArea(0, '<p align="center"><font size="20">'..text, nil)
end

getXmlInfo = function (a, b)
	if a == 'P' then
		a = b:match('P="(.-)"')
	else
		a = b:match(a..'="(%d+)"')
	end
	if not a then
		a = 0
	end
	return a
end

eventNewGame = function()
	firsted = false
	playersAlive = 0
	timer = nil
	updateInformation('<D>...')
	for i, v in next, tfm.get.room.playerList do
		tfm.exec.giveMeep(i)
		playersAlive = playersAlive + 1
	end
end

local split = function(t, s)
	local a = {}
	for i in string.gmatch(t, string.format("[^%s]+", s or "%s")) do
		a[#a + 1] = i
	end
	return a
end

eventChatCommand = function(name, command)
	local arg = split(command, ' ')
	if command == 'help' then
		tfm.exec.chatMessage(translate('help'), name)
	elseif arg[1] == 'save' then
		if db[name].timer < os.time() then
			local gen = (table.encrypt(db[name].save, dbPassword, key))
			tfm.exec.chatMessage('<R>'..translate('saveMsg')..':</R> <D>'..gen..'</D>', name)
			db[name].timer = os.time() + 10000
		else
			tfm.exec.chatMessage('<R>'..translate('waitCmd')..'</R>', name)
		end
	elseif arg[1] == 'load' and arg[2] then
		if db[name].timer < os.time() then
			local gen = table.decrypt(arg[2], dbPassword, key)
			if gen then
				if tonumber(gen.id) == tfm.get.room.playerList[name].id then
					db[name].save = gen
					tfm.exec.setPlayerScore(name, db[name].save.points, false)
					tfm.exec.chatMessage('<R>'..translate('loadMsg')..'</R>', name)
					db[name].timer = os.time() + 10000
				else
					tfm.exec.chatMessage(""..translate('wrongAccount').."</R>", name)
				end
			else
				tfm.exec.chatMessage('<R>'..translate('wrongSave')..'</R>', name)
			end
		else
			tfm.exec.chatMessage('<R>'..translate('waitCmd')..'</R>', name)
		end
	end
end

updateMap = function()
	playersAlive = playersAlive - 1
	if playersAlive <= 0 then
		tfm.exec.setGameTime(0)
		tfm.exec.newGame('#17')
	end
end

eventPlayerWon = function(name)
	if not firsted then
		if tfm.get.room.uniquePlayers >= 5 then
			db[name].save.points = db[name].save.points + 1
			tfm.exec.setPlayerScore(name, 1, true)
		end
		firsted = true
	end
	updateMap()
end

eventPlayerDied = function(name)
	updateMap()
end

tfm.exec.newGame('#17')

table.foreach(tfm.get.room.playerList, eventNewPlayer)