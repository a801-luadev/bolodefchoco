maps = {"@7686143", "@7116265", "@7115212", "@7115134", "@7686473", "@7686475", "@7686481", "@7686479", "@7686715", "@7615565", "@7519027", "@7687793", "@7520354", "@7520442", "@7519258", "@7521273", "@7615568", "@7115166", "@5965735", "@6268044", "@6515535", "@6690430", "@6692309", "@7686473", "@7687784"}
keys = {66, 67, 78, 86, 88}
miceInfo = {}
ui.setMapName("#Sizerace")
tfm.exec.disableAfkDeath()
tfm.exec.disableAutoNewGame()
tfm.exec.setGameTime(90)
tfm.exec.disableAutoShaman()
tfm.exec.newGame(maps[math.random(#maps)])

function eventNewGame()
ui.setMapName("#Sizerace")
tfm.exec.disableAfkDeath()
tfm.exec.setGameTime(90)
end

function eventPlayerDied(nick)
tfm.exec.changePlayerSize(nick, 1)
tfm.exec.respawnPlayer(nick)
end

function eventPlayerWon(nick)
tfm.exec.changePlayerSize(nick, 1)
if tfm.get.room.playerList[nick].community=="pl" then
	tfm.exec.chatMessage("<font color='#fff000'>Gracz " .. nick .. " właśnie wygrał rundę!")
else
	tfm.exec.chatMessage("<font color='#fff000'>Player " .. nick .. " has just won the round!")
end
end

function eventKeyboard(nick, key)
if key==88 and miceInfo[nick].lastTransform < os.time() - 2000 then
	tfm.exec.changePlayerSize(nick, 0.3)
	miceInfo[nick].lastTransform = os.time()
end
if key==67 and miceInfo[nick].lastTransform < os.time() - 2000 then
	tfm.exec.changePlayerSize(nick, 0.6)
	miceInfo[nick].lastTransform = os.time()
end
if key==86 and miceInfo[nick].lastTransform < os.time() - 2000 then
	tfm.exec.changePlayerSize(nick, 1)
	miceInfo[nick].lastTransform = os.time()
end
if key==66 and miceInfo[nick].lastTransform < os.time() - 2000 then
	tfm.exec.changePlayerSize(nick, 2.1)
	miceInfo[nick].lastTransform = os.time()
end
if key==78 and miceInfo[nick].lastTransform < os.time() - 2000 then
	tfm.exec.changePlayerSize(nick, 3.5)
	miceInfo[nick].lastTransform = os.time()
end
end

function eventTextAreaCallback(id, nick, call)
if tfm.get.room.playerList[nick].community=="pl" then
	if call=="help" then
 ui.addTextArea(1, "<p align='center'><font size='16'>#sizerace</font><br><br>Witaj w #sizerace! Zmieniaj rozmiar swojej myszki i przechodź najróżniejsze mapy z różnym poziomem trudności. Staraj się nie popełniać błędów! Możesz zmieniać swój rozmiar co 2 sekundy, dlatego każdy błąd poskutkuje stratą cennego czasu. Bądź najszybszy i baw się dobrze!<br><br><b>X</b> - rozmiar 0.3<br><b>C</b> - rozmiar 0.6<br><b>V</b> - rozmiar 1<br><b>B</b> - rozmiar 2.1<br><b>N</b> - rozmiar 3.5<br><br>Autor:<br>Boxofkrain#0000<br><br><a href='event:close'>Zamknij</a>", nick, 5, 50, 300, 265, 0x324650, 0x212F36, nil, true)
	elseif call=="close" then
 ui.removeTextArea(1, nick)
	end
else
	if call=="help" then
 ui.addTextArea(1, "<p align='center'><font size='16'>#sizerace</font><br><br>Welcome to #sizerace! Change size of your mouse and win different maps with different difficulty level. Don't make mistakes! You can change your mouse's size every 2 seconds only. Be the fastest and have fun!<br><br><b>X</b> - size 0.3<br><b>C</b> - size 0.6<br><b>V</b> - size 1<br><b>B</b> - size 2.1<br><b>N</b> - size 3.5<br><br>Author:<br>Boxofkrain#0000<br><br><a href='event:close'>Close</a>", nick, 5, 50, 300, 265, 0x324650, 0x212F36, nil, true)
	elseif call=="close" then
 ui.removeTextArea(1, nick)
	end
end
end

function eventNewPlayer(nick)
for i = 1,#keys do
	system.bindKeyboard(nick, keys[i], false, true)
end
miceInfo[nick] = {lastTransform = 0}
if tfm.get.room.playerList[nick].community=="pl" then
	ui.addTextArea(0, "<p align='center'><a href='event:help'>Pomoc</a></p>", nick, 5, 28, 65, nil, 0x324650, 0x212F36, nil, true)
	tfm.exec.chatMessage("<b><font color='#92CF91'>Hejka! Miło Cię widzieć na #sizerace! Wszystkie potrzebne informacje znajdziesz w zakładce Pomoc.</font></b>")
else
	ui.addTextArea(0, "<p align='center'><a href='event:help'>Help</a></p>", nick, 5, 28, 65, nil, 0x324650, 0x212F36, nil, true)
	tfm.exec.chatMessage("<b><font color='#92CF91'>Hey! Nice to see you in #sizerace! All the information you need are in Help tab.</font></b>")
end
if (nick=="Boxofkrain#0000") then
	tfm.exec.setNameColor("Boxofkrain#0000", 0xff0000)
end
end

function eventLoop(currentTime, remainingTime)
if remainingTime <= 500 then
	tfm.exec.newGame(maps[math.random(#maps)])
end
end

for nick in next, tfm.get.room.playerList do
eventNewPlayer(nick)
end
