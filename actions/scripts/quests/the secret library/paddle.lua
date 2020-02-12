local destination = {
	[64009] = {newPos = Position(33344, 31347, 7)},
	[64010] = {newPos = Position(33328, 31352, 7)},
	[64011] = {newPos = Position(33382, 31294, 7)},
	[64012] = {newPos = Position(33373, 31310, 7)}
}
function onUse(cid, item, fromPosition, itemEx, toPosition)
	local teleport = destination[item.actionid]
	if not teleport then
		return
	end
		doTeleportThing(cid,teleport.newPos)
		doSendMagicEffect(CONST_ME_TELEPORT)
		return true
end
