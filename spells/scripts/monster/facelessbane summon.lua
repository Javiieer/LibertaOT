 function onCastSpell(creature, var)
	local summoncount = creature:getSummons()
	local creaturePos = creature:getPosition()
	if #summoncount < 3 then
		for i = 1, 1 do
			local mid = Game.createMonster("Ripper spectre", Position(creaturePos.x + math.random(-3, 3), creaturePos.y + math.random(-3, 3), creaturePos.z), true, true)
			if not mid then
				return
			end
			mid:setMaster(creature)
		end
		for i = 1, 1 do
			local mid2 = Game.createMonster("Burster Spectre", Position(creaturePos.x + math.random(-3, 3), creaturePos.y + math.random(-3, 3), creaturePos.z), true, true)
			if not mid2 then
				return
			end
		end
		for i = 1, 1 do
			local mid3 = Game.createMonster("Gazer Spectre", Position(creaturePos.x + math.random(-3, 3), creaturePos.y + math.random(-3, 3), creaturePos.z), true, true)
			if not mid3 then
				return
			end
		end
	end
	return
end