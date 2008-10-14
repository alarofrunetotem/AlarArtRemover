--[[
Name: AlarArtRemover.lua
Revision: $Revision: 65902 $
Author: Alar of Daggerspine
Website: http://wow.aspide.it
Documentation:
SVN:
Description:
Dependencies: Alarmod
License: GPL v2.1
--]]
--@debug@ 
DEFAULT_CHAT_FRAME:AddMessage(GetTime().. " AlarArtRemover",1,0,0)
--@end-debug@
LoadAddOn('AlarShared')
local function help(self)
--===DOCBEGIN===
    self:HF_Title("Blizzard art remover")
    self:HF_Commands()
    self:RelNotes(2,0,0,[[
Upgrade: Now uses Ace3
Fixed: Art status is now always remember betweeen section
]])
    self:RelNotes(1,0,5,[[
Upgrade: WoW 2.4 
]])
    self:RelNotes(1,0,4,[[
Upgrade: Embedded libraries upgrade
Fixed: ...AlarLib-2.0.lua:4689: bad argument #1 to 'pairs' (table expected, got nil)
]])
    self:RelNotes(1,0,0,[[
Feature: Updated to WoW 2.3
]])
--===DOCEND===
end
local Id="AAR"
local Fullname="AlarArtRemover"
setglobal(Id,AlarCreateAddon(Fullname,true))
local aar=getglobal(Id)
aar.ID=Id
aar.DATABASE='db' ..Id
local L=AlarGetLocale()
function aar:OnInitialized()
    help(self)
    g=self:AddToggle("HIDEGRYPHON",false,L["Hide gryphon"],L["If checked, hides gryphon art"])
    g.width='full'
    --g=self:AddToggle("HIDEMAINBAR",false,L["Hide main bar"],L["If checked, hides main bar art"])
    --g.width='full'
    g=self:AddToggle("HIDELAGMETER",false,L["Hide lagmeter"],L["If checked, hides lagmeter art"])
    g.width='full'
--[[
    g=self:AddToggle("HIDEPETBAR",false,L["Hide pet bar"],L["If checked, hides pet bar art"])
    g.width='full'
--]]
    self.HIDEGRYPHON={tipo="form",
        items={"MainMenuBarLeftEndCap","MainMenuBarRightEndCap"}
        }
    self.HIDELAGMETER={tipo="unknown",
                    items={"MainMenuBarPerformanceBarFrame"}
                    }
    self.HIDEMAINBAR={tipo="form",
                    items={"MainMenuBarTexture0","MainMenuBarTexture1","MainMenuBarTexture2","MainMenuBarTexture3"}
                    }
    self.HIDEPETBAR={tipo="texture",
                    items={"SlidingActionBarTexture0","SlidingActionBarTexture1"}
                    }
end
function aar:Apply(toggle,value)
    local work=self[toggle]
    if (not work) then return end
    if (work.tipo == "form") then
        for _,f in pairs(work.items) do
            if (not value) then
                getglobal(f):Show()
            else 
                getglobal(f):Hide()
            end             
        end
    end 
end

function aar:OnDisabled()
    for i,v in self:Vars() do
        self._Apply[i](self,i,false)
    end
end
AAR=aar