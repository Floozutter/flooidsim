function love.load(arg)
	local modulename = arg[1]
	local func, err = loadfile(modulename)
	if func == nil then
		errstate = true
		errmsg = (
			"Usage: love visualizer LUAFILE\n"..
			"LUAFILE should return a single function that "..
			"relates a normalized time argument to normalized progress.\n\n"..
			"Error on loadfile "..modulename..": "..err
		)
	t = 0
end

function love.update(dt)
	if errstate then return end
	t = t + 1
end
	
function love.draw()
	if errstate then love.graphics.print(errmsg, 20, 20); return end
	love.graphics.print(modulename, t, t)
end