tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()

math.inSquare = function(x1,y1,r1,x2,y2,r2)
	return (x1 + r1 > x2 - r2 and x1 - r1 < x2 + r2) and (y1 + r1 > y2 - r2 and y1 - r1 < y2 + r2)
end

info = {}
eventNewPlayer = function(n)
	tfm.exec.chatMessage("<J>Press <B>spacebar</B> to get the enemy and <B>B</B> for boost.", playerName)
	if not info[n] then
		info[n] = {
			n = n,
			id = tfm.get.room.playerList[n].id,
			isDead = {false,0},
			capture = 0,
			size = 10,
			speed = 5,
			boost = {0,0,0}, -- speed, end, is boosting
			color = math.random(0xFFFFFF),
			coord = {math.random(800),math.random(400)},
			dir = {0,0},
		}
	end
	for k,v in next,{0,1,2,3,32,string.byte("POB",1,3)} do
		system.bindKeyboard(n,v,true,true)
		system.bindKeyboard(n,v,false,true)
	end
end
table.foreach(tfm.get.room.playerList,eventNewPlayer)

eventNewGame = function()
	table.foreach(tfm.get.room.playerList,tfm.exec.killPlayer)
end

eventLoop = function(currentTime)
	_G.currentTime = currentTime
end

loop = function()
	if currentTime / 1000 > 3 then
		for k,v in next,info do
			if not v.isDead[1] then
				v.coord[1] = v.coord[1] + v.dir[1]
				v.coord[2] = v.coord[2] + v.dir[2]

				if v.coord[1] < 1 then
					v.coord[1] = 800
				elseif v.coord[1] > 800 then
					v.coord[1] = 1
				end

				if v.coord[2] < 1 then
					v.coord[2] = 400
				elseif v.coord[2] > 400 then
					v.coord[2] = 1
				end

				if v.boost[3] == 1 then
					if v.boost[2] > 0 then
						v.boost[2] = v.boost[2] - .5
					else
						v.boost[2] = 0
						v.boost[3] = 0
						v.speed = v.boost[1]
					end
				else
					if v.boost[2] < 4.5 then
						v.boost[2] = v.boost[2] + .05
					end
				end

				ui.addTextArea(v.id or 1000,"",nil,v.coord[1] or 0,v.coord[2] or 0,v.size or 10,v.size or 10,v.color or 1,v.color or 1,.5,true)
				ui.addTextArea(-v.id,"<font size='8' color='#E6FF00'>" .. v.n,nil,v.coord[1] - 10 - #v.n,v.coord[2] - (v.size/2) - 15,nil,nil,1,1,0,true)
				ui.addTextArea(0,string.format("X: %s\nY: %s\nSize: %sx%s\nSpeed: %s\nBoost: %s",v.coord[1],v.coord[2],v.size,v.size,v.speed,v.boost[2]),v.n,0,30,120,100,1,1,0,true)
			else
				if os.time() > v.isDead[2] then
					v.isDead = {false,0}
					v.coord = {math.random(800),math.random(400)}
				end
			end
		end
	end
end
system.looping(loop, 10)

eventKeyboard = function(n,k,d)
	if k == 32 then
		if os.time() > info[n].capture then
			info[n].capture = os.time() + 5000

			for k,v in next,info do
				if n ~= v.n then
					if math.inSquare(v.coord[1],v.coord[2],v.size,info[n].coord[1],info[n].coord[2],info[n].size) then
						info[n].size = info[n].size + (10/100) * v.size
						info[n].speed = info[n].speed + (15/100) * v.speed
						ui.removeTextArea(v.id,nil)
						ui.removeTextArea(-v.id,nil)
						ui.removeTextArea(0,v.n)

						v.isDead = {true,os.time() + 10000}
						v.size = 10
						v.speed = 5

						info[n].capture = 0
						break
					end
				end
			end
		end
	elseif k == string.byte("B") then
		if info[n].boost[2] > .5 then
			info[n].boost[3] = d and 1 or 0
			if d then
				info[n].boost[1] = info[n].speed
				info[n].speed = info[n].speed * 2.5
			else
				info[n].speed = info[n].boost[1]
			end
		end
	elseif k == string.byte("P") then

	elseif k == string.byte("O") then
		ui.showColorPicker(0,n,info[n].color,"Square")
	else
		if k == 0 then
			info[n].dir = {-info[n].speed,0}
		elseif k == 2 then
			info[n].dir = {info[n].speed,0}
		elseif k == 1 then
			info[n].dir = {0,-info[n].speed}
		elseif k == 3 then
			info[n].dir = {0,info[n].speed}
		end
	end
end

eventColorPicked = function(i,n,c)
	info[n].color = c
end

tfm.exec.newGame('<C><P /><Z><S /><D /><O /></Z></C>')