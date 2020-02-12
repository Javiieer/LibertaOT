local monsters = {
	[1] = {pos = Position(32212, 32054, 15)},
	[2] = {pos = Position(32217, 32054, 15)}
}

local function functionBack(position, oldpos)
	local izcandar = Tile(position):getTopCreature()
	local bool, diference, health = false, 0, 0
	local spectators, spectator = Game.getSpectators(Position(32207, 32047, 14), false, false, 15, 15, 15, 15)
	for v = 1, #spectators do
		spectator = spectators[v]
		if spectator:getName():lower() == 'izcandar champion of summer' or spectator:getName():lower() == 'izcandar champion of winter' then
			oldpos = spectator:getPosition()
			bool = true
		end
	end
	if not bool then
		izcandar:remove()
		return true
	end
	local specs, spec = Game.getSpectators(Position(32207, 32047, 14), false, false, 15, 15, 15, 15)
	for i = 1, #specs do
		spec = specs[i]
		if spec:isMonster() and spec:getName():lower() == 'izcandar champion of summer' or spec:getName():lower() == 'izcandar champion of winter' then
			spec:teleportTo(position)
			health = spec:getHealth()
			diference = izcandar:getHealth() - health
		end
	end
	izcandar:addHealth( - diference)
	izcandar:teleportTo(oldpos)
end

function onCastSpell(creature, var)
	local index = math.random(1, 2)
	local monsterPos = creature:getPosition()
	if monsterPos.z ~= 14 then
		return true
	end
	local position = monsters[index].pos
	local form = Tile(position):getTopCreature()
	creature:teleportTo(position)
	local diference, health = 0, 0
	health = creature:getHealth()
	diference = form:getHealth() - health
	form:addHealth( - diference)
	form:teleportTo(monsterPos)
	addEvent(functionBack, 30 * 1000, position, monsterPos)
	return true
end