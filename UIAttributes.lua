--[[
    Cryolysis
    Copyright (C) 2006 Cryolysis: Reborn Team

    This file is part of Cryolysis.

    Cryolysis is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Cryolysis is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Cryolysis; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Cryolysis: Reborn Team (Alphabetically sorted)
        - Eternally777
	- Lom Enfroy
	- Thomas Hart II
--]]


------------------------------------------------------------------------------------------------------
-- Cryolysis
--
-- Copyright (c) 2006 Cryolysis: Reborn Team
-- Copyright (c) 2006 Kaeldra (darklyte@gmail.com)
-- Copyright (c) 2005-2006 Lom Enfroy
--
-- Skins: Eliah, Ner'zhul FR
--
--
-- Version 12.12.2006
------------------------------------------------------------------------------------------------------
local _G = getfenv(0)

function Cryolysis_UpdateDrinkButtonAttributes()
	local f = _G["CryolysisDrinkButton"]
	assert(f, "Error: Drink button not created or named properly!")
	if ( not InCombatLockdown() ) then
		f:SetAttribute("type1", "item")
		local highestWaterName = GetItemInfo(Cryo.db.char.highestWaterId)
		if ( highestWaterName ) then
			f:SetAttribute("item1", highestWaterName)
		end

		f:SetAttribute("type2", "spell")
		-- Changed by Lomig
		-- f:SetAttribute("spell2", "Conjure Water")
		f:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[11].Name)

		-- Added By Lomig 12/12/06 12:51pm (GMT+1)
		f:SetAttribute("type3", "Trade");
		f.Trade = function() Cryo:Trade("Drink"); end
		-- End of adding
		if not CryolysisAlreadyBind["CryolysisDrinkButton"] then
			CryolysisAlreadyBind["CryolysisDrinkButton"] = true;
			table.insert(CryolysisBinding, {"Use Water", "CLICK CryolysisDrinkButton:LeftButton"});
			table.insert(CryolysisBinding, {CRYOLYSIS_SPELL_TABLE[11].Name, "CLICK CryolysisDrinkButton:RightButton"});
			table.insert(CryolysisBinding, {"Trade Water", "CLICK CryolysisDrinkButton:MiddleButton"});
		end
	end
end

function Cryolysis_UpdateFoodButtonAttributes()
	local f = _G["CryolysisFoodButton"]
	assert(f, "Error: Food button not created or named properly!")
	if ( not InCombatLockdown() ) then
		f:SetAttribute("type1", "item")
		local highestFoodName = GetItemInfo(Cryo.db.char.highestFoodId)
		if ( highestFoodName ) then
			f:SetAttribute("item1", highestFoodName)
		end

		f:SetAttribute("type2", "spell")
		-- Changed by Lomig
		-- f:SetAttribute("spell2", "Conjure Food")
		f:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[10].Name)

		-- Added By Lomig 12/12/06 13:03pm (GMT+1)
		f:SetAttribute("type3", "Trade");
		CryolysisFoodButton.Trade = function() Cryo:Trade("Food"); end
		-- End of adding
		if not CryolysisAlreadyBind["CryolysisFoodButton"] then
			CryolysisAlreadyBind["CryolysisFoodButton"] = true;
			table.insert(CryolysisBinding, {"Use Food", "CLICK CryolysisFoodButton:LeftButton"});
			table.insert(CryolysisBinding, {CRYOLYSIS_SPELL_TABLE[10].Name, "CLICK CryolysisFoodButton:RightButton"});
			table.insert(CryolysisBinding, {"Trade Food", "CLICK CryolysisFoodButton:MiddleButton"});
		end
	end
end

function Cryolysis_UpdateLeftSpellAttributes()
	local spellLeft = {22, 4, 13, 23, 15, 50, 33, 35};
	local spellRight = {24, 2, 1, 25, 20, 50, 33, 35};
	local spellName1, spellName2 = nil, nil
	if CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.LeftSpell] ].ID then
		spellName1 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.LeftSpell] ].ID, "spell");
	elseif CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.LeftSpell] ].ID then
		spellName1 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.LeftSpell] ].ID, "spell");
	end
	if CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.LeftSpell] ].ID then
		spellName2 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.LeftSpell] ].ID, "spell");
	elseif CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.LeftSpell] ].ID then
		spellName2 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.LeftSpell] ].ID, "spell");
	end

	local f = _G["CryolysisLeftSpellButton"]
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type*", "spell")
		if spellName1 then f:SetAttribute("spell1", spellName1) else f:SetAttribute("spell1", nil) end
		if spellName2 then f:SetAttribute("spell2", spellName2) else f:SetAttribute("spell2", nil) end
	end
	if not CryolysisAlreadyBind["CryolysisLeftSpellButton"] then
		CryolysisAlreadyBind["CryolysisLeftSpellButton"] = true;
		table.insert(CryolysisBinding, {"Left Spell Menu (left clicked)", "CLICK CryolysisLeftSpellButton:LeftButton"});
		table.insert(CryolysisBinding, {"Left Spell Menu (right clicked)", "CLICK CryolysisLeftSpellButton:RightButton"});
	end
end

function Cryolysis_UpdateEvocationAttributes()
	local f = _G["CryolysisEvocationButton"]
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type*", "spell")
		f:SetAttribute("spell", CRYOLYSIS_SPELL_TABLE[49].Name)
		if not CryolysisAlreadyBind["CryolysisEvocationButton"] then
			CryolysisAlreadyBind["CryolysisEvocationButton"] = true;
			table.insert(CryolysisBinding, {CRYOLYSIS_SPELL_TABLE[49].Name, "CLICK CryolysisEvocationButton:LeftButton"});
		end
	end
end

function Cryolysis_UpdateRightSpellAttributes()
	local spellLeft = {22, 4, 13, 23, 15, 50, 33, 35};
	local spellRight = {24, 2, 1, 25, 20, 50, 33, 35};
	local spellName1, spellName2 = nil, nil
	if CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.RightSpell] ].ID then
		spellName1 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.RightSpell] ].ID, "spell");
	elseif CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.RightSpell] ].ID then
		spellName1 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.RightSpell] ].ID, "spell");
	end
	if CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.RightSpell] ].ID then
		spellName2 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellRight[Cryo.db.profile.RightSpell] ].ID, "spell");
	elseif CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.RightSpell] ].ID then
		spellName2 = GetSpellName(CRYOLYSIS_SPELL_TABLE[ spellLeft[Cryo.db.profile.RightSpell] ].ID, "spell");
	end

	local f = _G["CryolysisRightSpellButton"]
	if ( not InCombatLockdown() ) then
		f:SetAttribute("*type*", "spell")
		if spellName1 then f:SetAttribute("spell1", spellName1) else f:SetAttribute("spell1", nil) end
		if spellName2 then f:SetAttribute("spell2", spellName2) else f:SetAttribute("spell2", nil) end
	end
	if not CryolysisAlreadyBind["CryolysisRightSpellButton"] then
		CryolysisAlreadyBind["CryolysisRightSpellButton"] = true;
		table.insert(CryolysisBinding, {"Right Spell Menu (left clicked)", "CLICK CryolysisRightSpellButton:LeftButton"});
		table.insert(CryolysisBinding, {"Right Spell Menu (right clicked)", "CLICK CryolysisRightSpellButton:RightButton"});
	end
end

local buffButtonAttr = { "22 24", "4 2", "13 1", "23 25", "15 20", 50, 33, 35 }
function Cryolysis_UpdateBuffButtonAttributes()
	if ( InCombatLockdown() ) then
		return
	end
	for i = 1, 5, 1 do
		local f = _G["CryolysisBuffMenu"..i]
		local spellOne, spellTwo = strsplit(" ", buffButtonAttr[i])

		f:SetAttribute("*type*", "spell")
		f:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[tonumber(spellOne)].Name)
		f:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[tonumber(spellTwo)].Name)
		if not CryolysisAlreadyBind["CryolysisBuffMenu"..i] then
			CryolysisAlreadyBind["CryolysisBuffMenu"..i] = true;
			table.insert(CryolysisBinding2, {CRYOLYSIS_SPELL_TABLE[tonumber(spellOne)].Name, "CLICK CryolysisBuffMenu"..i..":LeftButton"});
			table.insert(CryolysisBinding2, {CRYOLYSIS_SPELL_TABLE[tonumber(spellTwo)].Name, "CLICK CryolysisBuffMenu"..i..":RightButton"});
		end
	end
	for i = 6, 8, 1 do
		local f = _G["CryolysisBuffMenu"..i]
		f:SetAttribute("*type*", "spell")
		f:SetAttribute("spell", CRYOLYSIS_SPELL_TABLE[ buffButtonAttr[i] ].Name)
		if not CryolysisAlreadyBind["CryolysisBuffMenu"..i] then
			CryolysisAlreadyBind["CryolysisBuffMenu"..i] = true;
			table.insert(CryolysisBinding2, {CRYOLYSIS_SPELL_TABLE[ buffButtonAttr[i] ].Name, "CLICK CryolysisBuffMenu"..i..":LeftButton"});
		end
	end
end

function Cryolysis_UpdatePortalButtonAttributes(PortalTempID)
	if ( InCombatLockdown() ) then
		return
	end
	for i=1, 12, 1 do
		local f = _G["CryolysisPortalMenu"..i];
		f:SetAttribute("*type*", "spell");
		if CRYOLYSIS_SPELL_TABLE[ PortalTempID[i] ].ID then
			f:SetAttribute("spell", CRYOLYSIS_SPELL_TABLE[ PortalTempID[i] ].Name);
		end
		if not CryolysisAlreadyBind["CryolysisPortalMenu"..i] then
			CryolysisAlreadyBind["CryolysisPortalMenu"..i] = true;
			table.insert(CryolysisBinding2, {CRYOLYSIS_SPELL_TABLE[ PortalTempID[i] ].Name, "CLICK CryolysisPortalMenu"..i..":LeftButton"});
		end

	end
end

function Cryolysis_UpdateMountButton(MountName, MountType)
	if ( InCombatLockdown() ) then
		return
	end
	if MountType == "Normal" then
		CryolysisMountButton:SetAttribute("type1", "item");
		CryolysisMountButton:SetAttribute("item1", MountName);
	else
		CryolysisMountButton:SetAttribute("type1", "item");
		CryolysisMountButton:SetAttribute("item1", MountName);
	end
	if not CryolysisAlreadyBind["CryolysisMountButton"] then
		CryolysisAlreadyBind["CryolysisMountButton"] = true;
		table.insert(CryolysisBinding, {MountName, "CLICK CryolysisMountButton:LeftButton"});
	end
end

function Cryolysis_UpdateManaStoneButtonAttributes(Manastone, item)
	if ( InCombatLockdown() ) then
		return
	end
	for i=1, 4, 1 do
		local f = _G["CryolysisManaStoneMenu"..i];
		f:SetAttribute("type1", "item");
		f:SetAttribute("type2", "spell");
		if Manastone.RankID[i] then
			local spellName = GetSpellName(Manastone.RankID[i], "spell");
			f:SetAttribute("item1", CRYOLYSIS_STONE_RANK2[i]);
			f:SetAttribute("spell2", spellName);
			if not CryolysisAlreadyBind["CryolysisManaStoneMenu"..i] then
				CryolysisAlreadyBind["CryolysisManaStoneMenu"..i] = true;
				table.insert(CryolysisBinding2, {CRYOLYSIS_STONE_RANK2[i], "CLICK CryolysisManaStoneMenu"..i..":LeftButton"});
				table.insert(CryolysisBinding2, {spellName, "CLICK CryolysisManaStoneMenu"..i..":RightButton"});
			end
		end
	end
end

function Cryolysis_InitMenuButton(f, texture, spell, anchor)
	_G[f:GetName().."Icon"]:SetTexture("Interface\\Icons\\"..texture)
	local t = f:GetHighlightTexture()
	t:SetVertexColor( 75/255, 216/255, 241/255 )
	f:SetHighlightTexture(t)
	f.spell = spell
	f.anchor = anchor
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f:Hide()
end

Cryolysis_UpdateRevisions("UIAttributes.lua", "$Rev$")