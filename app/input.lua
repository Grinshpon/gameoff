function noop() end



local Input = {InputActions = {}, KeyAction = {}, }


















local KeyAction = Input.KeyAction
local InputActions = Input.InputActions

















local function updateInputActions(ia)
   for _, action in pairs(ia.actions) do
      if action.isDown then
         action.down()
      end
   end
end











local inputActionsList = {}

local input = {}

function input.keyAction(k)
   local ka = {
      binding = k,
      pressed = noop,
      released = noop,
      down = noop,
      isDown = false,
   }
   return ka
end

function input.addInputActions(ia)
   table.insert(inputActionsList, ia)
end

function input.update()
   for _, ia in ipairs(inputActionsList) do
      if ia.enabled then          updateInputActions(ia) end
   end
end

function input.enable(ia)
   ia.enabled = true
end

function input.disable(ia)
   ia.enabled = false
end

function love.keypressed(key)
   for _, ia in ipairs(inputActionsList) do
      if ia.enabled then
         for _, action in pairs(ia.actions) do
            if key == action.binding then
               action.pressed()
               action.isDown = true
            end
         end
      end
   end
end
function love.keyreleased(key)
   for _, ia in ipairs(inputActionsList) do
      if ia.enabled then
         for _, action in pairs(ia.actions) do
            if key == action.binding then
               action.released()
               action.isDown = false
            end
         end
      end
   end
end

return input
