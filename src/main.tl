require "setup"
require "camera"
local sidekick = require "sidekick"
local game = require "game"

function love.load()
  --print(love.window.getDPIScale())
  game:initCursor()
  game:initCamera()
  game:initInputCallbacks()
end

function love.update(dt: number)
  sidekick.updateInput()
  sidekick.updateCoroutines()
end

function love.draw()
  love.graphics.push()
    -- window resultion / game resolution scaling
    -- todo: instead of calling getHeight, turn reziable off and store height in an options table
    game:setTransform("window")
    love.graphics.push()
      -- draw map
      game:setTransform("world")
        game:drawLevel()
    love.graphics.pop()
  love.graphics.pop()
end
