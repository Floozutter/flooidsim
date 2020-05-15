function love.load(arg)
	modulename = arg[1]
	func = loadfile(modulename)()
	t = 0
end

function love.update(dt)
	t = t + 1
end
	
function love.draw()
	love.graphics.print(modulename, t, t)
end