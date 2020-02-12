local config = {
	centerRoom = Position(32207, 32047, 14),
	newPosition = Position(32207, 32052, 14)
}

local bosses = {
	{BossPosition = Position(32207, 32047, 14), bossName = 'Izcandar The Banished'},
	{BossPosition = Position(32212, 32054, 15), bossName = 'Izcandar Champion of Summer'},
	{BossPosition = Position(32217, 32054, 15), bossName = 'Izcandar Champion of Winter'}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 10029 then
		if player:getPosition() ~= Position(32208, 32021, 13) then
			item:transform(10030)
			return true
		end
	end
	if item.itemid == 10029 then
		if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.TimeGuardianTimer) >= 10 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge The Time Guardian.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with The Time Guardian.")
				return true
			end
		end
		for q = 1,#bosses do
			Game.createMonster(bosses[q].bossName, bosses[q].BossPosition, true, true)
		end		
		for y = 32021, 32025 do
			local playerTile = Tile(Position(32208, y, 13)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.ForgottenKnowledge.TimeGuardianTimer, 20 * 60 * 60)
			end
		end
		Game.setStorageValue(GlobalStorage.ForgottenKnowledge.TimeGuardianTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(32967, 31654, 13), Position(32989, 31677, 14), Position(32870, 32724, 14), GlobalStorage.ForgottenKnowledge.TimeGuardianTimer)
		item:transform(10030)
		elseif item.itemid == 10030 then
		item:transform(10029)
	end
	return true
end