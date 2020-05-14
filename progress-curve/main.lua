function love.load(arg)
	text = arg[1]
end

function love.draw()
	love.graphics.print(text, 20, 20)
end