require "setup"
require "camera"
local map = require "map"
local input = require "input"

global enum TransformType
  "world"
  "ui"
  "window"
  "default"
end

local record Game
  cursor: love.graphics.Drawable
  camera: Camera
  screenToTile: function(Game, number, number): (number, number)
  tileToScreen: function(Game, number, number): (number, number)
  setTransform: function(Game, TransformType)
  initCursor: function(Game)
  initCamera: function(Game)
  initInputCallbacks: function(Game)
  drawLevel: function(Game)
end

local game: Game = {}

function game:screenToTile(x: number, y: number): (number,number)
  return 0,0
end

function game:tileToScreen(x: number, y: number): (number,number)
  return 0,0
end

function game:setTransform(ttype: TransformType)
  if ttype == nil or ttype == "default" then
    --love.graphics.scale(1)
  elseif ttype == "world" then
    love.graphics.translate(self.camera.x+config.width/2,self.camera.y+config.height/2)
    love.graphics.scale(self.camera.scale)
  elseif ttype == "window" then
    love.graphics.scale(love.graphics.getHeight()/config.height) -- scales with height only
  elseif ttype == "ui" then
    --make it so it's 1:1
  end
end

local example: map.Level = {width = 60, size = 5}

function game:drawLevel()
  local mouseX, mouseY = love.graphics.inverseTransformPoint(love.mouse.getPosition())
  --love.graphics.circle("fill",0,0,example.width) -- instead of filled circle maybe a sprite in the middle?
  love.graphics.circle("line",0,0,example.width)
  local totalWidth = example.width*(example.size+1)
  for i=1, example.size do
    local r = example.width*(i)
    love.graphics.circle("line",0,0,r+example.width)
    local sectorsHalf = math.pow(2,i)
    local angle = math.pi/(sectorsHalf)
    for j=0, sectorsHalf*2-1 do
      local theta = j*angle
      local cos = math.cos(theta)
      local sin = math.sin(theta)
      love.graphics.line(r*cos,r*sin,totalWidth*cos,totalWidth*sin)
      --love.graphics.circle("fill",r*cos,r*sin,5)
      --love.graphics.setColor(1,0,0)
      --love.graphics.circle("fill",totalWidth*cos,totalWidth*sin,5)
      --love.graphics.setColor(1,1,1)
    end
  end
  --test
  --local x,y = map.grid2cart(example,1,0)
  --love.graphics.circle("fill",x,y,5)
  --x,y = map.grid2cart(example,5,-1)
  --love.graphics.setColor(1,0,0)
  --love.graphics.circle("fill",x,y,5)
  --love.graphics.setColor(1,1,1)
  local rx,ry = map.cart2grid(example,mouseX,mouseY)
  local x,y = map.grid2cart(example,rx,ry)
  if rx>0 then love.graphics.circle("fill",x,y,5) end
end

function game:initCursor()
  self.cursor = love.graphics.newImage("assets/cursor.png") as love.graphics.Drawable
end

function game:initCamera()
  self.camera = {
    x = 0,
    y = 0,
    scale = 1.0,
  }
end

local camActions: input.InputActions = {
  actions = {
    zoomIn   = input.keyAction("="),
    zoomOut  = input.keyAction("-"),
    panLeft  = input.keyAction("left"),
    panRight = input.keyAction("right"),
    panUp    = input.keyAction("up"),
    panDown  = input.keyAction("down"),
  },
  enabled = false,
}


function game:initInputCallbacks()
  camActions.actions.zoomIn.pressed = function()
    if self.camera.scale < 3 then
      self.camera.scale = self.camera.scale + 1
    end
  end
  camActions.actions.zoomOut.pressed = function()
    if self.camera.scale > 1 then
      self.camera.scale = self.camera.scale - 1
    end
  end
  camActions.actions.panLeft.down = function()
    self.camera.x = self.camera.x + config.panSpeed*love.timer.getDelta()
  end
  camActions.actions.panRight.down = function()
    self.camera.x = self.camera.x - config.panSpeed*love.timer.getDelta()
  end
  camActions.actions.panDown.down = function()
    self.camera.y = self.camera.y - config.panSpeed*love.timer.getDelta()
  end
  camActions.actions.panUp.down = function()
    self.camera.y = self.camera.y + config.panSpeed*love.timer.getDelta()
  end

  input.addInputActions(camActions)
  input.enable(camActions)
end

return game
