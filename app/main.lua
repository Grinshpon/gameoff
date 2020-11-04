require("setup")
require("camera")
local sidekick = require("sidekick")
local game = require("game")

function love.load()

   game:initCursor()
   game:initCamera()
   game:initInputCallbacks()
end

function love.update(dt)
   sidekick.updateInput()
   sidekick.updateCoroutines()
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
