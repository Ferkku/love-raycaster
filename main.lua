Player = require("player")
Map = require("map")
Ray = require("ray")

WINDOW_WIDTH, WINDOW_HEIGHT = love.window.getMode()
DEGREE_IN_RADIAN = math.rad(1)

function love.load()
	love.graphics.setBackgroundColor(0.3, 0.3, 0.3)
	Map:load()
	Player:load()
end

function love.update(dt)
	Player:update(dt)
end

function love.draw()
	Map:draw()
	Player:draw()
	Ray:draw()
end

