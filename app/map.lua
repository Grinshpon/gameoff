

local Map = {Level = {}, }










local Level = Map.Level

local map = {}

function quadrant(x, y)
   if x > 0 then
      if y > 0 then          return 1 else          return 4 end
   elseif x < 0 then
      if y > 0 then          return 2 else          return 3 end
   end
end

local atan = math.atan

function ucAngle(x, y)
   if x == 0 then
      if y > 0 then          return math.pi / 2
      elseif y < 0 then          return math.pi * 3 / 2
      else          return 0 end
   elseif y == 0 then
      if x >= 0 then          return 0 else          return math.pi end
   end
   local q = quadrant(x, y)
   if q == 1 then       return atan(y / x)
   elseif q == 2 then       return atan(y / x) + math.pi
   elseif q == 3 then       return atan(y / x) + math.pi
   elseif q == 4 then       return atan(y / x) + math.pi * 2
   end
end

function map.cart2grid(l, x, y)
   local dist = math.sqrt(math.pow(x, 2) + math.pow(y, 2))
   if dist < l.width then       return 0, 0 end
   for i = 1, l.size do
      local r = l.width * (i + 1)
      if dist < r then
         local rx, ry = i, 0
         local theta = ucAngle(x, y)

         local angle = math.pi / math.pow(2, i)
         for j = 0, math.pow(2, i + 1) - 1 do
            local t = angle * (j + 1)
            if theta < t then                ry = j
               love.graphics.print(tostring(rx) .. "," .. tostring(ry), 0, 0)
               return rx, ry
            end
         end
         return 0, 0
      end
   end
   return 0, 0
end

function map.grid2cart(l, x, y)

   local theta = (y + 0.5) * math.pi / math.pow(2, x)

   local r = l.width * (x + 0.5)
   return r * math.cos(theta), r * math.sin(theta)
end

return map
