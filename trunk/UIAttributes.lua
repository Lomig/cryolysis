local _G = getfenv(0)

function Cryolysis_UpdateDrinkButtonAttributes()
	local f = _G["CryolysisDrinkButton"]
	assert(f, "Error: Drink button not created or named properly!")
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type1", "item")
		local highestWaterName = GetItemInfo(CryolysisPrivate.highestWaterId)
		if ( highestWaterName ) then
			f:SetAttribute("item1", highestWaterName)
		end
		
		f:SetAttribute("*type2", "spell")
		f:SetAttribute("spell2", "Conjure Water")
	end
	DEFAULT_CHAT_FRAME:AddMessage("Attributes set.")
end