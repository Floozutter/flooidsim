function love.load(arg)
	modulename = arg[1]
	func = require(modulename)
	t = 0
end

function love.update(dt)
	t = t + 0.1
end
	
function love.draw()
	love.graphics.print(modulename, t, t)
end