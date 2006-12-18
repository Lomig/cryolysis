local M = AceLibrary("Metrognome-2.0")
local _G = getfenv(0)
M:Register("Cryo_UpdateFunc", Cryolysis_OnUpdate, 0.5)
do
	local f = _G["CryolysisButton"]
	f:SetScript("OnUpdate", nil)
	M:Start("Cryo_UpdateFunc")
end