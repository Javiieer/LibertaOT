local config = {
	centerRoom = Position(32977, 31662, 14),
	newPosition = Position(32977, 31667, 14)
}

local bosses = {
	{BossPosition = Position(32977, 31662, 14), bossName = 'The Time Guardian'},
	{BossPosition = Position(32975, 31664, 13), bossName = 'The Freezing Time Guardian'},
	{BossPosition = Position(32980, 31664, 13), bossName = 'The Blazing Time Guardian'}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 9825 then
		if player:getPosition() ~= Position(33010, 31660, 14) then
			item:transform(9826)
			return true
		end
	end
	if item.itemid == 9825 then
		if Game.getStorageValue(GlobalStorage.ForgottenKnowledge.TimeGuardianTimer) >= 1 then
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
		for y = 31660, 31664 do
			local playerTile = Tile(Position(33010, y, 14)):getTopCreature()
			if playerTile and playerTile:isPlayer() then
				playerTile:getPosition():sendMagicEffect(CONST_ME_POFF)
				playerTile:teleportTo(config.newPosition)
				playerTile:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				playerTile:setExhaustion(Storage.ForgottenKnowledge.TimeGuardianTimer, 20 * 60 * 60)
			end
		end
		Game.setStorageValue(GlobalStorage.ForgottenKnowledge.TimeGuardianTimer, 1)
		addEvent(clearForgotten, 30 * 60 * 1000, Position(32967, 31654, 13), Position(32989, 31677, 14), Position(32870, 32724, 14), GlobalStorage.ForgottenKnowledge.TimeGuardianTimer)
		item:transform(9826)
		elseif item.itemid == 9826 then
		item:transform(9825)
	end
	return true
end
