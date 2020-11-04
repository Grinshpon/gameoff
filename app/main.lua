require("setup")
require("camera")
local game = require("game")

function love.load()

   game:initCursor()
   game:initCamera()
   game:initInputCallbacks()
end

function love.update(dt)
   updateInput()
end

function love.draw()
   love.graphics.push()


   game:setTransform("window")
   love.graphics.push()

   game:setTransform("world")
   game:drawLevel()
   love.graphics.pop()
   love.graphics.pop()
end
