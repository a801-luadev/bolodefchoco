local toDespawn = {}
do
	local addShamanObject = tfm.exec.addShamanObject
	tfm.exec.addShamanObject = function(...)
		toDespawn[#toDespawn + 1] = {
			addShamanObject(...),
			os.time() + 3000
		}
		return toDespawn[#toDespawn][1]
	end
end
text={}
lang={}
lang.en={
	clickRunway="Choose a plane.",
	clickRunway2="Click Runway to start",
	help="<J>Welcome to #plane <b>%s</b>! Use the controls to safely fly your plane to different Airports. You are able to fly however you want, but try not to crash!\n\n<ROSE>Commands:\n<font color='#32A9FF'><b>Shift</b> - Takes you back to the starting airport.\n<b>Move Right</b> - Accelerates your plane (your plane must be atleast at 85 speed to fly).\n<b>Move left or E</b> - Decelerates your plane, but try to keep your air speed over 85!\n<b>Jump</b> - Makes your plane go up when you have a speed of 85 or more.\n<b>Down</b> - Makes your plane slightly descend.\n<b>Space</b> - Makes your plane stay within one altitude; your plane will not go up or down.\n<b>F</b> - Makes your speed stay the same / not decreasing or increasing.\n\n<font size='16'><N>CLICK RUNWAY TO PREPARE FOR TAKE OFF.\n\n<font size='12'><J>Made by Fuzzyfirsdog#0000.<VP> Images edited by Blank#3495.",
	descend="DESCEND",
	altitude="ALTITUDE",
	speed="SPEED",
	distance="DISTANCE",
	accelerate="ACCELERATE",
	decelerate="DECELERATE",
	ascend="ASCEND",
	truth="True",
	falso="False",
	runway="Runway",
	close="Close"
}
lang.ar={
	clickRunway="Choose a plane",
	clickRunway2="Click Runway to start",
	help="<J>Welcome to #plane <b>%s</b>! Use the controls to safely fly your plane to different Airports. You are able to fly however you want, but try not to crash!\n\n<ROSE>Commands:\n<font color='#32A9FF'><b>Shift</b> - Takes you back to the starting airport.\n<b>Move Right</b> - Accelerates your plane (your plane must be atleast at 85 speed to fly).\n<b>Move left or E</b> - Decelerates your plane, but try to keep your air speed over 85!\n<b>Jump</b> - Makes your plane go up when you have a speed of 85 or more.\n<b>Down</b> - Makes your plane slightly descend.\n<b>Space</b> - Makes your plane stay within one altitude; your plane will not go up or down.\n<b>F</b> - Makes your speed stay the same / not decreasing or increasing.\n\n<font size='16'><N>CLICK RUNWAY TO PREPARE FOR TAKE OFF.\n\n<font size='12'><J>Made by Fuzzyfirsdog#0000.<VP> Images edited by Blank#3495.",
	descend="DESCEND",
	altitude="ALTITUDE",
	speed="SPEED",
	distance="DISTANCE",
	accelerate="ACCELERATE",
	decelerate="DECELERATE",
	ascend="ASCEND",
	truth="True",
	falso="False",
	runway="مدرج المطار",
	close="Close"
}
for _, s in next, {'AutoTimeLeft', 'PhysicalConsumables', 'AfkDeath', 'AutoShaman', 'AutoNewGame'} do
	tfm.exec['disable' .. s]()
end
tfm.exec.newGame('<C><P Ca="" F="0" H="3600" L="300000" aie="" /><Z><S><S X="2283" o="0" L="3000" Y="3484" H="350" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="400" L="800" Y="3460" H="314" P="0,0,0.3,0.2,0,0,0,0" T="6" /><S X="11839" L="400" Y="3612" H="400" P="0,0,0.3,3,45,0,0,0" T="6" /><S X="17885" o="0" L="3000" Y="3464" H="350" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="28453" o="0" L="3000" Y="3466" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="16208" L="800" Y="3444" H="314" P="0,0,0.1,0.2,0,0,0,0" T="7" /><S X="26914" L="400" Y="3428" H="344" P="0,0,0.3,0.2,0,0,0,0" T="6" /><S X="37994" L="400" Y="3408" H="400" P="0,0,0.05,0.1,0,0,0,0" T="11" /><S X="45602" L="1000" Y="3697" H="1000" P="0,0,0.3,3,40,0,0,0" T="5" /><S X="57719" o="0" L="3000" Y="3432" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="56055" L="400" Y="3411" H="400" P="0,0,0.3,0,0,0,0,0" T="10" /><S X="39695" o="0" L="3000" Y="3419" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="44208" L="74" Y="1769" H="78" P="1,0,0,20,-20,0,900,0" T="3" /><S X="44735" L="74" Y="2197" H="78" P="1,0,0,20,-80,0,900,0" T="3" /><S X="200" o="324650" L="400" Y="3152" H="24" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="407" o="324650" L="24" Y="3221" H="163" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="44495" L="1000" Y="3653" H="1000" P="0,0,0.3,3,40,0,0,0" T="5" /><S X="74655" o="0" L="3000" Y="3415" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="34349" L="1000" Y="3722" H="1000" P="0,0,0.3,3,40,0,0,0" T="5" /><S X="33870" L="1000" Y="3915" H="1000" P="0,0,0.3,3,40,0,0,0" T="5" /><S X="32903" L="1000" Y="3738" H="1000" P="0,0,0.3,3,40,0,0,0" T="5" /><S X="73049" L="400" Y="3410" H="400" P="0,0,0.3,0,0,0,0,0" T="10" /><S X="7900" L="3000" Y="4689" H="3000" P="0,0,0.3,2,0,0,0,0" T="6" /><S X="7203" L="900" Y="3527" H="900" P="0,0,0.3,1,45,0,0,0" T="5" /><S X="9066" L="3000" Y="4681" H="3000" P="0,0,0.3,2,0,0,0,0" T="6" /><S X="9839" L="900" Y="3366" H="900" P="0,0,0.3,1,45,0,0,0" T="5" /><S X="12061" L="3000" Y="4843" H="3000" P="0,0,0.3,2,0,0,0,0" T="6" /><S X="23971" L="3000" Y="4572" H="3000" P="0,0,0.1,1,0,0,0,0" T="7" /><S X="24117" L="3000" Y="4554" H="3000" P="0,0,0.1,1,0,0,0,0" T="7" /><S X="35322" L="3000" Y="3528" H="309" P="0,0,1,1,0,0,0,0" T="5" /><S X="53271" L="3000" Y="3456" H="481" P="0,0,0.3,1,0,0,0,0" T="10" /><S X="53051" L="3000" Y="4851" H="3000" P="0,0,0.3,1,45,0,0,0" T="10" /><S X="80628" L="3000" Y="3528" H="468" P="0,0,0.3,0.2,7,0,0,0" T="6" /><S X="5281" o="0" L="3000" Y="3484" H="350" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="20881" o="0" L="3000" Y="3464" H="350" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="31431" o="0" L="3000" Y="3466" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="42695" o="0" L="3000" Y="3419" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="60719" o="0" L="3000" Y="3432" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="77654" o="0" L="3000" Y="3414" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="95871" o="0" L="3000" Y="3400" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="94177" L="400" Y="3417" H="468" P="0,0,0.3,0.2,0,0,0,0" T="6" /><S X="98867" o="0" L="3000" Y="3400" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="123235" L="400" Y="3416" H="468" P="0,0,0.3,0.2,0,0,0,0" T="6" /><S X="124939" o="0" L="3000" Y="3412" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="127935" o="0" L="3000" Y="3412" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="168567" L="400" Y="3408" H="468" P="0,0,0.3,0.2,0,0,0,0" T="6" /><S X="170267" o="0" L="3000" Y="3408" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="173267" o="0" L="3000" Y="3408" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="214347" o="0" L="3000" Y="3402" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /><S X="217347" o="0" L="3000" Y="3402" H="400" P="0,0,0.3,0.2,0,0,0,0" T="12" /></S><D><DS X="219" Y="3289" /></D><O><O C="15" X="8453" P="0" Y="2564" /><O C="15" X="27032" P="0" Y="2497" /><O C="15" X="33275" P="0" Y="2755" /><O C="15" X="42144" P="0" Y="2646" /></O></Z></C>')
data={}
i=9210
function setData(n)
	i=i+23
	text[n]=lang[tfm.get.room.playerList[n].community] or lang.en
	data[n]=
		{
			inRoom=true,
			stall=false,
			radar={color=math.random(0xFFFFFF),id=i+33},
			lastX=tfm.get.room.playerList[n].x,
			lastY=tfm.get.room.playerList[n].y,
			plane=true,
			acceleration=false,
			speed=0,
			up=false,
			down=false,
			decelerate=false,
			stabilizeSpeed=false,
			speedLim=250,
			using="165d9c30648.png",
			accelerationSpeed=2.5,
			stealth=0,
			s=1,
			id="",
			sonicboom=false,
			id2=""
		}
end
a=""
function addPlanes(n)
	tfm.exec.lowerSyncDelay(n)
	ui.addTextArea(1001, "<p align='center'><b><a href='event:plane1'><J>A340</J></a></b>", n, 200, 3167, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1002, "<p align='center'><b><J><a href='event:plane2'>Cessna Citation</J></a></b>", n, 200, 3190, 190, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1003, "<p align='center'><b><J><a href='event:plane3'>F18</J></a></b>", n, 295, 3213, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1004, "<p align='center'><b><J><a href='event:plane4'>A320</J></a></b>", n, 200, 3213, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1005, "<p align='center'><b><J><a href='event:plane5'>B-737</J></a></b>", n, 200, 3236, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1006, "<p align='center'><b><J><a href='event:plane6'>B-787</J></a></b>", n, 295, 3236, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1007, "<p align='center'><b><J><a href='event:plane7'>A380</J></a></b>", n, 295, 3259, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1008, "<p align='center'><b><J><a href='event:plane8'>B-747</J></a></b>", n, 200, 3259, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1009, "<p align='center'><b><J><a href='event:plane9'>A350 XWB</J></a></b>", n, 200, 3282, 95, 23, 0x000001, 0x000001, 1, false)
	ui.addTextArea(1010, "<p align='center'><b><J><a href='event:plane10'>Concorde</J></a></b>", n, 295, 3282, 95, 23, 0x000001, 0x000001, 1, false)
	if n=="Fuzzyfirsdog#0000" or n=="Bolodefchoco#0000" or n=="Blank#3495" or n=="Sebafrancuz#0000" then
		ui.addTextArea(1011, "<p align='center'><b><J><a href='event:plane11'>SR 71B</J></a></b>", n, 200, 3305, 95, 23, 0x000001, 0x000001, 1, false)
	end
end
function showPlanes(n,a)
	if data[n].using=="165d9c30648.png" then -- A340
		tfm.exec.addImage(data[n].using,"%"..n, -415, -170, a)
	elseif data[n].using=="165e4735f1f.png" then -- Cessna Citation
		tfm.exec.addImage(data[n].using,"%"..n, -225, -80, a)
	elseif data[n].using=="165b9ec4f68.png" then -- F18
		tfm.exec.addImage(data[n].using,"%"..n, -225, -122, a)
	elseif data[n].using=="165c581475c.png" then --A320
		tfm.exec.addImage(data[n].using,"%"..n, -385, -160, a)
	elseif data[n].using=="165dea1e6a2.png" then --737
		tfm.exec.addImage(data[n].using,"%"..n, -420, -214, a)
	elseif data[n].using=="165d9c2a1f9.png" then --787
		tfm.exec.addImage(data[n].using,"%"..n, -330, -217, a)
	elseif data[n].using=="165cfe74cca.png" then --A380
		tfm.exec.addImage(data[n].using,"%"..n, -375, -180, a)
	elseif data[n].using=="165cfe53158.png" then --747
		tfm.exec.addImage(data[n].using,"%"..n, -335, -140, a)
	elseif data[n].using=="165d4a31588.png" then --A350XWB
		tfm.exec.addImage(data[n].using,"%"..n, -355, -230, a)
	elseif data[n].using=="165d4a2c6af.png" then --Concorde
		tfm.exec.addImage(data[n].using,"%"..n, -450, -107, a)
	elseif data[n].using=="165d4baf672.png" then --SR 71B
		data[n].id2=tfm.exec.addImage(data[n].using,"%"..n, -307, -125, a)
	end
end
function eventNewPlayer(n)
	if not data[n] then
			setData(n)
	end
	ui.addTextArea(97, "", n, 595, 277, 200, 115, 0x005c0b, 0x005c0b, 1, true)
	ui.addTextArea(178, "", n, 595, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(278, "", n, 606, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(378, "", n, 612, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(478, "", n, 620, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(578, "", n, 632, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(678, "", n, 644, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(787, "", n, 658, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(878, "", n, 672, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(978, "", n, 737, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(179, "", n, 708, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(237, "<p align='center'><font color='#FFFFFF'><font size='40'>"..text[n].clickRunway, n, 0, 350, 800, 60, 0x324650, 0x000000, 0.7, true)
	data[n].inRoom=true
	addPlanes(n)
	tfm.exec.respawnPlayer(n)
	tfm.exec.chatMessage(text[n].help,n)
	for i=0,100 do
		tfm.exec.bindKeyboard(n, i, true, true)
	end
a=n
	for n,player in pairs(tfm.get.room.playerList) do
		showPlanes(n,a)
	end
	showPlanes(n,nil)
end

for n,player in pairs(tfm.get.room.playerList) do
	setData(n)
	ui.addTextArea(97, "", n, 595, 277, 200, 115, 0x005c0b, 0x005c0b, 1, true)
	ui.addTextArea(178, "", n, 595, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(278, "", n, 606, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(378, "", n, 612, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(478, "", n, 620, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(578, "", n, 632, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(678, "", n, 644, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(787, "", n, 658, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(878, "", n, 672, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(978, "", n, 737, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(179, "", n, 708, 392, 1, 1, 0x1aff00, 0x000000, 1, true)
	ui.addTextArea(237, "<p align='center'><font color='#FFFFFF'><font size='40'>"..text[n].clickRunway, n, 0, 350, 800, 60, 0x324650, 0x000000, 0.7, true)
	addPlanes(n)
	tfm.exec.chatMessage(text[n].help,n)
	tfm.exec.addImage(data[n].using,"%"..n, -415, -170, nil)
	for i=0,100 do
		tfm.exec.bindKeyboard(n, i, true, true)
	end
end
function accelerate(n)
	if not data[n].stabilizeSpeed==true and data[n].speed<=data[n].speedLim and data[n].decelerate==false and data[n].acceleration==true then
		data[n].speed=data[n].speed+data[n].accelerationSpeed
	end
	if data[n].speed>85 and data[n].up==true and data[n].down==false then
		tfm.exec.movePlayer(n,0,0,false,0,-50,false)
	elseif data[n].speed>85 and data[n].up==false and data[n].down==false then
		tfm.exec.movePlayer(n,0,0,false,0,-27,false)
	elseif data[n].speed>85 and data[n].up==false and data[n].down==true then
		tfm.exec.movePlayer(n,0,0,false,0,-13,false)
	end
	if data[n].acceleration==true then
		tfm.exec.movePlayer(n,0,0,false,data[n].speed,0,false)
	end
end
function eventKeyboard(n, key, down, x,y)
	if key==16 then
		ui.addTextArea(237, "<p align='center'><font color='#FFFFFF'><font size='40'>"..text[n].clickRunway, n, 0, 350, 800, 60, 0x324650, 0x000000, 0.7, true)
		data[n].speed=0
		data[n].acceleration=false
		tfm.exec.movePlayer(n,215,3287,false,0,0,false)
		ui.removeTextArea(1000,n)
	elseif key==72 then
		ui.addTextArea(228, "<font size='12'>"..string.format(text[n].help,n), n, 27, 105, 529, 270, 0x324650, 0x324650, 1, true)
		ui.addTextArea(113, "<p align='center'><a href='event:close'><font size='13'>"..text[n].close, n, 27, 370, 529, 24, 0x496878, 0x000001, 1, true)
	elseif key==2 then
		data[n].acceleration=true
		data[n].decelerate=false
		data[n].stabilizeSpeed=false
	elseif key==69 then
		data[n].decelerate=true
		data[n].acceleration=false
		data[n].stabilizeSpeed=false
	elseif key==0 then
		data[n].decelerate=true
		data[n].acceleration=false
		data[n].stabilizeSpeed=false
	elseif key==1 then
		data[n].up=true
		data[n].down=false
	elseif key==32 then
		data[n].up=false
		data[n].down=false
	elseif key==70 then
		data[n].decelerate=false
		data[n].stabilizeSpeed=true
	elseif key==3 then
		data[n].up=false
		data[n].down=true
	end
end
function decelerate(n)
	if data[n].decelerate==true and data[n].speed>0 then
		data[n].speed=data[n].speed-7
		tfm.exec.movePlayer(n,0,0,false,data[n].speed,0,false)
	end
	if data[n].speed<0 then
		data[n].speed=0
	end
end
function eventLoop()
	for n,player in pairs(tfm.get.room.playerList) do
		if data[n].inRoom==true then
			if data[n].speed>=450 and data[n].sonicboom==false then
				data[n].sonicboom=true
				if data[n].using=="165b9ec4f68.png" then
					data[n].id=tfm.exec.addImage("165e9e21f73.png","%"..n, -300, -167, nil)
				elseif data[n].using=="165d4a2c6af.png" then
					data[n].id=tfm.exec.addImage("165e9e2c348.png","%"..n, -450, -185, nil)
				elseif data[n].using=="165d4baf672.png" then
					data[n].id=tfm.exec.addImage("165e9e262ac.png","%"..n, -307, -120, nil)
					tfm.exec.removeImage(data[n].id2)
				end
			end
			if data[n].speed<450 and data[n].sonicboom==true then
				tfm.exec.removeImage(data[n].id)
				data[n].sonicboom=false
				if data[n].using=="165d4baf672.png" then
					tfm.exec.addImage(data[n].using,"%"..n, -307, -125, a)
				end
			end
			if data[n].stealth==0 then
				if not (tfm.get.room.playerList[n].x<=140) and not (tfm.get.room.playerList[n].y<=0) then
					data[n].lastX=tfm.get.room.playerList[n].x
					data[n].lastY=tfm.get.room.playerList[n].y
					ui.addTextArea(data[n].radar.id, "", nil, math.floor(tfm.get.room.playerList[n].x/1500+595), math.floor(tfm.get.room.playerList[n].y/30+278), 1, 1, data[n].radar.color, 0xFFFFFF, 1, true)
					ui.addTextArea(data[n].radar.id/2.378, "<p align='center'><font size='10'><font color='#FFFFFF'>"..n, nil, math.floor(tfm.get.room.playerList[n].x/1500+480), math.floor(tfm.get.room.playerList[n].y/30+260), 255, 24, 0x324650, 0x000001, 0, true)
				else
					ui.addTextArea(data[n].radar.id, "", nil, math.floor(data[n].lastX/1500+595), math.floor(data[n].lastY/30+278), 1, 1, data[n].radar.color, 0xFFFFFF, 1, true)
				end
			end
		end
		if data[n].stealth==1 then
			if not (tfm.get.room.playerList[n].x<140) and not (tfm.get.room.playerList[n].y<=0) then
					data[n].lastX=tfm.get.room.playerList[n].x
					data[n].lastY=tfm.get.room.playerList[n].y
					ui.addTextArea(data[n].radar.id, "", n, math.floor(tfm.get.room.playerList[n].x/1500+595), math.floor(tfm.get.room.playerList[n].y/30+278), 1, 1, 0xFF0000, 0xFF0000, 1, true)
					ui.addTextArea(data[n].radar.id/2.378, "<p align='center'><font size='10'><font color='#FF0000'>"..n, n, math.floor(tfm.get.room.playerList[n].x/1500+480), math.floor(tfm.get.room.playerList[n].y/30+260), 255, 24, 0x324650, 0x000001, 0, true)
				else
					ui.addTextArea(data[n].radar.id, "", n, math.floor(data[n].lastX/1500+595), math.floor(data[n].lastY/30+278), 1, 1, 0xFF0000, 0xFF0000, 1, true)
				end
		end
		accelerate(n)
		if data[n].decelerate==true and data[n].speed>0 then
			data[n].speed=data[n].speed-7
			tfm.exec.movePlayer(n,0,0,false,data[n].speed,0,false)
		end
		if data[n].speed<0 then
			data[n].speed=0
		end
		if (-tfm.get.room.playerList[n].y+3600<1000) and data[n].speed>85 then
			ui.addTextArea(444, "<p align='center'><font color='#FFFFFF'><font face='verdana'><font size='13'>Terrain! Pull up.\n", n, 369, 36, 133, 28, 0xff0000, 0xFF0000, 1, true)
		end
		if (-tfm.get.room.playerList[n].y+3600>1000) or data[n].speed<85 then
			ui.removeTextArea(444,n)
		end
		if -tfm.get.room.playerList[n].y+3600>352 and data[n].speed<85 and data[n].stall==false then
			data[n].stall=true
		end
		if data[n].stall==true then
			ui.addTextArea(3, "<p align='center'><font color='#FFFFFF'><font face='verdana'><font size='15'>STALL\n", n, 369, 36, 133, 35, 0xff0000, 0xFF0000, 1, true)
			data[n].stall=false
		elseif data[n].speed>85 or -tfm.get.room.playerList[n].y+3600<365 then
			ui.removeTextArea(3,n)
		end
		if data[n].up==true then
			up="<font color='#FF9696'><b>↑"
		end
		if data[n].up==false then
			up="<font color='#FF9696'><b>-"
		end
		if data[n].down==true then
			down="<VP>"..text[n].truth
			up="<font color='#FF9696'><b>↓"
		end
		if data[n].acceleration==true then
			acceleration="<font color='#FF9696'><b>→"
		end
		if data[n].acceleration==false then
			acceleration="<font color='#FF0000'>"..text[n].falso
		end
		if data[n].decelerate==true then
			decelerate="<VP>"..text[n].truth
			acceleration="<font color='#FF9696'><b>←"
		end
		if data[n].decelerate==false then
			decelerate="<font color='#FF9696'><b>-"
		end
		if data[n].stabilizeSpeed==true or (data[n].stabilizeSpeed==false and data[n].decelerate==false and data[n].acceleration==false) then
			decelerate="<font color='#FF0000'>F"..text[n].falso
			acceleration="<font color='#FF9696'><b>-"
			decelerate="<font color='#FF9696'><b>-"
		end
		ui.addTextArea(2, "", n, 9, 27, 316, 51, 0x000001, 0x000001, 1, true)
		ui.addTextArea(0, "<p align='center'><font color='#FFFFFF'><font face='verdana'><font size='13'>SPEED\n"..math.floor(data[n].speed).."\n"..acceleration, n, 121, 32, 93, 60, 0x000000, 0xff0000, 1, true)
		ui.addTextArea(1, "<p align='center'><font color='#FFFFFF'><font face='verdana'><font size='13'>ALTITUDE: \n"..(-tfm.get.room.playerList[n].y+3600).."\n"..up, n, 14, 32, 93, 60, 0x000000, 0xff0000, 1, true)
		ui.addTextArea(13, "<p align='center'><font color='#FFFFFF'><font face='verdana'><font size='13'>DISTANCE\n"..tfm.get.room.playerList[n].x, n, 228, 32, 93, 40, 0x000000, 0xff0000, 1, true)
	end
end
function eventPlayerDied(n)
	if data[n].s==0 then
		ui.addTextArea(237, "<p align='center'><font color='#FFFFFF'><font size='40'>"..text[n].clickRunway, n, 0, 350, 800, 61, 0x324650, 0x000000, 0.7, true)
	end
	data[n].speed=0
	data[n].acceleration=false
	tfm.exec.respawnPlayer(n)
	showPlanes(n,nil)
end

function eventTextAreaCallback(id,n,a)
	data[n].stealth=0
	data[n].s=0
	if not (a=="runway") then
		ui.addTextArea(237, "<p align='center'><font color='#FFFFFF'><font size='40'>"..text[n].clickRunway2, n, 0, 350, 800, 60, 0x324650, 0x000000, 0.7, true)
		data[n].s=1
		ui.addTextArea(1000, "<p align='center'><b><a href='event:runway'><BV>"..text[n].runway.."</a></b>", n, 295, 3167, 95, 23, 0x000001, 0x000001, 1, false)
	end
	if a=="runway" and tfm.get.room.playerList[n].x<405 then
		tfm.exec.movePlayer(n,855,3284,false,0,0,false)
		ui.removeTextArea(237,n)
	elseif a=="plane1" then
		data[n].accelerationSpeed=3
		data[n].speedLim=250
		data[n].using="165d9c30648.png"
		tfm.exec.killPlayer(n)
	elseif a=="plane2" then
		data[n].speedLim=200
		data[n].accelerationSpeed=3
		data[n].using="165e4735f1f.png"
		tfm.exec.killPlayer(n)
	elseif a=="plane3" then
		data[n].using="165b9ec4f68.png"
		data[n].speedLim=500
		data[n].accelerationSpeed=6.5
		tfm.exec.killPlayer(n)
	elseif a=="plane4" then
		data[n].using="165c581475c.png"
		data[n].speedLim=225
		data[n].accelerationSpeed=3
		tfm.exec.killPlayer(n)
	elseif a=="plane5" then
		data[n].using="165dea1e6a2.png"
		data[n].speedLim=225
		data[n].accelerationSpeed=3
		tfm.exec.killPlayer(n)
	elseif a=="plane6" then
		data[n].using="165d9c2a1f9.png"
		data[n].speedLim=300
		data[n].accelerationSpeed=3.5
		tfm.exec.killPlayer(n)
	elseif a=="plane7" then
		data[n].using="165cfe74cca.png"
		data[n].speedLim=300
		data[n].accelerationSpeed=3.5
		tfm.exec.killPlayer(n)
	elseif a=="plane8" then
		data[n].using="165cfe53158.png"
		data[n].speedLim=300
		data[n].accelerationSpeed=3.5
		tfm.exec.killPlayer(n)
	elseif a=="plane9" then
		data[n].using="165d4a31588.png"
		data[n].speedLim=300
		data[n].accelerationSpeed=3.5
		tfm.exec.killPlayer(n)
	elseif a=="plane10" then
		data[n].using="165d4a2c6af.png"
		data[n].speedLim=550
		data[n].accelerationSpeed=5
		tfm.exec.killPlayer(n)
	elseif a=="plane11" then
		if n=="Blank#3495" or n=="Fuzzyfirsdog#0000" or n=="Bolodefchoco#0000" or n=="Sebafrancuz#0000" then
			data[n].using="165d4baf672.png"
			data[n].speedLim=900
			data[n].accelerationSpeed=8
			tfm.exec.killPlayer(n)
		end
	end
	if a=="close" then
		ui.removeTextArea(113,n)
		ui.removeTextArea(228,n)
	end
end
system.disableChatCommandDisplay("s",true)
function eventChatCommand(n,m)
	if m=="s" and data[n].using=="165d4baf672.png" and data[n].stealth==0 then
		data[n].stealth=1
		tfm.exec.chatMessage("<ROSE>You are now on stealth.",n)
		ui.removeTextArea(data[n].radar.id/2.378,nil)
		ui.removeTextArea(data[n].radar.id,nil)
	elseif m=="s" and data[n].using=="165d4baf672.png" and data[n].stealth==1 then
		data[n].stealth=0
		tfm.exec.chatMessage("<R>You are now visible on the radar.",n)
	end
end
function eventPlayerLeft(n)
	data[n].inRoom=false
	ui.removeTextArea(data[n].radar.id,nil)
	ui.removeTextArea(data[n].radar.id/2.378,nil)
end
