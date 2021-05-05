THETA = math.pi / 3
RANGE = 200

function love.load()
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
    -- draw field-of-view
    love.graphics.setColor(0.5, 0.5, 0)
    love.graphics.arc("fill", yo, xo, RANGE, -THETA/2 - math.pi/2, THETA/2 - math.pi/2)
    -- draw cursor
    local k = math.tan(THETA / 2) * dx
    if math.abs(dy) <= k and dx*dx + dy*dy < RANGE*RANGE then
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
