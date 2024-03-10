local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- Always check line number in regexp and file
local me,ns=...
print("AlarArtRemover loaded")
if (GetAccountExpansionLevel()==0) then
  local addon=ns
  function addon:Start()
   local items={
     MainMenuBarEndCaps
   }
   for _,f in pairs(items) do
     if f then f:Hide() end
   end

  end
  addon:Start()
else
C_Timer.After(2,function()
  local items={
    MainMenuBarEndCaps,
  }
  for _,f in pairs(items) do
    if f then f:Hide() end
  end
end
)
end
