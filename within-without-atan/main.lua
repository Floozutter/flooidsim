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
    -- draw field-of-view
    love.graphics.setColor(0.5, 0.5, 0)
    love.graphics.arc("fill", yo, xo, RANGE, -THETA/2 - math.pi/2, THETA/2 - math.pi/2)
    -- draw cursor
    if false then
        love.graphics.setColor(0, 1, 0)
    else
        love.graphics.setColor(1, 0, 0)
    end
    love.graphics.circle("fill", y, x, 5)
end
