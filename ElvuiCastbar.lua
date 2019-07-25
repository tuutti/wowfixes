local E, L, V, P, G = unpack(ElvUI)
local CT = E:NewModule("CustomElvuiCastBar")
local EP = LibStub("LibElvUIPlugin-1.0") 
local addonName, addonTable = ... --See http://www.wowinterface.com/forums/showthread.php?t=51502&p=304704&postcount=2

local units = {"Player", "Pet", "Target", "Focus", "Arena", "Boss"}

function SetCastbarTextColor(unit)
	local durationColor = {r = 1, g = 1, b = 1, a = 1}
	local textColor = {r = 1, g = 1, b = 1, a = 1}
	
	if unit == "Arena" then
		for i = 1, 5 do
			local unitframe = _G["ElvUF_Arena"..i]
			local castbar = unitframe and unitframe.Castbar
			
			if castbar then
				castbar.Text:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
				castbar.Time:SetTextColor(durationColor.r, durationColor.g, durationColor.b, durationColor.a)
			end
		end
	elseif unit == "Boss" then
		for i = 1, MAX_BOSS_FRAMES do
			local unitframe = _G["ElvUF_Boss"..i]
			local castbar = unitframe and unitframe.Castbar
			
			if castbar then
				castbar.Text:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
				castbar.Time:SetTextColor(durationColor.r, durationColor.g, durationColor.b, durationColor.a)
			end
		end
	else
		local unitframe = _G["ElvUF_"..unit]
		local castbar = unitframe and unitframe.Castbar

		if castbar then
			castbar.Text:SetTextColor(textColor.r, textColor.g, textColor.b, textColor.a)
			castbar.Time:SetTextColor(durationColor.r, durationColor.g, durationColor.b, durationColor.a)
		end
	end
end

local units = {"Player", "Pet", "Target", "Focus", "Arena", "Boss"}


function CT:Initialize()
	EP:RegisterPlugin(addonName, CT.InsertOptions)
end

E:RegisterModule(CT:GetName()) 

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	for _, unit in pairs(units) do
		SetCastbarTextColor(unit)
	end
end)

