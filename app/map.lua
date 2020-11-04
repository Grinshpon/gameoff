

local Map = {Level = {}, }










local Level = Map.Level

local map = {}

function map.cart2grid(l, x, y)
   return 0, 0
end

function map.grid2cart(l, x, y)

   local theta = math.pi / math.pow(2, x)
   theta = theta * (y + 0.5)
   local r = l.width * (x + 0.5)
   return r * math.cos(theta), r * math.sin(theta)
end

return map
