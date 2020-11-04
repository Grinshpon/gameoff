local input = require "input"

local sidekick = {}

local coroutines: {thread} = {}
local coCount = 0

local type AnyFn = function(...: any)

global function startCoroutine(f: AnyFn, ...: any): thread
  local co = coroutine.create(f)
  coroutine.resume(co,...)
  table.insert(coroutines, co)
  coCount = coCount+1
  return co
end

global function stopCoroutine(cox: thread)
  for i,coy in ipairs(coroutines) do
    if cox == coy then
      table.remove(coroutines,i)
      coCount = coCount-1
      return
    end
  end
end

--global function compose<A,B,C>(f: (function(B):C), g: (function(A):B)): (function(A):C)
  --return (function(x: A):C return f(g(x)) end)
--end

function sidekick.updateCoroutines()
  local co: thread
  for i=coCount,1,-1 do
    co = coroutines[i]
    coroutine.resume(co)
    if coroutine.status(co) == "dead" then
      table.remove(coroutines)
      coCount = coCount-1
    end
  end
end

function sidekick.updateInput()
  input.update()
end

return sidekick
