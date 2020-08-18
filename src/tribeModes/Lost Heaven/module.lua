-- map: @7744070
shamanObjects = {}
idlenessPlayers = {}
bookClickPlayerTimeList = {}
playersData = {}



tfm.exec.disableAutoShaman(true)
tfm.exec.disableAfkDeath(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.newGame("@7744070")
tfm.exec.chatMessage("<font color = '#FFFF00'>Добро пожаловать в библиотеку Lost Heaven!</font>")

-- 1я книга (Правила)
function showFirstBook(playerName) ui.addTextArea(1,"<font color='#FF0000' size='10'><b>Свод правил</b></font>", nil, 180,115,90, 15, 0,0xffffffff, 0,true) end
function firstBookClick(playerName)
    local text = [==[
    *Книга написана чем-то, напоминающим странную смесь крови, слёз и ядовитых испарений действующего вулкана.*
    
    1.   Общий свод правил.
    1.1. Мат в умеренных количествах разрешен.
    1.2. Помните с нами играют маленькие дети.
    1.3. Обманывать сокланавцев запрещено.
    1.4. Администрация действует на свое усмотрение
            в спорных ситуациях.

    2.   Конкурсы и комната племени.
    2.1. Запуск луа и смена карт на конкурсе без разрешения
            организатора запрещен
    2.2. Игроки, не состоящие в племени не имеют право
            участвовать в конкурсах и присутствовать на фармах
            с пометкой племени
    2.3. Запрещена реклама фарма без пометки Lost Heaven

    Могут быть случаи бана, если человек не нарушал
    вышеперечисленное, чтобы узнать причину 
    напишите мне (Naomikio#0000) или в сообщения группы.
    ]==]
    ui.addPopup(1,0, text, playerName, 210, 30, 400,true)
end

-- 2-6я книги, мне ☻☺похуй☺☻ (История племени)
function showSecondBook(playerName) ui.addTextArea(2,"<font color='#9999FF' size='10'><b>История</b></font>", nil, 255, 125, 90, 20, 0,0xffffffff, 0,true) end
function secondBookClick(playerName)
    local text0 = [==[
	"Краткая история племени Lost Heaven"

	Наше племя зародилось 4 мая 2020 года. Создателей племени было 11 человек
	(Druggy_Doggy#3098, Nikitapley#6179, Min#7943, Voimyasatani#6041, Fireball#3838,
	Naomikio#0000, Liza#6232, Honeyul#5711, Buterbrot#9081, Stuntman_www_x#0831,
	Cherzik#2636) - большинство ушло по некоторым обстоятельствам, но всех нас объединяла
	одна цель - создать племя без жёстких правил и для общения. На данный момент, наша
	мечта стала явью. Мы все искренне верим, что наше племя действительно стало очень
	дружным и активным. Первый наш конкурс на 100 участников в племени сразу же дал очень
	хорошие результаты. Мы были удивлены таким активом. Люди, помнящие тот конкурс и
	присутствовавшие на нем, все ещё с нами и очень хорошо отзываются о нашем племени.
	Изначально были совершенно другие звания, а т.е. названия грехов по их иерархии в
	мифологии на английском языке (если найдется Олд, вспомнивший хоть одно - напишите
	одному из нынешних колдунов, вы получите 50 сыра от нас :3). Далее очень долгое
	время у нас стояли звания по тематике Данте, а именно 9 кругов ада. Сейчас, в принципе,
	не особо отличается от предыдущих тематикой, но все же немного поменяли. Наказательным
	званием ранее было "фанат деда".

	Кто же такой дед? Дед являлся первым активом и участником нашего племени, хоть сейчас
	он и предал племя, но все равно звание, я думаю, остаётся в памяти многих людей.
		
	Открыть следующую страницу?
    ]==]


    ui.addPopup(2000,1, text0, playerName, 110, 30, 600,true)
end

function eventPopupAnswer(popupID, playerName, answer)
local text1 = [==[
	Сейчас же, мы уже очень большое племя, находящееся в топе 100 лучших племен
	(на момент написания текста 66 место). И каждый создатель, даже ушедший, я думаю, очень
	рад, что в конечном итоге мы добились чего хотели.

	Мы вас всех очень любим!
	
	Открыть следующую страницу?
    ]==]       
    
    local text2 = [==[
	Нынешние создатели, оставшиеся в племени: Buterbrot#9081, Honeyuli#5711,
	Voimyasatani#6041, Fireball#3848, Naomikio#0000)
	Также, хочу уточнить, что абсолютно на равных правах с нами есть Главные Еретики
	(просто поставленно такое звание, чтоб не нарушать концепцию данного звания и
	не терять изначальную задумку):
	•Sheogorath#8725 - спасибо за множество отличных карт, активное участие в жизни племени,
		организацию фарма, слежкой за чатом и всегда идеально выполненную работу,
	•Keras#9975 - спасибо за множество луа - скриптов, актив в племени, помощь в дискорд
		сервере, слежку за чатом и организацией фарма.

	Но, конечно же, во всех наших достижениях ещё мы очень благодарны нашим еретиками: 
	•Viz#1717 (поблагодарим его за новые звания, проявление активности и инициативы,
		слежку за фармом, написание чудесного гайда для шаманов и многое другое)
		•Felixe96#0000 (поблагодарим за хороший монтаж видео, инвайты мышей и провождение 
		конкурсов)
	•Floweystyle#8410 (поблагодарим за то, что все проблемы с фотошопом брал на себя и делал
		отличные работы, а так же за создание карт)
	•Juzya#8075 (спасибо за монтаж видео и слежку за чатом!)
	•Karamelka#6455 (спасибо за слежку за чатом, повышение мышей)
	•Kawaymixare#0000 (Самый первый еретик и один из первых участников племени. Много
		помощи было в написании луа, очистки нулевых аккаунтов, активных обсуждений и
		внесений предложений для развития племени и многое другое)
		
		Открыть следующую страницу?
    ]==]   

    local text3 = [==[
	Tiran (творческие люди, занимающиеся созданием карт или же написанием луа-скриптов):
	•Missellik#5355 - спасибо за гайд по виприну и большое количество карт, также организацию
		фарма
	•Herobrine816#0000 спасибо за гайд и очень большое количество карт!
	
	Также, поблагодарим людей со званием "Helper", которые всегда помогали племени и очень
		его любят.

	И, конечно же, спасибо абсолютно каждой мышке за то, что проявляет активную жизнь
	в племени и помогает его развитию приглашением мышей!
    ]==]
    local text5 = [==[
	5. Отвечать на вопросы

	6. Делать скрины по возможности. Качественные! Без
		команды /watch и чата а скрине, если он там ни к месту.

	7. Писать посты о конкурсах в группе вк

	8. Приветствовать всех новеньких
        
	9. Организация фарма по возможности  

	Открыть следующую страницу?
    ]==]

    local text6 = [==[
	Обязанности Гневливых:

	1. Помогать племени своими навыками, которые указали
		в заявке при вступлении

	2. По возможности помогать Еретикам и Обманщикам

	3. Докладывать Еретикам или Обманщикам о нарушителях.
    ]==]    
	if answer == "yes" then
		if popupID == 2000 then
			ui.addPopup(2001,1, text1, playerName, 110, 30, 600,true)
		elseif popupID == 2001 then
			ui.addPopup(2002,1, text2, playerName, 110, 30, 600,true)
		elseif popupID == 2002 then
			ui.addPopup(2003,0, text3, playerName, 110, 30, 600,true)
		elseif popupID == 1700 then
			ui.addPopup(1701,1, text5, playerName, 210, 30, 400,true)
		elseif popupID == 1701 then
			ui.addPopup(1702,0, text6, playerName, 210, 30, 400,true)
		end
	end
end


-- 7я книга (Краткий путеводитель по кругам ада)
function showSevenBook(playerName) ui.addTextArea(7,"<font color='#38ABFF' size='10'><b>Путеводитель</b></font>", nil, 295, 115, 90, 15, 0,0xffffffff, 0,true) end
function sevenBookClick(playerName)
    local text0 = [==[
        "Краткий путеводитель по кругам ада.
         Автор - Данте Алигьери"

        1 круг — Лимбо
        Первый круг ада — Лимбо, где пребывают души тех, 
        кто в неправедных делах уличен не был,
        но умер некрещеным.
        
        2 круг — Сладострастие
        Здесь обитают души тех, кого на путь
        греха толкнула любовь.
        
        3 круг — Чревоугодие
        В этом круге заключены обжоры
        
        4 круг — Жадность
        Обитель тех, кто «недостойно тратил и копил»
        
        5 круг — Гнев и Лень
        Все круги до пятого — пристанище несдержанных,
        а несдержанность считается меньшим грехом,
        чем «злоба или буйное скотство»
    ]==]   

    local text1 = [==[

        6 круг — Для еретиков и лжеучителей
        Здесь царит неизбывная скорбь, а в раскрытых гробницах,
        словно в вечных печах, покоятся еретики и лжеучителя.
        
        7 круг — Для насильников и убийц всех мастей
        Сюда попадают и тираны, и убийцы, и самоубийцы
        
        8 круг — Для обманувших и недоверившихся
        Пристанище сводников и обольстителей, состоит из 10 рвов
        
        9 круг — Для отступников и предателей всех сортов
        Здесь покоятся вмороженные в лед отступники, и главный
        из них — Люцифер, падший ангел.
    ]==]
    ui.addPopup(7001,0, text1, playerName, 210, 50, 400,true)
    ui.addPopup(7000,0, text0, playerName, 210, 50, 400,true)
end

-- 8я книга (Обжорство)
function showEightBook(playerName) ui.addTextArea(8,"<font color='#38ABFF' size='10'><b>Обжорство</b></font>", nil,80,200,70, 15, 0,0xffffffff, 0,true) end
function eightBookClick(playerName)
	tfm.exec.changePlayerSize(playerName, 1.5)
	playersData[playerName].timeToBeSized = 5000
end


-- 9я книга (Блуд)
function showNineBook(playerName) ui.addTextArea(9,"<font color='#F0EC2C' size='10'><b>Блуд</b></font>", nil, 155, 201, 35, 15, 0,0xffffffff, 0,true) end
function nineBookClick(playerName)
    local x = tfm.get.room.playerList[playerName].x
    local y = tfm.get.room.playerList[playerName].y
    table.insert(shamanObjects, {["time"] = 1000 , ["object"] = tfm.exec.addShamanObject(35, x-50, y-50, 45, 10, 10, false)})
    table.insert(shamanObjects, {["time"] = 1000, ["object"] = tfm.exec.addShamanObject(35, x+50, y-50, 135, -10, 10, false)})
    tfm.exec.playEmote(playerName, 3)
end


-- 10я книга (Гордыня)
function showTenBook(playerName) ui.addTextArea(10, "<font color='#FFFFFF' size='10'><b>Гордыня</b></font>", nil, 172, 192, 55, 15, 0, 0xffffffff, 0, true) end
function tenBookClick(playerName)
    system.bindKeyboard(playerName, 32, true, true)
    tfm.exec.movePlayer(playerName, 0, 0, true, 0, -50, true)
end


-- 11я книга (Лень)
function showElevenBook(playerName) ui.addTextArea(11,"<font color='#00DC74' size='10'><b>Лень</b></font>", nil, 207, 201, 40, 15, 0,0xffffffff, 0,true) end
function elevenBookClick(playerName)
    table.insert(idlenessPlayers, {['time'] = 10000, ['playerName'] = playerName, ['x'] = tfm.get.room.playerList[playerName].x, ['y'] = tfm.get.room.playerList[playerName].y})
    tfm.exec.playEmote(playerName, 6)
end

-- 12я книга (Гнев)
function showTwelveBook(playerName) ui.addTextArea(12,"<font color='#FF0000' size='10'><b>Гнев</b></font>", nil, 240, 201, 40, 15, 0,0xffffffff, 0,true) end
function twelveBookClick(playerName)
    tfm.exec.playEmote(playerName, 4)
    x = tfm.get.room.playerList[playerName].x
    y = tfm.get.room.playerList[playerName].y
    tfm.exec.explosion(x, y, 30, 250, true)
end

-- 14я книга (Жадность)
function showForteenBook(playerName) ui.addTextArea(14,"<font color='#FDD169' size='10'><b>Жадность</b></font>", nil, 270, 201, 70, 15, 0,0xffffffff, 0,true) end
function forteenBookClick(playerName)
    x = tfm.get.room.playerList[playerName].x
    y = tfm.get.room.playerList[playerName].y
    tfm.exec.displayParticle(19, x+10, y-10)
    tfm.exec.setPlayerScore(playerName, tfm.get.room.playerList[playerName].score+16)
end

-- 15я книга (Заклинания для изменения комнаты племени)
function showFifteenBook(playerName) ui.addTextArea(15,"<font color='#9050B5' size='10'><b>Заклинания<br/> изменения</b></font>", nil, 130, 272, 75, 30, 0,0xffffffff, 0,true) end
function fifteenBookClick(playerName)
    local text0 = [==[
        *Из этой книги исходит странная энергия*

        Комната племени - магическое пространство, изменяющее
        свою форму при помощи несложных чар и произнесения
        заклинаний. Не каждый может их использовать,
        а только избранные маги с сильнейшими душами.
        Ниже мы приводим некоторые из этих заклинаний.
        
        Магические места, созданные Missellik:
        
        @7708970 - Комната для конкурса красоты.
        @7709932 - Запасная комната для КК.
        @7710456 - Комната отдыха
        @7715253 - Лагерь в лесу
        
        Магические места, созданные Weneys, так же известным
        под именем Хермеус Мора:
        
        @6561207 - Дом смертельной музыки
    ]==]

    local text1 = [==[
        Магические места, созданные даэдрическим принцем
        Шеогоратом:
        
        @7725946 - Зал огня
        @7729172 - Святилище Шеогората (место поклонения)
        @7729731 - Зал для Конкурса красоты
        @7744070 - Библиотека Хаоса (внимание: вы уже
        находитесь здесь! Не создавайте пространственных
        парадоксов!)
    ]==]        
    ui.addPopup(1501,0, text1, playerName, 210, 50, 400,true)
    ui.addPopup(1500,0, text0, playerName, 210, 50, 400,true)
end

-- 16я книга (Звания и как их получить)
function showSixteenBook(playerName) ui.addTextArea(16,"<font color='#00FF00' size='10'><b>Звания</b></font>", nil, 200, 270, 90, 20, 0,0xffffffff, 0,true) end
function sixteenBookClick(playerName)
    local text0 = [==[
        1. Zabveniy (Забвенный)
        Вступая в наше племя вы получаете данное звание. 
        Это означает, что вы умерли, не оставив никакой памяти
        о себе, попадая в наш потерянный рай;

        0. Dolbaeb (удалено по соображениям цензуры)
        Человек, нарушивший правила,  получает данное звание;

        2. Slastolyubiviy (Сластолюбивый)
        Поздравляем, вы внесли первый вклад в наше племя и
        отправляетесь на второй круг;

        3. Nenasitniy (Ненасытный)
        Действительно ненасытный... Ради желания быть выше,
        вы приглашаете все больше мышей в наш общий котел,
        где теперь всем им суждено вариться всем вместе;

        4. Neistomvy (Неистовый)
        Ярое желание и какие-то побуждения стать выше,
        получить больше доступа к командам - одобрено, спасибо
        за ещё 5 хороших людей или прекрасный конкурс!
    ]==]

    local text1 = [==[
        5. Lutiy (Лютый)
        Вы отправляетесь в следующий круг, где теперь уже
        водичка погорячее в вашем котле, но все ещё не
        дотягивает до горячих источников;

        6. Renegat (Ренегат)
        Поздравляем вас с достижении вершины земного пути.
        Дальше уже только через постель....

        7. Helper (Помощник)
        Попадают самые активные люди, добровольно
        помогающие племени в его развитии;









    ]==]       
    
    local text2 = [==[
        STAFF:
        8. Tiran (Тиран)
        Творческие люди, которые создают прекрасные карты,
        занимаются фотошопом и пишут нам коды. Если вы тоже
        считаете себя творческим человеком - напишите одному
        из участников стаффа и покажите свои примеры своих
        работ;

        9. Eretik (Еретик)
        Люди, помогающие племени, наделённые возможностью
        судить человека за грехи. Набор по заявкам.
        В данный момент набор закрыт;

        10. Glavniy Eretik (Главный еретик)
        Еретикам, которые очень многое сделали для нашего
        племени, дана возможность выбирать кого же изгнать из
        нашего Рая;

        11. Koldun, Predatel (Колдун, Предатель)
        Создатели племени.

    ]==]   

    ui.addPopup(1602,0, text2, playerName, 210, 50, 400,true)
    ui.addPopup(1601,0, text1, playerName, 210, 50, 400,true)
    ui.addPopup(1600,0, text0, playerName, 210, 50, 400,true)
end

-- 17я книга (Руководство для Еретиков и Обманщиков)
function showSeventeenBook(playerName) ui.addTextArea(17,"<font color='#FF0000' size='10'><b>Руководство</b></font>", nil, 240, 275, 80, 20, 0,0xffffffff, 0,true) end
function seventeenBookClick(playerName)
    local text4 = [==[
	"Руководство для Еретиков и Обманщиков"

	*Когда вы заглядываете в эту книгу, у вас появляется
		чувство, будто начальство следит за вами. Даже при том,
		что у вас нет начальства"
        
	1. Повышать людей на одно звание выше за каждых 5-и
		мышей, приглашённых ими в племя (проверять в истории)

	2. Участвовать на всех конкурсах по возможности. 
		Помогать с запуском модулей, повышать за проведение
		конкурса (не даем звание, если просят, а помогаем
		с запуском!)

	3. Слежка за чатом ( мат разрешен, оскорбления выносятся
		на рассмотрение в конфе стаффа)

	4. Если человек мешает конкурсу командой /module stop
		либо запуском луа без разрешения проводящего конкурс
		- даем звание "Dolboeb" (также его даем, если мышка
		приглашает исключённого игрока, либо игрока в чс)

	Открыть следующую страницу?
    ]==]
    ui.addPopup(1700,1, text4, playerName, 210, 20, 400,true)
end


-- 18я книга (Уроки картостроения)
function showEighteenBook(playerName) ui.addTextArea(18,"<font color='#FF0000' size='10'><b>Картостроение</b></font>", nil, 210, 335, 90, 20, 0,0xffffffff, 0,true) end
function eighteenBookClick(playerName)
    local text0 = [==[
        "Уроки картостроения"

        *В этой книге нет ничего, кроме адресов. В ней всего
        полстраницы!*
        
        Урок рисования в Viprin drawing editor:
        vk.com/photo-195009903_457239299
        
        Урок по созданию движущихся платформ в Viprin drawing
        editor:
        vk.com/photo-195009903_457239246
        
        Урок по добавлению на карту ивентовых фонов и зверушек
        с Bouboum:
        vk.com/photo-195009903_457239294        
    ]==]

    ui.addPopup(1800,0, text0, playerName, 210, 50, 400,true)
end


-------------------------------------------------------------------------------------------------------------------

-- Полёт
-- Подбросить игрока вверх
function fly(playerName)
    tfm.exec.movePlayer(playerName, 0, 0, true, 0, -50, true)
end


-- Удаляет по таймеру зарегестрированные объекты шамана
--
-- Необходимо вызывать эту функцию каждый раз в eventLoop
function deleteShamanObjectsManager()
    print(#shamanObjects)
    local keyForRemove = {}
    for key, value in pairs(shamanObjects) do
        if shamanObjects[key].time <= 0 then
            if tfm.exec.removeObject(shamanObjects[key].object) == nil then
                table.insert(keyForRemove, key)
            end
        else
            shamanObjects[key].time = shamanObjects[key].time - 500
        end
    end
    -- for key, value in pairs(keyForRemove) do
    --     shamanObjects[value] = nil
    -- end
end

-- Возвращает игрока на место и включает эмоцию сна
--
-- Необходимо вызывать эту функцию каждый раз в eventLoop
function idlenessPlayersManager()
    local keyForRemove = {}
    for key, value in pairs(idlenessPlayers) do
        if idlenessPlayers[key].time <= 0 then
            table.insert(keyForRemove, key)
        else
            tfm.exec.movePlayer(idlenessPlayers[key].playerName, idlenessPlayers[key].x, idlenessPlayers[key].y, false, 0, 0, false)
            idlenessPlayers[key].time = idlenessPlayers[key].time - 500
        end
    end
    for key, value in pairs(keyForRemove) do
       shamanObjects[value] = nil
    end
end


-- Обновляет время отката нового использования книги
--
-- Необходимо вызывать эту функцию каждый раз в eventLoop
function bookClickPlayerTimeManager()
    local keyForRemove = {}
    for key, value in pairs(bookClickPlayerTimeList) do
        if bookClickPlayerTimeList[key].time <= 0 then
            table.insert(keyForRemove, key)
        else
            tfm.exec.movePlayer(bookClickPlayerTimeList[key].playerName, bookClickPlayerTimeList[key].x, bookClickPlayerTimeList[key].y, false, 0, 0, false)
            bookClickPlayerTimeList[key].time = bookClickPlayerTimeList[key].time - 500
        end
    end
    for key, value in pairs(keyForRemove) do
        bookClickPlayerTimeList[value] = nil
    end
end

-- Вернуть игрокам нормальный размер после обжорства
function giveNormalSizeBack()
	for key, value in next, playersData do
		if value.timeToBeSized >= 0 then
			value.timeToBeSized = value.timeToBeSized - 500
			print(value.timeToBeSized)
		else
			tfm.exec.changePlayerSize(key, 1.0)
		end
	end
end

-- Функция вызываемая каждые ~0.5с
function eventLoop(currentTime, timeRemaining)
    deleteShamanObjectsManager()
    idlenessPlayersManager()
    bookClickPlayerTimeManager()
	giveNormalSizeBack()
end


-- Функция вызываемая при нажатие игроком забинденой для него клавиши
function eventKeyboard(playerName, keyCode, down, xPlayerPosition,yPlayerPosition)
    -- Если нажат пробел
    if keyCode == 32 then
        fly(playerName)
    end
end


-- Функция вызываемая когда игрок кликает мышью
function eventMouse(playerName,xMousePosition,yMousePosition)
	local x = xMousePosition
    local y = yMousePosition
    isBookClicked = false

    -- Проверка может ли он кликать
    -- (Есть ли он в списке откатов?)
    for key, value in pairs(bookClickPlayerTimeList) do
        if (bookClickPlayerTimeList[key].time > 0 or bookClickPlayerTimeList[key].playerName == playerName) then
            print(bookClickPlayerTimeList[key].playerName.."   "..bookClickPlayerTimeList[key].time)
            return
        end
    end

    -- 1я книга
	if (x > 205 and x < 240 and y > 135 and y < 190) then
        firstBookClick(playerName)
        isBookClicked = true
    end

    -- 2я книга
	if (x > 250 and x < 310 and y > 140 and y < 190) then
        secondBookClick(playerName)
        isBookClicked = true
    end

    -- 7я книга
	if (x > 310 and x < 365 and y > 145 and y < 190) then
        sevenBookClick(playerName)
        isBookClicked = true
    end

    -- 8я книга
	if (x > 105 and x < 125 and y > 215 and y < 270) then
        eightBookClick(playerName)
        isBookClicked = true
    end
    
    -- 9я книга
    if (x > 160 and x < 190 and y > 215 and y < 270) then
		nineBookClick(playerName)
        isBookClicked = true
    end

    -- 10я книга
    if (x > 190 and x < 215 and y > 210 and y < 270) then
        tenBookClick(playerName)
        isBookClicked = true
    end
    
    -- 11я книга
    if (x > 215 and x < 235 and y > 215 and y < 270) then
        elevenBookClick(playerName)
        isBookClicked = true
    end

    -- 12я книга
    if ((x > 235 and x < 250 and y > 250 and y < 270) or (x > 235 and x < 260 and y > 220 and y < 250)) then
        twelveBookClick(playerName)
        isBookClicked = true
    end

    -- 14я книга
    if (x > 285 and x < 305 and y > 215 and y < 270) then
        forteenBookClick(playerName)
        isBookClicked = true
    end

    -- 15я книга
    if (x > 135 and x < 193 and y > 305 and y < 335) then
        fifteenBookClick(playerName)
        isBookClicked = true
    end

    -- 16я книга
    if ((x > 193 and x < 220 and y > 315 and y < 335) or (x > 200 and x < 235 and y > 290 and y < 315)) then
        sixteenBookClick(playerName)
        isBookClicked = true
    end

    -- 17я книга
    if (x > 235 and x < 300 and y > 300 and y < 315) then
        seventeenBookClick(playerName)
        isBookClicked = true
    end

    -- 18я книга
    if (x > 220 and x < 285 and y > 315 and y < 330) then
        eighteenBookClick(playerName)
        isBookClicked = true
    end
    

    -- Если игрок нажал на книгу отметить в списке
    -- Нужно для отката клика (ограничение частоты клика)
    if isBookClicked then
        table.insert(bookClickPlayerTimeList, {['time'] = 2000, ['playerName'] = playerName})
    end

	print(playerName.." "..x.." "..y)
end


-- Бинд мыши(указателя) для всех мышей
function bindAllCursors()
    for playerName,data in next, tfm.get.room.playerList do 
        system.bindMouse(playerName, true)
    end
end


-- Показать весь UI книг для для игрока с ником playerName
-- если playerName == nil, то покажет для всех
function showAllBooksForPlayer(playerName)
    showFirstBook(playerName)
    showSecondBook(playerName)
    showSevenBook(playerName)
    showEightBook(playerName)
    showNineBook(playerName)
    showTenBook(playerName)
    showElevenBook(playerName)
    showTwelveBook(playerName)
    showForteenBook(playerName)
    showFifteenBook(playerName)
    showSixteenBook(playerName)
    showSeventeenBook(playerName)
    showEighteenBook(playerName)
end


-- Функция вызываемая когда новый игрок заходит в комнату
function eventNewPlayer(playerName)
    system.bindMouse(playerName, true)
    showAllBooksForPlayer(playerName)
	tfm.exec.respawnPlayer(playerName)
	playersData[playerName] = {
		timeToBeSized = 0
	}
	tfm.exec.chatMessage("<font color = '#FFFF00'>Добро пожаловать в библиотеку Lost Heaven!</font>", playerName)
end

-- Функция вызывается когда игрок сдох
function eventPlayerDied(playerName)
	tfm.exec.respawnPlayer(playerName)
end



-- Функция вызываемая при запуске луа
function main()
    bindAllCursors()
    showAllBooksForPlayer(nil)
end


main()
-- @7744070
table.foreach(tfm.get.room.playerList, eventNewPlayer)
-- system.bindMouse("Keras#9975", true)