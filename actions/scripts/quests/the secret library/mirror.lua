local p = {x = 32811, y = 32755, z = 9} -- where to tp to 33672, 31884, 5
function onUse(cid, item, fromPosition, itemEx, toPosition)
	doTeleportThing(cid,p)	
	doSendMagicEffect(p,10)
	return true
end