local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- Always check line number in regexp and file
local me,ns=...
local pp=print
--@debug@
--Postal_BlackBookButton
-- SendMailNameEditBox
LoadAddOn("Blizzard_DebugTools")
LoadAddOn("LibDebug")
if LibDebug then LibDebug() end
--@end-debug@
--[===[@non-debug@
local print=function() end
local DevTools_Dump=function() end
--@end-non-debug@]===]
local addon --#MailCommander
local LibInit,minor=LibStub("LibInit",true)
assert(LibInit,me .. ": Missing LibInit, please reinstall")
addon=LibStub("LibInit"):NewAddon(ns,me,{noswitch=false,profile=true,enhancedProfile=true})
local C=addon:GetColorTable()
local L=addon:GetLocale()
function addon:OnInitialized()
	local g=self:AddToggle("HIDEGRYPHON",true,L["Hide gryphon"],L["If checked, hides gryphon art"])
	g.width='full'
	g=self:AddToggle("HIDEMAINBAR",false,L["Hide main bar"],L["If checked, hides main bar art"])
	g.width='full'
	self.HIDEGRYPHON={tipo="form",
		items={"MainMenuBarLeftEndCap","MainMenuBarRightEndCap"}
	}
	self.HIDEMAINBAR={tipo="form",
		items={"MainMenuBarTexture0","MainMenuBarTexture1","MainMenuBarTexture2","MainMenuBarTexture3"}
	}
	self:Trigger("HIDEGRYPHON")
	self:Trigger("HIDEMAINBAR")
end
function addon:Apply(toggle,value)
	local work=self[toggle]
	if (not work) then return end
	if (work.tipo == "form") then
		for _,f in pairs(work.items) do
			if (not value) then
				_G[f]:Show()
			else
				_G[f]:Hide()
			end
		end
	end
end

function addon:OnDisabled()
		for i,v in self:Vars() do
				self:Apply(i,false)
		end
end
_G.AAR=addon
