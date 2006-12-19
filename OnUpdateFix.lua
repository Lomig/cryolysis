local M = AceLibrary("Metrognome-2.0")
local _G = getfenv(0)
M:Register("Cryo_UpdateFunc", Cryo.CryolysisButton_OnUpdate, 0.1, self)
do
	local f = _G["CryolysisButton"]
	f:SetScript("OnUpdate", nil)
	M:Start("Cryo_UpdateFunc")
end