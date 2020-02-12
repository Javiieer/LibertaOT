local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)

	if msgcontains(msg, "the curse") and player:getStorageValue(Storage.CurseSpreads.roteiroquest) == -1 then
		npcHandler.topic[cid] = 1
		npcHandler:say({
			"We tried to prevent this really hard. Cornell won't ferry anyone affected by the curse back to Edron. But somehow one or more cursed people must have slipped through the cracks. Now the curse reached Edron, maybe even Cormaya! ... ",
			"This is a catastrophe. I'm sure they need help in Edron but I can't leave Grimvale. The curse is very strong here and my people need me. Would you be willing to travel to Edron and aid them there?"
		}, cid)
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		npcHandler:say("Thank you so much! Please travel to Edron and talk to Daniel Steelsoul. I'm sure he can tell you more about the spreading of the curse.", cid)
		player:setStorageValue(Storage.CurseSpreads.roteiroquest, 1)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings, fellow {believer} |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Always be on guard, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "This ungraceful haste is most suspicious!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
