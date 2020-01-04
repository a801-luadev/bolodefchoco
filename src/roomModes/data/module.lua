eventNewPlayer = function(n)
	system.loadPlayerData(n)
end
for n in next, tfm.get.room.playerList do eventNewPlayer(n) end

eventPlayerDataLoaded = function(n, data)
	local treeStage, wizardDefeats, santaSaves = data:match("xm19={(%d+),(%d+),(%d+),")
	if not treeStage then
		tfm.exec.chatMessage("<R>You don't have Chaostmas data", n)
	else
		tfm.exec.chatMessage("<PT>Tree stage: <VI>" .. treeStage .. "\n<PT>Wizard defeats: <VI>" .. wizardDefeats .. "\n<PT>Santa saves: <VI>" .. santaSaves, n)
	end
end
