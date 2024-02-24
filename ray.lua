local rays = {}

function rays:distance(x1, y1, x2, y2)
	return (math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)))
end

--Draws ray until it hits the grid
--If the ray hits a wall then it stops
--Else the ray will continue by adding the xOff and yOff to rayX, rayY
function rays:draw()
	local rayA = Player.angle - DEGREE_IN_RADIAN * 30

	if rayA < 0 then
		rayA = rayA + 2 * math.pi
	end

	if rayA > 2 * math.pi then
		rayA = rayA - 2 * math.pi
	end

	for ray = 1, 60 do
		--HORIZONTAL LINE CHECK

		local dof = 0
		local rayX, rayY, xOff, yOff = 0, 0, 0, 0

		local rayHitX, rayHitY = 0, 0
		local rayHitMap = 0

		--Horizontal distance, (x,y) coords
		local distH = 1000000
		local horX, horY = Player.x, Player.y

		local aTan = -1 / math.tan(rayA)

		--Ray facing up
		if rayA > math.pi then
			rayY = bit.lshift((bit.rshift(Player.y, 6)), 6) - 0.0001
			rayX = (Player.y - rayY) * aTan + Player.x
			yOff = 64
			xOff = -yOff * aTan
		end

		--Ray facing down
		if rayA < math.pi then
			rayY = bit.lshift((bit.rshift(Player.y, 6)), 6) + 64
			rayX = (Player.y - rayY) * aTan + Player.x
			yOff = -64
			xOff = -yOff * aTan
		end

		--Ray straight left or right
		if rayA == 0 or rayA == math.pi then
			rayX = Player.x
			rayY = Player.y
			dof = 8
		end

		while dof < 8 do
			rayHitX = bit.rshift(rayX, 6)
			rayHitY = bit.rshift(rayY, 6)
			rayHitMap = rayHitY * Map.x + rayHitX
			--Check for walls
			if
				rayHitMap > 0
				and rayHitMap < Map.x * Map.y
				and (Map.array[rayHitMap + 1 - 8] == 1 or Map.array[rayHitMap + 1] == 1)
			then
				horX = rayX
				horY = rayY
				distH = rays:distance(Player.x, Player.y, horX, horY)
				dof = 8
			else
				rayX = rayX - xOff
				rayY = rayY - yOff
				dof = dof + 1
			end
		end

		--VERTICAL LINE CHECK
		dof = 0

		--Vertical distance, (x,y) coords
		local distV = 1000000
		local vertX, vertY = Player.x, Player.y

		local nTan = -1 * math.tan(rayA)

		--Ray facing left
		if rayA > math.pi / 2 and rayA < (3 / 2) * math.pi then
			rayX = bit.lshift((bit.rshift(Player.x, 6)), 6) - 0.0001
			rayY = (Player.x - rayX) * nTan + Player.y
			xOff = 64
			yOff = -xOff * nTan
		end

		--Ray facing right
		if rayA < math.pi / 2 or rayA > (3 / 2) * math.pi then
			rayX = bit.lshift((bit.rshift(Player.x, 6)), 6) + 64
			rayY = (Player.x - rayX) * nTan + Player.y
			xOff = -64
			yOff = -xOff * nTan
		end

		--Ray straight up or down
		if rayA == 0 or rayA == math.pi then
			rayX = Player.x
			rayY = Player.y
			dof = 8
		end

		while dof < 8 do
			rayHitX = bit.rshift(rayX, 6)
			rayHitY = bit.rshift(rayY, 6)
			rayHitMap = rayHitY * Map.x + rayHitX
			if
				rayHitMap > 0
				and rayHitMap < Map.x * Map.y
				and (Map.array[rayHitMap] == 1 or Map.array[rayHitMap + 1] == 1)
			then
				dof = 8
				vertX = rayX
				vertY = rayY
				distV = rays:distance(Player.x, Player.y, vertX, vertY)
			else
				rayX = rayX - xOff
				rayY = rayY - yOff
				dof = dof + 1
			end
		end

		local distFinal = 0
		if distV < distH then
			rayX = vertX
			rayY = vertY
			distFinal = distV
			love.graphics.setColor(0.9, 0, 0)
		elseif distH < distV then
			rayX = horX
			rayY = horY
			distFinal = distH
			love.graphics.setColor(0.7, 0, 0)
		end

		love.graphics.line(Player.x, Player.y, rayX, rayY)

		--3D Walls

		--Fix fisheye
		local ca = Player.angle - rayA

		if ca < 0 then
			ca = ca + 2 * math.pi
		end

		if ca > 2 * math.pi then
			ca = ca - 2 * math.pi
		end

		distFinal = distFinal * math.cos(ca)

		--Draw walls
		local lineH = (Map.s * 320) / distFinal

		if lineH > 320 then
			lineH = 320
		end

		local lineOff = 160 - lineH / 2

		--The -4 is for aligning
		love.graphics.setLineWidth(8)
		love.graphics.line(ray * 8 + 530 - 4, lineOff, ray * 8 + 530 - 4, lineH + lineOff)

		--Adjusts next ray by one degree
		rayA = rayA + DEGREE_IN_RADIAN

		if rayA < 0 then
			rayA = rayA + 2 * math.pi
		end

		if rayA > 2 * math.pi then
			rayA = rayA - 2 * math.pi
		end
	end
end

return rays

