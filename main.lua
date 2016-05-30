require('ULUA/ULUA-LOVE')

RESIZE_WIN({
	width = 960,
	height = 540,
	isResizable = true
})

SET_BACKGROUND({
	color = '#ffffff'
})

local image
function createImage()
	image = love.graphics.newImage('dice-'..RANDOM({
		min = 1,
		max = 6
	})..'.png')
end
createImage()

function love.load()
	canvas = love.graphics.newCanvas(480, 540)
	love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 0, 0, 128)
        love.graphics.rectangle('fill', 0, 0, 100, 100)
    love.graphics.setCanvas()
end

function love.draw()
	love.graphics.draw(canvas)
	love.graphics.draw(image, 480, 100, 0, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
end

function love.mousepressed(x, y, button, isTouch)
	if button == 1 then
		createImage()
	end
end
