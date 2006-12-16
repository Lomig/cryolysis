-- Assign the library "Metrognome-2.0" to variable M, obviously.
local M = AceLibrary("Metrognome-2.0")
local _G = getfenv(0)

-- To use Metrognome, we first have to register a function to repeat.
-- This doesn't start the function, it just lets metro know that we'll
-- need it eventually.  The syntax is:
-- ':Register(<custom name>, <function to call when it starts>, <time in seconds between calls>)'
M:Register("Cryo_UpdateFunc", Cryolysis_OnUpdate, 0.5)

do
	local f = _G["CryolysisButton"]
	-- This erases the frames current OnUpdate handler so we can replace it.
	f:SetScript("OnUpdate", nil)
	-- Now start our repeating function, and it'll run the OnUpdate() handler
	-- on our own schedule :)
	M:Start("Cryo_UpdateFunc")
end

-- Usually, it wouldn't be this messy.  I would do this before the frame is even created,
-- but I can't do to the way it's written.