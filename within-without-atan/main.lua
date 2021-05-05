ANGLE = math.pi / 3
RANGE = 200

function love.load(args)
    if args[1] ~= nil then
        ANGLE = 2 * math.pi * tonumber(args[1])
    end
    x = 0
    y = 0
end

function love.update()
    y, x = love.mouse.getPosition()
end

function love.draw()
    local xo = love.graphics.getHeight() / 2
    local yo = love.graphics.getWidth() / 2
    local dx = xo - x
    local dy = yo - y
    local k = math.tan(ANGLE / 2) * dx
    local valid = 0 < ANGLE and ANGLE <= 2 * math.pi
    local visible = false
    if valid and dx*dx + dy*dy < RANGE*RANGE then
        if ANGLE < math.pi then
            visible = math.abs(dy) <= k
        elseif ANGLE == math.pi then
            visible = dx >= 0
        elseif ANGLE < 2 * math.pi then
            visible = math.abs(dy) >= k
        else
            visible = true
        end
    end
    -- draw field-of-view
    if valid then
        love.graphics.setColor(0.5, 0.5, 0)
        love.graphics.arc("fill", yo, xo, RANGE, -ANGLE/2 - math.pi/2, ANGLE/2 - math.pi/2)
    end
    -- draw cursor
    if visible then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(0, 1, 0)
    end
    love.graphics.circle("fill", y, x, 5)
    -- draw info
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(dx .. ", " .. dy)
    love.graphics.print("k = " .. k, 0, 20)
end
