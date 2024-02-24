local player = {}

function player:load()
	self.x, self.y = 300, 300

	self.angle = 0

	self.speed = 200
	self.turnSpeed = 5

	self.dx = math.cos(self.angle) * self.speed
	self.dy = math.sin(self.angle) * self.speed

	self.sprite = love.graphics.newImage("player.png")
end

function player:update(dt)
	if love.keyboard.isDown("w") then
		self.x = self.x + self.dx * dt
		self.y = self.y + self.dy * dt
	end

	if love.keyboard.isDown("s") then
		self.x = self.x - self.dx * dt
		self.y = self.y - self.dy * dt
	end

	if love.keyboard.isDown("a") then
		self.angle = self.angle - self.turnSpeed * dt
		self.dx = math.cos(self.angle) * self.speed
		self.dy = math.sin(self.angle) * self.speed
		if self.angle < 0 then
			self.angle = 2 * math.pi
		end
	end

	if love.keyboard.isDown("d") then
		self.angle = self.angle + self.turnSpeed * dt
		self.dx = math.cos(self.angle) * self.speed
		self.dy = math.sin(self.angle) * self.speed
		if self.angle > 2 * math.pi then
			self.angle = 0
		end
	end
end

function player:draw()
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(self.sprite, self.x, self.y, self.angle, nil, nil, 4, 4)

	love.graphics.line(self.x, self.y, self.x + math.cos(self.angle) * 20, self.y + math.sin(self.angle) * 20)
end

return player

