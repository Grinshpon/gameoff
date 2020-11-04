require("setup")
require("camera")
local map = require("map")
local input = require("input")

 TransformType = {}






local Game = {}











local game = {}

function game:screenToTile(x, y)
   return 0, 0
end

function game:tileToScreen(x, y)
   return 0, 0
end

function game:setTransform(ttype)
   if ttype == nil or ttype == "default" then

   elseif ttype == "world" then
      love.graphics.translate(self.camera.x + config.width / 2, self.camera.y + config.height / 2)
      love.graphics.scale(self.camera.scale)
   elseif ttype == "window" then
      love.graphics.scale(love.graphics.getHeight() / config.height)
   elseif ttype == "ui" then

   end
end

local example = { width = 60, size = 5 }

function game:drawLevel()


   love.graphics.circle("line", 0, 0, example.width)
   local totalWidth = example.width * (example.size + 1)
   for i = 1, example.size do
      local r = example.width * (i)
      love.graphics.circle("line", 0, 0, r + example.width)
      local sectorsHalf = math.pow(2, i)
      local angle = math.pi / (sectorsHalf)
      for j = 0, sectorsHalf * 2 - 1 do
         local theta = j * angle
         local cos = math.cos(theta)
         local sin = math.sin(theta)
         love.graphics.line(r * cos, r * sin, totalWidth * cos, totalWidth * sin)




      end
   end
end

function game:initCursor()
   self.cursor = love.graphics.newImage("assets/cursor.png")
end

function game:initCamera()
   self.camera = {
      x = 0,
      y = 0,
      scale = 1.0,
   }
end

function game:initInputCallbacks()
   input.actions.zoomIn.pressed = function()
      if self.camera.scale < 3 then
         self.camera.scale = self.camera.scale + 1
      end
   end
   input.actions.zoomOut.pressed = function()
      if self.camera.scale > 1 then
         self.camera.scale = self.camera.scale - 1
      end
   end
   input.actions.panLeft.down = function()
      self.camera.x = self.camera.x + config.panSpeed * love.timer.getDelta()
   end
   input.actions.panRight.down = function()
      self.camera.x = self.camera.x - config.panSpeed * love.timer.getDelta()
   end
   input.actions.panDown.down = function()
      self.camera.y = self.camera.y - config.panSpeed * love.timer.getDelta()
   end
   input.actions.panUp.down = function()
      self.camera.y = self.camera.y + config.panSpeed * love.timer.getDelta()
   end
end

function updateInput()
   input:update()
end

return game