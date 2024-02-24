local map = {}

function map:load()
	map.x, map.y = 8, 8
	map.s = 64

	map.array = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		0,
		1,
		0,
		0,
		0,
		0,
		1,
		1,
		0,
		1,
		0,
		0,
		0,
		0,
		1,
		1,
		0,
		1,
		0,
		0,
		0,
		0,
		1,
		1,
		0,
		0,
		0,
		0,
		0,
		0,
		1,
		1,
		0,
		0,
		0,
		0,
		1,
		0,
		1,
		1,
		0,
		0,
		0,
		0,
		0,
		0,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1,
	}
end

function map:draw()
	for i = 1, map.x do
		for j = 1, map.y do
			if map.array[i + 8 * j - 8] == 1 then
				love.graphics.setColor(1, 1, 1)
			elseif map.array[i + 8 * j - 8] == 0 then
				love.graphics.setColor(0, 0, 0)
			end

			love.graphics.rectangle("fill", (i - 1) * 64, (j - 1) * 64, map.s - 1, map.s - 1)
		end
	end
end

return map

