addConju = function(...)tfm.exec.addConjuration(...)end;addImage = function(...)tfm.exec.addImage(...)end;addJoint = function(...)tfm.exec.addJoint(...)end;addPhyObj = function(...)tfm.exec.addPhysicObject(...)end;addShaObj = function(...)tfm.exec.addShamanObject(...)end;changepsize = function(...)tfm.exec.changePlayerSize(...)end;chatMsg = function(...)tfm.exec.chatMessage(...)end;disableAfkDie = function(...)tfm.exec.disableAfkDeath(...)end;DisableAllShaSkill = function(...)tfm.exec.disableAllShamanSkills(...)end;disableAutoNewGame = function(...)tfm.exec.disableAutoNewGame(...)end;disableAutoScore = function(...)tfm.exec.disableAutoScore(...)end;disableAutoSha = function(...)tfm.exec.disableAutoShaman(...)end;disableAutotimeLeft = function(...)tfm.exec.disableAutoTimeLeft(...)end;disabledebug = function(...)tfm.exec.disableDebugCommand(...)end;disableminimode = function(...)tfm.exec.disableMinimalistMode(...)end;disablemort = function(...)tfm.exec.disableMortCommand(...)end;disablephyconsu = function(...)tfm.exec.disablePhysicalConsumables(...)end;disableprespawnp = function(...)tfm.exec.disablePrespawnPreview(...)end;disablewatch = function(...)tfm.exec.disableWatchCommand(...)end;displayp = function(...)tfm.exec.displayParticle(...)end;explo = function(...)tfm.exec.explosion(...)end;givechesse = function(...)tfm.exec.giveCheese(...)end;giveconsu = function(...)tfm.exec.giveConsumables(...)end;givem = function(...)tfm.exec.giveMeep(...)end;givet = function(...)tfm.exec.giveTransformations(...)end;killp = function(...)tfm.exec.killPlayer(...)end;linkp = function(...)tfm.exec.linkMice(...)end;lowersdelay = function(...)tfm.exec.lowerSyncDelay(...)end;moveobj = function(...)tfm.exec.moveObject(...)end;movep = function(...)tfm.exec.movePlayer(...)end;newgame = function(...)tfm.exec.newGame(...)end;pemote = function(...)tfm.exec.playEmote(...)end;pwin = function(...)tfm.exec.playerVictory(...)end;addimg = function(...)tfm.exec.removeCheese(...)end;reimg = function(...)tfm.exec.removeImage(...)end;rejoint = function(...)tfm.exec.removeJoint(...)end;reobj = function(...)tfm.exec.removeObject(...)end;rephyobj = function(...)tfm.exec.removePhysicObject(...)end;replayer = function(...)tfm.exec.respawnPlayer(...)end;setAutoMapFlipMode = function(...)tfm.exec.setAutoMapFlipMode(...)end;setgtime = function(...)tfm.exec.setGameTime(...)end;setncolor = function(...)tfm.exec.setNameColor(...)end;setpscore = function(...)tfm.exec.setPlayerScore(...)end;setmaxplayer = function(...)tfm.exec.setRoomMaxPlayers(...)end;setpass = function(...)tfm.exec.setRoomPassword (...)end;setsha = function(...)tfm.exec.setShaman(...)end;setshamode = function(...)tfm.exec.setShamanMode(...)end;setvamp = function(...)tfm.exec.setVampirePlayer(...)end;snow = function(...)tfm.exec.snow(...)end;addp = function(...)ui.addPopup(...)end;addtarea = function(...)ui.addTextArea (...)end;retarea = function(...)ui.removeTextArea (...)end;mapname = function(...)ui.setMapName (...)end;shaname = function(...)ui.setShamanName (...)end;showcpicker = function(...)ui.showColorPicker (...)end;uptarea = function(...)ui.updateTextArea (...)end;

--[[ Require By: Nettoork#0000 ]]--
do local a={}local b={}local c={}local d={}local e;e={['perfomance']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(f,g,h)local i=0;for v=1,f do local j=os.time()for k=1,g do h(g)end;i=i+os.time()-j end;return'Estimated Time: '..i/f..' ms.'end},['button']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(...)local l={...}local m=-543212345+l[1]*3;local n=l[9]and'0x2A424B'or'0x314e57'ui.addTextArea(m,'',l[4],l[5]-1,l[6]-1,l[7],l[8],0x7a8d93,0x7a8d93,1,true)ui.addTextArea(m-1,'',l[4],l[5]+1,l[6]+1,l[7],l[8],0x0e1619,0x0e1619,1,true)ui.addTextArea(m-2,'<p align="center"><a href="event:'..l[3]..'">'..l[2]..'</a></p>',l[4],l[5],l[6],l[7],l[8],n,n,1,true)end,['remove']=function(m,o)for k=0,2 do ui.removeTextArea(-543212345+m*3-k,o)end end},['ui-design']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(...)local l={...}if l[6]<0 or l[7]and l[7]<0 then return elseif not l[7]then l[7]=l[6]/2 end;local m=543212345+l[1]*8;ui.addTextArea(m,'',l[3],l[4],l[5],l[6]+100,l[7]+70,0x78462b,0x78462b,1,true)ui.addTextArea(m+1,'',l[3],l[4],l[5]+(l[7]+140)/4,l[6]+100,l[7]/2,0x9d7043,0x9d7043,1,true)ui.addTextArea(m+2,'',l[3],l[4]+(l[6]+180)/4,l[5],(l[6]+10)/2,l[7]+70,0x9d7043,0x9d7043,1,true)ui.addTextArea(m+3,'',l[3],l[4],l[5],20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+4,'',l[3],l[4]+l[6]+80,l[5],20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+5,'',l[3],l[4],l[5]+l[7]+50,20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+6,'',l[3],l[4]+l[6]+80,l[5]+l[7]+50,20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+7,l[2],l[3],l[4]+3,l[5]+3,l[6]+94,l[7]+64,0x1c3a3e,0x232a35,1,true)end,['remove']=function(m,o)for k=0,7 do ui.removeTextArea(543212345+m*8+k,o)end end},['text-area-custom']={AUTHOR='Nettoork#0000',_VERSION='2.0',dependencies={},['add']=function(...)local p={...}if type(p[1])=='table'then for k,v in next,p do if type(v)=='table'then if not v[3]then v[3]='nil'end;addTextArea(table.unpack(v))end end else if not p[3]then p[3]='nil'end;b[p[3]..'_'..p[1]]={...}ui.addTextArea(...)end end,['update']=function(m,q,o)if not o then o='nil'end;if not b[o..'_'..m]then return elseif type(q)=='string'then ui.updateTextArea(m,q,o)b[o..'_'..m][2]=q;return end;local r={text=2,x=4,y=5,w=6,h=7,background=8,border=9,alpha=10,fixed=11}for k,v in next,q do if r[k]then b[o..'_'..m][r[k]]=v end end;local s=b[o..'_'..m]ui.addTextArea(s[1],s[2],s[3],s[4],s[5],s[6],s[7],s[8],s[9],s[10],s[11])end,['remove']=function(m,o)if not o then o='nil'end;if b[o..'_'..m]then b[o..'_'..m]=nil end;ui.removeTextArea(m,o)end},['string-to-boolean']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['parse']=function(t)local u={}for k,v in next,t do u[v]=true end;return u end},['database']={AUTHOR='Nettoork#0000',_VERSION='1.1',dependencies={},['create']=function(w,x)if not c[w]then c[w]=x end end,['delete']=function(w)c[w]=nil end,['get']=function(w,...)local y,z={},{...}if not z[1]then return c[w]else for k,v in next,z do if c[w][v]then y[#y+1]=c[w][v]end end;return table.unpack(y)end end,['set']=function(w,...)local A=v;for k,v in next,{...}do if not A then A=v else c[w][A]=v;A=false end end end},['encryption']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['encrypt']=function(t,B,C)if not t or not B or not C or type(t)~='table'or B==''or C==''then return end;local D,E,F,G='','','',''for k in B:gmatch('.')do D=D..k:byte()end;for k in C:gmatch('.')do G=G..k:byte()end;math.randomseed(D)otherSeed=math.random(1000000)local H=pcall(function()for k,v in next,t do if type(v)=='string'or type(v)=='number'then if type(v)=='string'then v="'"..v.."'"end;F=F..' '..v..' '..k:upper()else return end end;F=F..' '..G;for k in F:gmatch('.')do local I=k:byte()+68+math.random(5)otherSeed=otherSeed+k:byte()math.randomseed(otherSeed)if I>=65 and I<=122 and not(I>=91 and I<=96)then I=string.char(I)end;E=E..I end end)math.randomseed(os.time())if not H then return else return E end end,['decrypt']=function(J,B,C)if not J or not B or not C or type(J)~='string'or B==''or C==''then return end;local D,E,K,G='','','',''for k in B:gmatch('.')do D=D..k:byte()end;for k in C:gmatch('.')do G=G..k:byte()end;math.randomseed(D)otherSeed=math.random(1000000)local H=pcall(function()for k in J:gmatch('.')do if k:byte()>=65 and k:byte()<=122 then local I=k:byte()-68-math.random(5)otherSeed=otherSeed+I;math.randomseed(otherSeed)E=E..string.char(I)else K=K..k;if K:len()>=3 then local I=tonumber(K)-68-math.random(5)otherSeed=otherSeed+I;math.randomseed(otherSeed)E=E..string.char(I)K=''end end end end)math.randomseed(os.time())if not H then return else local u,L,M,N,O={},0,0;for k,v in string.gmatch(E,'[^%s]+')do M=M+1 end;for k,v in string.gmatch(E,'[^%s]+')do L=L+1;if L==M and k~=G then return elseif N then if N:sub(-1)=="'"then u[k:lower()]=N:gsub("'",'')N=nil else N=N..' '..k end elseif O then u[k:lower()]=O;O=nil elseif k:sub(1,1)=="'"then N=k else O=k end end;return u end end},['sleep']={AUTHOR='Nettoork#0000',_VERSION='1.1',dependencies={},['loop']=function()local P={}for k,v in next,a do if not v[2]or v[2]<os.time()then if coroutine.status(v[1])=='dead'then P[#P+1]=k else local Q,R=coroutine.resume(v[1])v[2]=R end end end;if P[1]then for k,v in next,P do a[v]=nil end end end,['run']=function(S,T)if not T then T=500 end;a[#a+1]={coroutine.create(function()local U=function(V)coroutine.yield(os.time()+math.floor(V/T)*T)end;S(U)end),timeValue=nil}end},['wait-time']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['check']=function(W,X,Y,Z)if W and X then if not d[W]then d[W]={}end;if not d[W][X]then Z=0;d[W][X]=os.time()+(Y or 1000)end;if d[W][X]<=os.time()or Z and Z==0 then d[W][X]=os.time()+(Y or 1000)return true else return false end end end},['json']={AUTHOR='https://github.com/rxi',_VERSION='0.1.1',dependencies={},['encode']=function(_)local a0;local a1={["\\"]="\\\\",["\""]="\\\"",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local a2={["\\/"]="/"}for a3,v in pairs(a1)do a2[v]=a3 end;local function a4(a5)return a1[a5]or string.format("\\u%04x",a5:byte())end;local function a6(_)return"null"end;local function a7(_,a8)local a9={}a8=a8 or{}if a8[_]then error("circular reference")end;a8[_]=true;if _[1]~=nil or next(_)==nil then local V=0;for a3 in pairs(_)do if type(a3)~="number"then error("invalid table: mixed or invalid key types")end;V=V+1 end;if V~=#_ then error("invalid table: sparse array")end;for k,v in ipairs(_)do table.insert(a9,a0(v,a8))end;a8[_]=nil;return"["..table.concat(a9,",").."]"else for a3,v in pairs(_)do if type(a3)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(a9,a0(a3,a8)..":"..a0(v,a8))end;a8[_]=nil;return"{"..table.concat(a9,",").."}"end end;local function aa(_)return'"'.._:gsub('[%z\1-\31\\"]',a4)..'"'end;local function ab(_)if _~=_ or _<=-math.huge or _>=math.huge then error("unexpected number value '"..tostring(_).."'")end;return _ end;local ac={["nil"]=a6,["table"]=a7,["string"]=aa,["number"]=ab,["boolean"]=tostring}a0=function(_,a8)local ad=type(_)local S=ac[ad]if S then return S(_,a8)end;error("unexpected type '"..ad.."'")end;return a0(_)end,['decode']=function(ae)local af;local a2={["\\/"]="/"}local function ag(...)local a9={}for k=1,select("#",...)do a9[select(k,...)]=true end;return a9 end;local ah=ag(" ","\t","\r","\n")local ai=ag(" ","\t","\r","\n","]","}",",")local aj=ag("\\","/",'"',"b","f","n","r","t","u")local ak=ag("true","false","null")local al={["true"]=true,["false"]=false,["null"]=nil}local function am(ae,an,ao,ap)for k=an,#ae do if ao[ae:sub(k,k)]~=ap then return k end end;return#ae+1 end;local function aq(ae,an,ar)local as=1;local at=1;for k=1,an-1 do at=at+1;if ae:sub(k,k)=="\n"then as=as+1;at=1 end end;error(string.format("%s at line %d col %d",ar,as,at))end;local function au(V)local S=math.floor;if V<=0x7f then return string.char(V)elseif V<=0x7ff then return string.char(S(V/64)+192,V%64+128)elseif V<=0xffff then return string.char(S(V/4096)+224,S(V%4096/64)+128,V%64+128)elseif V<=0x10ffff then return string.char(S(V/262144)+240,S(V%262144/4096)+128,S(V%4096/64)+128,V%64+128)end;error(string.format("invalid unicode codepoint '%x'",V))end;local function av(Q)local aw=tonumber(Q:sub(3,6),16)local ax=tonumber(Q:sub(9,12),16)if ax then return au((aw-0xd800)*0x400+ax-0xdc00+0x10000)else return au(aw)end end;local function ay(ae,k)local az=false;local aA=false;local aB=false;local aC;for aD=k+1,#ae do local aE=ae:byte(aD)if aE<32 then aq(ae,aD,"control character in string")end;if aC==92 then if aE==117 then local aF=ae:sub(aD+1,aD+5)if not aF:find("%x%x%x%x")then aq(ae,aD,"invalid unicode escape in string")end;if aF:find("^[dD][89aAbB]")then aA=true else az=true end else local a5=string.char(aE)if not aj[a5]then aq(ae,aD,"invalid escape char '"..a5 .."' in string")end;aB=true end;aC=nil elseif aE==34 then local Q=ae:sub(k+1,aD-1)if aA then Q=Q:gsub("\\u[dD][89aAbB]..\\u....",av)end;if az then Q=Q:gsub("\\u....",av)end;if aB then Q=Q:gsub("\\.",a2)end;return Q,aD+1 else aC=aE end end;aq(ae,k,"expected closing quote for string")end;local function aG(ae,k)local aE=am(ae,k,ai)local Q=ae:sub(k,aE-1)local V=tonumber(Q)if not V then aq(ae,k,"invalid number '"..Q.."'")end;return V,aE end;local function aH(ae,k)local aE=am(ae,k,ai)local aI=ae:sub(k,aE-1)if not ak[aI]then aq(ae,k,"invalid literal '"..aI.."'")end;return al[aI],aE end;local function aJ(ae,k)local a9={}local V=1;k=k+1;while 1 do local aE;k=am(ae,k,ah,true)if ae:sub(k,k)=="]"then k=k+1;break end;aE,k=af(ae,k)a9[V]=aE;V=V+1;k=am(ae,k,ah,true)local aK=ae:sub(k,k)k=k+1;if aK=="]"then break end;if aK~=","then aq(ae,k,"expected ']' or ','")end end;return a9,k end;local function aL(ae,k)local a9={}k=k+1;while 1 do local G,_;k=am(ae,k,ah,true)if ae:sub(k,k)=="}"then k=k+1;break end;if ae:sub(k,k)~='"'then aq(ae,k,"expected string for key")end;G,k=af(ae,k)k=am(ae,k,ah,true)if ae:sub(k,k)~=":"then aq(ae,k,"expected ':' after key")end;k=am(ae,k+1,ah,true)_,k=af(ae,k)a9[G]=_;k=am(ae,k,ah,true)local aK=ae:sub(k,k)k=k+1;if aK=="}"then break end;if aK~=","then aq(ae,k,"expected '}' or ','")end end;return a9,k end;local aM={['"']=ay,["0"]=aG,["1"]=aG,["2"]=aG,["3"]=aG,["4"]=aG,["5"]=aG,["6"]=aG,["7"]=aG,["8"]=aG,["9"]=aG,["-"]=aG,["t"]=aH,["f"]=aH,["n"]=aH,["["]=aJ,["{"]=aL}af=function(ae,an)local aK=ae:sub(an,an)local S=aM[aK]if S then return S(ae,an)end;aq(ae,an,"unexpected character '"..aK.."'")end;if type(ae)~="string"then error("expected argument of type string, got "..type(ae))end;local a9,an=af(ae,am(ae,1,ah,true))an=am(ae,an,ah,true)if an<=#ae then aq(ae,an,"trailing garbage")end;return a9 end}}local aN=1547917483395+2628*10^6;require=function(aO)if aO=='hide-warning'then aN=false else if aN and os.time()>aN then aN=false;print("<R>Warning! You may be using an outdated version of require, check in <i>atelier801.com/topic?f=6&t=880333</i> if this has a better version, otherwise you can disable this warning with require('hide-warning').</R>")end;if e[aO]then if e[aO]['INIT_SCRIPT']and type(e[aO]['INIT_SCRIPT'])=='function'then e[aO]['INIT_SCRIPT']()e[aO]['INIT_SCRIPT']=nil end;return e[aO]elseif aO=='libs'then return e else print('Library "'..aO..'" not found! <i>Require Version: 1.2.2 | Author: Nettoork#0000</i>')return false end end end end


-- [[ Bibliotecas ]] --
local wait = require("wait-time")
local stb = require("string-to-boolean")

-- [[ Variaveis ]]

local jogadores = {}
local mapas = {'@7570168', '@7565291','@7570258'}
local podeChecar = false
local morto = false
local vivo = false
local admins = stb.parse({"Sla#3700"})
local timeToRemove=1.3
local vivos = 0
local timer = 0
local timer1 = 0
local cdwn

-- [[ Traduções ]] ---
lang = {
	br = {
		WELCOME = "<J>Bem Vindo a Vivo ou Morto, Se Aparecer um rato dançando, Dance, Se Aparecer um rato morto, durma. \n Caso esteja com shaman offline, digite !skip</J>",
		CHOICE = "<p align=\"center\"><font size=\"20\" color=\"#BABD2F\"><a href=\"event:vivo\">Vivo</a> || <a href=\"event:morto\">Morto</a>",
		RWIN = "<D>~[Juiz] ~ Os Jogadores Venceram!",
		ERROR1 = "<R>É Necessário possuir dois ou mais jogadores para o jogo iniciar!"
	},
	en = {
		WELCOME = "<J>Welcome to Alive or Dead, If a mouse shows up dancing, Dance, If a dead mouse appears, sleep.</J>",
		CHOICE = "<p align=\"center\"><font size=\"20\" color=\"#BABD2F\"><a href=\"event:vivo\">Alive</a> || <a href=\"event:morto\">Dead</a>",
		RWIN = "<D>~[Juiz] ~ The players won!",
		ERROR1 = "<R>Is necessary have two or more players to start the game!"
	},
	hu = {
		WELCOME = "<J>Üdv az Alive and Dead-ben, ha egy táncoló egeret látsz, táncolj, ha egy halott egeret látsz, aludj.</J>",
		CHOICE = "<p align=\"center\"><font size=\"20\" color=\"#BABD2F\"><a href=\"event:vivo\">Élő</a> || <a href=\"event:morto\">Halott</a>",
		RWIN = "<D>~[Juiz] ~ A játékosok nyertek!",
	},
	he = {
		WELCOME = "<J>ברוכים הבאים לחי או מת, אם מופיע עכבר רוקד, רקדו, אם מופיע עכבר מת, תשנו.</J>",
		CHOICE = "<p align=\"center\"><font size=\"20\" color=\"#BABD2F\"><a href=\"event:vivo\">חי</a> || <a href=\"event:morto\">מת</a>",
		RWIN = "<D>~[Juiz] ~ השחקנים ניצחו!",
	},
}

function translate(p, k)
	local cmm = tfm.get.room.playerList[p] and tfm.get.room.playerList[p].community or "en"
	cmm = lang[cmm] and cmm or "en"
	return lang[cmm][k] or "ERROR"
end

-- [[ Evento Novo Jogador ]] --
eventNewPlayer = function(nome)
	jogadores[nome] = {
 monstro = false,
 fez = false
	}
ajuda(nome)
end

-- [[ Função Enviar Mensagem De Ajuda ]] --
ajuda = function (p)
chatMsg(translate(p, "WELCOME"), p)
end

-- [[Considerar jogadores na sala como novos jogadores]] --
table.foreach(tfm.get.room.playerList, eventNewPlayer)

-- [[ Evento Novo Jogo ]] --
eventNewGame = function()
cdwn = false
skip = 0
podeChecar = false
vivos = 0
for _ in pairs(tfm.get.room.playerList) do
vivos = vivos + 1
end
iniciarounao()
if vivos >= 2 then
for nome, jogador in pairs(tfm.get.room.playerList) do
if jogador.isShaman then
jogadores[nome].monstro = true
vivos = vivos - 1
addtarea(0, translate(nome, "CHOICE"), nome, 286, 362, 198, 30, 0x077bb5, 0x000000, 1, true)
tfm.exec.movePlayer(nome,400,121,false,0,0,true)
tfm.exec.setNameColor(nome, 0xCB546B)
end
end
for nome, jogador in pairs(tfm.get.room.playerList) do
if not jogador.isShaman then
tfm.exec.setNameColor(nome, 0xC45345B)
jogadores[nome].monstro = false
retarea(0, nome)
end
end
end
end
-- [[ Evento Clicar No Evento Da Textarea ]] --
eventTextAreaCallback = function(id, name, ref)
 if ref == "vivo"  then
 if timer1 > os.time() then return end
 pa = 1
 timer1 = os.time() + 3000
 timer = os.time() + 1200
 vivo = true
 morto = false
 local id2 = tfm.exec.addImage("168b09842dc.png", "&1", 252, 77, nil)
 system.newTimer(function()
 if id2 then
 tfm.exec.removeImage(id2)
 end
 end,timeToRemove*1000,false)
 elseif ref == "morto" then
 if timer1 > os.time() then return end
 vivo = false
 morto = true
 timer = os.time() + 1200
 timer1 = os.time() + 3000
 podeChecar = true
 local id = tfm.exec.addImage("16a1977936f.png", "&2", 186, 22, nil)
 local timeToRemove=3
 system.newTimer(function()
 if id then
 tfm.exec.removeImage(id)
 end
 end,timeToRemove*1000,false)
 end
 end
-- [[ Evento que acontece a cada 500 milisegundos ]] --
eventLoop = function(tc, tr)
if tr == 0 then
if vivos <= 1 then
tfm.exec.newGame('<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="802" o="324650" X="400" Y="378" T="12" H="42" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="324650" X="806" Y="404" T="12" H="10" /><S P="0,0,0,0,0,0,0,0" L="10" o="fffffffff" X="2" Y="198" T="12" H="405" /><S P="0,0,0.3,0.2,0,0,0,0" L="806" o="fffffffff" X="401" Y="1" T="12" H="10" /><S P="0,0,0,0,0,0,0,0" L="10" o="fffffffff" X="806" Y="202" T="12" H="412" /></S><D><DS Y="350" X="401" /></D><O /></Z></C>')
else
tfm.exec.newGame(mapas[math.random(#mapas)])
end
elseif vivo then
cdwn = true
pa = 1
if timer > os.time() then return end
for nome, v in pairs(tfm.get.room.playerList) do
if jogadores[nome].fez == false and jogadores[nome].monstro == false and pa == 1 then
killp(nome)
print("oi")
else
jogadores[nome].fez = false
end
end
vivo = false
elseif morto then
if timer > os.time() then return end
cdwn = true
for nome, v in pairs(tfm.get.room.playerList) do
if jogadores[nome].fez == false and jogadores[nome].monstro == false and pa == 1 then
killp(nome)
else
jogadores[nome].fez = false
end
end
morto = false
end
end
-- [[ Evento, Um Jogador fez um emoji ]] --
function eventEmotePlayed(nome, eid)
if vivo then
if eid == 0 then
jogadores[nome].fez = true
else
matar(nome)
end
end
if morto then
if eid == 6 then
jogadores[nome].fez = true
else
matar(nome)
end
end
end
-- [[ Função, mata quem não compriu o proposto ]] --
matar = function(...)
if jogadores[...].monstro == true and cdwn == true then
else
killp(...)
checaJogadores()
end
end
-- [[ Função, Checa os Jogadores ]] --
checaJogadores = function()
if vivos <= 1 then
for name, v in pairs(tfm.get.room.playerList) do
if not v.isDead and not v.isShaman then
tfm.exec.setPlayerScore(name,25)
chatMsg(translate(name, "RWIN"), name)
end
end
tfm.exec.newGame(mapas[math.random(#mapas)])
end
end
-- [[ Evento Jogador Morreu ]] --
eventPlayerDied = function()
vivos = vivos - 1
checaJogadores()
end
-- [[ Evento Summonar um Item ]] --
function eventSummoningStart(playerName, objectType, xPosition, yPosition, angle)
tfm.exec.newGame(mapas[math.random(#mapas)])
end
-- [[ Evento Que acontece ao digitar um comando ]] --
eventChatCommand = function(nome, cmd)
local arg = {}
for i in string.gmatch(cmd, "[^" .. (s or "%s") .. "]+") do
arg[#arg + 1] = i
end
if (admins[nome]) and arg[1] == "admin" then
admins[arg[2]] = true
elseif (admins[nome]) and arg[1] == "np" then
tfm.exec.newGame(arg[2])
elseif (admins[nome]) and arg[1] == "score" then
tfm.exec.setPlayerScore(arg[2],25, true)
elseif arg[1] == "help" or arg[1] == "ajuda" then
ajuda(nome)
elseif arg[1] == "skip" then
skip = skip + 1
skipf()
end
end
skipf = function()
if skip >= 3 then
tfm.exec.newGame(mapas[math.random(#mapas)])
end
end
iniciarounao = function()
if vivos <= 1 then
for nome, jogador in pairs(tfm.get.room.playerList) do
chatMsg(translate(name, "ERROR1"))
end
tfm.exec.newGame('<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="802" o="324650" X="400" Y="378" T="12" H="42" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="324650" X="806" Y="404" T="12" H="10" /><S P="0,0,0,0,0,0,0,0" L="10" o="fffffffff" X="2" Y="198" T="12" H="405" /><S P="0,0,0.3,0.2,0,0,0,0" L="806" o="fffffffff" X="401" Y="1" T="12" H="10" /><S P="0,0,0,0,0,0,0,0" L="10" o="fffffffff" X="806" Y="202" T="12" H="412" /></S><D><DS Y="350" X="401" /></D><O /></Z></C>')
end
end
-- [[ Desabilita/Limita Coisas e Inicia um mapa do Module ]] --
tfm.exec.disablePhysicalConsumables(true)
tfm.exec.setRoomMaxPlayers(20)
tfm.exec.newGame('<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="802" o="324650" X="400" Y="378" T="12" H="42" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="324650" X="806" Y="404" T="12" H="10" /><S P="0,0,0,0,0,0,0,0" L="10" o="fffffffff" X="2" Y="198" T="12" H="405" /><S P="0,0,0.3,0.2,0,0,0,0" L="806" o="fffffffff" X="401" Y="1" T="12" H="10" /><S P="0,0,0,0,0,0,0,0" L="10" o="fffffffff" X="806" Y="202" T="12" H="412" /></S><D><DS Y="350" X="401" /></D><O /></Z></C>')