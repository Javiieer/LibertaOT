local config = {
	centerRoom = Position(32207, 32047, 14),
	BossPosition = Position(32207, 32047, 14),
	newPosition = Position(32207, 32052, 14)
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 10029 then
		if player:getPosition() ~= Position(32208, 32021, 13) then
			item:transform(10030)
			return true
		end
	end
	if item.itemid == 10029 then
		if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.TenebrisTimer) >= 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to wait a while, recently someone challenge Lady Tenebris.")
			return true
		end
		local specs, spec = Game.getSpectators(config.centerRoom, false, false, 15, 15, 15, 15)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Someone is fighting with Lady Tenebris.")
				return true
			end
		end
		for y = 32021, 32025 do
			local playerTile = Tile(Position(32208, y, 13)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.ForgottenKnowledge.LadyTenebrisTimer, 20 * 60 * 60)
			end
		end
		for d = 1, 6 do
			Game.createMonster('shadow tentacle', Position(math.random(32200, 32215), math.random(32040, 32054), 14), true, true)
		end
		Game.createMonster("lady tenebris", config.BossPosition, true, true)
		Game.setStorageValue(GlobalStorage.ForgottenKnowledge.TenebrisTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(32895, 31584, 14), Position(32929, 31614, 14), Position(32925, 31617, 14), GlobalStorage.ForgottenKnowledge.TenebrisTimer)
		item:transform(10030)
		elseif item.itemid == 10030 then
		item:transform(10029)
	end
	return true
end
		
		
		
		