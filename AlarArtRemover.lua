local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- Always check line number in regexp and file
print("AlarArtRemover loaded")
C_Timer.After(2,function()
  local items={
    MainMenuBarArtFrameBackground,
    MainMenuBarArtFrame.LeftEndCap,
    MainMenuBarArtFrame.RightEndCap
  }
  for _,f in pairs(items) do
    if f then f:Hide() end
  end
end
)
