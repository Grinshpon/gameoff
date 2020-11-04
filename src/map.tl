-- map based on circular grid

local record Map
  record Level
    width: number -- the width of each ring
    size: number --the number of "rings"
  end

  --cartesian to grid coords and vice versa
  cart2grid: function(Level,number,number): (number,number)
  grid2cart: function(Level,number,number): (number,number)
end

local Level = Map.Level

local map: Map = {}

function map.cart2grid(l: Level,x: number,y:number): (number,number)
  return 0,0
end

function map.grid2cart(l: Level,x: number,y:number): (number,number)
  --local theta = math.pi*(y+1)/(4*(x+1))
  local theta = math.pi/math.pow(2,x)
  theta = theta*(y+0.5)
  local r = l.width*(x+0.5)
  return r*math.cos(theta), r*math.sin(theta)
end

return map
