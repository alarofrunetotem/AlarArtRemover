local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- Always check line number in regexp and file
local me,ns=...
local pp=print
local addon=ns
function addon:Start()
	local items={
		MainMenuBarLeftEndCap,
		MainMenuBarRightEndCap,
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3
	}
	for _,f in pairs(items) do
		if f then f:Hide() end
	end
	
end
addon:Start()
_G.AAR=addon
