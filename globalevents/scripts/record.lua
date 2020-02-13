function onRecord(current, old)
	addEvent(Game.broadcastMessage, 150, 'Nuevo Record!: ' .. current .. ' players online.', MESSAGE_STATUS_DEFAULT)
	return true
end
