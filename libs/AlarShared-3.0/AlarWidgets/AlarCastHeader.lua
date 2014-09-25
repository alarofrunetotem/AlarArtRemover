local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local MAJOR_VERSION = ("AlarCastHeader.lua"):gsub(".lua","")
local MINOR_VERSION = 500 + tonumber(string.sub("$Revision: 85 $", 12, -3))
local Type,Version,Ancestor = "AlarCastHeader",2
--[[
Name: AlarPanels.lua
Revision: $Rev: 85 $
Author: Alar of Daggerspine
Email: alar@aspide.it
Website: http://www.curse.com
SVN: $HeadUrl:$
Description: Generic library
Dependencies: Ace3
License: LGPL v2.1
--]]
local me, ns = ...
--@debug@
print("Loading",__FILE__," inside ",me)
--@end-debug@
if (LibDebug) then LibDebug() end
local function debug(...)
--@debug@
	print(...)
--@end-debug@
end
local print=_G.print
local notify=_G.print
local error=_G.error
local function dump() end
local function debugEnable() end
if (LibStub("AlarLoader-3.0",true)) then
	local rc=LibStub("AlarLoader-3.0"):GetPrintFunctions(MAJOR_VERSION)
	print=rc.print
	--@debug@
	debug=rc.debug
	dump=rc.dump
	--@end-debug@
	notify=rc.notify
	error=rc.error
	debugEnable=rc.debugEnable
else
	debug("Missing AlarLoader-3.0")
end
local _,_,_,toc=GetBuildInfo()
debugEnable(false)
local L=LibStub("AceLocale-3.0"):GetLocale('AlarShared',true)
--[[ Standard prologue end --]]
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=LibStub("AceGUI-3.0")
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
local InjectStandardMethods=AWG.InjectStandardMethods
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local methods={} --# Control
function methods:SetBackdrop(backdrop)
	self.frame:SetBackdrop(backdrop)
end
function methods:OnAcquire()
	self:Parent(Ancestor,"OnAcquire")
	self.frame.tooltipText=C(L["Drag with Shift button to move"],"yellow")
	self.content:Show()
end
function methods:Append(frame)
	self:SetUserData(frame,'frame')
	frame:SetParent(self.frame)
end
function methods:SetTitle(...)
	self.frame:SetText(...)
end
function methods:SetTooltipText(text)
	self.frame.tooltipText=C(L["Drag with Shift button to move"],"yellow") .. "\n" .. text
end
function methods:SetOnAttributeChanged(snippet)
	self.frame:SetAttribute('_onattributechanged',snippet)
end
function methods:ApplyStatus()
	local status = self:Status()
	local frame = self.frame
	self:SetWidth(status.width or 100)
	self:SetHeight(status.height or 30)
	if status.top and status.left then
		frame:SetPoint("TOP",UIParent,"BOTTOM",0,status.top)
		frame:SetPoint("LEFT",UIParent,"LEFT",status.left,0)
	else
		frame:SetPoint("CENTER",UIParent,"CENTER")
	end
end
function methods:SetModifiedCast(modifier,actiontype,button,value)
	local attribute=actiontype
	if (actiontype=="macrotext") then actiontype ="macro" end
	self.frame:SetAttribute(modifier .. "type" .. button,actiontype)
	self.frame:SetAttribute(modifier .. attribute .. button,value)
end
do
	local serial=0
	local function tooltipshow(this,r,g,b)
		if InCombatLockdown() then return end
		if(this.tooltipText ~= nil) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(this.tooltipText, r or 1, g or 0.82, b or 0);
			if (this.obj:IsRestricted()) then
				GameTooltip:AddLine(L["Disabled due to combat lockdown"],1,0,0)
			end
			GameTooltip:Show()
		end
	end
	local function tooltiphide(this)
			if(this.tooltipText ~= nil) then
			GameTooltip:Hide();
			end
	end
	local function Constructor()
		local frame=CreateFrame("Button",Type..serial,UIParent,"UIPanelButtonTemplate,SecureActionButtonTemplate,SecureHandlerAttributeTemplate")
		serial =serial +1
		local widget={frame=frame}
		frame.obj=widget
		frame:SetClampedToScreen(true)
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:RegisterForClicks("AnyDown")
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function (frame) if (IsShiftKeyDown()) then frame:StartMoving() end end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
		frame:SetScript("OnEnter",tooltipshow)
		frame:SetScript("OnLeave",tooltiphide)
		--Container Support
		local content = CreateFrame("Frame",nil,frame)
		widget.content = content
		content.obj = widget
		content:SetPoint("TOPLEFT",frame,"TOPLEFT",12,-20)
		content:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-12,13)

		widget.type = Type
		InjectStandardMethods(widget)
		widget:Inject(methods,Ancestor)
		widget.localstatus = {}
		frame:SetWidth(100)
		frame:SetHeight(20)
		frame:SetMovable(true)
		widget:Show()
		return AceGUI:RegisterAsContainer(widget)
	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets[Type]=Version
end
