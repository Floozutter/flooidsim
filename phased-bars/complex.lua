local Complex = {}
Complex.__index = Complex

function Complex.new(r, i)
    local c = {r = r, i = i}
    setmetatable(c, Complex)
    return c
end

function Complex.__add(a, b)
    return Complex.new(a.r + b.r, a.i + b.i)
end

function Complex.__sub(a, b)
    return Complex.new(a.r - b.r, a.i - b.i)
end

function Complex.__mul(a, b)
    return Complex.new(
        a.r * b.r - a.i * b.i,
        a.r * b.i + a.i * b.r
    )
end

function Complex.__tostring(c)
    return c.r .. " + " .. c.i .. "i"
end

return Complex
