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
    local text = "*Книга написана чем-то, напоминающим странную смесь крови, слёз и ядовитых испарений действующего вулкана.*\n1.   Общий свод правил.\n1.1. Мат в умеренных количествах разрешен.\n1.2. Помните с нами играют маленькие дети.\n1.3. Обманывать сокланавцев запрещено.\n1.4. Администрация действует на свое усмотрение\nв спорных ситуациях.\n\n2.   Конкурсы и комната племени.\n2.1. Запуск луа и смена карт на конкурсе без разрешения\nорганизатора запрещен\n2.2. Игроки, не состоящие в племени не имеют право\nучаствовать в конкурсах и присутствовать на фармах\nс пометкой племени\n2.3. Запрещена реклама фарма без пометки Lost Heaven\nМогут быть случаи бана, если человек не нарушал\nвышеперечисленное, чтобы узнать причину \nнапишите мне (Naomikio#0000) или в сообщения группы."
    ui.addPopup(1,0, text, playerName, 210, 30, 400,true)
end

-- 2-6я книги, мне ☻☺похуй☺☻ (История племени)
function showSecondBook(playerName) ui.addTextArea(2,"<font color='#9999FF' size='10'><b>История</b></font>", nil, 255, 125, 90, 20, 0,0xffffffff, 0,true) end
function secondBookClick(playerName)
    local text0 = "Краткая история племени Lost Heaven\nНаше племя зародилось 4 мая 2020 года. Создателей племени было 11 человек\n(Druggy_Doggy#3098, Nikitapley#6179, Min#7943, Voimyasatani#6041, Fireball#3838,\nNaomikio#0000, Liza#6232, Honeyul#5711, Buterbrot#9081, Stuntman_www_x#0831,\nCherzik#2636) - большинство ушло по некоторым обстоятельствам, но всех нас объединяла\nодна цель - создать племя без жёстких правил и для общения. На данный момент, наша\nмечта стала явью. Мы все искренне верим, что наше племя действительно стало очень\nдружным и активным. Первый наш конкурс на 100 участников в племени сразу же дал очень\nхорошие результаты. Мы были удивлены таким активом. Люди, помнящие тот конкурс и\nприсутствовавшие на нем, все ещё с нами и очень хорошо отзываются о нашем племени.\nИзначально были совершенно другие звания, а т.е. названия грехов по их иерархии в\nмифологии на английском языке (если найдется Олд, вспомнивший хоть одно - напишите\nодному из нынешних колдунов, вы получите 50 сыра от нас :3). Далее очень долгое\nвремя у нас стояли звания по тематике Данте, а именно 9 кругов ада. Сейчас, в принципе,\nне особо отличается от предыдущих тематикой, но все же немного поменяли. Наказательным\nзванием ранее было 'фанат деда'.\n\nКто же такой дед? Дед являлся первым активом и участником нашего племени, хоть сейчас\nон и предал племя, но все равно звание, я думаю, остаётся в памяти многих людей.\n\nОткрыть следующую страницу?"

    ui.addPopup(2000,1, text0, playerName, 110, 30, 600,true)
end

function eventPopupAnswer(popupID, playerName, answer)
	local text1 = "Сейчас же, мы уже очень большое племя, находящееся в топе 100 лучших племен\n(на момент написания текста 66 место). И каждый создатель, даже ушедший, я думаю, очень\nрад, что в конечном итоге мы добились чего хотели.\n\nМы вас всех очень любим!\n\nОткрыть следующую страницу?"

    local text2 = "Нынешние создатели, оставшиеся в племени: Buterbrot#9081, Honeyuli#5711,\nVoimyasatani#6041, Fireball#3848, Naomikio#0000)\nТакже, хочу уточнить, что абсолютно на равных правах с нами есть Главные Еретики\n(просто поставленно такое звание, чтоб не нарушать концепцию данного звания и\nне терять изначальную задумку):\n•Sheogorath#8725 - спасибо за множество отличных карт, активное участие в жизни племени,\nорганизацию фарма, слежкой за чатом и всегда идеально выполненную работу,\n•Keras#9975 - спасибо за множество луа - скриптов, актив в племени, помощь в дискорд\nсервере, слежку за чатом и организацией фарма.\n\nНо, конечно же, во всех наших достижениях ещё мы очень благодарны нашим еретиками: \n•Viz#1717 (поблагодарим его за новые звания, проявление активности и инициативы,\nслежку за фармом, написание чудесного гайда для шаманов и многое другое)\n•Felixe96#0000 (поблагодарим за хороший монтаж видео, инвайты мышей и провождение \nконкурсов)\n•Floweystyle#8410 (поблагодарим за то, что все проблемы с фотошопом брал на себя и делал\nотличные работы, а так же за создание карт)\n•Juzya#8075 (спасибо за монтаж видео и слежку за чатом!)\n•Karamelka#6455 (спасибо за слежку за чатом, повышение мышей)\n•Kawaymixare#0000 (Самый первый еретик и один из первых участников племени. Много\nпомощи было в написании луа, очистки нулевых аккаунтов, активных обсуждений и внесений предложений для развития племени и многое другое)\n\nОткрыть следующую страницу?"
	local text3 = "Tiran (творческие люди, занимающиеся созданием карт или же написанием луа-скриптов):\n•Missellik#5355 - спасибо за гайд по виприну и большое количество карт, также организацию\nфарма\n•Herobrine816#0000 спасибо за гайд и очень большое количество карт!\n\nТакже, поблагодарим людей со званием 'Helper', которые всегда помогали племени и очень\nего любят.\nИ, конечно же, спасибо абсолютно каждой мышке за то, что проявляет активную жизнь\nв племени и помогает его развитию приглашением мышей!"
    local text5 = "5. Отвечать на вопросы\n\n6. Делать скрины по возможности. Качественные! Без\nкоманды /watch и чата а скрине, если он там ни к месту.\n\n7. Писать посты о конкурсах в группе вк\n\n8. Приветствовать всех новеньких\n\n9. Организация фарма по возможности  \n\nОткрыть следующую страницу?"

    local text6 = "Обязанности Гневливых:\n\n1. Помогать племени своими навыками, которые указали\nв заявке при вступлении\n\n2. По возможности помогать Еретикам и Обманщикам\n\n3. Докладывать Еретикам или Обманщикам о нарушителях."

	if answer == "yes" then
		if popupID == 2000 then
			ui.addPopup(2001,1, text1, playerName, 110, 30, 600,true)
		elseif popupID == 2001 then
			ui.addPopup(2002,1, text2, playerName, 110, 30, 600,true)
		elseif popupID == 2002 then
			ui.addPopup(2003,0, text3, playerName, 110, 30, 600,true)
		elseif popupID == 1700 then
			ui.addPopup(1701,1, text5, playerName, 210, 30, 600,true)
		elseif popupID == 1701 then
			ui.addPopup(1702,0, text6, playerName, 210, 30, 600,true)
		end
	end
end


-- 7я книга (Краткий путеводитель по кругам ада)
function showSevenBook(playerName) ui.addTextArea(7,"<font color='#38ABFF' size='10'><b>Путеводитель</b></font>", nil, 295, 115, 90, 15, 0,0xffffffff, 0,true) end
function sevenBookClick(playerName)
    local text0 = "Краткий путеводитель по кругам ада.\n Автор - Данте Алигьери\n\n1 круг — Лимбо\nПервый круг ада — Лимбо, где пребывают души тех, \nкто в неправедных делах уличен не был,\nно умер некрещеным.\n\n2 круг — Сладострастие\nЗдесь обитают души тех, кого на путь\nгреха толкнула любовь.\n\n 3 круг — Чревоугодие\nВ этом круге заключены обжоры\n\n4 круг — Жадность\nОбитель тех, кто «недостойно тратил и копил»\n\n5 круг — Гнев и Лень\nВсе круги до пятого — пристанище несдержанных,\nа несдержанность считается меньшим грехом,\nчем «злоба или буйное скотство»"
    local text1 = "6 круг — Для еретиков и лжеучителей\nЗдесь царит неизбывная скорбь, а в раскрытых гробницах,\nсловно в вечных печах, покоятся еретики и лжеучителя.\n\n7 круг — Для насильников и убийц всех мастей\nСюда попадают и тираны, и убийцы, и самоубийцы\n\n8 круг — Для обманувших и недоверившихся\nПристанище сводников и обольстителей, состоит из 10 рвов\n\n 9 круг — Для отступников и предателей всех сортов\nЗдесь покоятся вмороженные в лед отступники, и главный\nиз них — Люцифер, падший ангел."
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
    local text0 = "*Из этой книги исходит странная энергия*\nКомната племени - магическое пространство, изменяющее\nсвою форму при помощи несложных чар и произнесения\nзаклинаний. Не каждый может их использовать,\nа только избранные маги с сильнейшими душами.\nНиже мы приводим некоторые из этих заклинаний.\n\nМагические места, созданные Missellik:\n\n@7708970 - Комната для конкурса красоты.\n@7709932 - Запасная комната для КК.\n@7710456 - Комната отдыха\n@7715253 - Лагерь в лесу\n\nМагические места, созданные Weneys, так же известным\nпод именем Хермеус Мора:\n\n@6561207 - Дом смертельной музыки"

    local text1 = "Магические места, созданные даэдрическим принцем\nШеогоратом:\n\n@7725946 - Зал огня\n@7729172 - Святилище Шеогората (место поклонения)\n@7729731 - Зал для Конкурса красоты\n@7744070 - Библиотека Хаоса (внимание: вы уже\nнаходитесь здесь! Не создавайте пространственных\nпарадоксов!)"
    ui.addPopup(1501,0, text1, playerName, 210, 50, 600,true)
    ui.addPopup(1500,0, text0, playerName, 210, 50, 600,true)
end

-- 16я книга (Звания и как их получить)
function showSixteenBook(playerName) ui.addTextArea(16,"<font color='#00FF00' size='10'><b>Звания</b></font>", nil, 200, 270, 90, 20, 0,0xffffffff, 0,true) end
function sixteenBookClick(playerName)
    local text0 = "1. Zabveniy (Забвенный)\nВступая в наше племя вы получаете данное звание. \nЭто означает, что вы умерли, не оставив никакой памяти\nо себе, попадая в наш потерянный рай;\n\n0. Dolbaeb (удалено по соображениям цензуры)\nЧеловек, нарушивший правила,  получает данное звание;\n2. Slastolyubiviy (Сластолюбивый)\nПоздравляем, вы внесли первый вклад в наше племя и\nотправляетесь на второй круг;\n\n3. Nenasitniy (Ненасытный)\nДействительно ненасытный... Ради желания быть выше,\nвы приглашаете все больше мышей в наш общий котел,\nгде теперь всем им суждено вариться всем вместе;\n\n4. Neistomvy (Неистовый)\nЯрое желание и какие-то побуждения стать выше,\nполучить больше доступа к командам - одобрено, спасибо\nза ещё 5 хороших людей или прекрасный конкурс!\n"

    local text1 = "5. Lutiy (Лютый)\nВы отправляетесь в следующий круг, где теперь уже\nводичка погорячее в вашем котле, но все ещё не\nдотягивает до горячих источников;\n\n6. Renegat (Ренегат)\nПоздравляем вас с достижении вершины земного пути.\nДальше уже только через постель....\n\n7. Helper (Помощник)\nПопадают самые активные люди, добровольно\nпомогающие племени в его развитии;\n"

    local text2 = "STAFF:\n8. Tiran (Тиран)\nТворческие люди, которые создают прекрасные карты,\nзанимаются фотошопом и пишут нам коды. Если вы тоже\nсчитаете себя творческим человеком - напишите одному\nиз участников стаффа и покажите свои примеры своих\nработ;\n\n9. Eretik (Еретик)\nЛюди, помогающие племени, наделённые возможностью\nсудить человека за грехи. Набор по заявкам.\nВ данный момент набор закрыт;\n\n10. Glavniy Eretik (Главный еретик)\nЕретикам, которые очень многое сделали для нашего\nплемени, дана возможность выбирать кого же изгнать из\nнашего Рая;\n\n11. Koldun, Predatel (Колдун, Предатель)\nСоздатели племени.\n"

    ui.addPopup(1602,0, text2, playerName, 210, 50, 600,true)
    ui.addPopup(1601,0, text1, playerName, 210, 50, 600,true)
    ui.addPopup(1600,0, text0, playerName, 210, 50, 600,true)
end

-- 17я книга (Руководство для Еретиков и Обманщиков)
function showSeventeenBook(playerName) ui.addTextArea(17,"<font color='#FF0000' size='10'><b>Руководство</b></font>", nil, 240, 275, 80, 20, 0,0xffffffff, 0,true) end
function seventeenBookClick(playerName)
    local text4 = "	Руководство для Еретиков и Обманщиков\n\n*Когда вы заглядываете в эту книгу, у вас появляется\n		чувство, будто начальство следит за вами. Даже при том,\nчто у вас нет начальства*\n\n1. Повышать людей на одно звание выше за каждых 5-и\nмышей, приглашённых ими в племя (проверять в истории)\n\n2. Участвовать на всех конкурсах по возможности. \nПомогать с запуском модулей, повышать за проведение\nконкурса (не даем звание, если просят, а помогаем\nс запуском!)\n\n3. Слежка за чатом ( мат разрешен, оскорбления выносятся\nна рассмотрение в конфе стаффа)\n\n4. Если человек мешает конкурсу командой /module stop\nлибо запуском луа без разрешения проводящего конкурс\n- даем звание 'Dolboeb' (также его даем, если мышка\nприглашает исключённого игрока, либо игрока в чс)\n\nОткрыть следующую страницу?"

    ui.addPopup(1700,1, text4, playerName, 210, 20, 400,true)
end


-- 18я книга (Уроки картостроения)
function showEighteenBook(playerName) ui.addTextArea(18,"<font color='#FF0000' size='10'><b>Картостроение</b></font>", nil, 210, 335, 90, 20, 0,0xffffffff, 0,true) end
function eighteenBookClick(playerName)
    local text0 = "Уроки картостроения\n\n*В этой книге нет ничего, кроме адресов. В ней всего\nполстраницы!*\n       Урок рисования в Viprin drawing editor:\nvk.com/photo-195009903_457239299\nУрок по созданию движущихся платформ в Viprin drawing\neditor:\nvk.com/photo-195009903_457239246\n\nУрок по добавлению на карту ивентовых фонов и зверушек\nс Bouboum:\nvk.com/photo-195009903_457239294"

    ui.addPopup(1800,0, text0, playerName, 210, 50, 600,true)
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
