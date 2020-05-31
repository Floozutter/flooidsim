local DURATION = 3  -- Plotting time in seconds.
local RESETKEY = "space"  -- Key to reset plot.

function loadfunc(filename)
	--[[ Loads a plottable function from a file. ]]--
	local USAGE = (
		"Usage: love visualizer LUAFILE\n"..
		"LUAFILE should return a single function that "..
		"relates a normalized time argument to normalized progress.\n\n"
	)
	-- Guarantee filename is a string.
	local fntype = type(filename)
	if fntype ~= "string" then
		local err = "Unexpected type "..fntype.." on filename argument."
		return nil, USAGE..err
	end
	-- Try loading the file as a chunk.
	local chunk, loadfile_err = loadfile(filename)
	if chunk == nil then  -- File failed to load as a chunk.
		local err = "Error on loadfile "..filename..": "..loadfile_err
		return nil, USAGE..err
	end
	-- Try executing the chunk to get a function.
	local res = chunk()
	local restype = type(res)
	if restype ~= "function" then  -- Chunk failed to return a function.
		local err = "Unexpected type "..restype.." on chunk execution."
		return nil, USAGE..err
	end
	-- Passed all checks, return function with no error messages.
	return res, nil
end

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
	-- Try loading the file as a function.
	func, errmsg = loadfunc(filename)
	if func == nil then errstate = true; return end
	-- Create canvas.
	canvas = love.graphics.newCanvas(love.graphics.getDimensions())
	-- Set plot.
	reset()
end

function love.update(dt)
	-- Handle error state.
	if errstate then return end
	-- Check if user is holding down the reset key.
	if love.keyboard.isDown(RESETKEY) then return end
	-- Update time variable.
	t = t + dt/DURATION
	if t > 1 then t = 1 end
end
	
function love.draw()
	-- Handle error state.
	if errstate then love.graphics.print(errmsg, 20, 20); return end
	-- Plot t, func(t) on the canvas.
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setCanvas(canvas)
		love.graphics.circle(
			"fill",
			love.graphics.getWidth() * t,
			love.graphics.getHeight() * (1 - func(t)),
			10
		)
	love.graphics.setCanvas()
	-- Draw canvas to the window.
	love.graphics.draw(canvas)
end

function love.keypressed(key)
	-- Reset on spacebar.
	if key == RESETKEY then reset() end
end