local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local toc=select(4,GetBuildInfo())
local me, ns = ...
local pp=print
local L=LibStub("AceLocale-3.0"):GetLocale(me,true)
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
LibStub("AlarLoader-3.0")(__FILE__,me,ns)
--X:loadingList(__FILE__,me)
--X:GetPrintFunctions(me,ns)
local print=ns.print or print
local debug=ns.debug or print
--[[ Standard prologue end --]]
local function help(self)
--===DOCBEGIN===
		self:HF_Title("Blizzard art remover","RELNOTES")
		self:HF_Paragraph("Description")
		self:HF_Pre("Hides gryphons and artwork from blzzard main actionbar\n")
self:RelNotes(3,5,2,[[
Upgrade: Updated Alar Shared version
]])
self:RelNotes(3,5,1,[[
Upgrade: Updated to 6.0.3
]])
--===DOCEND===
end
local addon=LibStub("AlarLoader-3.0"):CreateAddon(me,true)
function addon:OnInitialized()
	help(self)
	local g=self:AddToggle("HIDEGRYPHON",false,L["Hide gryphon"],L["If checked, hides gryphon art"])
	g.width='full'
	g=self:AddToggle("HIDEMAINBAR",false,L["Hide main bar"],L["If checked, hides main bar art"])
	g.width='full'
	self.HIDEGRYPHON={tipo="form",
		items={"MainMenuBarLeftEndCap","MainMenuBarRightEndCap"}
	}
	self.HIDEMAINBAR={tipo="form",
		items={"MainMenuBarTexture0","MainMenuBarTexture1","MainMenuBarTexture2","MainMenuBarTexture3"}
	}
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
