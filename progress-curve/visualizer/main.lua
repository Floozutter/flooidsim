function reset()
	t = 0
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
	love.graphics.setCanvas()
end

function love.load(arg)
	local modulename = arg[1]
	local chunk, err = loadfile(modulename)
	if chunk == nil then
		errstate = true
		errmsg = (
			"Usage: love visualizer LUAFILE\n"..
			"LUAFILE should return a single function that "..
			"relates a normalized time argument to normalized progress.\n\n"..
			"Error on loadfile "..modulename..": "..err
		)
		return
	end
	func = chunk()
	canvas = love.graphics.newCanvas(love.graphics.getDimensions())
	reset()
end

function love.update(dt)
	if errstate then return end
	t = t + 5
end
	
function love.draw()
	if errstate then love.graphics.print(errmsg, 20, 20); return end
	love.graphics.setColor(1, 1, 1, 1)
	--love.graphics.print(modulename, t, t)
	love.graphics.setCanvas(canvas)
		love.graphics.circle("fill", t, func(t), 10)
	love.graphics.setCanvas()
	love.graphics.draw(canvas)
end

function love.keypressed(key)
	if key == "space" then reset() end
end