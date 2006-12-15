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

function Cryolysis_Initialize()

	-- Initilialisation des Textes (VO / VF / VA)
	if CryolysisConfig ~= {} then
		if (CryolysisConfig.CryolysisLanguage == "enUS") or (CryolysisConfig.CryolysisLanguage == "enGB") then
			Cryolysis_Localization_Dialog_En();
		elseif (CryolysisConfig.CryolysisLanguage == "deDE") then
			Cryolysis_Localization_Dialog_De();
		elseif (CryolysisConfig.CryolysisLanguage == "frFR") then
			Cryolysis_Localization_Dialog_Fr();
		elseif (CryolysisConfig.CryolysisLanguage == "zhCN") then
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
	if UnitClass("player") ~= CRYOLYSIS_UNIT_MAGE then
		HideUIPanel(CryolysisProvisionMenu);
		HideUIPanel(CryolysisSpellTimerButton);
		HideUIPanel(CryolysisButton);
		HideUIPanel(CryolysisPortalMenuButton);
		HideUIPanel(CryolysisBuffMenuButton);
		HideUIPanel(CryolysisMountButton);
		HideUIPanel(CryolysisFoodButton);
		HideUIPanel(CryolysisDrinkButton);
		HideUIPanel(CryolysisManastoneButton);
		HideUIPanel(CryolysisEvocationButton);
		HideUIPanel(CryolysisLeftSpellButton);
		HideUIPanel(CryolysisRightSpellButton);
--		HideUIPanel(CryolysisAntiFearButton);
--		HideUIPanel(CryolysisConcentrationButton);
	else
		-- On charge (ou on cr�) la configuration pour le joueur et on l'affiche sur la console
		if CryolysisConfig == nil or CryolysisConfig.Version ~= Default_CryolysisConfig.Version then
			CryolysisConfig = {};
			CryolysisConfig = Default_CryolysisConfig;
--			if UnitLevel("player") < 40 then CryolysisConfig.StonePosition[8] = false; end
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Interface.DefaultConfig, "USER");

			CryolysisButton:ClearAllPoints();
--			CryolysisConcentrationButton:ClearAllPoints();
--			CryolysisAntiFearButton:ClearAllPoints();
			CryolysisSpellTimerButton:ClearAllPoints();
			CryolysisButton:SetPoint("CENTER", "UIParent", "CENTER",0,-100);
--			CryolysisConcentrationButton:SetPoint("CENTER", "UIParent", "CENTER",100,-30);
--			CryolysisAntiFearButton:SetPoint("CENTER", "UIParent", "CENTER",100,30);
			CryolysisSpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",120,340);

		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Interface.UserConfig, "USER");
		end
		-----------------------------------------------------------
		-- Ex�ution des fonctions de d�arrage
		-----------------------------------------------------------

		-- Affichage d'un message sur la console
		Cryolysis_Msg(CRYOLYSIS_MESSAGE.Interface.Welcome, "USER");
		-- Cr�tion de la liste des sorts disponibles
		Cryolysis_SpellSetup();
		-- Cr�tion de la liste des emplacements des fragments
		Cryolysis_ProvisionSetup();
		-- Cr�tion des menus de buff et d'invocation
		Cryolysis_CreateMenu();

		-- Lecture de la configuration dans le SavedVariables.lua, �riture dans les variables d�inies


		if not CRYOLYSIS_SPELL_TABLE[25].ID then CryolysisConfig.LeftSpell = 1; end
		if not CRYOLYSIS_SPELL_TABLE[15].ID then
			CryolysisConfig.RightSpell = 2;
			if not CRYOLYSIS_SPELL_TABLE[2].ID then
				CryolysisConfig.StonePosition[6] = false;
			end
		end
		----------------------------------------
		-- Inventory Menu Setup
		----------------------------------------
		if (CryolysisConfig.ProvisionSort) then CryolysisProvisionSort_Button:SetChecked(1); end
		if (CryolysisConfig.ProvisionDestroy) then CryolysisProvisionDestroy_Button:SetChecked(1); end
		if (CryolysisConfig.Restock) then CryolysisRestock_Button:SetChecked(1); end
		if (CryolysisConfig.RestockConfirm) then CryolysisRestockConfirm_Button:SetChecked(1); end

		CryolysisBag_Slider:SetValue(4 - CryolysisConfig.ProvisionContainer);
		CryolysisBag_SliderLow:SetText("5");
		CryolysisBag_SliderHigh:SetText("1");

  		CryolysisTeleport_Slider:SetValue(CryolysisConfig.RestockTeleport);
		CryolysisTeleport_SliderLow:SetText("");
		CryolysisTeleport_SliderHigh:SetText("");

  		CryolysisPortal_Slider:SetValue(CryolysisConfig.RestockPortals);
		CryolysisPortal_SliderLow:SetText("");
		CryolysisPortal_SliderHigh:SetText("");

  		CryolysisPowder_Slider:SetValue(CryolysisConfig.RestockPowder);
		CryolysisPowder_SliderLow:SetText("");
		CryolysisPowder_SliderHigh:SetText("");

  		CryolysisCountType_Slider:SetValue(CryolysisConfig.CountType);
		CryolysisCountType_SliderLow:SetText("");
		CryolysisCountType_SliderHigh:SetText("");

		CryolysisButton_Slider:SetValue(CryolysisConfig.Button);
		CryolysisButton_SliderLow:SetText("");
		CryolysisButton_SliderHigh:SetText("");

		CryolysisCircle_Slider:SetValue(CryolysisConfig.Circle);
		CryolysisCircle_SliderLow:SetText("");
		CryolysisCircle_SliderHigh:SetText("");

		CryolysisDrink_Slider:SetValue(CryolysisConfig.MPLimit);
		CryolysisDrink_SliderLow:SetText("0%");
		CryolysisDrink_SliderHigh:SetText("100%");

		CryolysisFood_Slider:SetValue(CryolysisConfig.HPLimit);
		CryolysisFood_SliderLow:SetText("0%");
		CryolysisFood_SliderHigh:SetText("100%");

		CryolysisPolyWarn_Slider:SetValue(CryolysisConfig.PolyWarnTime);
		CryolysisPolyWarn_SliderLow:SetText("");
		CryolysisPolyWarn_SliderHigh:SetText("");

  		----------------------------------------
		-- Message Menu Setup
		----------------------------------------

		if (CryolysisConfig.CryolysisToolTip) then CryolysisShowTooltips_Button:SetChecked(1); end
		if (CryolysisConfig.Sound) then CryolysisSound_Button:SetChecked(1); end
   		if (CryolysisConfig.ChatMsg) then CryolysisShowMessage_Button:SetChecked(1); end
		if (CryolysisConfig.QuickBuff) then CryolysisQuickBuff_Button:SetChecked(1); end
		if (CryolysisConfig.PolyMessage) then CryolysisShowPolyMessage_Button:SetChecked(1); end
		if (CryolysisConfig.PortalMessage) then CryolysisShowPortalMessage_Button:SetChecked(1); end
		if (CryolysisConfig.SteedSummon) then CryolysisShowSteedSummon_Button:SetChecked(1); end
		if not (CryolysisConfig.ChatType) then CryolysisChatType_Button:SetChecked(1); end
		if (CryolysisConfig.PolyWarn) then CryolysisPolyWarn_Button:SetChecked(1); end
		if (CryolysisConfig.PolyBreak) then CryolysisPolyBreak_Button:SetChecked(1); end
		if (CryolysisConfig.SteedMessage) then CryolysisShowSteedMessage_Button:SetChecked(1); end


     	----------------------------------------
		-- Button Menu Setup
		----------------------------------------
		CryolysisShowButton_String:SetText(CRYOLYSIS_CONFIGURATION.Show.Text)
		CryolysisOnButton_String:SetText(CRYOLYSIS_CONFIGURATION.Text.Text)
		if (CryolysisConfig.StonePosition[1]) then CryolysisShowFood_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[2]) then CryolysisShowDrink_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[3]) then CryolysisShowManaStone_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[4]) then CryolysisShowLeftSpell_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[5]) then CryolysisShowEvocation_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[6]) then CryolysisShowRightSpell_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[7]) then CryolysisShowBuffMenu_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[8]) then CryolysisShowMount_Button:SetChecked(1); end
		if (CryolysisConfig.StonePosition[9]) then CryolysisShowPortalMenu_Button:SetChecked(1); end

		if (CryolysisConfig.FoodCountText) then CryolysisFoodText_Button:SetChecked(1); end
		if (CryolysisConfig.DrinkCountText) then CryolysisDrinkText_Button:SetChecked(1); end
		if (CryolysisConfig.ManastoneCooldownText) then CryolysisManaStoneText_Button:SetChecked(1); end
		if (CryolysisConfig.EvocationCooldownText) then CryolysisEvocationText_Button:SetChecked(1); end
		if (CryolysisConfig.PowderCountText) then CryolysisPowderText_Button:SetChecked(1); end
		if (CryolysisConfig.FeatherCountText) then CryolysisFeatherText_Button:SetChecked(1); end
		if (CryolysisConfig.RuneCountText) then CryolysisRuneText_Button:SetChecked(1); end

		CryolysisLeftSpell_Slider:SetValue(CryolysisConfig.LeftSpell);
		CryolysisLeftSpell_SliderLow:SetText("");
		CryolysisLeftSpell_SliderHigh:SetText("");

		CryolysisRightSpell_Slider:SetValue(CryolysisConfig.RightSpell);
		CryolysisRightSpell_SliderLow:SetText("");
		CryolysisRightSpell_SliderHigh:SetText("");

		CryolysisManaStoneOrder_Slider:SetValue(CryolysisConfig.ManaStoneOrder);
		CryolysisManaStoneOrder_SliderLow:SetText("Weakest");
		CryolysisManaStoneOrder_SliderHigh:SetText("Strongest");

		----------------------------------------
		-- Timer Menu Setup
		----------------------------------------
		CryolysisListSpells:ClearAllPoints();
		CryolysisListSpells:SetJustifyH(CryolysisConfig.SpellTimerJust);
		CryolysisListSpells:SetPoint("TOP"..CryolysisConfig.SpellTimerJust, "CryolysisSpellTimerButton", "CENTER", CryolysisConfig.SpellTimerPos * 23, 5);
		ShowUIPanel(CryolysisButton);

		if CryolysisConfig.SpellTimerJust == -23 then
			AnchorSpellTimerTooltip = "ANCHOR_LEFT";
		else
			AnchorSpellTimerTooltip = "ANCHOR_RIGHT";
		end


		if (CryolysisConfig.ShowSpellTimers) then CryolysisShowSpellTimers_Button:SetChecked(1); end
		if (CryolysisConfig.ShowSpellTimerButton) then CryolysisTimerButton_Button:SetChecked(1); end
		if (CryolysisConfig.SpellTimerPos == -1) then CryolysisSTimer_Button:SetChecked(1); end
		if (CryolysisConfig.Graphical) then CryolysisGraphicalTimer_Button:SetChecked(1); end
		if not (CryolysisConfig.Yellow) then CryolysisTimerColor_Button:SetChecked(1); end
		if (CryolysisConfig.SensListe == -1) then CryolysisTimerDirection_Button:SetChecked(1); end

		----------------------------------------
		-- Graphical Menu Setup
		----------------------------------------
--		if (CryolysisConfig.AntiFearAlert) then CryolysisAntiFearAlert_Button:SetChecked(1); end
--		if (CryolysisConfig.ConcentrationAlert) then CryolysisConcentrationAlert_Button:SetChecked(1); end
		if (CryolysisConfig.CryolysisLockServ) then CryolysisIconsLock_Button:SetChecked(1); end
		if (CryolysisConfig.ManaStoneMenuPos == -34) then CryolysisManaStoneMenu_Button:SetChecked(1); end
		if (CryolysisConfig.BuffMenuPos == -34) then CryolysisBuffMenu_Button:SetChecked(1); end
		if (CryolysisConfig.PortalMenuPos == -34) then CryolysisPortalMenu_Button:SetChecked(1); end
		if (CryolysisConfig.NoDragAll) then CryolysisLock_Button:SetChecked(1); end
		
		CryolysisManaStoneMenuAnchor_Slider:SetValue(CryolysisConfig.ManaStoneMenuAnchor);
		CryolysisManaStoneMenuAnchor_SliderLow:SetText("");
		CryolysisManaStoneMenuAnchor_SliderHigh:SetText("")
		
		CryolysisBuffMenuAnchor_Slider:SetValue(CryolysisConfig.BuffMenuAnchor);
		CryolysisBuffMenuAnchor_SliderLow:SetText("");
		CryolysisBuffMenuAnchor_SliderHigh:SetText("")

		CryolysisPortalMenuAnchor_Slider:SetValue(CryolysisConfig.PortalMenuAnchor);
		CryolysisPortalMenuAnchor_SliderLow:SetText("");
		CryolysisPortalMenuAnchor_SliderHigh:SetText("")

		CryolysisButtonRotate_Slider:SetValue(CryolysisConfig.CryolysisAngle);
		CryolysisButtonRotate_SliderLow:SetText("0");
		CryolysisButtonRotate_SliderHigh:SetText("360");

		CryolysisButtonScale_Slider:SetValue(CryolysisConfig.CryolysisButtonScale);
		CryolysisButtonScale_SliderLow:SetText("50 %");
		CryolysisButtonScale_SliderHigh:SetText("150 %");

		CryolysisStoneScale_Slider:SetValue(CryolysisConfig.CryolysisStoneScale);
		CryolysisStoneScale_SliderLow:SetText("50 %");
		CryolysisStoneScale_SliderHigh:SetText("150 %");
		-- On r�le la taille de la pierre et des boutons suivant les r�lages du SavedVariables
		
		CryolysisButton:SetScale(CryolysisConfig.CryolysisButtonScale/100)
		for i, v in ipairs(CryolysisConfig.StoneLocation) do
			_G[v]:SetScale(CryolysisConfig.CryolysisButtonScale/100)
		end
		
		if CryolysisConfig.NoDragAll then
			Cryolysis_NoDrag();
			CryolysisButton:RegisterForDrag("");
			CryolysisSpellTimerButton:RegisterForDrag("");
		else
			Cryolysis_Drag();
			CryolysisButton:RegisterForDrag("LeftButton");
			CryolysisSpellTimerButton:RegisterForDrag("LeftButton");
		end
		-- On v�ifie que les fragments sont dans le sac d�ini par le D�oniste
		-- Cryolysis_ProvisionSwitch("CHECK");

		-- Le Shard est-il v�ouill�sur l'interface ?

		-- Les boutons sont-ils v�ouill� sur le Shard ?
		Cryolysis_ButtonSetup();
		Cryolysis_LanguageInitialize();
		if CryolysisConfig.SM then
			CRYOLYSIS_EVOCATION_ALERT_MESSAGE = CRYOLYSIS_SHORT_MESSAGES[1];
			CRYOLYSIS_INVOCATION_MESSAGES = CRYOLYSIS_SHORT_MESSAGES[2];
		end
		-- Added by Lomig to replace the Toggle function
		Cryolysis_UpdateMainButtonAttributes();
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
	-- Blah blah blah, le joueur est-il bien un D�oniste ? On finira par le savoir !
	if UnitClass("player") ~= CRYOLYSIS_UNIT_MAGE then
		return;
	end
	if string.find(string.lower(arg1), "recall") then
		CryolysisButton:ClearAllPoints();
		CryolysisButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
		CryolysisSpellTimerButton:ClearAllPoints();
		CryolysisSpellTimerButton:SetPoint("CENTER", "UIParent", "CENTER",0,0);
	elseif string.find(string.lower(arg1), "sm") then
		if CRYOLYSIS_Evocation_ALERT_MESSAGE == CRYOLYSIS_SHORT_MESSAGES[1] then
			CryolysisConfig.SM = false;
			CryolysisLocalization();
			Cryolysis_Msg("Short Messages : <red>Off", "USER");
		else
			CryolysisConfig.SM = true;
			CRYOLYSIS_Evocation_ALERT_MESSAGE = CRYOLYSIS_SHORT_MESSAGES[1];
			CRYOLYSIS_INVOCATION_MESSAGES = CRYOLYSIS_SHORT_MESSAGES[2];
			Cryolysis_Msg("Short Messages : <brightGreen>On", "USER");
		end
	elseif string.find(string.lower(arg1), "reset") then
		CryolysisConfig.Version = "reboot";
		Cryolysis_Loaded = false;
		Cryolysis_LoadVariables();
	elseif string.find(string.lower(arg1), "toggle") then
		if CryolysisButton:IsVisible() then
			HideUIPanel(CryolysisButton)
		else
			ShowUIPanel(CryolysisButton)
		end
	else
		if CRYOLYSIS_MESSAGE.Help ~= nil then
			for i = 1, #(CRYOLYSIS_MESSAGE.Help), 1 do
				Cryolysis_Msg(CRYOLYSIS_MESSAGE.Help[i], "USER");
			end
		end
		Cryolysis_Toggle();
	end
end

function Cryolysis_UpdateMenuAnchor()

	-- Manastone Menu
	CryolysisManastoneButton:SetAttribute("*childraise*", true);

	CryolysisManaStoneMenu0:SetAttribute("statemap-anchor", "$input");
	CryolysisManaStoneMenu0:SetAttribute("delaystatemap-anchor", "0");
	CryolysisManaStoneMenu0:SetAttribute("delaytimemap-anchor", "8");
	CryolysisManaStoneMenu0:SetAttribute("delayhovermap-anchor", "true");

	CryolysisManastoneButton:SetAttribute("onmouseupbutton", "mup");
	CryolysisManastoneButton:SetAttribute("onmousedownbutton", "mdn");
	CryolysisManastoneButton:SetAttribute("*anchorchild-mdn", CryolysisManaStoneMenu0);
	CryolysisManastoneButton:SetAttribute("*childofsx-mdn", 0);
	CryolysisManastoneButton:SetAttribute("*childofsy-mdn", 0);
	CryolysisManastoneButton:SetAttribute("*childpoint-mdn", "CENTER");
	CryolysisManastoneButton:SetAttribute("*childrelpoint-mdn", "CENTER");
	CryolysisManastoneButton:SetAttribute("*childstate-mdn", "^mousedown");
	CryolysisManastoneButton:SetAttribute("*childreparent-mdn", "true");

	CryolysisManastoneButton:SetAttribute("*anchorchild-mup", CryolysisManaStoneMenu0);
	CryolysisManastoneButton:SetAttribute("*childstate-mup", "mouseup");
	CryolysisManastoneButton:SetAttribute("*childverify-mup", true);

	CryolysisManaStoneMenu0:SetAttribute("state", 0)

	CryolysisManaStoneMenu0:SetAttribute("statemap-anchor-mousedown", "1-0");
	CryolysisManaStoneMenu0:SetAttribute("statemap-anchor-mouseup", "!0:");
	CryolysisManaStoneMenu0:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
	CryolysisManaStoneMenu0:SetAttribute("delaytimemap-anchor-mouseup", "8");
	CryolysisManaStoneMenu0:SetAttribute("delayhovermap-anchor-mouseup", "true");

	-- Buff Menu
	CryolysisBuffMenuButton:SetAttribute("*childraise*", true);

	CryolysisBuffMenu0:SetAttribute("statemap-anchor", "$input");
	CryolysisBuffMenu0:SetAttribute("delaystatemap-anchor", "0");
	CryolysisBuffMenu0:SetAttribute("delaytimemap-anchor", "8");
	CryolysisBuffMenu0:SetAttribute("delayhovermap-anchor", "true");

	CryolysisBuffMenuButton:SetAttribute("onmouseupbutton", "mup");
	CryolysisBuffMenuButton:SetAttribute("onmousedownbutton", "mdn");
	CryolysisBuffMenuButton:SetAttribute("*anchorchild-mdn", CryolysisBuffMenu0);
	CryolysisBuffMenuButton:SetAttribute("*childofsx-mdn", 0);
	CryolysisBuffMenuButton:SetAttribute("*childofsy-mdn", 0);
	CryolysisBuffMenuButton:SetAttribute("*childpoint-mdn", "CENTER");
	CryolysisBuffMenuButton:SetAttribute("*childrelpoint-mdn", "CENTER");
	CryolysisBuffMenuButton:SetAttribute("*childstate-mdn", "^mousedown");
	CryolysisBuffMenuButton:SetAttribute("*childreparent-mdn", "true");

	CryolysisBuffMenuButton:SetAttribute("*anchorchild-mup", CryolysisBuffMenu0);
	CryolysisBuffMenuButton:SetAttribute("*childstate-mup", "mouseup");
	CryolysisBuffMenuButton:SetAttribute("*childverify-mup", true);

	CryolysisBuffMenu0:SetAttribute("state", 0)

	CryolysisBuffMenu0:SetAttribute("statemap-anchor-mousedown", "1-0");
	CryolysisBuffMenu0:SetAttribute("statemap-anchor-mouseup", "!0:");
	CryolysisBuffMenu0:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
	CryolysisBuffMenu0:SetAttribute("delaytimemap-anchor-mouseup", "8");
	CryolysisBuffMenu0:SetAttribute("delayhovermap-anchor-mouseup", "true");

	-- Portal Menu
	CryolysisPortalMenuButton:SetAttribute("*childraise*", true);

	CryolysisPortalMenu0:SetAttribute("statemap-anchor", "$input");
	CryolysisPortalMenu0:SetAttribute("delaystatemap-anchor", "0");
	CryolysisPortalMenu0:SetAttribute("delaytimemap-anchor", "8");
	CryolysisPortalMenu0:SetAttribute("delayhovermap-anchor", "true");

	CryolysisPortalMenuButton:SetAttribute("onmouseupbutton", "mup");
	CryolysisPortalMenuButton:SetAttribute("onmousedownbutton", "mdn");
	CryolysisPortalMenuButton:SetAttribute("*anchorchild-mdn", CryolysisPortalMenu0);
	CryolysisPortalMenuButton:SetAttribute("*childofsx-mdn", 0);
	CryolysisPortalMenuButton:SetAttribute("*childofsy-mdn", 0);
	CryolysisPortalMenuButton:SetAttribute("*childpoint-mdn", "CENTER");
	CryolysisPortalMenuButton:SetAttribute("*childrelpoint-mdn", "CENTER");
	CryolysisPortalMenuButton:SetAttribute("*childstate-mdn", "^mousedown");
	CryolysisPortalMenuButton:SetAttribute("*childreparent-mdn", "true");

	CryolysisPortalMenuButton:SetAttribute("*anchorchild-mup", CryolysisPortalMenu0);
	CryolysisPortalMenuButton:SetAttribute("*childstate-mup", "mouseup");
	CryolysisPortalMenuButton:SetAttribute("*childverify-mup", true);

	CryolysisPortalMenu0:SetAttribute("state", 0)

	CryolysisPortalMenu0:SetAttribute("statemap-anchor-mousedown", "1-0");
	CryolysisPortalMenu0:SetAttribute("statemap-anchor-mouseup", "!0:");
	CryolysisPortalMenu0:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
	CryolysisPortalMenu0:SetAttribute("delaytimemap-anchor-mouseup", "8");
	CryolysisPortalMenu0:SetAttribute("delayhovermap-anchor-mouseup", "true");

end

Cryolysis_UpdateRevisions("CryolysisInitialize.lua", "$Rev$")
