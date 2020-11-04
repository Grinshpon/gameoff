local sidekick = {}

local coroutines = {}
local coCount = 0

local AnyFn = {}

function startCoroutine(f, ...)
   local co = coroutine.create(f)
   coroutine.resume(co, ...)
   table.insert(coroutines, co)
   coCount = coCount + 1
   return co
end

function stopCoroutine(cox)
   for i, coy in ipairs(coroutines) do
      if cox == coy then
         table.remove(coroutines, i)
         coCount = coCount - 1
         return
      end
   end
end

function sidekick.updateCoroutines()
   local co
   for i = coCount + 1, 1, -1 do
      co = coroutines[i]
      coroutine.resume(co)
      if coroutine.status(co) == "dead" then
         table.remove(coroutines)
         coCount = coCount - 1
      end
   end
end

return sidekick
