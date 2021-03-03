local texts = {
	en = {
		redirect = "<VP><B>/room #perguntas</B>"
	},
	br = {
		redirect = "<VP><B>/sala #perguntas</B>"
	},
	es = {
		redirect = "<VP><B>/sala #perguntas</B>"
	}
}
local translation = tfm.get.room.community
translation = texts[translation] or texts.en

eventNewPlayer = function(playerName)
	tfm.exec.chatMessage(translation.redirect, playerName)
end
eventNewPlayer()