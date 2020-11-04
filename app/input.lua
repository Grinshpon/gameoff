function noop()
end

 KeyAction = {}







 Input = {}



function Input.new(o)
   local self = setmetatable({}, { __index = Input })
   self.actions = o.actions
   return self
end

function Input:update()
   for _, action in pairs(self.actions) do
      if action.isDown then
         action.down()
      end
   end
end

local input = Input.new({
   actions = {
      zoomIn = { binding = "=", pressed = noop, released = noop, down = noop, isDown = false },
      zoomOut = { binding = "-", pressed = noop, released = noop, down = noop, isDown = false },
      panLeft = { binding = "left", pressed = noop, released = noop, down = noop, isDown = false },
      panRight = { binding = "right", pressed = noop, released = noop, down = noop, isDown = false },
      panUp = { binding = "up", pressed = noop, released = noop, down = noop, isDown = false },
      panDown = { binding = "down", pressed = noop, released = noop, down = noop, isDown = false },
   },
})

function love.keypressed(key)
   for _, action in pairs(input.actions) do
      if key == action.binding then
         action.pressed()
         action.isDown = true
      end
   end
end
function love.keyreleased(key)
   for _, action in pairs(input.actions) do
      if key == action.binding then
         action.released()
         action.isDown = false
      end
   end
end

return input
