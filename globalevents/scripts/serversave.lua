local shutdownAtServerSave = true
local cleanMapAtServerSave = false
local closeAtServerSave = false

local function serverSave()
	setGlobalStorageValueDB(GlobalStorage.LastServerSave, os.time()) -- needed for the daily reward system
	if shutdownAtServerSave then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	end
	if closeAtServerSave then
		Game.setGameState(GAME_STATE_SHUTDOWN)
	end
	if cleanMapAtServerSave then
		cleanMap()
	end
end

local function secondServerSaveWarning()
	--Game.broadcastMessage("Guardando El Servidor En Un Minuto. Please logout.", MESSAGE_EVENT_ADVANCE)
	addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
	--Game.broadcastMessage("Guardando El Servidor en 3 minutos. Please logout.", MESSAGE_EVENT_ADVANCE)
	addEvent(secondServerSaveWarning, 120000)
end

function onTime(interval)
	--Game.broadcastMessage("Guardando El Servidor en 5 minutos. Please logout.", MESSAGE_EVENT_ADVANCE)
	addEvent(firstServerSaveWarning, 120000)
	return not shutdownAtServerSave
end
