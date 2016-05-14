love.graphics.setBackgroundColor(255, 255, 255)
love.window.setMode(800, 600, {
	resizable = true
})

local image
function createImage()
	image = love.graphics.newImage('dice-'..love.math.random(1, 6)..'.png')
end
createImage()

function love.draw()
	love.graphics.draw(image, 400, 300, 0, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
end

function love.mousepressed(x, y, button, isTouch)
	if button == 1 then
		createImage()
	end
end
