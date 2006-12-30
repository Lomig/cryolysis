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

------------------------------------------------------------------------------------------------------
-- FONCTION D'INITIALISATION
------------------------------------------------------------------------------------------------------
local _G = getfenv(0)

function Cryo_Init()

	-- Initilialisation des Textes (VO / VF / VA)
	if Cryo.db.profile ~= {} then
		if (Cryo.db.profile.CryolysisLanguage == "enUS") or (Cryo.db.profile.CryolysisLanguage == "enGB") then
			Cryolysis_Localization_Dialog_En();
		elseif (Cryo.db.profile.CryolysisLanguage == "deDE") then
			Cryolysis_Localization_Dialog_De();
		elseif (Cryo.db.profile.CryolysisLanguage == "frFR") then
			Cryolysis_Localization_Dialog_Fr();
		elseif (Cryo.db.profile.CryolysisLanguage == "zhCN") then
			Cryolysis_Localization_Dialog_Cn();
		else
			Cryolysis_Localization_Dialog_Tw();
		end
	elseif GetLocale() == "enUS" or GetLocale() == "enGB" then
		Cryolysis_Localization_Dialog_En();
	elseif GetLocale() == "deDE" then
		Cryolysis_Localization_Dialog_De();
	elseif GetLocale() == "frFR" then
		Cryolysis_Localization_Dialog_Fr();
	elseif GetLocale() == "zhCN" then
		Cryolysis_Localization_Dialog_Cn();
	else
		Cryolysis_Localization_Dialog_Tw();
	end


	-- On initialise ! Si le joueur n'est pas D�oniste, on cache Cryolysis (chuuuut !)
	-- On indique aussi que N�rosis est initialis�maintenant
	local _, class = UnitClass("player")
	if ( class ~= "MAGE" ) then
		HideUIPanel(CryolysisProvisionMenu);
		HideUIPanel(CryolysisSpellTimerButton);
		HideUIPanel(CryolysisButton);
		HideUIPanel(CryolysisPortalMenuButton);
		HideUIPanel(CryolysisBuffMenuButton);
		HideUIPanel(CryolysisMountButton);
		HideUIPanel(CryolysisFoodButton);
		HideUIPanel(CryolysisDrinkButton);
		HideUIPanel(CryolysisManaStoneButton);
		HideUIPanel(CryolysisEvocationButton);
		HideUIPanel(CryolysisLeftSpellButton);
		HideUIPanel(CryolysisRightSpellButton);
--		HideUIPanel(CryolysisAntiFearButton);
--		HideUIPanel(CryolysisConcentrationButton);
	else
		-- On charge (ou on cr�) la configuration pour le joueur et on l'affiche sur la console
--		if Cryo.db.profile.Version ~= Default_Cryo.db.profile.Version then
		--	Cryo.db.profile = {};
		--	Cryo.db.profile = Default_Cryo.db.profile;
--			if UnitLevel("player") < 40 then Cryo.db.profile.StonePosition[8] = false; end
--			Cryo:Msg(CRYOLYSIS_MESSAGE.Interface.DefaultConfig, "USER");

--			CryolysisButton:ClearAllPoints();
--			CryolysisConcentrationButton:ClearAllPoints();
--			CryolysisAntiFearButton:ClearAllPoints();
--			CryolysisSpellTimerButton:ClearAllPoints();
--			CryolysisButton:SetPoint("CENTER", "UIParent", "CENTER",0,-100);
--			CryolysisConcentrationButton:SetPoint("CENTER", "UIParent", "CENTER",100,-30);
--			CryolysisAntiFearButton:SetPoint("CENTER", "UIParent", "CENTER",100,30);
--			CryolysisSpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",120,340);

--		else
--			Cryo:Msg(CRYOLYSIS_MESSAGE.Interface.UserConfig, "USER");
--		end
		-----------------------------------------------------------
		-- Ex�ution des fonctions de d�arrage
		-----------------------------------------------------------

		-- Affichage d'un message sur la console
		Cryo:Msg(CRYOLYSIS_MESSAGE.Interface.Welcome, "USER");
		-- Cr�tion de la liste des sorts disponibles
		Cryo:SpellSetup();
		-- Cr�tion de la liste des emplacements des fragments
		Cryo:ProvisionSetup();
		-- Cr�tion des menus de buff et d'invocation
		Cryo:CreateMenu();

		-- Lecture de la configuration dans le SavedVariables.lua, �riture dans les variables d�inies


		if not CRYOLYSIS_SPELL_TABLE[25].ID then Cryo.db.profile.LeftSpell = 1; end
		if not CRYOLYSIS_SPELL_TABLE[15].ID then
			Cryo.db.profile.RightSpell = 2;
			if not CRYOLYSIS_SPELL_TABLE[2].ID then
				Cryo.db.profile.StonePosition[6] = false;
			end
		end
		----------------------------------------
		-- Inventory Menu Setup
		----------------------------------------
		if (Cryo.db.profile.ProvisionSort) then CryolysisProvisionSort_Button:SetChecked(1); end
		if (Cryo.db.profile.ProvisionDestroy) then CryolysisProvisionDestroy_Button:SetChecked(1); end
		if (Cryo.db.profile.Restock) then CryolysisRestock_Button:SetChecked(1); end
		if (Cryo.db.profile.RestockConfirm) then CryolysisRestockConfirm_Button:SetChecked(1); end

		CryolysisBag_Slider:SetValue(4 - Cryo.db.profile.ProvisionContainer);
		CryolysisBag_SliderLow:SetText("5");
		CryolysisBag_SliderHigh:SetText("1");

  		CryolysisTeleport_Slider:SetValue(Cryo.db.profile.RestockTeleport);
		CryolysisTeleport_SliderLow:SetText("");
		CryolysisTeleport_SliderHigh:SetText("");

  		CryolysisPortal_Slider:SetValue(Cryo.db.profile.RestockPortals);
		CryolysisPortal_SliderLow:SetText("");
		CryolysisPortal_SliderHigh:SetText("");

  		CryolysisPowder_Slider:SetValue(Cryo.db.profile.RestockPowder);
		CryolysisPowder_SliderLow:SetText("");
		CryolysisPowder_SliderHigh:SetText("");

  		CryolysisCountType_Slider:SetValue(Cryo.db.profile.CountType);
		CryolysisCountType_SliderLow:SetText("");
		CryolysisCountType_SliderHigh:SetText("");

		CryolysisButton_Slider:SetValue(Cryo.db.profile.Button);
		CryolysisButton_SliderLow:SetText("");
		CryolysisButton_SliderHigh:SetText("");

		CryolysisCircle_Slider:SetValue(Cryo.db.profile.Circle);
		CryolysisCircle_SliderLow:SetText("");
		CryolysisCircle_SliderHigh:SetText("");

		CryolysisDrink_Slider:SetValue(Cryo.db.profile.MPLimit);
		CryolysisDrink_SliderLow:SetText("0%");
		CryolysisDrink_SliderHigh:SetText("100%");

		CryolysisFood_Slider:SetValue(Cryo.db.profile.HPLimit);
		CryolysisFood_SliderLow:SetText("0%");
		CryolysisFood_SliderHigh:SetText("100%");

		CryolysisPolyWarn_Slider:SetValue(Cryo.db.profile.PolyWarnTime);
		CryolysisPolyWarn_SliderLow:SetText("");
		CryolysisPolyWarn_SliderHigh:SetText("");

  		----------------------------------------
		-- Message Menu Setup
		----------------------------------------

		if Cryo.db.profile.CryolysisLanguage == "frFR" then
			CryolysisLanguage_Slider:SetValue(1);
		elseif Cryo.db.profile.CryolysisLanguage == "enUS" then
			CryolysisLanguage_Slider:SetValue(2);
		elseif Cryo.db.profile.CryolysisLanguage == "deDE" then
			CryolysisLanguage_Slider:SetValue(3);
		elseif Cryo.db.profile.CryolysisLanguage == "zhTW" then
			CryolysisLanguage_Slider:SetValue(4);
		else
			CryolysisLanguage_Slider:SetValue(5);  --"zhCN"
		end
		CryolysisLanguage_SliderText:SetText("Langue / Language / Sprache / èªžè¨€ / è¯­è¨€");
		CryolysisLanguage_SliderLow:SetText("");
		CryolysisLanguage_SliderHigh:SetText("")

		if (Cryo.db.profile.CryolysisToolTip) then CryolysisShowTooltips_Button:SetChecked(1); end
		if (Cryo.db.profile.Sound) then CryolysisSound_Button:SetChecked(1); end
   		if (Cryo.db.profile.ChatMsg) then CryolysisShowMessage_Button:SetChecked(1); end
		if (Cryo.db.profile.QuickBuff) then CryolysisQuickBuff_Button:SetChecked(1); end
		if (Cryo.db.profile.PolyMessage) then CryolysisShowPolyMessage_Button:SetChecked(1); end
		if (Cryo.db.profile.PortalMessage) then CryolysisShowPortalMessage_Button:SetChecked(1); end
		if (Cryo.db.profile.SteedSummon) then CryolysisShowSteedSummon_Button:SetChecked(1); end
		if not (Cryo.db.profile.ChatType) then CryolysisChatType_Button:SetChecked(1); end
		if (Cryo.db.profile.PolyWarn) then CryolysisPolyWarn_Button:SetChecked(1); end
		if (Cryo.db.profile.PolyBreak) then CryolysisPolyBreak_Button:SetChecked(1); end
		if (Cryo.db.profile.SteedMessage) then CryolysisShowSteedMessage_Button:SetChecked(1); end


     	----------------------------------------
		-- Button Menu Setup
		----------------------------------------
		CryolysisShowButton_String:SetText(CRYOLYSIS_CONFIGURATION.Show.Text)
		CryolysisOnButton_String:SetText(CRYOLYSIS_CONFIGURATION.Text.Text)
		if (Cryo.db.profile.StonePosition[1]) then CryolysisShowFood_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[2]) then CryolysisShowDrink_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[3]) then CryolysisShowManaStone_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[4]) then CryolysisShowLeftSpell_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[5]) then CryolysisShowEvocation_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[6]) then CryolysisShowRightSpell_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[7]) then CryolysisShowBuffMenu_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[8]) then CryolysisShowMount_Button:SetChecked(1); end
		if (Cryo.db.profile.StonePosition[9]) then CryolysisShowPortalMenu_Button:SetChecked(1); end

		if (Cryo.db.profile.FoodCountText) then CryolysisFoodText_Button:SetChecked(1); end
		if (Cryo.db.profile.DrinkCountText) then CryolysisDrinkText_Button:SetChecked(1); end
		if (Cryo.db.profile.ManastoneCooldownText) then CryolysisManaStoneText_Button:SetChecked(1); end
		if (Cryo.db.profile.EvocationCooldownText) then CryolysisEvocationText_Button:SetChecked(1); end
		if (Cryo.db.profile.PowderCountText) then CryolysisPowderText_Button:SetChecked(1); end
		if (Cryo.db.profile.FeatherCountText) then CryolysisFeatherText_Button:SetChecked(1); end
		if (Cryo.db.profile.RuneCountText) then CryolysisRuneText_Button:SetChecked(1); end

		CryolysisLeftSpell_Slider:SetValue(Cryo.db.profile.LeftSpell);
		CryolysisLeftSpell_SliderLow:SetText("");
		CryolysisLeftSpell_SliderHigh:SetText("");

		CryolysisRightSpell_Slider:SetValue(Cryo.db.profile.RightSpell);
		CryolysisRightSpell_SliderLow:SetText("");
		CryolysisRightSpell_SliderHigh:SetText("");

		CryolysisManaStoneOrder_Slider:SetValue(Cryo.db.profile.ManaStoneOrder);
		CryolysisManaStoneOrder_SliderLow:SetText("Weakest");
		CryolysisManaStoneOrder_SliderHigh:SetText("Strongest");

		----------------------------------------
		-- Timer Menu Setup
		----------------------------------------
		CryolysisListSpells:ClearAllPoints();
		CryolysisListSpells:SetJustifyH(Cryo.db.profile.SpellTimerJust);
		CryolysisListSpells:SetPoint("TOP"..Cryo.db.profile.SpellTimerJust, "CryolysisSpellTimerButton", "CENTER", Cryo.db.profile.SpellTimerPos * 23, 5);
		ShowUIPanel(CryolysisButton);

		if Cryo.db.profile.SpellTimerJust == -23 then
			AnchorSpellTimerTooltip = "ANCHOR_LEFT";
		else
			AnchorSpellTimerTooltip = "ANCHOR_RIGHT";
		end


		if (Cryo.db.profile.ShowSpellTimers) then CryolysisShowSpellTimers_Button:SetChecked(1); end
		if (Cryo.db.profile.ShowSpellTimerButton) then CryolysisTimerButton_Button:SetChecked(1); end
		if (Cryo.db.profile.SpellTimerPos == -1) then CryolysisSTimer_Button:SetChecked(1); end
		if (Cryo.db.profile.Graphical) then CryolysisGraphicalTimer_Button:SetChecked(1); end
		if not (Cryo.db.profile.Yellow) then CryolysisTimerColor_Button:SetChecked(1); end
		if (Cryo.db.profile.SensListe == -1) then CryolysisTimerDirection_Button:SetChecked(1); end

		----------------------------------------
		-- Graphical Menu Setup
		----------------------------------------
--		if (Cryo.db.profile.AntiFearAlert) then CryolysisAntiFearAlert_Button:SetChecked(1); end
--		if (Cryo.db.profile.ConcentrationAlert) then CryolysisConcentrationAlert_Button:SetChecked(1); end
		if (Cryo.db.profile.CryolysisLockServ) then CryolysisIconsLock_Button:SetChecked(1); end
		if (Cryo.db.profile.ManaStoneMenuPos == -34) then CryolysisManaStoneMenu_Button:SetChecked(1); end
		if (Cryo.db.profile.BuffMenuPos == -34) then CryolysisBuffMenu_Button:SetChecked(1); end
		if (Cryo.db.profile.PortalMenuPos == -34) then CryolysisPortalMenu_Button:SetChecked(1); end
		if (Cryo.db.profile.NoDragAll) then CryolysisLock_Button:SetChecked(1); end

		CryolysisManaStoneMenuAnchor_Slider:SetValue(Cryo.db.profile.ManaStoneMenuAnchor);
		CryolysisManaStoneMenuAnchor_SliderLow:SetText("");
		CryolysisManaStoneMenuAnchor_SliderHigh:SetText("")

		CryolysisBuffMenuAnchor_Slider:SetValue(Cryo.db.profile.BuffMenuAnchor);
		CryolysisBuffMenuAnchor_SliderLow:SetText("");
		CryolysisBuffMenuAnchor_SliderHigh:SetText("")

		CryolysisPortalMenuAnchor_Slider:SetValue(Cryo.db.profile.PortalMenuAnchor);
		CryolysisPortalMenuAnchor_SliderLow:SetText("");
		CryolysisPortalMenuAnchor_SliderHigh:SetText("")

		CryolysisButtonRotate_Slider:SetValue(Cryo.db.profile.CryolysisAngle);
		CryolysisButtonRotate_SliderLow:SetText("0");
		CryolysisButtonRotate_SliderHigh:SetText("360");

		CryolysisButtonScale_Slider:SetValue(Cryo.db.profile.CryolysisButtonScale);
		CryolysisButtonScale_SliderLow:SetText("50 %");
		CryolysisButtonScale_SliderHigh:SetText("150 %");

		CryolysisStoneScale_Slider:SetValue(Cryo.db.profile.CryolysisStoneScale);
		CryolysisStoneScale_SliderLow:SetText("50 %");
		CryolysisStoneScale_SliderHigh:SetText("150 %");
		-- On r�le la taille de la pierre et des boutons suivant les r�lages du SavedVariables

		CryolysisButton:SetScale(Cryo.db.profile.CryolysisButtonScale/100)
		for i, v in ipairs(Cryo.db.profile.StoneLocation) do
			local f = _G[v]
			if ( f ) then
				f:SetScale(Cryo.db.profile.CryolysisButtonScale/100)
			end
		end

		if Cryo.db.profile.NoDragAll then
			Cryo:DragControl(false);
			CryolysisButton:RegisterForDrag("");
			CryolysisSpellTimerButton:RegisterForDrag("");
		else
			Cryo:DragControl(true);
			CryolysisButton:RegisterForDrag("LeftButton");
			CryolysisSpellTimerButton:RegisterForDrag("LeftButton");
		end
		-- On v�ifie que les fragments sont dans le sac d�ini par le D�oniste
		-- Cryo:ProvisionSwitch("CHECK");

		-- Le Shard est-il v�ouill�sur l'interface ?

		-- Les boutons sont-ils v�ouill� sur le Shard ?
		Cryo:ButtonSetup()
		Cryolysis_LanguageInitialize();
		if Cryo.db.profile.SM then
			CRYOLYSIS_EVOCATION_ALERT_MESSAGE = CRYOLYSIS_SHORT_MESSAGES[1];
			CRYOLYSIS_INVOCATION_MESSAGES = CRYOLYSIS_SHORT_MESSAGES[2];
		end
		-- Added by Lomig to replace the Toggle function
		Cryo:UpdateMainButtonAttributes();
		Cryolysis_UpdateMenuAnchor();


	end
end

function Cryolysis_LanguageInitialize()

	-- Localisation du speech.lua
	CryolysisLocalization();

	-- Localisation du XML
	CryolysisVersion:SetText(CryolysisData.Label);

	----------------------------------------
	-- Inventory Menu Dialog Setup
	----------------------------------------

	CryolysisProvisionSort_Option:SetText(CRYOLYSIS_CONFIGURATION.ProvisionMove);
	CryolysisProvisionDestroy_Option:SetText(CRYOLYSIS_CONFIGURATION.ProvisionDestroy);
	CryolysisButton_SliderText:SetText(CRYOLYSIS_CONFIGURATION.Button.Text);
	CryolysisCircle_SliderText:SetText(CRYOLYSIS_CONFIGURATION.Circle.Text);
	CryolysisRestock_Option:SetText(CRYOLYSIS_CONFIGURATION.Restock.Restock);
	CryolysisRestockConfirm_Option:SetText(CRYOLYSIS_CONFIGURATION.Restock.Confirm);
	CryolysisTeleport_SliderText:SetText(CRYOLYSIS_ITEM.RuneOfTeleportation);
    	CryolysisPortal_SliderText:SetText(CRYOLYSIS_ITEM.RuneOfPortals);
	CryolysisPowder_SliderText:SetText(CRYOLYSIS_ITEM.ArcanePowder);
	CryolysisCountType_SliderText:SetText(CRYOLYSIS_CONFIGURATION.CountType);
	CryolysisFood_SliderText:SetText(CRYOLYSIS_CONFIGURATION.Food);
	CryolysisBag_SliderText:SetText(CRYOLYSIS_CONFIGURATION.BagSelect);
	CryolysisButtonScale_SliderText:SetText(CRYOLYSIS_CONFIGURATION.CryolysisSize);
	CryolysisStoneScale_SliderText:SetText(CRYOLYSIS_CONFIGURATION.StoneScale)
	CryolysisDrink_SliderText:SetText(CRYOLYSIS_CONFIGURATION.Skin);



	----------------------------------------
	-- Message Menu Dialog Setup
	----------------------------------------

	CryolysisSound_Option:SetText(CRYOLYSIS_CONFIGURATION.Sound);
	CryolysisShowMessage_Option:SetText(CRYOLYSIS_CONFIGURATION.ShowMessage);
	CryolysisShowPolyMessage_Option:SetText(CRYOLYSIS_CONFIGURATION.ShowPolyMessage);
	CryolysisShowPortalMessage_Option:SetText(CRYOLYSIS_CONFIGURATION.ShowPortalMessage);
   	 CryolysisShowSteedMessage_Option:SetText(CRYOLYSIS_CONFIGURATION.ShowSteedMessage);
	CryolysisPolyWarn_Option:SetText(CRYOLYSIS_CONFIGURATION.Polymorph.Warn);
	CryolysisPolyBreak_Option:SetText(CRYOLYSIS_CONFIGURATION.Polymorph.Break);
	CryolysisChatType_Option:SetText(CRYOLYSIS_CONFIGURATION.ChatType);

	----------------------------------------
	-- Button Menu Dialog Setup
	----------------------------------------

	CryolysisShowFood_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Food);
	CryolysisShowDrink_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Drink);
	CryolysisShowManaStone_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Manastone);
	CryolysisShowLeftSpell_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.LeftSpell);
	CryolysisShowEvocation_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Evocation);
	CryolysisShowRightSpell_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.RightSpell);
	CryolysisShowMount_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Steed);
	CryolysisShowBuffMenu_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Buff);
	CryolysisShowPortalMenu_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Portal);
	CryolysisShowTooltips_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Tooltips);
	CryolysisQuickBuff_Option:SetText(CRYOLYSIS_CONFIGURATION.QuickBuff);

	CryolysisMessagePlayer_Section:SetText(CRYOLYSIS_CONFIGURATION.SpellMenu2);
    CryolysisManaStoneOrder_SliderText:SetText(CRYOLYSIS_CONFIGURATION.ManaStoneOrder);

	CryolysisFoodText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Food);
	CryolysisDrinkText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Drink);
	CryolysisManaStoneText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Manastone);
	CryolysisEvocationText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Evocation);
	CryolysisPowderText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Powder);
	CryolysisFeatherText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Feather);
	-- CryolysisRuneText_Option:SetText(CRYOLYSIS_CONFIGURATION.Text.Rune);

	----------------------------------------
	-- Timer Menu Dialog Setup
	----------------------------------------

	CryolysisShowSpellTimers_Option:SetText(CRYOLYSIS_CONFIGURATION.SpellTime);
	CryolysisTimerButton_Option:SetText(CRYOLYSIS_CONFIGURATION.Show.Spelltimer);
	CryolysisGraphicalTimer_Section:SetText(CRYOLYSIS_CONFIGURATION.TimerMenu);
	CryolysisGraphicalTimer_Option:SetText(CRYOLYSIS_CONFIGURATION.GraphicalTimer);
	CryolysisTimerColor_Option:SetText(CRYOLYSIS_CONFIGURATION.TimerColor);

	CryolysisTimerDirection_Option:SetText(CRYOLYSIS_CONFIGURATION.TimerDirection);

	----------------------------------------
	-- Graphical Menu Dialog Setup
	----------------------------------------

	CryolysisLock_Option:SetText(CRYOLYSIS_CONFIGURATION.MainLock);
	CryolysisManaStoneMenu_Option:SetText(CRYOLYSIS_CONFIGURATION.ManaStoneMenu)
	CryolysisBuffMenu_Option:SetText(CRYOLYSIS_CONFIGURATION.BuffMenu);
	CryolysisPortalMenu_Option:SetText(CRYOLYSIS_CONFIGURATION.PortalMenu);
	CryolysisSTimer_Option:SetText(CRYOLYSIS_CONFIGURATION.STimerLeft);
	CryolysisIconsLock_Option:SetText(CRYOLYSIS_CONFIGURATION.ButtonLock);
	CryolysisButtonRotate_SliderText:SetText(CRYOLYSIS_CONFIGURATION.MainRotation);
end

------------------------------------------------------------------------------------------------------
-- FONCTION GERANT LA COMMANDE CONSOLE /CRYO
------------------------------------------------------------------------------------------------------
function Cryolysis_SlashHandler(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
	local _, class = UnitClass("player")
	-- Blah blah blah, le joueur est-il bien un D�oniste ? On finira par le savoir !
	if ( class ~= "MAGE" ) then
		return;
	end
	if string.find(string.lower(arg1), "recall") then
		CryolysisButton:ClearAllPoints();
		CryolysisButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
		CryolysisSpellTimerButton:ClearAllPoints();
		CryolysisSpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
	elseif string.find(string.lower(arg1), "sm") then
		if CRYOLYSIS_Evocation_ALERT_MESSAGE == CRYOLYSIS_SHORT_MESSAGES[1] then
			Cryo.db.profile.SM = false;
			CryolysisLocalization();
			Cryo:Msg("Short Messages : <red>Off", "USER");
		else
			Cryo.db.profile.SM = true;
			CRYOLYSIS_Evocation_ALERT_MESSAGE = CRYOLYSIS_SHORT_MESSAGES[1];
			CRYOLYSIS_INVOCATION_MESSAGES = CRYOLYSIS_SHORT_MESSAGES[2];
			Cryo:Msg("Short Messages : <brightGreen>On", "USER");
		end
	elseif string.find(string.lower(arg1), "reset") then
		Cryo.db.profile.Version = "reboot"
		Cryolysis_Loaded = false
		Cryo:LoadVariables()
	elseif string.find(string.lower(arg1), "toggle") then
		if CryolysisButton:IsVisible() then
			HideUIPanel(CryolysisButton)
		else
			ShowUIPanel(CryolysisButton)
		end
	else
		if CRYOLYSIS_MESSAGE.Help ~= nil then
			for i = 1, #(CRYOLYSIS_MESSAGE.Help), 1 do
				Cryo:Msg(CRYOLYSIS_MESSAGE.Help[i], "USER");
			end
		end
		Cryo:ToggleOptions();
	end
end

function Cryolysis_UpdateMenuAnchor()

	-- Manastone Menu
	CryolysisManastoneButton:SetAttribute("*childraise*", true)

	CryolysisManastoneButton:SetAttribute("onmousedownbutton1", "down1")
	CryolysisManastoneButton:SetAttribute("onmousedownbutton2", "down2")
	CryolysisManastoneButton:SetAttribute("*anchorchild-down1", CryolysisManaStoneMenu0)
	CryolysisManastoneButton:SetAttribute("*anchorchild-down2", CryolysisManaStoneMenu0)

	CryolysisManastoneButton:SetAttribute("*childofsx-down1", 0)
	CryolysisManastoneButton:SetAttribute("*childofsy-down1", 0)
	CryolysisManastoneButton:SetAttribute("*childofsx-down2", 0)
	CryolysisManastoneButton:SetAttribute("*childofsy-down2", 0)
	CryolysisManastoneButton:SetAttribute("*childpoint-down1", "CENTER")
	CryolysisManastoneButton:SetAttribute("*childpoint-down2", "CENTER")
	CryolysisManastoneButton:SetAttribute("*childrelpoint-down1", "CENTER")
	CryolysisManastoneButton:SetAttribute("*childrelpoint-down2", "CENTER")

	CryolysisManastoneButton:SetAttribute("*childstate-down1", "^mousedown1")
	CryolysisManastoneButton:SetAttribute("*childstate-down2", "^mousedown2")
	CryolysisManastoneButton:SetAttribute("*childreparent-down1", "true")
	CryolysisManastoneButton:SetAttribute("*childreparent-down2", "true")

	CryolysisManaStoneMenu0:SetAttribute("state", 0)

	CryolysisManaStoneMenu0:SetAttribute("statemap-anchor-mousedown1", "0-1")
	CryolysisManaStoneMenu0:SetAttribute("statemap-anchor-mousedown2", "0-1")
	CryolysisManaStoneMenu0:SetAttribute("delaystatemap-anchor-mousedown1", "*:0")
	CryolysisManaStoneMenu0:SetAttribute("delaytimemap-anchor-mousedown1", "8")
	CryolysisManaStoneMenu0:SetAttribute("delayhovermap-anchor-mousedown1", "true")



	-- Buff Menu
	CryolysisBuffMenuButton:SetAttribute("*childraise*", true)

	CryolysisBuffMenuButton:SetAttribute("onmousedownbutton1", "down1")
	CryolysisBuffMenuButton:SetAttribute("onmousedownbutton2", "down2")
	CryolysisBuffMenuButton:SetAttribute("*anchorchild-down1", CryolysisBuffMenu0)
	CryolysisBuffMenuButton:SetAttribute("*anchorchild-down2", CryolysisBuffMenu0)

	CryolysisBuffMenuButton:SetAttribute("*childofsx-down1", 0)
	CryolysisBuffMenuButton:SetAttribute("*childofsy-down1", 0)
	CryolysisBuffMenuButton:SetAttribute("*childofsx-down2", 0)
	CryolysisBuffMenuButton:SetAttribute("*childofsy-down2", 0)
	CryolysisBuffMenuButton:SetAttribute("*childpoint-down1", "CENTER")
	CryolysisBuffMenuButton:SetAttribute("*childpoint-down2", "CENTER")
	CryolysisBuffMenuButton:SetAttribute("*childrelpoint-down1", "CENTER")
	CryolysisBuffMenuButton:SetAttribute("*childrelpoint-down2", "CENTER")

	CryolysisBuffMenuButton:SetAttribute("*childstate-down1", "^mousedown1")
	CryolysisBuffMenuButton:SetAttribute("*childstate-down2", "^mousedown2")
	CryolysisBuffMenuButton:SetAttribute("*childreparent-down1", "true")
	CryolysisBuffMenuButton:SetAttribute("*childreparent-down2", "true")

	CryolysisBuffMenu0:SetAttribute("state", 0)

	CryolysisBuffMenu0:SetAttribute("statemap-anchor-mousedown1", "0-1")
	CryolysisBuffMenu0:SetAttribute("statemap-anchor-mousedown2", "0-1")
	CryolysisBuffMenu0:SetAttribute("delaystatemap-anchor-mousedown1", "*:0")
	CryolysisBuffMenu0:SetAttribute("delaytimemap-anchor-mousedown1", "8")
	CryolysisBuffMenu0:SetAttribute("delayhovermap-anchor-mousedown1", "true")

	-- Portal Menu
	CryolysisPortalMenuButton:SetAttribute("*childraise*", true)

	CryolysisPortalMenuButton:SetAttribute("onmousedownbutton1", "down1")
	CryolysisPortalMenuButton:SetAttribute("onmousedownbutton2", "down2")
	CryolysisPortalMenuButton:SetAttribute("*anchorchild-down1", CryolysisPortalMenu0)
	CryolysisPortalMenuButton:SetAttribute("*anchorchild-down2", CryolysisPortalMenu0)

	CryolysisPortalMenuButton:SetAttribute("*childofsx-down1", 0)
	CryolysisPortalMenuButton:SetAttribute("*childofsy-down1", 0)
	CryolysisPortalMenuButton:SetAttribute("*childofsx-down2", 0)
	CryolysisPortalMenuButton:SetAttribute("*childofsy-down2", 0)
	CryolysisPortalMenuButton:SetAttribute("*childpoint-down1", "CENTER")
	CryolysisPortalMenuButton:SetAttribute("*childpoint-down2", "CENTER")
	CryolysisPortalMenuButton:SetAttribute("*childrelpoint-down1", "CENTER")
	CryolysisPortalMenuButton:SetAttribute("*childrelpoint-down2", "CENTER")

	CryolysisPortalMenuButton:SetAttribute("*childstate-down1", "^mousedown1")
	CryolysisPortalMenuButton:SetAttribute("*childstate-down2", "^mousedown2")
	CryolysisPortalMenuButton:SetAttribute("*childreparent-down1", "true")
	CryolysisPortalMenuButton:SetAttribute("*childreparent-down2", "true")

	CryolysisPortalMenu0:SetAttribute("state", 0)

	CryolysisPortalMenu0:SetAttribute("statemap-anchor-mousedown1", "0-1")
	CryolysisPortalMenu0:SetAttribute("statemap-anchor-mousedown2", "0-1")
	CryolysisPortalMenu0:SetAttribute("delaystatemap-anchor-mousedown1", "*:0")
	CryolysisPortalMenu0:SetAttribute("delaytimemap-anchor-mousedown1", "8")
	CryolysisPortalMenu0:SetAttribute("delayhovermap-anchor-mousedown1", "true")

end

Cryolysis_UpdateRevisions("CryolysisInitialize.lua", "$Rev$")