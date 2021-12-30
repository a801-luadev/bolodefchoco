local public
local setPublic = function()
	public = {
		[1] = {
			color = "7AC9C4",
			name = "Public Module Team members",
			list = _TEAM.mt
		},
		[2] = {
			color = "1ABC9C",
			name = "Shades Translators",
			list = _TEAM.st
		},
		[3] = {
			color = "E8822D",
			name = "Funcorp members",
			list = _TEAM.fc
		},
		[4] = {
			color = "2ECF73",
			name = "Sentinel members",
			list = _TEAM.sent
		},
		[5] = {
			color = "FFB6C1",
			name = "Public Fashion Squad members",
			list = _TEAM.fs
		},
		[6] = {
			color = "F3D165",
			name = "Shades Helpers members",
			list = _TEAM.sh
		},
		[7] = {
			color = "A77AC9",
			name = "Public Flash Squad members",
			list = _TEAM.fla
		},
		[8] = {
			color = "546E78",
			name = "Public Bots",
			list = _TEAM.bot
		},
		[9] = {
			color = "212121",
			name = "????????",
			list = _TEAM.evt
		},
	}
	local mapLength = math.ceil(#public / 2) * 400
	tfm.exec.newGame('<C><P L="' .. mapLength .. '" /><Z><S><S c="4" L="' .. mapLength .. '" o="E0E0E" X="' .. mapLength/2 .. '" H="385" Y="207" T="12" P=",,,,,,," /><S L="' .. mapLength .. '" X="' .. mapLength/2 .. '" H="35" Y="380" T="6" P=",,.3,.2,,,," /><S L="10" X="-5" H="71" Y="335" T="12" P=",,,,,,," /><S L="10" H="71" X="' .. mapLength+5 .. '" Y="335" T="12" P=",,,,,,," /></S><D><DS Y="360" X="350" /></D><O /></Z></C>')
end

local str = "<font color='#%s' face='Verdana'><B>%s online at %s</B><font size='3'>\n\n</font><font face='Lucida console'>"

local loaded = { }
local updateList = function(playerName)
	if not public then return end

	local X, Y = 0, 1
	for k = 1, #public do
		if not playerName or not public[k].str then
			public[k].str = string.format(str, public[k].color, public[k].name, os.date("%H:%M:%S"))
		end

		Y = (Y + 1) % 2
		ui.addTextArea(-k, public[k].str, playerName, 5 + X * 400, 20 + Y * 200, 390, 190 - (Y * 15), -1, 1, 1, false)
		X = X + Y

		if not playerName then
			for v in pairsByIndexes(public[k].list) do
				system.loadPlayerData(v)
			end
		end
	end
	ui.addTextArea(0, "<p align='center'><a href='event:@list'><VP>?", playerName, 780, 380, 15, 15, 1, 1, .6, true)
end

local checkTeams = function()
	if _TEAM._loaded then
		setPublic()
		return true
	end
	return false
end

local moduleList, moduleListCounter
do
	moduleList, moduleListCounter = { }, 0
	for moduleName, module in pairsByIndexes(modeMetaInfo) do
		if string.byte(moduleName, 2) ~= 3 and not module.isPrivate then -- Not tribe house modules
			moduleListCounter = moduleListCounter + 1
			moduleList[moduleListCounter] = module
		end
	end
	modeMetaInfo = nil
end

local info = { }

local openList = function(playerName)
	local module = moduleList[info[playerName]]
	ui.addTextArea(1, "<p align='center'><font size='22'><FC><a href='event:" .. module.name .. (module.hasAdmin and ("0" .. playerName) or "") .. "'>" .. string.upper(module.name) .. "</a>\n\n<font size='13'><p align='left'><J>Owner(s) : <V>" .. table.concat(module.authors, ", ") .. "\n\n<N>" .. (module.description or ""), playerName, 475, 165 + 60, 250, 146, 1, 1, .6, true)
	ui.addTextArea(2, "<VP><p align='center'><font size='15'><a href='event:@left'>«</a>\n", playerName, 475, 325 + 54, 20, 20, 1, 1, .6, true)
	ui.addTextArea(3, "<VP><p align='center'><font size='15'><a href='event:@right'>»</a>\n", playerName, 705, 325 + 54, 20, 20, 1, 1, .6, true)
	ui.addTextArea(4, "<VP><p align='center'><font size='14'><a href='event:@close'>Close</a>\n", playerName, 505, 325 + 54, 190, 20, 1, 1, .6, true)
end

eventNewGame = function()
	ui.setBackgroundColor("#1")
	ui.setMapName("Ba dum tss")
end

eventNewPlayer = function(playerName)
	updateList(playerName)
	tfm.exec.respawnPlayer(playerName)
	info[playerName] = 1
	tfm.exec.chatMessage("<VP>This is the personal room of <B>Bolodefchoco</B>.\n• Join our official Discord server to get help with Lua and modules: <B>https://discord.gg/quch83R</B>", playerName)
	tfm.exec.chatMessage("<CEP>\t/c D_shades<font size='-3'><G>#0780</G></font> <font color='#7AC9C4'>,moduleteam</font>\n\t/c D_shades<font size='-3'><G>#0780</G></font> <font color='#EF98AA'>,fashionsquad</font>\n\t/c D_shades<font size='-3'><G>#0780</G></font> <font color='#F3D165'>,shelpers</font>\n\t/c D_shades<font size='-3'><G>#0780</G></font> <font color='#FF9C00'>,funcorp</font>\n\t/c D_shades<font size='-3'><G>#0780</G></font> <font color='#2ECF73'>,sentinel</font>\n\t/c D_shades<font size='-3'><G>#0780</G></font> <font color='#2F7FCC'>,mapcrew</font>", playerName)
	tfm.exec.chatMessage("<VP>Type <B>!donate</B> if you would like to donate for this module!", playerName)
	tfm.exec.chatMessage("<N2>Ξ " .. playerName, "Bolodefchoco#0015")
	eventNewGame()
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)

eventPlayerDataLoaded = function(user)
	if loaded[user] then return end
	loaded[user] = true
	local update = false
	for k = 1, #public do
		if public[k].list[user] then
			public[k].str = public[k].str .. "[" .. public[k].list[user] .. "] <a href='event:" .. user .. "'>" .. user .. "</a>\n"
			ui.updateTextArea(-k, public[k].str)
			update = true
		end
	end
	if update then
		ui.addTextArea(0, "<p align='center'><a href='event:@list'><VP>?", playerName, 780, 380, 15, 15, 1, 1, .6, true)
	end
end

eventTextAreaCallback = function(id, playerName, callback)
	if id < 0 then
		tfm.exec.chatMessage("<J>/c " .. callback, playerName)
	else
		if callback == "@list" then
			openList(playerName)
		elseif callback == "@left" then
			info[playerName] = info[playerName] - 1
			if info[playerName] < 1 then
				info[playerName] = moduleListCounter
			end

			openList(playerName)
		elseif callback == "@right" then
			info[playerName] = info[playerName] + 1
			if info[playerName] > moduleListCounter then
				info[playerName] = 1
			end

			openList(playerName)
		elseif callback == "@close" then
			for i = 1, 4 do
				ui.removeTextArea(i, playerName)
			end
		else
			tfm.exec.chatMessage("<J>/room #bolodefchoco0" .. callback, playerName)
		end
	end
end

local timer = 0
eventLoop = function()
	if not public then
		if not checkTeams() then
			return
		end
	end

	timer = timer + .5
	if timer == .5 or timer == 60 then
		timer = .5
		loaded = { }
		updateList()
	end
end

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoShaman()
tfm.exec.disableAfkDeath()
tfm.exec.disableMortCommand()
tfm.exec.disablePhysicalConsumables()
system.disableChatCommandDisplay("donate")

local a,b,c,d,e,f=string.match,string.sub,string.gsub,string.gmatch,string.char,string.rep;local g=math.max;local h=table.unpack;local function i(j)local k=0;for l in next,j do k=type(l)=="number"and l or k end;return k end;do local m=h;h=function(j,k,n)return m(j,k or 1,n or i(j))end end;local o;local function p(q)local r={}for k in next,q do r[k]=true end;for k in next,q["*nil"]do r[k]=true end;return r end;local function s(q,r)return setmetatable({["*parentDefined"]=q~=o and setmetatable(r or p(q),{__index=q["*parentDefined"]})or{},["*nil"]={},["*parent"]=q},{__index=function(j,t)if not rawget(j,"*nil")[t]then if rawget(j,"*parentDefined")[t]then return q[t]else return o[t]end end end,__newindex=function(j,u,v)rawset(j,u,v)if v==nil then j["*nil"][u]=true else j["*nil"][u]=nil end end})end;local function w(j,t,v,x)if j==x then while j~=o do if rawget(j,t)~=nil or j["*nil"][t]then if v==nil then j["*nil"][t]=true end;break else j=j["*parent"]end end end;j[t]=v end;local y,z={},{}local A;local B={["or"]=function(C,D,...)return A(C,...)or A(D,...)end,["and"]=function(C,D,...)return A(C,...)and A(D,...)end,["<"]=function(C,D,...)return A(C,...)<A(D,...)end,[">"]=function(C,D,...)return A(C,...)>A(D,...)end,["<="]=function(C,D,...)return A(C,...)<=A(D,...)end,[">="]=function(C,D,...)return A(C,...)>=A(D,...)end,["~="]=function(C,D,...)return A(C,...)~=A(D,...)end,["=="]=function(C,D,...)return A(C,...)==A(D,...)end,[".."]=function(C,D,...)return A(C,...)..A(D,...)end,["+"]=function(C,D,...)return A(C,...)+A(D,...)end,["-"]=function(C,D,...)return A(C,...)-A(D,...)end,["*"]=function(C,D,...)return A(C,...)*A(D,...)end,["/"]=function(C,D,...)return A(C,...)/A(D,...)end,["//"]=function(C,D,...)return math.floor(A(C,...)/A(D,...))end,["%"]=function(C,D,...)return A(C,...)%A(D,...)end,["^"]=function(C,D,...)return A(C,...)^A(D,...)end}local E={"(.*%d)(or)(%d.*)","(.*%d)(and)(%d.*)","(.*%d)([<>~=]=?)(%d.*)","(.*%d)(%.%.)(%d.*)","(.*%d)([%+%-])(%d.*)","(.*%d)([%*/%%]/?)(%d.*)","(.*%d)(%^)(%d.*)"}local F={"^%s*([%+%-%*/%%%^=~><%.][=/%.]?)()","^%s*(and)()[^_%w]","^%s*(or)()[^_%w]"}local G={["#"]=function(C)return#C end,["-"]=function(C)return-C end,["not"]=function(C)return not C end}local H="[#%-]"local I={"%^"}local J={["="]=function(x,K,v)return v end,["+="]=function(x,K,v)return x[K]+v end,["-="]=function(x,K,v)return x[K]-v end,["*="]=function(x,K,v)return x[K]*v end,["/="]=function(x,K,v)return x[K]/v end,["^="]=function(x,K,v)return x[K]^v end,["%="]=function(x,K,v)return x[K]%v end,["..="]=function(x,K,v)return x[K]..v end,["or="]=function(x,K,v)return x[K]or v end,["and="]=function(x,K,v)return x[K]and v end,["//="]=function(x,K,v)return math.floor(x[K]/v)end}local L,M,N;local function O(P)P=c(P,"\\(.)(%d?%d?)",function(C,D)if C=="a"then return"\a"..D elseif C=="b"then return"\b"..D elseif C=="f"then return"\f"..D elseif C=="n"then return"\n"..D elseif C=="r"then return"\r"..D elseif C=="t"then return"\t"..D elseif C=="v"then return"\v"..D elseif C=="\\"then return"\\"..D elseif C=="\""then return"\""..D elseif C=="'"then return"'"..D elseif C=="["then return"["..D elseif C=="]"then return"]"..D elseif a(C,"^%d$")then return e(tonumber(C..D))else error("invalid escape sequence")end end)return P end;local function Q(R)while true do local S=a(R,"^[^\"']-%[(=-)%[")or a(R,"^[^']-(\")")or a(R,"'")if S then local T;if S~='"'and S~="'"then T=a(R,"%["..S.."%[.-%]"..S.."%]()")else local U;U,T=a(R,S.."(.-)"..S.."()")if T then local V=0;repeat U=O(U.."0")if b(U,-1)==e(0)then V=V+1;U,T=a(R,S..'(.-'..f(S..'.-',V)..')'..S..'()')else break end until false end end;if T then R=b(R,T)else return S end else return false end end end;local function W(C)return C:gsub("[^\n]+","")end;local function X(R,Y)local Z=1;while true do local _=b(R,Z)local a0,a1=a(_,"()%-%-(%[?=*%[?)")if a0 then local S=Q(b(_,1,a0-1))if not S then local D=a(a1,"%[(=-)%[")if D then R=b(R,1,Z-1)..c(_,"%-%-%["..D.."%[.-%]"..D.."%]",Y and W or"",1)else R=b(R,1,Z-1)..c(_,"%-%-.-\r?\n","\n",1)end else local a2,a3,U=b(_,a0)if S=="'"or S=='"'then U,a3=a(a2,"(.-)"..S.."()")local V=0;repeat U=O(U.."0")if b(U,-1)==e(0)then V=V+1;U,a3=a(a2,'(.-'..f(S..'.-',V)..')'..S..'()')else break end until false else a3=a(a2,"%]"..S.."%]()")end;Z=Z+a0+a3-2 end else break end end;return R end;local function a4(a5,...)return function(...)local C={a5(...)}if C[1]then return C[1],C end end,...end;local function a6(R)local a7,Z=a(R,"^%s*([_%a][_%w]*)()")if a7 then R=b(R,Z)end;return R,a7 end;local function a8(a9,aa,_,ab)if a9[1]==y then if aa=="function"then L,M=_,ab;return h(a9,2)elseif aa=="main"then error("'return' used outside function")else L,M=_,ab;return h(a9)end end;if a9[1]==z then if aa=="function"or aa=="main"then error("'break' used outside loop")else L,M=_,ab;return z end end end;local ac,ad;local function ae(af,x)local V=0;local C=af:match("^%s*{value%[1%]%(unpack%(args,1,c%)%)")local Z,ag,ah,ai=a(af,"^%s*{()%s*(}?)()")local v={}while ag==""do if ai==""then error("error")end;af=b(af,Z)Z=a(af,"^%s*%[()")local t,aj;if Z then af,t=ac(b(af,Z),x)Z=a(af,"^%s*%]%s*=%s*()")else t,Z=a(af,"^%s*([_%a][_%w]*)%s*=%s*()")if not Z then V=V+1;t=V;Z=1 end end;local ak={ac(b(af,Z),x)}af=ak[1]if x then v[t]=ak[2]local l=V;if Z==1 then for k=3,i(ak)do l=l+1;v[l]=ak[k]end end;for k=l+1,i(v)do v[k]=nil end end;ai,Z,ag,ah=a(af,"^%s*(,?)()%s*(}?)()")end;return b(af,ah),v end;local function al(R,am)local i=ad(R,nil,"",nil,true)local an=b(R,1,i)R=b(R,i+(am or 3)+1)return R,an end;function A(v,x,ao,ap,aq)local Z;for k=1,#E do v,Z=c(v,E[k],function(C,ar,D)aq=aq+1;ao[aq]=B[ar](C,D,x,ao,ap,aq)return tostring(aq)end)if Z~=0 then break end end;local k=tonumber(a(v,"%d+"))if ap[k]then ao[k]=select(2,ac(ap[k],x,nil,nil,true))ap[k]=nil end;return ao[k]end;function ac(R,x,as,at,au)if not au then N=R end;local v,av,aw,ax;if at then v=at;ax=true else v={}local a7;R,a7=a6(R)if a7 then if a7=="function"then local ay,Z,an=a(R,"^%s*%((.-)%)()")if not ay then error("error")end;local az=b(R,Z)R,an=al(az)if x then local r=p(x)local ab=M+L-#az;v[1]=function(...)local q=s(x,r)local aA,V,aB={...},0,false;for aC in d(ay,"%s*([^,]+)%s*")do if aB then error("error")end;V=V+1;if aC=="..."then q["..."]={h(aA,V,select("#",...))}aB=true else q[aC]=aA[V]end end;return ad(an,q,"function",ab)end end elseif G[a7]then R,v[1]=ac(R,x,true)if x then v[1]=G[a7](v[1])end elseif a7=="true"then v[1]=true elseif a7=="false"then v[1]=false elseif a7=="nil"then v[1]=nil else if x then v[1]=x[a7]end;ax=true end else local Z;v[1],Z=a(R,"^%s*\"(.-)\"()")if Z then local V=0;repeat v[1]=O(v[1].."0")if b(v[1],-1)==e(0)then V=V+1;v[1],Z=a(R,'^%s*"(.-'..f('".-',V)..')"()')else break end until false;v[1]=b(v[1],1,-2)R=b(R,Z)else v[1],Z=a(R,"^%s*'(.-)'()")if Z then local V=0;repeat v[1]=O(v[1].."0")if b(v[1],-1)==e(0)then V=V+1;v[1],Z=a(R,'^%s*\'(.-'..f('\'.-',V)..')\'()')else break end until false;v[1]=b(v[1],1,-2)R=b(R,Z)else local aD;aD,v[1],Z=a(R,'^%s*%[(=-)%[(.-)%]%1%]()')if Z then v[1],Z=a(R,'^%s*%['..aD..'%[(.-)%]'..aD..'%]()')R=b(R,Z)else local aE,a0,Z=a(R,"^%s*(%.?)(%d+)()")if a0 then R=b(R,Z)if aE==""then local a3,Z=a(R,"^%s*%.(%d+)()")if a3 then R=b(R,Z)a0=a0 .."."..a3 else a3,Z=a(R,"^%s*x(%w+)()")if a3 then if a0~="0"then error("error")end;R=b(R,Z)a0=a0 .."x"..a3 end end;v[1]=tonumber(a0)else v[1]=tonumber("0."..a0)end else Z=a(R,"^%s*%(()")if Z then R,v[1]=ac(b(R,Z),x)Z=a(R,"^%s*%)()")R=b(R,Z)ax=true elseif a(R,"^%s*{")then R,v[1]=ae(R,x)else Z=a(R,"^%s*%.%.%.()")if Z then R=b(R,Z)if x then if not x["..."]then error("error")end;v=x["..."]end else local ar,Z=a(R,"^%s*("..H..")()")if Z then if not G[ar]then error("error")end;R,v[1]=ac(b(R,Z),x,true)if x then v[1]=G[ar](v[1])end else error("unexpected character")end end end end end end end end end;while ax do aw=true;local aC,Z;if a(R,"^%s*{")then R,aC=ae(R,x)if x then if av then v={v[1](av,aC)}else v={v[1](aC)}end end;av=false else aC,Z=a(R,"^%s*\"(.-)\"()")if aC then local V=0;repeat aC=O(aC.."0")if b(aC,-1)==e(0)then V=V+1;aC,Z=a(R,'^%s*"(.-'..f('".-',V)..')"()')else break end until false;aC=b(aC,1,-2)R=b(R,Z)if x then if av then v={v[1](av,aC)}else v={v[1](aC)}end end;av=false else aC,Z=a(R,"^%s*'(.-)'()")if aC then local V=0;repeat aC=O(aC.."0")if b(aC,-1)==e(0)then V=V+1;aC,Z=a(R,'^%s*\'(.-'..f('\'.-',V)..')\'()')else break end until false;aC=b(aC,1,-2)R=b(R,Z)if x then if av then v={v[1](av,aC)}else v={v[1](aC)}end end;av=false else local aD;aD,aC,Z=a(R,'^%s*%[(=-)%[(.-)%]%1%]()')if aC then R=b(R,Z)if x then if av then v={v[1](av,aC)}else v={v[1](aC)}end end;av=false elseif a(R,"^%s*%(")then local Z=a(R,"^%s*%(%s*%)()")if Z then R=b(R,Z)if x then if av then v={v[1](av)}else v={v[1]()}end end else local aF,l,V={},0;if av then l=1;aF[l]=av end;Z=a(R,"^%s*%(()")while Z do local ak={ac(b(R,Z),x)}R=ak[1]l=l+1;V=l;for k=2,i(ak)do V=l+k-2;aF[V]=ak[k]end;Z=a(R,"^%s*,()")end;if x then v={v[1](h(aF,1,V))}end;Z=a(R,"^%s*%)()")R=b(R,Z)end;av=false else if av then error("error")end;Z=a(R,"^%s*%[()")if Z then local t;R,t=ac(b(R,Z),x)Z=a(R,"^%s*%]()")R=b(R,Z)if x then v[1]=v[1][t]end;aw=false else local aG;aG,Z=a(R,"^%s*%.%s*([_%a][_%w]*)()")if Z then R=b(R,Z)if x then v[1]=v[1][aG]end;aw=false else aG,Z=a(R,"^%s*:%s*([_%a][_%w]*)()")if Z then R=b(R,Z)if x then av=v[1]v[1]=v[1][aG]else av=true end;aw=false else break end end end end end end end end;if at then if not aw then error("error")end;return R end;if not as then local ao,V,aH,aI,ap={v[1]},1,true,"1",{}while aH do aH=false;for k=1,#F do local ar,Z=a(R,F[k])if ar then if not B[ar]then error("error")end;aH=true;local aJ,aK=b(R,Z)R=ac(aJ,nil,true)aK=b(aJ,1,#aJ-#R)V=V+1;ap[V]=aK;if x then aI=aI..ar..V end;break end end end;if x and aI~="1"then v={A(aI,x,ao,ap,V)}end else for k=1,#I do local ar,Z=a(R,"^%s*("..I[k]..")()")if Z then local aL;R,aL=ac(b(R,Z),x,true)if x then v={B[ar](v[1],aL)}end;break end end end;return R,h(v)end;local function aM(R,x)N=R;local Z=a(R,"^%s*;()")if Z then R=b(R,Z)if a(R,"^%s*$")then return""end end;local a7;R,a7=a6(R)if a7 then if a7=="local"then local aN;R,aN=a6(R)if aN then if aN=="function"then local aO,aF,Z,aP=a(R,"^%s*([_%a][_%w]*)%s*%((.-)%)()")local az=b(R,Z)R,aP=al(az)if x then local ab=M+L-#az;local r=p(x)x[aO]=function(...)local q=s(x,r)local aA={...}local V=0;local aB=false;for aC in d(aF,"%s*([^,]+)%s*")do if aB then error("error")end;V=V+1;if aC=="..."then q["..."]={h(aA,V,select('#',...))}aB=true else q[aC]=aA[V]end end;return ad(aP,q,"function",ab)end end else local ay={}local V=1;ay[V]=aN;local Z=a(R,"^%s*,()")while Z do V=V+1;R,aN=a6(b(R,Z))ay[V]=aN;Z=a(R,"^%s*,()")end;local Z=a(R,"^%s*=()")V=0;local aQ,l={},0;while Z do local ak={ac(b(R,Z),x)}R=ak[1]if x then V=V+1;l=V;for k=2,i(ak)do l=V+k-2;aQ[l]=ak[k]end end;Z=a(R,"^%s*,()")end;if x then for k=1,#ay do x[ay[k]]=k<=l and aQ[k]or nil end end end else error("error")end elseif a7=="function"then local aO,aF,Z,aP=a(R,"^%s*([_%a][_%.:%s%w]*)%s*%(%s*(.-)%)()")local az=b(R,Z)R,aP=al(az)if x then local ab=M+L-#az;local j=x;local aR;for Z,aS in d(aO,"([^%.%s]+)%s*%.%s*([^%.%s]+)")do j=j[Z]aR=aS end;if not aR then aR=a(aO,"[^:%s]+")end;local aT=a(aO,"^%s*.-%s*:%s*(.*)%s*$")if aT then j=j[aR]aR=aT end;local r=p(x)w(j,aR,function(...)local q=s(x,r)if aT then aF=aF==""and"self"or"self,"..aF end;local aA={...}local V=0;local aB=false;for aC in d(aF,"%s*([^,]+)%s*")do if aB then error("error")end;V=V+1;if aC=="..."then q["..."]={h(aA,V,select('#',...))}aB=true else q[aC]=aA[V]end end;return ad(aP,q,"function",ab)end,x)end elseif a7=="while"then local aJ=R;R=ac(R,nil)local aU=b(aJ,1,#aJ-#R)local Z=a(R,"^%s*do()")if Z then local az=b(R,Z)local an;R,an=al(az)if x then local ab=M+L-#az;while select(2,ac(aU,x))do local q=s(x)local a9={ad(an,q,"breakable",ab)}if a9[1]==y then return h(a9)elseif a9[1]==z then return R end end end else error("do expected")end elseif a7=="for"then local aN,Z=a(R,"^%s*([_%a][_%w]*)%s*=()")if aN then local aV;R,aV=ac(b(R,Z),x)Z=a(R,"^%s*,()")if Z then local aW;R,aW=ac(b(R,Z),x)local aX;Z=a(R,"^%s*,()")if Z then R,aX=ac(b(R,Z),x)if x and not aX then error("for step must be a number")end end;Z=a(R,"^%s*do()")if Z then local az=b(R,Z)local an;R,an=al(az)if x then local ab=M+L-#az;for k=aV,aW,aX or 1 do local q=s(x)q[aN]=k;local a9={ad(an,q,"breakable",ab)}if a9[1]==y then return h(a9)elseif a9[1]==z then return R end end end else error("error")end else error("error")end else aN,Z=a(R,"^%s*(.-)%s+in%s+()")if not aN then error("error")end;local aF={}local V,l=0,0;while Z do local ak={ac(b(R,Z),x)}R=ak[1]V=V+1;l=V;for k=2,i(ak)do l=V+k-2;aF[l]=ak[k]end;Z=a(R,"^%s*,()")end;for k=l+1,i(aF)do aF[k]=nil end;Z=a(R,"^%s*do()")if Z then local az=b(R,Z)local an;R,an=al(az)if x then local ab=M+L-#az;for ai,ao in a4(aF[1],aF[2],aF[3])do local q=s(x)local V=0;for aY in d(aN,"%s*([^,]+)%s*")do V=V+1;q[aY]=ao[V]end;local a9={ad(an,q,"breakable",ab)}if a9[1]==y then return h(a9)elseif a9[1]==z then return R end end end else error("error")end end elseif a7=="repeat"then local an,aZ,az;local az=R;R,an=al(R,5)aZ=R;R=ac(aZ,nil)aZ=b(aZ,1,#aZ-#R)if x then local ab=M+L-#az;repeat local q=s(x)local a9={ad(an,q,"breakable",ab)}if a9[1]==y then return h(a9)elseif a9[1]==z then return R end until select(2,ac(aZ,x))end elseif a7=="if"then local aZ;R,aZ=ac(R,x)local Z=a(R,"^%s*then()")local q;if x then q=s(x)end;if Z then local az=b(R,Z)local an;R,an=al(az,0)if aZ then if x then local ab=M+L-#az;local a9={ad(an,q,"if",ab)}if a9[1]==y or a9[1]==z then return h(a9)end end;local a_,Z=a(R,"^else(i?f?)()")while Z do if a_=="if"then R=ac(b(R,Z),nil)Z=a(R,"^%s*then()")end;R=al(b(R,Z),0)a_,Z=a(R,"^else(i?f?)()")end;R=b(R,4)else Z=a(R,"^elseif()")while Z do R,aZ=ac(b(R,Z),x)Z=a(R,"^%s*then()")if Z then az=b(R,Z)R,an=al(az,0)if aZ then if x then local ab=M+L-#az;local a9={ad(an,q,"if",ab)}if a9[1]==y or a9[1]==z then return h(a9)end end;local a_,Z=a(R,"^else(i?f?)()")while Z do if a_=="if"then R=ac(b(R,Z),nil)Z=a(R,"^%s*then()")end;R=al(b(R,Z),0)a_,Z=a(R,"^else(i?f?)()")end;R=b(R,4)break end else error("error")end;Z=a(R,"^elseif()")end;if not aZ then Z=a(R,"^else()")if Z then az=b(R,Z)R,an=al(b(R,Z))if x then local ab=M+L-#az;local a9={ad(an,q,"if",ab)}if a9[1]==y or a9[1]==z then return h(a9)end end else R=b(R,4)end end end else error("error")end elseif a7=="elseif"then return"",#R+6 elseif a7=="else"then return"",#R+4 elseif a7=="end"then return"",#R+3 elseif a7=="do"then local az=R;local an;R,an=al(R)if x then local ab=M+L-#az;local q=s(x)local a9={ad(an,q,"breakable",ab)}if a9[1]==y then return h(a9)elseif a9[1]==z then return R end end elseif a7=="break"then if x then return z end elseif a7=="return"then local Z,V,l=1,0,0;local b0={}local a7=select(2,a6(R))if a(R,"^%s*$")or a7 and(a7=="end"or a7=="elseif"or a7=="else"or a7=="until")then if x then return y end else while Z do local ak={ac(b(R,Z),x)}R=ak[1]V=V+1;l=V;for k=2,i(ak)do l=V+k-2;b0[l]=ak[k]end;Z=a(R,"^%s*,()")end;if x then return y,h(b0,1,l)end end elseif a7=="until"then return"",#R+5 else local ay={}local V=0;local aY=a7;local Z=1;while Z do R=b(R,Z)V=V+1;ay[V]={x,aY}while true do Z=a(R,"^%s*%[()[^=%]]")if Z then if x then ay[V][1]=ay[V][1][ay[V][2]]end;R,ay[V][2]=ac(b(R,Z),x)Z=a(R,"^%s*%]()")else local aG;aG,Z=a(R,"^%s*%.([_%a][_%w]*)()")if Z then if x then ay[V][1]=ay[V][1][ay[V][2]]end;ay[V][2]=aG else break end end;R=b(R,Z)end;aY,Z=a(R,"^%s*,%s*([_%a][_%w]*)()")end;if a(R,"^%s*[:%(\"'{%[]")then local at={}if x then if#ay>1 then error("error")end;at[1]=ay[1][1][ay[1][2]]end;R=ac(R,x,nil,at)else local ar,Z=a(R,"^%s*(%S-=)%s*()")V=0;local aQ,l={},0;while Z do local ak={ac(b(R,Z),x)}R=ak[1]if x then V=V+1;l=V;for k=2,i(ak)do l=V+k-2;aQ[l]=ak[k]end end;Z=a(R,"^%s*,()")end;if x then for k=1,#ay do w(ay[k][1],ay[k][2],J[ar](ay[k][1],ay[k][2],k<=l and aQ[k]or nil),x)end end end end else Z=a(R,"^%s*%(()")if Z then local at={}R,at[1]=ac(b(R,Z),x)Z=a(R,"^%s*%)()")R=ac(b(R,Z),x,nil,at)else error("unexpected character.")end end;return R end;function ad(R,x,aa,b1,b2)local C,D=L,M;L,M=#R,b1 or M;local b3=L;local ak={}while not a(R,"^%s*$")do ak={aM(R,x)}R=ak[1]if R==z or R==y then return a8(ak,aa,C,D)end end;L,M=C,D;if b2 then return b3-(ak[2]or b3)else return h(ak,2)end end;local function b4(b5,R,x,b6,...)o=x or _G;o._G=o;if b6 then R=X(R,true)end;x=s(o)L,M=#R,0;local b7={pcall(b5,R,x,...)}if b7[1]then return h(b7,2)else M=M+L-#N;local b8=select(2,c(b(R,1,M),"\n",""))+1;error("[LuaYan]:"..b8 ..":"..a(b7[2]or"0:","%d+:(.*)$"))end end
local load = {readExpression=function(R,q,b9)return b4(ac,R,q,nil,b9)end,readLine=function(R,q)return b4(aM,R,q)end,readScript=function(R,q,b6)return b4(ad,R,q,not(b6==false),"main",0)end,removeComments=X}
eventChatCommand = function(playerName, command)
	if command == "donate" then
		tfm.exec.chatMessage("<VP>Access the donation link through <font color='#7AC9C4'><B>https://a801-luadev.github.io/?redirect=bolodefchoco</B></font>", playerName)
		return
	end

	if owners[playerName] then
		load.readScript(command)
	end
end

