function reset()
	--[[ Resets the plot. ]]--
	-- Reset time variable.
	t = 0
	-- Reset canvas.
	love.graphics.setCanvas(canvas)
		love.graphics.clear()
	love.graphics.setCanvas()
end

function love.load(arg)
	-- Get Lua filename command-line argument.
	local filename = arg[1]
	-- Try loading the file as a chunk.
	local chunk, err = loadfile(filename)
	if chunk == nil then  -- Chunk failed to load.
		errstate = true
		errmsg = (
			"Usage: love visualizer LUAFILE\n"..
			"LUAFILE should return a single function that "..
			"relates a normalized time argument to normalized progress.\n\n"..
			"Error on loadfile "..filename..": "..err
		)
		return
	end
	func = chunk()
	-- Create canvas.
	canvas = love.graphics.newCanvas(love.graphics.getDimensions())
	-- Set plot.
	reset()
end

function love.update(dt)
	-- Handle error state.
	if errstate then return end
	-- Update time variable.
	t = t + 5
end
	
function love.draw()
	-- Handle error state.
	if errstate then love.graphics.print(errmsg, 20, 20); return end
	-- Plot t, func(t) on canvas.
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setCanvas(canvas)
		love.graphics.circle("fill", t, func(t), 10)
	love.graphics.setCanvas()
	-- Draw canvas to the window.
	love.graphics.draw(canvas)
end

function love.keypressed(key)
	-- Reset on spacebar.
	if key == "space" then reset() end
end