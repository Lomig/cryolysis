local _G = getfenv(0)

function Cryolysis_UpdateDrinkButtonAttributes()
	local f = _G["CryolysisDrinkButton"]
	assert(f, "Error: Drink button not created or named properly!")
	if ( not InCombatLockdown() ) then
		f:SetAttribute("type1", "item")
		local highestWaterName = GetItemInfo(CryolysisPrivate.highestWaterId)
		if ( highestWaterName ) then
			f:SetAttribute("item1", highestWaterName)
		end
		
		f:SetAttribute("type2", "spell")
		-- Changed by Lomig
		-- f:SetAttribute("spell2", "Conjure Water")
		f:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[11].Name)

		-- Added By Lomig 12/12/06 12:51pm (GMT+1)
		f:SetAttribute("type3", "Trade");
		f.Trade = function() Cryolysis_Trade_Water(); end
		-- End of adding

	end
end

function Cryolysis_UpdateFoodButtonAttributes()
	local f = _G["CryolysisFoodButton"]
	assert(f, "Error: Food button not created or named properly!")
	if ( not InCombatLockdown() ) then
		f:SetAttribute("type1", "item")
		local highestFoodName = GetItemInfo(CryolysisPrivate.highestFoodId)
		if ( highestFoodName ) then
			f:SetAttribute("item1", highestFoodName)
		end
		
		f:SetAttribute("type2", "spell")
		-- Changed by Lomig
		-- f:SetAttribute("spell2", "Conjure Food")
		f:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[10].Name)

		-- Added By Lomig 12/12/06 13:03pm (GMT+1)
		f:SetAttribute("type3", "Trade");
		CryolysisFoodButton.Trade = function() Cryolysis_Trade_Food(); end
		-- End of adding
	end
end

function Cryolysis_UpdateEvocationAttributes()
	local f = _G["CryolysisEvocationButton"]
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type*", "spell")
		f:SetAttribute("spell", CRYOLYSIS_SPELL_TABLE[49].Name)
	end
end

function Cryolysis_UpdateRightSpellAttributes()
	local f = _G["CryolysisRightSpellButton"]
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type*", "spell")
		f:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[15].Name)
		f:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[20].Name)
	end
end