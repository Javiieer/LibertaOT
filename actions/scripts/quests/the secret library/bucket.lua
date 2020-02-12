local p = {x = 33357, y = 31308, z = 4} -- where to tp to 33672, 31884, 5
function onUse(cid, item, fromPosition, itemEx, toPosition)
	doTeleportThing(cid,p)	
	doSendMagicEffect(p,10)
	return true
end