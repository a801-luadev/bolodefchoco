do local a={}local b={}local c={}local d={}local e;e={['perfomance']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(f,g,h)local i=0;for v=1,f do local j=os.time()for k=1,g do h(g)end;i=i+os.time()-j end;return'Estimated Time: '..i/f..' ms.'end},['button']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(...)local l={...}local m=-543212345+l[1]*3;local n=l[9]and'0x2A424B'or'0x314e57'ui.addTextArea(m,'',l[4],l[5]-1,l[6]-1,l[7],l[8],0x7a8d93,0x7a8d93,1,true)ui.addTextArea(m-1,'',l[4],l[5]+1,l[6]+1,l[7],l[8],0x0e1619,0x0e1619,1,true)ui.addTextArea(m-2,'<p align="center"><a href="event:'..l[3]..'">'..l[2]..'</a></p>',l[4],l[5],l[6],l[7],l[8],n,n,1,true)end,['remove']=function(m,o)for k=0,2 do ui.removeTextArea(-543212345+m*3-k,o)end end},['ui-design']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['create']=function(...)local l={...}if l[6]<0 or l[7]and l[7]<0 then return elseif not l[7]then l[7]=l[6]/2 end;local m=543212345+l[1]*8;ui.addTextArea(m,'',l[3],l[4],l[5],l[6]+100,l[7]+70,0x78462b,0x78462b,1,true)ui.addTextArea(m+1,'',l[3],l[4],l[5]+(l[7]+140)/4,l[6]+100,l[7]/2,0x9d7043,0x9d7043,1,true)ui.addTextArea(m+2,'',l[3],l[4]+(l[6]+180)/4,l[5],(l[6]+10)/2,l[7]+70,0x9d7043,0x9d7043,1,true)ui.addTextArea(m+3,'',l[3],l[4],l[5],20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+4,'',l[3],l[4]+l[6]+80,l[5],20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+5,'',l[3],l[4],l[5]+l[7]+50,20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+6,'',l[3],l[4]+l[6]+80,l[5]+l[7]+50,20,20,0xbeb17d,0xbeb17d,1,true)ui.addTextArea(m+7,l[2],l[3],l[4]+3,l[5]+3,l[6]+94,l[7]+64,0x1c3a3e,0x232a35,1,true)end,['remove']=function(m,o)for k=0,7 do ui.removeTextArea(543212345+m*8+k,o)end end},['text-area-custom']={AUTHOR='Nettoork#0000',_VERSION='2.0',dependencies={},['add']=function(...)local p={...}if type(p[1])=='table'then for k,v in next,p do if type(v)=='table'then if not v[3]then v[3]='nil'end;addTextArea(table.unpack(v))end end else if not p[3]then p[3]='nil'end;b[p[3]..'_'..p[1]]={...}ui.addTextArea(...)end end,['update']=function(m,q,o)if not o then o='nil'end;if not b[o..'_'..m]then return elseif type(q)=='string'then ui.updateTextArea(m,q,o)b[o..'_'..m][2]=q;return end;local r={text=2,x=4,y=5,w=6,h=7,background=8,border=9,alpha=10,fixed=11}for k,v in next,q do if r[k]then b[o..'_'..m][r[k]]=v end end;local s=b[o..'_'..m]ui.addTextArea(s[1],s[2],s[3],s[4],s[5],s[6],s[7],s[8],s[9],s[10],s[11])end,['remove']=function(m,o)if not o then o='nil'end;if b[o..'_'..m]then b[o..'_'..m]=nil end;ui.removeTextArea(m,o)end},['string-to-boolean']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['parse']=function(t)local u={}for k,v in next,t do u[v]=true end;return u end},['database']={AUTHOR='Nettoork#0000',_VERSION='1.1',dependencies={},['create']=function(w,x)if not c[w]then c[w]=x end end,['delete']=function(w)c[w]=nil end,['get']=function(w,...)local y,z={},{...}if not z[1]then return c[w]else for k,v in next,z do if c[w][v]then y[#y+1]=c[w][v]end end;return table.unpack(y)end end,['set']=function(w,...)local A=v;for k,v in next,{...}do if not A then A=v else c[w][A]=v;A=false end end end},['encryption']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['encrypt']=function(t,B,C)if not t or not B or not C or type(t)~='table'or B==''or C==''then return end;local D,E,F,G='','','',''for k in B:gmatch('.')do D=D..k:byte()end;for k in C:gmatch('.')do G=G..k:byte()end;math.randomseed(D)otherSeed=math.random(1000000)local H=pcall(function()for k,v in next,t do if type(v)=='string'or type(v)=='number'then if type(v)=='string'then v="'"..v.."'"end;F=F..' '..v..' '..k:upper()else return end end;F=F..' '..G;for k in F:gmatch('.')do local I=k:byte()+68+math.random(5)otherSeed=otherSeed+k:byte()math.randomseed(otherSeed)if I>=65 and I<=122 and not(I>=91 and I<=96)then I=string.char(I)end;E=E..I end end)math.randomseed(os.time())if not H then return else return E end end,['decrypt']=function(J,B,C)if not J or not B or not C or type(J)~='string'or B==''or C==''then return end;local D,E,K,G='','','',''for k in B:gmatch('.')do D=D..k:byte()end;for k in C:gmatch('.')do G=G..k:byte()end;math.randomseed(D)otherSeed=math.random(1000000)local H=pcall(function()for k in J:gmatch('.')do if k:byte()>=65 and k:byte()<=122 then local I=k:byte()-68-math.random(5)otherSeed=otherSeed+I;math.randomseed(otherSeed)E=E..string.char(I)else K=K..k;if K:len()>=3 then local I=tonumber(K)-68-math.random(5)otherSeed=otherSeed+I;math.randomseed(otherSeed)E=E..string.char(I)K=''end end end end)math.randomseed(os.time())if not H then return else local u,L,M,N,O={},0,0;for k,v in string.gmatch(E,'[^%s]+')do M=M+1 end;for k,v in string.gmatch(E,'[^%s]+')do L=L+1;if L==M and k~=G then return elseif N then if N:sub(-1)=="'"then u[k:lower()]=N:gsub("'",'')N=nil else N=N..' '..k end elseif O then u[k:lower()]=O;O=nil elseif k:sub(1,1)=="'"then N=k else O=k end end;return u end end},['sleep']={AUTHOR='Nettoork#0000',_VERSION='1.1',dependencies={},['loop']=function()local P={}for k,v in next,a do if not v[2]or v[2]<os.time()then if coroutine.status(v[1])=='dead'then P[#P+1]=k else local Q,R=coroutine.resume(v[1])v[2]=R end end end;if P[1]then for k,v in next,P do a[v]=nil end end end,['run']=function(S,T)if not T then T=500 end;a[#a+1]={coroutine.create(function()local U=function(V)coroutine.yield(os.time()+math.floor(V/T)*T)end;S(U)end),timeValue=nil}end},['wait-time']={AUTHOR='Nettoork#0000',_VERSION='1.0',dependencies={},['check']=function(W,X,Y,Z)if W and X then if not d[W]then d[W]={}end;if not d[W][X]then Z=0;d[W][X]=os.time()+(Y or 1000)end;if d[W][X]<=os.time()or Z and Z==0 then d[W][X]=os.time()+(Y or 1000)return true else return false end end end},['json']={AUTHOR='https://github.com/rxi',_VERSION='0.1.1',dependencies={},['encode']=function(_)local a0;local a1={["\\"]="\\\\",["\""]="\\\"",["\b"]="\\b",["\f"]="\\f",["\n"]="\\n",["\r"]="\\r",["\t"]="\\t"}local a2={["\\/"]="/"}for a3,v in pairs(a1)do a2[v]=a3 end;local function a4(a5)return a1[a5]or string.format("\\u%04x",a5:byte())end;local function a6(_)return"null"end;local function a7(_,a8)local a9={}a8=a8 or{}if a8[_]then error("circular reference")end;a8[_]=true;if _[1]~=nil or next(_)==nil then local V=0;for a3 in pairs(_)do if type(a3)~="number"then error("invalid table: mixed or invalid key types")end;V=V+1 end;if V~=#_ then error("invalid table: sparse array")end;for k,v in ipairs(_)do table.insert(a9,a0(v,a8))end;a8[_]=nil;return"["..table.concat(a9,",").."]"else for a3,v in pairs(_)do if type(a3)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(a9,a0(a3,a8)..":"..a0(v,a8))end;a8[_]=nil;return"{"..table.concat(a9,",").."}"end end;local function aa(_)return'"'.._:gsub('[%z\1-\31\\"]',a4)..'"'end;local function ab(_)if _~=_ or _<=-math.huge or _>=math.huge then error("unexpected number value '"..tostring(_).."'")end;return _ end;local ac={["nil"]=a6,["table"]=a7,["string"]=aa,["number"]=ab,["boolean"]=tostring}a0=function(_,a8)local ad=type(_)local S=ac[ad]if S then return S(_,a8)end;error("unexpected type '"..ad.."'")end;return a0(_)end,['decode']=function(ae)local af;local a2={["\\/"]="/"}local function ag(...)local a9={}for k=1,select("#",...)do a9[select(k,...)]=true end;return a9 end;local ah=ag(" ","\t","\r","\n")local ai=ag(" ","\t","\r","\n","]","}",",")local aj=ag("\\","/",'"',"b","f","n","r","t","u")local ak=ag("true","false","null")local al={["true"]=true,["false"]=false,["null"]=nil}local function am(ae,an,ao,ap)for k=an,#ae do if ao[ae:sub(k,k)]~=ap then return k end end;return#ae+1 end;local function aq(ae,an,ar)local as=1;local at=1;for k=1,an-1 do at=at+1;if ae:sub(k,k)=="\n"then as=as+1;at=1 end end;error(string.format("%s at line %d col %d",ar,as,at))end;local function au(V)local S=math.floor;if V<=0x7f then return string.char(V)elseif V<=0x7ff then return string.char(S(V/64)+192,V%64+128)elseif V<=0xffff then return string.char(S(V/4096)+224,S(V%4096/64)+128,V%64+128)elseif V<=0x10ffff then return string.char(S(V/262144)+240,S(V%262144/4096)+128,S(V%4096/64)+128,V%64+128)end;error(string.format("invalid unicode codepoint '%x'",V))end;local function av(Q)local aw=tonumber(Q:sub(3,6),16)local ax=tonumber(Q:sub(9,12),16)if ax then return au((aw-0xd800)*0x400+ax-0xdc00+0x10000)else return au(aw)end end;local function ay(ae,k)local az=false;local aA=false;local aB=false;local aC;for aD=k+1,#ae do local aE=ae:byte(aD)if aE<32 then aq(ae,aD,"control character in string")end;if aC==92 then if aE==117 then local aF=ae:sub(aD+1,aD+5)if not aF:find("%x%x%x%x")then aq(ae,aD,"invalid unicode escape in string")end;if aF:find("^[dD][89aAbB]")then aA=true else az=true end else local a5=string.char(aE)if not aj[a5]then aq(ae,aD,"invalid escape char '"..a5 .."' in string")end;aB=true end;aC=nil elseif aE==34 then local Q=ae:sub(k+1,aD-1)if aA then Q=Q:gsub("\\u[dD][89aAbB]..\\u....",av)end;if az then Q=Q:gsub("\\u....",av)end;if aB then Q=Q:gsub("\\.",a2)end;return Q,aD+1 else aC=aE end end;aq(ae,k,"expected closing quote for string")end;local function aG(ae,k)local aE=am(ae,k,ai)local Q=ae:sub(k,aE-1)local V=tonumber(Q)if not V then aq(ae,k,"invalid number '"..Q.."'")end;return V,aE end;local function aH(ae,k)local aE=am(ae,k,ai)local aI=ae:sub(k,aE-1)if not ak[aI]then aq(ae,k,"invalid literal '"..aI.."'")end;return al[aI],aE end;local function aJ(ae,k)local a9={}local V=1;k=k+1;while 1 do local aE;k=am(ae,k,ah,true)if ae:sub(k,k)=="]"then k=k+1;break end;aE,k=af(ae,k)a9[V]=aE;V=V+1;k=am(ae,k,ah,true)local aK=ae:sub(k,k)k=k+1;if aK=="]"then break end;if aK~=","then aq(ae,k,"expected ']' or ','")end end;return a9,k end;local function aL(ae,k)local a9={}k=k+1;while 1 do local G,_;k=am(ae,k,ah,true)if ae:sub(k,k)=="}"then k=k+1;break end;if ae:sub(k,k)~='"'then aq(ae,k,"expected string for key")end;G,k=af(ae,k)k=am(ae,k,ah,true)if ae:sub(k,k)~=":"then aq(ae,k,"expected ':' after key")end;k=am(ae,k+1,ah,true)_,k=af(ae,k)a9[G]=_;k=am(ae,k,ah,true)local aK=ae:sub(k,k)k=k+1;if aK=="}"then break end;if aK~=","then aq(ae,k,"expected '}' or ','")end end;return a9,k end;local aM={['"']=ay,["0"]=aG,["1"]=aG,["2"]=aG,["3"]=aG,["4"]=aG,["5"]=aG,["6"]=aG,["7"]=aG,["8"]=aG,["9"]=aG,["-"]=aG,["t"]=aH,["f"]=aH,["n"]=aH,["["]=aJ,["{"]=aL}af=function(ae,an)local aK=ae:sub(an,an)local S=aM[aK]if S then return S(ae,an)end;aq(ae,an,"unexpected character '"..aK.."'")end;if type(ae)~="string"then error("expected argument of type string, got "..type(ae))end;local a9,an=af(ae,am(ae,1,ah,true))an=am(ae,an,ah,true)if an<=#ae then aq(ae,an,"trailing garbage")end;return a9 end}}local aN=1547917483395+2628*10^6;require=function(aO)if aO=='hide-warning'then aN=false else if aN and os.time()>aN then aN=false;print("<R>Warning! You may be using an outdated version of require, check in <i>atelier801.com/topic?f=6&t=880333</i> if this has a better version, otherwise you can disable this warning with require('hide-warning').</R>")end;if e[aO]then if e[aO]['INIT_SCRIPT']and type(e[aO]['INIT_SCRIPT'])=='function'then e[aO]['INIT_SCRIPT']()e[aO]['INIT_SCRIPT']=nil end;return e[aO]elseif aO=='libs'then return e else print('Library "'..aO..'" not found! <i>Require Version: 1.2.2 | Author: Nettoork#0000</i>')return false end end end end
--[[ Current Version: 1.2.2 ]]--

-- Biblioteca wait-time
local wait = require("wait-time")

-- Biblioteca string-to-boolean
local stb = require("string-to-boolean")

-- Variáveis básicas
tfm.exec.disableAfkDeath(true)
local podeClicar = {}
local time = os.time()
local toRemove = {}
local objects = {}
local maps = {'<C><P L="1600" /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="1600" o="1c1c1c" H="400" c="4" Y="201" T="12" X="799" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="430808" H="123" c="4" Y="40" T="12" X="701" /><S P="0,0,0.3,0.2,0,0,0,0" L="38" o="430808" H="121" c="4" Y="44" T="12" X="487" /><S c="3" L="104" o="28ff" H="310" X="1446" Y="39" T="12" P="0,0,0.3,0.2,90,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="17" o="ff3838" H="400" c="3" Y="284" T="12" X="792" /><S P="0,0,0.3,0.2,0,0,0,0" L="38" o="430808" H="121" c="4" Y="41" T="12" X="553" /><S P="0,0,0.3,0.2,0,0,0,0" L="40" o="430808" H="136" c="4" Y="48" T="12" X="626" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="430808" H="123" c="4" Y="46" T="12" X="333" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="430808" H="123" c="4" Y="42" T="12" X="407" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="430808" H="123" c="4" Y="41" T="12" X="777" /><S L="104" o="ff3838" H="310" X="156" Y="35" T="12" P="0,0,0.3,0.2,90,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="1600" o="ff3838" H="73" c="3" Y="-33" T="12" X="801" /><S c="4" L="107" o="f1c61" H="138" X="1547" Y="331" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="1600" o="ff3838" H="73" X="801" Y="108" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="430808" H="137" c="4" Y="334" T="12" X="70" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="ff3838" H="137" c="3" Y="334" T="12" X="204" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="430808" H="137" c="4" Y="334" T="12" X="340" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="ff3838" H="137" c="3" Y="334" T="12" X="476" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="430808" H="137" c="4" Y="334" T="12" X="613" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="ff3838" H="137" c="3" Y="334" T="12" X="715" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="28ff" H="137" c="3" Y="330" T="12" X="881" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="f1c61" H="137" c="4" Y="330" T="12" X="1018" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="28ff" H="137" c="3" Y="330" T="12" X="1153" /><S P="0,0,0,0.2,0,0,0,0" L="17" o="28ff" H="400" c="3" Y="284" T="12" X="812" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="f1c61" H="123" c="4" Y="46" T="12" X="861" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="f1c61" H="123" c="4" Y="48" T="12" X="939" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="f1c61" H="137" c="4" Y="330" T="12" X="1290" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="f1c61" H="123" c="4" Y="48" T="12" X="1100" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="f1c61" H="123" c="4" Y="47" T="12" X="1187" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="f1c61" H="123" c="4" Y="41" T="12" X="1269" /><S P="0,0,0.3,0.2,0,0,0,0" L="45" o="f1c61" H="123" c="4" Y="49" T="12" X="1015" /><S P="0,0,0.3,0.2,0,0,0,0" L="137" o="28ff" H="137" c="3" Y="330" T="12" X="1428" /><S c="3" L="800" o="28ff" H="73" X="1203" Y="108" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S c="3" L="800" o="28ff" H="73" X="1201" Y="-33" T="12" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DS Y="48" X="798" /></D><O /></Z></C>', '@7566173'} -- Lista de mapas
local mapInfo = { blueTeam = { x = 1069, y = 139 }, redTeam = { x = 430, y = 135 } } -- Informações de mapa
local canCheck = false -- Se pode ou não chegar o número de jogadores vivos
blueTeam = {} -- Time azul
redTeam = {} -- Time vermelho
blueTeamAlive = 0 -- Jogadores do time azul vivos
redTeamAlive = 0 -- Jogadores do time vermelho vivos
color_blueTeam = 0x1300ff -- Cor do time azul
color_redTeam = 0xff0000 -- Cor do time vermelho

-- Traduções
lang = {
	br = {
		WELCOME = "<J>Bem Vindo a Arrow, escolha sua equipe e vá para Luta!</J><ROSE> Aperte Espaço para Atirar Flechas</ROSE><VI>\nPara informações Adicionais e Avaliação de Mapa: https://atelier801.com/topic?f=842389&t=929772&p=1#m1</VI>",
	  RedTeam = "<a href='event:redTeam'><p align='center'>Entre para a Equipe Vermelha",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>Entre para a Equipe Azul",
		AWIN = "<D>~ [Juiz] Empate!",
		RWIN = "<R>~ [Equipe Vermelha] ~ Nós Vencemos!",
		BWIN = "<BV>~ [Equipe Azul] ~ Nós Vencemos!"
	},
	en = {
		WELCOME = "<J>Welcome to Arrow, choose your team and go to Fight! </J> <ROSE> Press Space to Shoot Arrows</ROSE><VI>\nFor additional information and map submissions: https://atelier801.com/topic?f=842389&t=929772&p=1#m1</VI>",
		RedTeam = "<a href='event:redTeam'><p align='center'>Join the Red Team",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>Join the Blue Team",
		AWIN = "<D>~ [Judge] No Winners!",
		RWIN = "<R>~ [Red Team] ~ We Won!",
		BWIN = "<BV>~ [Blue Team] ~ We Won!"
	},
		es = {
		WELCOME = "<J>Bienvenido a Arrow, ¡elige tu equipo y ve a pelear! </ J> <ROSE> Presiona la barra espaciadora para tirar flechas</ROSE>",
		RedTeam = "<a href='event:redTeam'><p align='center'>Entrar al Equipo Rojo",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>Entrar al Equipo Azul",
		AWIN = "<D>~ [Juez] ¡No hay ganadores!",
		RWIN = "<R>~ [Equipo Rojo] ~ ¡Nosotros ganamos!",
		BWIN = "<BV>~ [Equipo Azul] ~ ¡Nosotros ganamos!"
	},
		pl = {
		WELCOME = "<J>Witaj w Arrow, wybierz drużynę i WALCZ! </ J> <ROSE> Naciśnij spację aby wystrzelić strzałę</ROSE>\n<VI>Dodatkowe informacje oraz zgłaszanie map: https://atelier801.com/topic?f=842389&t=929772&p=1#m1</VI>",
		RedTeam = "<a href='event:redTeam'><p align='center'>Dołącz do Czerwonej Drużyny",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>Dołącz do Niebieskiej Drużyny",
		AWIN = "<D>~ [Sędzia] Brak Zwycięzców!",
		RWIN = "<R>~ [Czerwona Drużyna] ~ Wygraliśmy!",
		BWIN = "<BV>~ [Niebieska Drużyna] ~ Wygraliśmy!"
	},
	ar = {
		WELCOME = "<J>مرحبًا في Arrow, اختر فريقك واذهب للقتال! </ J> <ROSE>اضغط زر مسافة لتهجم بسهم</ROSE>",
		RedTeam = "<a href='event:redTeam'><p align='center'>انضم للفريق الأحمر",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>انضم للفريق الأزرق",
		AWIN = "<D>~ [الحكم] لا فائزين!",
		RWIN = "<R>~ [الفريق الأحمر] ~ نحنُ فُزنا!",
		BWIN = "<BV>~ [الفريق الأزرق] ~ We !"
	},
	cn = {
  WELCOME = "<J>欢迎来到 Arrow, 选择想加入的队伍然后参战吧! </ J> <ROSE> 按空格键来发射弓箭</ROSE>",
  RedTeam = "<a href='event:redTeam'><p align='center'>加入红队",
  BlueTeam = "<a href='event:blueTeam'><p align='center'>加入蓝队",
  AWIN = "<D>~ [裁判] 没有人胜出!",
  RWIN = "<R>~ [红队] ~ 我们赢了!",
  BWIN = "<BV>~ [蓝队] ~ 我们赢了!"
	},
 fr = {
  WELCOME = "<J>Bienvenue dans Arrow, choisis ton équipe et lance-toi au combat !</ J> <ROSE> Appuie sur espace pour tirer des flèches</ROSE>",
  RedTeam = "<a href='event:redTeam'><p align='center'>Rejoins l'équipe rouge",
  BlueTeam = "<a href='event:blueTeam'><p align='center'>Rejoins l'équipe bleue",
  AWIN = "<D>~ [Juge] Pas de gagnant !",
  RWIN = "<R>~ [Équipe rouge] ~ On a gagné !",
  BWIN = "<BV>~ [Équipe bleue] ~ On a gagné !"
	},
 nl = {
  WELCOME = "<J>Welkom bij Arrow, kies je team en ga vechten! </ J> <ROSE> Druk op de spatiebalk om pijlen te schieten</ROSE>",
  RedTeam = "<a href='event:redTeam'><p align=‘center'>Lid van het rode team worden",
  BlueTeam = "<a href='event:blueTeam'><p align=‘center'>Lid van het blauwe team worden",
  AWIN = "<D>~ [Jury] Geen winnaars!",
  RWIN = "<R>~ [Team rood] ~ We hebben gewonnen!",
  BWIN = "<BV>~ [Team blauw] ~ We hebben gewonnen!"
 },
 he = {
		WELCOME = "<J>ברוכים הבאים לחץ, בחרו את קבוצתכם והילחמו! </ J> <ROSE> לחצו על מקש הרווח כדי לירות חצים</ROSE>",
		RedTeam = "<a href='event:redTeam'><p align='center'>הצטרפו לקבוצה האדומה",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>הצטרפו לקבוצה הכחולה",
		AWIN = "<D>~ [שופט] אין מנצחים!",
		RWIN = "<R>~ [קבוצה אדומה] ~ אנחנו ניצחנו!",
		BWIN = "<BV>~ [קבוצה כחולה] ~ אנחנו ניצחנו!"
	},
	hu = {
		WELCOME = "<J>Üdvözlet az Arrow-ban, válassz csapatot és harcolj! </ J> <ROSE> A nyilak kilövéséhez használd a Space billentyűt</ROSE>",
		RedTeam = "<a href='event:redTeam'><p align='center'>Csatlakozz a Piros csapathoz",
		BlueTeam = "<a href='event:blueTeam'><p align='center'>Csatlakozz a kék csapathoz",
		AWIN = "<D>~ [Bíró] Nincs nyertes!",
		RWIN = "<R>~ [Piros csapat] ~ Nyertünk!",
		BWIN = "<BV>~ [Kék csapat] ~ Nyertünk!"
	},
}

-- Mensagem de Ajuda
local help = function(name)
	tfm.exec.chatMessage(translate(name, "WELCOME"), name)
end

-- Iniciar novo mapa
local startNewMap = function()
	tfm.exec.newGame(maps[math.random(#maps)])
end

-- Chegar número de jogadores vivos
local checkPlayersAlive = function()
	if blueTeamAlive == 0 or redTeamAlive == 0 then
		canCheck = false
		if blueTeamAlive == 0 and redTeamAlive == 0 then
			for i, v in pairs(tfm.get.room.playerList) do
			tfm.exec.chatMessage(translate(i, "AWIN"), i)
		end
		elseif blueTeamAlive == 0 then
	  for i, v in pairs(tfm.get.room.playerList) do
			tfm.exec.chatMessage(translate(i, "RWIN"), i)
		end
		elseif redTeamAlive == 0 then
	  for i, v in pairs(tfm.get.room.playerList) do
			tfm.exec.chatMessage(translate(i, "BWIN"), i)
		end
		end
		for username, data in next, tfm.get.room.playerList do
			if not data.isDead then
				tfm.exec.giveCheese(username)
				tfm.exec.playerVictory(username)
			end
		end
		startNewMap()
	end
end

-- Evento (Toda hora)
eventLoop = function(currentTime, timeRemaining)
if timeRemaining == 0 then
		startNewMap()
	elseif currentTime >= 20000 and currentTime <= 20500 then
 for username, data in next, tfm.get.room.playerList do
			if not data.isDead and not blueTeam[username] and not redTeam[username] then
				tfm.exec.killPlayer(username)
			end
		end
		ui.removeTextArea(1)
		ui.removeTextArea(2)
		canCheck = true
		checkPlayersAlive()
end
end
	for i, v in next, objects do
		if v[2] < os.time() then
			toRemove[#toRemove + 1] = i
		end
	end
	for i, v in next, toRemove do
		if objects[v] then
			tfm.exec.removeObject(objects[v][1])
			table.remove(objects, v)
		end
	end

-- Traduz as Mensagens
function translate(p, k)
	local cmm = tfm.get.room.playerList[p] and tfm.get.room.playerList[p].community or "en"
	cmm = lang[cmm] and cmm or "en"
	return lang[cmm][k] or "ERROR"
end

-- Evento (Novo jogador)
eventNewPlayer = function(name)
	tfm.exec.bindKeyboard(name, 32, true, true)
	help(name)
for p, v in pairs(tfm.get.room.playerList) do
podeClicar[p] = 0
end
end

-- Evento (TextArea clicada)
eventTextAreaCallback = function(id, name, ref)
	if ref == "blueTeam" or ref == "redTeam" and _G[ref.."Alive"] <= 10 and not tfm.get.room.playerList.isDead then
if podeClicar[name] > time then return end
 podeClicar[name] = time + 500
		_G[ref.."Alive"] = _G[ref.."Alive"] + 1
		_G[ref][name] = name
		tfm.exec.movePlayer(name, mapInfo[ref].x, mapInfo[ref].y)
		tfm.exec.setNameColor(name, _G["color_"..ref])
	end
	ui.removeTextArea(1, name)
	ui.removeTextArea(2, name)
end

-- Evento (Jogador morre)
eventPlayerDied = function(name)
	if blueTeam[name] then
		blueTeam[name] = nil
		blueTeamAlive = blueTeamAlive - 1
	elseif redTeam[name] then
		redTeam[name] = nil
		redTeamAlive = redTeamAlive - 1
	end
	if canCheck then
		checkPlayersAlive()
	end
end

-- Evento (Sempre que um jogador sair)
eventPlayerLeft = eventPlayerDied

-- Evento (Teclado ativado)
eventKeyboard = function(username, key, down, x, y)
	if key == 32 and not tfm.get.room.playerList[username].isDead and (blueTeam[username] or redTeam[username]) then
		if wait.check("arrow", username, 1200)  then
			objects[#objects + 1] = {tfm.exec.addShamanObject(35, blueTeam[username] and x - 20 or x + 20, y-10, blueTeam[username] and 180 or 0,  blueTeam[username] and -40 or 40), os.time() + 5000}
		end
	end
end

-- Evento (Novo mapa)
eventNewGame = function()
	local id=tfm.exec.addImage("168a552a1be.png", "&1", 197, 21, nil)
	local timeToRemove=5
	system.newTimer(function()
		if id then
			tfm.exec.removeImage(id)
		end
	end,timeToRemove*1000,false)
	tfm.exec.setGameTime(600)
for p, v in pairs(tfm.get.room.playerList) do
podeClicar[p] = 0
end
	blueTeam = {}
	redTeam = {}
	blueTeamAlive = 0
	redTeamAlive = 0
for i, v in pairs(tfm.get.room.playerList) do
	ui.addTextArea(1, translate(i, "RedTeam"), i, 6, 26, 182, 21, 0xff0011, 0, 1, true)
	ui.addTextArea(2, translate(i, "BlueTeam"), i, 647, 26, 182, 21, 0x0011ff, 0, 1, true)
end
end
-- Máximo de jogadores na sala
tfm.exec.setRoomMaxPlayers(20)

-- Desativar automatizações do Transformice ✓
for index, value in next, {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft', 'PhysicalConsumables'} do
	tfm.exec['disable' .. value]()
end

-- Considerar jogadores na sala como novos jogadores
table.foreach(tfm.get.room.playerList, eventNewPlayer)

-- Iniciar jogo
startNewMap()