do local a={}local b={}local c={}local d={}local e={"eventChatCommand ","eventChatMessage","eventEmotePlayed","eventFileLoaded","eventFileSaved","eventKeyboard","eventMouse","eventLoop","eventNewGame","eventNewPlayer","eventPlayerDataLoaded","eventPlayerDied","eventPlayerGetCheese","eventPlayerLeft","eventPlayerVampire","eventPlayerWon","eventPlayerRespawn","eventPlayerMeep","eventPopupAnswer","eventSummoningStart","eventSummoningCancel","eventSummoningEnd","eventTextAreaCallback","eventColorPicked"}local f;f={['perfomance']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(g,h,i)local j=0;for v=1,g do local k=os.time()for l=1,h do i(h)end;j=j+os.time()-k end;return'Estimated Time: '..j/g..' ms.'end},['button']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(...)local m={...}local n=-543212345+m[1]*3;local o=m[9]and'0x2A424B'or'0x314e57'ui.addTextArea(n,'',m[4],m[5]-1,m[6]-1,m[7],m[8],0x7a8d93,0x7a8d93,1,true)ui.addTextArea(n-1,'',m[4],m[5]+1,m[6]+1,m[7],m[8],0x0e1619,0x0e1619,1,true)ui.addTextArea(n-2,'<p align="center"><a href="event:'..m[3]..'">'..m[2]..'</a></p>',m[4],m[5],m[6],m[7],m[8],o,o,1,true)end,['remove']=function(n,p)for l=0,2 do ui.removeTextArea(-543212345+n*3-l,p)end end},['ui-design']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(...)local m={...}if m[6]<0 or m[7]and m[7]<0 then return elseif not m[7]then m[7]=m[6]/2 end;local n=543212345+m[1]*8;ui.addTextArea(n,'',m[3],m[4],m[5],m[6]+100,m[7]+70,0x78462b,0x78462b,1,true)ui.addTextArea(n+1,'',m[3],m[4],m[5]+(m[7]+140)/4,m[6]+100,m[7]/2,0x9d7043,0x9d7043,1,true)ui.addTextArea(n+2,'',m[3],m[4]+(m[6]+180)/4,m[5],(m[6]+10)/2,m[7]+70,0x9d7043,0x9d7043,1,true)ui.addTextArea(n+3,'',m[3],m[4],m[5],20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(n+4,'',m[3],m[4]+m[6]+80,m[5],20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(n+5,'',m[3],m[4],m[5]+m[7]+50,20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(n+6,'',m[3],m[4]+m[6]+80,m[5]+m[7]+50,20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(n+7,m[2],m[3],m[4]+3,m[5]+3,m[6]+94,m[7]+64,0x1c3a3e,0x232a35,1,true)end,['remove']=function(n,p)for l=0,7 do ui.removeTextArea(543212345+n*8+l,p)end end},['text-area-custom']={AUTHOR='Nettoork#0000',_VERSION='2.0',dependencies={},['add']=function(...)local q={...}if type(q[1])=='table'then for l,v in next,q do if type(v)=='table'then if not v[3]then v[3]='nil'end;addTextArea(table.unpack(v))end end else if not q[3]then q[3]='nil'end;b[q[3]..'_'..q[1]]={...}ui.addTextArea(...)end end,['update']=function(n,r,p)if not p then p='nil'end;if not b[p..'_'..n]then return elseif type(r)=='string'then ui.updateTextArea(n,r,p)b[p..'_'..n][2]=r;return end;local s={text=2,x=4,y=5,w=6,h=7,background=8,border=9,alpha=10,fixed=11}for l,v in next,r do if s[l]then b[p..'_'..n][s[l]]=v end end;local t=b[p..'_'..n]ui.addTextArea(t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10],t[11])end,['remove']=function(n,p)if not p then p='nil'end;if b[p..'_'..n]then b[p..'_'..n]=nil end;ui.removeTextArea(n,p)end},['string-to-boolean']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['parse']=function(u)local w={}for l,v in next,u do w[v]=true end;return w end},['database']={AUTHOR='Nettoork#0000',_VERSION='1.1',dependencies={},['create']=function(x,y)if not c[x]then c[x]=y end end,['delete']=function(x)c[x]=nil end,['get']=function(x,...)local z,A={},{...}if not A[1]then return c[x]else for l,v in next,A do if c[x][v]then z[#z+1]=c[x][v]end end;return table.unpack(z)end end,['set']=function(x,...)local B=v;for l,v in next,{...}do if not B then B=v else c[x][B]=v;B=false end end end},['encryption']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['encrypt']=function(u,C,D)if not u or not C or not D or type(u)~='table'or C==''or D==''then return end;local E,F,G,H='','','',''for l in C:gmatch('.')do E=E..l:byte()end;for l in D:gmatch('.')do H=H..l:byte()end;math.randomseed(E)otherSeed=math.random(1000000)local I=pcall(function()for l,v in next,u do if type(v)=='string'or type(v)=='number'then if type(v)=='string'then v="'"..v.."'"end;G=G..' '..v..' '..l:upper()else return end end;G=G..' '..H;for l in G:gmatch('.')do local J=l:byte()+68+math.random(5)otherSeed=otherSeed+l:byte()math.randomseed(otherSeed)if J>=65 and J<=122 and not(J>=91 and J<=96)then J=string.char(J)end;F=F..J end end)math.randomseed(os.time())if not I then return else return F end end,['decrypt']=function(K,C,D)if not K or not C or not D or type(K)~='string'or C==''or D==''then return end;local E,F,L,H='','','',''for l in C:gmatch('.')do E=E..l:byte()end;for l in D:gmatch('.')do H=H..l:byte()end;math.randomseed(E)otherSeed=math.random(1000000)local I=pcall(function()for l in K:gmatch('.')do if l:byte()>=65 and l:byte()<=122 then local J=l:byte()-68-math.random(5)otherSeed=otherSeed+J;math.randomseed(otherSeed)F=F..string.char(J)else L=L..l;if L:len()>=3 then local J=tonumber(L)-68-math.random(5)otherSeed=otherSeed+J;math.randomseed(otherSeed)F=F..string.char(J)L=''end end end end)math.randomseed(os.time())if not I then return else local w,M,N,O,P={},0,0;for l,v in string.gmatch(F,'[^%s]+')do N=N+1 end;for l,v in string.gmatch(F,'[^%s]+')do M=M+1;if M==N and l~=H then return elseif O then if O:sub(-1)=="'"then w[l:lower()]=O:gsub("'",'')O=nil else O=O..' '..l end elseif P then w[l:lower()]=P;P=nil elseif l:sub(1,1)=="'"then O=l else P=l end end;return w end end},['sleep']={AUTHOR='Nettoork#0000',_VERSION='1.1',dependencies={},['loop']=function()local Q={}for l,v in next,a do if not v[2]or v[2]<os.time()then if coroutine.status(v[1])=='dead'then Q[#Q+1]=l else local R,S=coroutine.resume(v[1])v[2]=S end end end;if Q[1]then for l,v in next,Q do a[v]=nil end end end,['run']=function(T,U)if not U then U=500 end;a[#a+1]={coroutine.create(function()local V=function(W)coroutine.yield(os.time()+math.floor(W/U)*U)end;local X,Y=pcall(T,V)if Y then print(Y)end end),timeValue=nil}end},['wait-time']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['check']=function(Z,_,a0,a1)if Z and _ then if not d[Z]then d[Z]={}end;if not d[Z][_]then a1=0;d[Z][_]=os.time()+(a0 or 1000)end;if d[Z][_]<=os.time()or a1 and a1==0 then d[Z][_]=os.time()+(a0 or 1000)return true else return false end end end},['json']={AUTHOR='https://github.com/rxi',_VERSION='0.1.1',dependencies={},['encode']=function(a2)local a3;local a4={["\\"]="\\\\",["\""]="\\\"",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local a5={["\\/"]="/"}for a6,v in pairs(a4)do a5[v]=a6 end;local function a7(a8)return a4[a8]or string.format("\\u%04x",a8:byte())end;local function a9(a2)return"null"end;local function aa(a2,ab)local ac={}ab=ab or{}if ab[a2]then error("circular reference")end;ab[a2]=true;if a2[1]~=nil or next(a2)==nil then local W=0;for a6 in pairs(a2)do if type(a6)~="number"then error("invalid table: mixed or invalid key types")end;W=W+1 end;if W~=#a2 then error("invalid table: sparse array")end;for l,v in ipairs(a2)do table.insert(ac,a3(v,ab))end;ab[a2]=nil;return"["..table.concat(ac,",").."]"else for a6,v in pairs(a2)do if type(a6)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(ac,a3(a6,ab)..":"..a3(v,ab))end;ab[a2]=nil;return"{"..table.concat(ac,",").."}"end end;local function ad(a2)return'"'..a2:gsub('[%z\1-\31\\"]',a7)..'"'end;local function ae(a2)if a2~=a2 or a2<=-math.huge or a2>=math.huge then error("unexpected number value '"..tostring(a2).."'")end;return a2 end;local af={["nil"]=a9,["table"]=aa,["string"]=ad,["number"]=ae,["boolean"]=tostring}a3=function(a2,ab)local ag=type(a2)local T=af[ag]if T then return T(a2,ab)end;error("unexpected type '"..ag.."'")end;return a3(a2)end,['decode']=function(ah)local ai;local a5={["\\/"]="/"}local function aj(...)local ac={}for l=1,select("#",...)do ac[select(l,...)]=true end;return ac end;local ak=aj(" ","\t","\r","\n")local al=aj(" ","\t","\r","\n","]","}",",")local am=aj("\\","/",'"',"b","f","n","r","t","u")local an=aj("true","false","null")local ao={["true"]=true,["false"]=false,["null"]=nil}local function ap(ah,aq,ar,as)for l=aq,#ah do if ar[ah:sub(l,l)]~=as then return l end end;return#ah+1 end;local function at(ah,aq,au)local av=1;local aw=1;for l=1,aq-1 do aw=aw+1;if ah:sub(l,l)=="\n"then av=av+1;aw=1 end end;error(string.format("%s at line %d col %d",au,av,aw))end;local function ax(W)local T=math.floor;if W<=0x7f then return string.char(W)elseif W<=0x7ff then return string.char(T(W/64)+192,W%64+128)elseif W<=0xffff then return string.char(T(W/4096)+224,T(W%4096/64)+128,W%64+128)elseif W<=0x10ffff then return string.char(T(W/262144)+240,T(W%262144/4096)+128,T(W%4096/64)+128,W%64+128)end;error(string.format("invalid unicode codepoint '%x'",W))end;local function ay(R)local az=tonumber(R:sub(3,6),16)local aA=tonumber(R:sub(9,12),16)if aA then return ax((az-0xd800)*0x400+aA-0xdc00+0x10000)else return ax(az)end end;local function aB(ah,l)local aC=false;local aD=false;local aE=false;local aF;for aG=l+1,#ah do local aH=ah:byte(aG)if aH<32 then at(ah,aG,"control character in string")end;if aF==92 then if aH==117 then local aI=ah:sub(aG+1,aG+5)if not aI:find("%x%x%x%x")then at(ah,aG,"invalid unicode escape in string")end;if aI:find("^[dD][89aAbB]")then aD=true else aC=true end else local a8=string.char(aH)if not am[a8]then at(ah,aG,"invalid escape char '"..a8 .."' in string")end;aE=true end;aF=nil elseif aH==34 then local R=ah:sub(l+1,aG-1)if aD then R=R:gsub("\\u[dD][89aAbB]..\\u....",ay)end;if aC then R=R:gsub("\\u....",ay)end;if aE then R=R:gsub("\\.",a5)end;return R,aG+1 else aF=aH end end;at(ah,l,"expected closing quote for string")end;local function aJ(ah,l)local aH=ap(ah,l,al)local R=ah:sub(l,aH-1)local W=tonumber(R)if not W then at(ah,l,"invalid number '"..R.."'")end;return W,aH end;local function aK(ah,l)local aH=ap(ah,l,al)local aL=ah:sub(l,aH-1)if not an[aL]then at(ah,l,"invalid literal '"..aL.."'")end;return ao[aL],aH end;local function aM(ah,l)local ac={}local W=1;l=l+1;while 1 do local aH;l=ap(ah,l,ak,true)if ah:sub(l,l)=="]"then l=l+1;break end;aH,l=ai(ah,l)ac[W]=aH;W=W+1;l=ap(ah,l,ak,true)local aN=ah:sub(l,l)l=l+1;if aN=="]"then break end;if aN~=","then at(ah,l,"expected ']' or ','")end end;return ac,l end;local function aO(ah,l)local ac={}l=l+1;while 1 do local H,a2;l=ap(ah,l,ak,true)if ah:sub(l,l)=="}"then l=l+1;break end;if ah:sub(l,l)~='"'then at(ah,l,"expected string for key")end;H,l=ai(ah,l)l=ap(ah,l,ak,true)if ah:sub(l,l)~=":"then at(ah,l,"expected ':' after key")end;l=ap(ah,l+1,ak,true)a2,l=ai(ah,l)ac[H]=a2;l=ap(ah,l,ak,true)local aN=ah:sub(l,l)l=l+1;if aN=="}"then break end;if aN~=","then at(ah,l,"expected '}' or ','")end end;return ac,l end;local aP={['"']=aB,["0"]=aJ,["1"]=aJ,["2"]=aJ,["3"]=aJ,["4"]=aJ,["5"]=aJ,["6"]=aJ,["7"]=aJ,["8"]=aJ,["9"]=aJ,["-"]=aJ,["t"]=aK,["f"]=aK,["n"]=aK,["["]=aM,["{"]=aO}ai=function(ah,aq)local aN=ah:sub(aq,aq)local T=aP[aN]if T then return T(ah,aq)end;at(ah,aq,"unexpected character '"..aN.."'")end;if type(ah)~="string"then error("expected argument of type string, got "..type(ah))end;local ac,aq=ai(ah,ap(ah,1,ak,true))aq=ap(ah,aq,ak,true)if aq<=#ah then at(ah,aq,"trailing garbage")end;return ac end},['runtime-analyze']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['run']=function(...)local aQ=0;local aR=0;local aS=0;local aT={}local aU={...}local aV={}local aW={"#83FFA4","#30FF67","#00FF44","#E9FF82","#EEFF24","#F5F604","#FF524F","#FF302D","#E60400","#C70502"}for l=1,10 do aV[l]=string.rep("\226\150\136",l)end;if tfm.get.room.name:find("^\42\03")~=nil then aS=40 else aS=60 end;local aX=function()local aY=""for l,v in next,aT do local aZ=math.floor(v.timeLoaded/(aS/10))*(5-math.floor(aQ/2))aZ=aZ>10 and 10 or aZ;local a_=(aZ==0 and""or"<font color='"..aW[aZ].."'>")..(aZ==0 and""or aV[aZ])aY=aY..string.format("<PT>[%s]</PT>\n%dms %s",l,v.timeLoaded,a_)..'</font>\n'end;local aZ=math.floor(aR/(aS/10))*(5-math.floor(aQ/2))aZ=aZ>10 and 10 or aZ;local a_=(aZ==0 and""or"<font color='"..aW[aZ].."'>")..(aZ==0 and""or aV[aZ])aY=aY..string.format("<D>Global Runtime:</D>\n%dms %s",aR,a_)..'</font> '..aS..'ms\n'if aU[1]then for l,v in next,aU do ui.addTextArea(3102301909,aY,v,5,26,0,0,1,1,0.5,true)end else ui.addTextArea(3102301909,aY,nil,5,26,0,0,1,1,0.5,true)end end;local b0={['eventLoop']=function()aQ=aQ+1;if aQ>8 then aR=0;aQ=0;for l,v in next,aT do aT[l]={call=0,timeLoaded=0}end end;aX()end}for l,v in next,e do if _G[v]and type(_G[v])=="function"then local b1=_G[v]if not aT[v]then aT[v]={call=0,timeLoaded=0}end;_G[v]=function(...)aT[v].call=aT[v].call+1;if b0[v]then b0[v](table.unpack({...}))end;local b2=os.time()b1(table.unpack({...}))local b3=os.time()-b2;aR=aR-aT[v].timeLoaded;aT[v].timeLoaded=aT[v].timeLoaded+b3+b3*0.15;aR=aR+aT[v].timeLoaded end else if b0[v]then _G[v]=b0[v]end end end end},['parse-xml']={AUTHOR='http://lua-users.org/wiki/LuaXml',_VERSION='1.0',dependencies={},['parse']=function(b4)local ab={}local b5={}table.insert(ab,b5)local b6,a8,b7,b8,b9;local l,aG=1,1;while true do b6,aG,a8,b7,b8,b9=string.find(b4,"<(%/?)([%w:]+)(.-)(%/?)>",l)if not b6 then break end;local ba=string.sub(b4,l,b6-1)if not string.find(ba,"^%s*$")then table.insert(b5,ba)end;local m={}string.gsub(b8,"([%-%w]+)=([\"'])(.-)%2",function(bb,bc,bd)m[bb]=bd end)if b9=="/"then table.insert(b5,{label=b7,xarg=m,empty=1})elseif a8==""then b5={label=b7,xarg=m}table.insert(ab,b5)else local be=table.remove(ab)b5=ab[#ab]if#ab<1 then error("nothing to close with "..b7)end;if be.label~=b7 then error("trying to close "..be.label.." with "..b7)end;table.insert(b5,be)end;l=aG+1 end;local ba=string.sub(b4,l)if not string.find(ba,"^%s*$")then table.insert(ab[#ab],ba)end;if#ab>1 then error("unclosed "..ab[#ab].label)end;return ab[1]end},['foreach-index']={AUTHOR='https://stackoverflow.com/users/68204/rberteig',_VERSION='1.0',dependencies={},['run']=function(ag,T,bf)local bg={}for a6,bc in next,ag do bg[#bg+1]=a6 end;table.sort(bg,bf)for bc,a6 in ipairs(bg)do T(a6,ag[a6])end end}}local bh=1547917483395+2628*10^6;require=function(bi)if bi=='hide-warning'then bh=false else if bh and os.time()>bh then bh=false;print("<R>Warning! You may be using an outdated version of require, check in <i>pastebin.com/u/KananGamer</i> if this has a better version, otherwise you can disable this warning with require('hide-warning').</R>")end;if f[bi]then if f[bi]['INIT_SCRIPT']and type(f[bi]['INIT_SCRIPT'])=='function'then f[bi]['INIT_SCRIPT']()f[bi]['INIT_SCRIPT']=nil end;return f[bi]else print('Library "'..bi..'" not found! <i>Require Version: 1.3.0 | Author: Nettoork#0000</i>')return false end end end end
--[[ Current Version: 1.3.0 ]]--

local sleep = require("sleep")
local stb = require("string-to-boolean")
local admins = stb.parse({"Nettoork#0000"})
local maps = {"@7214563", "@7273409"}
local db = {}
local objects = {}
local loading
local timer

local split = function(t, s)
	local a={}
	for i in string.gmatch(t, "[^" .. (s or "%s") .. "]+") do
		a[#a + 1] = i
	end
	return a
end

local addGround = function()
	tfm.exec.addPhysicObject(1, 800, 387, { type = 6, restitution=0.2, friction=0.3, width=1600, height=37, groundCollision=true, miceCollision=true })
	tfm.exec.removePhysicObject(2)
end

local removeGround = function()
	tfm.exec.addPhysicObject(2, 800, 387, { type = 3, restitution = 0.2, friction = 0.3, width = 1600, height = 37, groundCollision = true, miceCollision = false })
	tfm.exec.removePhysicObject(1)
end

local checkPlayers = function()
	local alive = 0
	local totalPlayer = 0
	local lastPlayer
	for i, v in next, tfm.get.room.playerList do
		if not v.isDead then
			alive = alive + 1
			lastPlayer = i
		end
		totalPlayer = totalPlayer + 1
	end
	if ((alive == 1 and totalPlayer > 1) or alive <= 0 or (timer and timer <= 0)) and loading then
		loading = false
		sleep.run(function(sleep)
			if alive == 1 then
				ui.addTextArea(1, "\n\n\n\n<p align='center'><font size='60'><PT>"..lastPlayer.." venceu.</PT></font></p>", nil, 5, 26, 790, 390, 1, 1, 0, true)
				db[lastPlayer].level = db[lastPlayer].level + 1
				tfm.exec.setPlayerScore(lastPlayer, db[lastPlayer].level, false)
				tfm.exec.respawnPlayer(lastPlayer)
				tfm.exec.giveCheese(lastPlayer)
				tfm.exec.playerVictory(lastPlayer)
			elseif alive <= 0 or (timer and timer <= 0) then
				ui.addTextArea(1, "\n\n\n\n<p align='center'><font size='60'><PT>Não houveram vencedores</PT></font></p>", nil, 5, 26, 790, 390, 1, 1, 0, true)
			end
			sleep(5000)
			ui.removeTextArea(1)
			startGame()
		end)
	end
end

startGame = function()
	loading = true
	tfm.exec.newGame(maps[math.random(#maps)])
	tfm.exec.setGameTime(600)
	sleep.run(function(sleep)
		sleep(8000)
		if not loading then
			return
		end
		local total = 0
		if math.random(20) == 15 then
			for i = 1, 10 do
				objects[#objects + 1] = tfm.exec.addShamanObject(33, math.random(100, 1500), 26)
			end
			tfm.exec.chatMessage("<PT>CÓ, CÓ, CÓ!</PT>")
		end
		while loading do
			local s = sleep
			sleep = function(t)
				if not loading then
					return
				end
				s(t)
			end
			total = total + 1
			if total == 2 then
				for username in next, tfm.get.room.playerList do
					tfm.exec.giveMeep(username, true)
				end
			end
			for i = 1, math.random(10) == 1 and 1 or 2 do
				local object = math.random(7)
				objects[#objects + 1] = tfm.exec.addShamanObject(object == 5 and 6 or object, math.random(100, 1500), 350)
			end
			sleep(500)
			for i = math.random(4, 8), 1, -1 do
				ui.addTextArea(1, "\n\n\n\n<p align='center'><font size='60'>"..i.."</font></p>", nil, 5, 26, 790, 390, 1, 1, 0, true)
				sleep(1000)
			end
			ui.removeTextArea(1)
			removeGround()
			sleep(5000)
			addGround()
			checkPlayers()
			for i, v in next, objects do
				tfm.exec.removeObject(v)
			end
			objects = {}
			sleep(5000)
		end
		addGround()
		for i, v in next, objects do
			tfm.exec.removeObject(v)
		end
		ui.removeTextArea(1)
	end)
end

eventChatCommand = function(name, command)
	if admins[name] then
		local arg = split(command, " ")
		if arg[1] == "ban" and db[arg[2]] and not db[arg[2]].isBanned then
			db[arg[2]].isBanned = true
			tfm.exec.chatMessage("<R>"..arg[2].." foi impedido de jogar.</R>", arg[3] and name)
			tfm.exec.killPlayer(arg[2])
		elseif arg[1] == "unban" and db[arg[2]] and db[arg[2]].isBanned then
			db[arg[2]].isBanned = false
			tfm.exec.chatMessage("<BV>"..arg[2].." foi perdoado.</BV>", arg[3] and name)
		end
	end
	if command == "stop" and db[name] then
		db[name].displayMsg = not db[name].displayMsg
	end
end

eventNewPlayer = function(name)
	tfm.exec.chatMessage("<D>Seja bem-vindo a sala #lava. Essa é uma versão remasterizada feita por Nettoork#0000 de uma das primeiras versões do minigame que atualmente pertence à Sr_Timbo#6367.</D>\n<ROSE>Para vencer a partida, sobreviva subindo em objetos de shaman que serão jogadores de forma aleatória pelo mapa, e logo após o chão se transformará em lava.</ROSE>\n<BV>Sistema anti bug do X implementado, caso encontre algum erro reporte para <B>Bolodefchoco#0015</B></BV>", name)
	if not db[name] then
		db[name] = {
			isBanned = false,
			level = 0,
			moving = 0,
			displayMsg = true,
			notMoving = 0
		}
	end
	tfm.exec.setPlayerScore(name, db[name].level, false)
	for i = 0, 3 do system.bindKeyboard(name, i, true, true) end
	system.bindKeyboard(name, 32, true, true)
	system.bindKeyboard(name, string.byte("E"), true, true)
	tfm.exec.lowerSyncDelay(name)
end

eventLoop = function(a, t)
	sleep.loop()
	timer = t

	if a > 5000 then
		local time = os.time()
		for k, v in next, tfm.get.room.playerList do
			if not db[k] then return end
			if not v.isDead then
				if db[k].moving == 0 then
					if v.vx == 0 then
						if db[k].notMoving < 3 then
							db[k].notMoving = db[k].notMoving + .5
						else
							db[k].moving = os.time() + 5000
							if db[k].displayMsg then
								tfm.exec.chatMessage("Você morrerá caso não se mover constantemente! Digite !stop para não receber mais essa mensagem.", k)
							end
							db[k].notMoving = 0
						end
					end
				else
					if time > db[k].moving then
						tfm.exec.killPlayer(k)
					end
				end
			end
		end
	end
end

eventKeyboard = function(name)
	if not db[name] then return end
	db[name].moving = 0
end

eventNewGame = function()
	for i, v in next, tfm.get.room.playerList do
		if not db[i] then break end
		if db[i].isBanned then
			tfm.exec.killPlayer(i)
		end
		db[i].moving = 0
	end
	addGround()
end

eventPlayerDied = checkPlayers
eventPlayerLeft = checkPlayers

for index, value in next, {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft', 'PhysicalConsumables', 'AfkDeath', 'DebugCommand', 'AutoScore'} do
	tfm.exec['disable' .. value]()
end

for i, v in next, {"ban", "unban", "omg", "stop"} do
	system.disableChatCommandDisplay(v)
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)

startGame()