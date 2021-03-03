local C = require "complex"

PERIOD = 3
SCALE = 100
COLOR = {
    {0, 0, 1},
    {1, 0, 0}
}
VECTOR = {
    C.new(1, 0),
    C.new(0, 1)
}

function love.load()
    t = 0
    love.graphics.setLineWidth(4)
end

function love.update(dt)
    t = t + dt / PERIOD
    if t >= 1 then t = t - 1 end
end

function love.draw()
    local theta = 2 * math.pi * t
    local cos = C.new(math.cos(theta), 0)
    local sin = C.new(math.sin(theta), 0)
    local bector = {
        cos * VECTOR[1] - sin * VECTOR[2],
        sin * VECTOR[1] + cos * VECTOR[2]
    }
    local x = love.graphics.getWidth() / 2
    local y = love.graphics.getHeight() / 2
    for i, c in ipairs(bector) do
        local color = COLOR[i]
        if color ~= nil then love.graphics.setColor(color) end
        love.graphics.line(x, y, SCALE * c.r + x, -SCALE * c.i + y)
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("<" .. tostring(VECTOR[1]) .. ", " .. tostring(VECTOR[2]) .. ">")
    love.graphics.print("theta = " .. theta, 0, 20)
end
