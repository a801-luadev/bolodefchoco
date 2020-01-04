table.foreach({"AutoNewGame","AutoTimeLeft","AutoShaman"},function(_,f) tfm.exec["disable"..f]() end)
tfm.exec.newGame(math.random(100))
mice = {}
respawnPoint = {}
transform = function(n,x,y)
	if not mice[n] then
		mice[n] = {
			id = nil,
			object = 104,
			currentTitle = "Little Cake",
			move = {-40,-30,40,30}
		}
	end
	if respawnPoint[1] == nil and (T and T/1000 > 1) then respawnPoint = {(not tfm.get.room.playerList[n].isDead and tfm.get.room.playerList[n].x or 400),(not tfm.get.room.playerList[n].isDead and tfm.get.room.playerList[n].y or 100)} end
	x = (not x and (tfm.get.room.playerList[n].isDead and l.x or tfm.get.room.playerList[n].x) or x or 400)
	y = (not y and (tfm.get.room.playerList[n].isDead and l.y or tfm.get.room.playerList[n].y) or y or 200)
	local vx,vy = tfm.get.room.playerList[n].isDead and l.vx or 0,tfm.get.room.playerList[n].isDead and l.vy or 0
	tfm.exec.killPlayer(n)
	mice[n].id = tfm.exec.addShamanObject(mice[n].object,x,y,ANGLE,vx,vy)
	ui.addTextArea(mice[n].id,"<p align='center'><font color='#FFF3CE' size='12' face='verdana'>"..n.."\n<font size='11'>«"..mice[n].currentTitle.."»",nil,x-43,y-67,nil,30,1,1,.4,true)
end

eventNewGame=function()
	respawnPoint = {}
	table.foreach(tfm.get.room.playerList,tfm.exec.respawnPlayer)
	don = false
end

eventNewPlayer=function(n)
	eventLoop(1,1)
	transform(n)
end

eventKeyboard=table.foreach({0,1,2,3,32},function(_,k) table.foreach(tfm.get.room.playerList,function(n) system.bindKeyboard(n,k,true,true) end) end) or function(n,k)
	if mice[n] then
		if k < 5 then
			k = k + 1
			if k == 1 or k == 3 then
				tfm.exec.moveObject(mice[n].id,0,0,true,mice[n].move[k])
			end
			if k == 2 or k == 4 then
				tfm.exec.moveObject(mice[n].id,0,0,false,0,mice[n].move[k],true)
			end
		end
		if k == 32 then
			tfm.exec.removeObject(mice[n].id)
			ui.removeTextArea(mice[n].id,nil)
			if mice[n].object == 104 then
				mice[n].object = 207
				mice[n].currentTitle = "Big Cake"
			else
				mice[n].object = 104
				mice[n].currentTitle = "Little Cake"
			end
			transform(n)
		end
		eventLoop(1,1)
	end
end

local don = false
eventLoop=function(T,R,REVIVE) _G.T = T;_G.R = R
	if T>1000 then
		if not don then
			if math.floor(T/1000) == 2 then
				don = true
				table.foreach(tfm.get.room.playerList,function(n)
					tfm.exec.respawnPlayer(n);if mice[n] then ui.removeTextArea(mice[n].id,nil) end;transform(n)
				end)
			end
		end
		for n,v in next,mice do
			if tfm.get.room.playerList[n] then
				l = tfm.get.room.objectList[mice[n].id]
				ANGLE = l.angle or 0
				ui.addTextArea(mice[n].id,"<p align='center'><font color='#FFF3CE' size='12' face='verdana'>"..n.."\n<font size='11'>«"..mice[n].currentTitle.."»",nil,l.x-43,l.y-67,nil,30,1,1,.4,true)
				if l.x > 820 or l.x < -30 or l.y > 390 or REVIVE then
					tfm.exec.removeObject(mice[n].id)
					ui.removeTextArea(mice[n].id,nil)
					transform(n,respawnPoint[1],respawnPoint[2])
				end
			end
		end
	end
end

eventChatCommand=function(n,c)
	local p = {}
	for v in c:gmatch('[^%s]+') do
		table.insert(p,v)
	end
	p[1]=p[1]:lower()
	if p[1] == "move" then
		if p[2] and p[3] then
			mice[n].move[tonumber(p[2])] = tonumber(p[3])
		else
			mice[n].move = {-40,-30,40,30}
		end
	end
	if p[1] == "r" then
		eventLoop(T,R,true)
	end
end
