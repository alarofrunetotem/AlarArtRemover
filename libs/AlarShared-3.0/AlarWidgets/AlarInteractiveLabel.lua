local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local MAJOR_VERSION = ("AlarInteractiveLabel.lua"):gsub(".lua","")
local MINOR_VERSION = 500 + tonumber(string.sub("$Revision$", 12, -3))
local me,ns=...
local pp=print
local Type, Version = "AlarInteractiveLabel", 23
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local AWG=LibStub("AlarWidgets-3.0")
local InjectStandardMethods=AWG.InjectStandardMethods
LibStub("AlarLoader-3.0"):loadingList(__FILE__,me)

-- Lua APIs
local select, pairs = select, pairs

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: GameFontHighlightSmall

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
end

local function Label_OnClick(frame, button)
	frame.obj:Fire("OnClick", button,frame.obj.label:GetText())
	AceGUI:ClearFocus()
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:LabelOnAcquire()
		self:SetHighlight()
		self:SetHighlightTexCoord()
		self:SetDisabled(false)
		local highlight=self.highlight
		highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		highlight:SetAllPoints()
		highlight:SetBlendMode("ADD")	end,

	-- ["OnRelease"] = nil,

	["SetHighlight"] = function(self, ...)
		self.highlight:SetTexture(...)
	end,

	["SetHighlightTexCoord"] = function(self, ...)
		local c = select("#", ...)
		if c == 4 or c == 8 then
			self.highlight:SetTexCoord(...)
		else
			self.highlight:SetTexCoord(0, 1, 0, 1)
		end
	end,

	["SetDisabled"] = function(self,disabled)
		self.disabled = disabled
		if disabled then
			self.frame:EnableMouse(false)
			self.label:SetTextColor(0.5, 0.5, 0.5)
		else
			self.frame:EnableMouse(true)
			self.label:SetTextColor(1, 1, 1)
		end
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	-- create a Label type that we will hijack
	local label = AceGUI:Create("AlarLabel")

	local frame = label.frame
	frame:EnableMouse(true)
	frame:SetScript("OnEnter", Control_OnEnter)
	frame:SetScript("OnLeave", Control_OnLeave)
	frame:SetScript("OnMouseDown", Label_OnClick)
	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")


	label.highlight = highlight
	label.type = Type
	label.LabelOnAcquire = label.OnAcquire
	label:Inject(methods)

	return label
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)

