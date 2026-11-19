local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- Always check line number in regexp and file
local me,ns=...
local level =GetAccountExpansionLevel()
  local callback = function()
  local items={
    MainMenuBar and MainMenuBar.EndCaps,
    MainActionBar and MainActionBar.EndCaps
  }
  for _,f in pairs(items) do
    if f then 
      f:Hide()
    end
  end
end
---@type TimerCallback
local cb = C_FunctionContainers.CreateCallback(callback)
C_Timer.After(2, cb)