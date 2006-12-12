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
end

function Cryolysis_UpdateFoodButtonAttributes()
	local f = _G["CryolysisFoodButton"]
	assert(f, "Error: Food button not created or named properly!")
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type1", "item")
		local highestFoodName = GetItemInfo(CryolysisPrivate.highestFoodId)
		if ( highestFoodName ) then
			f:SetAttribute("item1", highestFoodName)
		end
		
		f:SetAttribute("*type2", "spell")
		f:SetAttribute("spell2", "Conjure Food")
	end
end