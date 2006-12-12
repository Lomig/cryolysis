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


-- Default Configuations
-- In case configuations are lost or version is changed
Default_CryolysisConfig = {
	Version = CryolysisData.Version;       	-- The version from Localization.lua
	ProvisionContainer = 4;                 -- Where food/water is stored.  furthest bag on the keft
	ProvisionSort = true;                   -- Sort food and drink
	ProvisionDestroy = false;               -- Destroy Excess food and dirnk
	ConcentrationAlert = true;				-- Unused
	ShowSpellTimers = true;					-- Show spell timers
	HPLimit = 85;							-- Eat food when under this amount
	MPLimit = 100;							-- Drink water when under this amount
	Button = 1;								-- Main button function.  1 = eat/drink, 2 = Evocation, 3 = polymorph
	Circle = 2;								-- Outside circle display.  0 = None 1 = HP, 2 = Mana, 3 = Evocation
	ManaStoneOrder = 2;         			-- 1 Weakest manastone first  2 Greatest manastone first
	ButtonText = true;						-- Show item count on buttons
	FoodCountText = true;						-- Show food count
	DrinkCountText = true;						-- Show drink count
	PowderCountText = false;                     -- Show arcane powder count
	FeatherCountText = true;                    -- Show light feather count
	RuneCountText = false;                       -- Show Rune of teleportation/portals count
	ManastoneCooldownText = true;               -- Show Mana gem cooldown
	EvocationCooldownText = false;               -- Show evocation cooldown
	CryolysisLockServ = true;
	CryolysisAngle = 180;   --          \/          \/
	StonePosition = {true, true, true, true, true, true, true, false, true};
	CryolysisToolTip = true;
	LeftSpell = 4;
	RightSpell = 5;
	NoDragAll = false;
	PortalMenuPos = 34;
	PortalMenuAnchor = -6;
	BuffMenuPos = 34;
	BuffMenuAnchor = 20;
	ChatMsg = true;
	ChatType = true;
	CryolysisLanguage = GetLocale();
	ShowCount = true;
	CountType = 2;                  -- Inside sphere display.  1 = none, 2 = food/drink, 3 = Evocation cooldown
	ConcentrationScale = 100;
	CryolysisButtonScale = 100;
	CryolysisColor = "Aqua";
	Sound = true;
	SpellTimerPos = 1;
	SpellTimerJust = "LEFT";
	Food = 1;                       -- I dont remember what this is
	Graphical = true;
	Yellow = true;
	SensListe = 1;
	SM = false;                         -- Short message
	QuickBuff = false;
	PolyScale = 100;
	PolyWarn = true;
	PolyBreak = true;
	PolyWarnTime = 5;
	EvocationUp = false;
	FireWardUp = false;
	PolyMessage = true;
	PortalMessage = true;
	SteedMessage = false;
	CooldownTimers = true;
	CombatTimers = true;
	Restock	= true;					-- Ask me if I want to restock.  If false, don't restock at all 
	RestockConfirm = true;			-- Don't bother asking, just restock
	RestockTeleport = 10;			-- Restock to 10 Rune of Teleportation
	RestockPortals = 10;			-- Restock to 10 Rune of Portals
	RestockPowder = 20;				-- Restock to 20 Arcane Powder
};

CryolysisConfig = {};
local Debug = false;
local Loaded = false;

-- Detect installation of mod
local CryolysisRL = true;

-- Initialization of the variables used by Cryolysis for spells
local SpellCastName = nil;
local SpellCastRank = nil;
local SpellTargetName = nil;
local SpellTargetLevel = nil;
local SpellCastTime = 0;
local CombustionFade = false;
-- Initialization of the tables to manage timers
-- One for spell timers, one for mob groups, and the last allows the association of a timer and graphic frame
-- Le dernier permet l'association d'un timer à une frame graphique
SpellTimer = {};
local SpellGroup = {
	Name = {"Rez", "Main", "Cooldown"},
	SubName = {" ", " ", " "},
	Visible = {true, true, true}
};

local TimerTable = {};
for i = 1, 50, 1 do
	TimerTable[i] = false;
end
Private = {
	-- Menus: Shows buff and portal
	PortalShow = false;
	PortalMenuShow = false;
	BuffShow = false;
	BuffMenuShow = false;

	-- Menus: Allows the progressive disappearance of the Portal menu (transparency) 
	AlphaPortalMenu = 1;
	AlphaPortalVar = 0;
	PortalVisible = false;

	-- Menus: Allows the progressive disappearance of the buff menu (transparency) 
	AlphaBuffMenu = 1;
	AlphaBuffVar = 0;
	BuffVisible = false;

	-- Menus : Allows recasting of the last spell by middle clicking
	LastPortal = 0;
	LastBuff = 0;
	PortalMess = nil;
	-- For Polymorph alerts
	PolyTarget = nil;
	PolyWarning = false;
	PolyWarnTime = 0;
	PolyMess = nil;
	PolyBreakTime = 0;
	
	-- Cooldown vars
	EvocationCooldown = 0;
	EvocationCooldownText = "";
	ManastoneCooldown = 0;
	ManastoneCooldownText = "";

	-- Message vars
	PortalMess = 0;
	SteedMess = 0;
	RezMess = 0;
	TPMess = 0;

}
-- Order of Portals
-- Teleports then Portals
-- Orgrimmar, Undercity, Thunderbluff, Ironforge, Stormwind, Darnassus
local PortalTempID = {38, 40, 39, 37, 51, 46, 47, 31, 30, 28, 29, 27}
local PortalName = {
	"Orgrimmar", "Undercity", "Thunder Bluff", "Ironforge", "Stormwind", "Darnassus",  -- 1-6, Teleports
	"Orgrimmar", "Undercity", "Thunder Bluff", "Ironforge", "Stormwind", "Darnassus"   -- 7-12, Portals
}
-- List Buttons available for the mage in each menu
local PortalMenuCreate = {};
local BuffMenuCreate = {};

-- Variable uses to manage mounting
local Mount = {
 	Name = "none";
	Title = "none";
	Icon = nil;
	Location = {nil, nil};
	Available = false;
}
local CryolysisMounted = false;
local CryolysisTellMounted = true;
local PlayerCombat = false;


-- Variables used for arcane concentration
local Concentration = false;
--local AntiFearInUse = false;				-- Disabled... Haven't found a use yet 
local ConcentrationID = -1;

-- Variables used for provision management
-- (mainly counting)
local Provision = 0;
local ProvisionContainer = 4;
local ProvisionSlot = {};
-- local ProvisionID = 1;
local ProvisionMP = 0;
local ProvisionTime = 0;

-- Variable uses for spellcasting
-- (mainly counting)
local Count = {
	RuneOfTeleportation = 0;
	RuneofPortals = 0;
	ArcanePowder = 0;					-- added this
	LightFeather = 0;					-- and this
	Food = 0;
	Drink = 0;
	FoodLastRank = nil;
	FoodLastName = nil;
	DrinkLastRank = nil;
	DrinkLastName = nil;
}
-- Variables used for the Spell button mangement and use of the reagents
local StoneIDInSpellTable = {0, 0, 0, 0}
local Manastone = {
	["OnHand"] = {false, false, false, false},
	["Location"] = {
		[1] = {nil, nil},
		[2] = {nil, nil},
		[3] = {nil, nil},
		[4] = {nil, nil}
	},
	["Mode"] = {1, 1, 1, 1},
	["MP"] = { 530, 800, 1130, 1470 },
	["Restore"] = { "375-425", "550-650", "775-925", "1000-1200", },
    ["RankID"] = { nil, nil, nil, nil },
};
local StoneMaxRank = {0, 0, 0, 0};
local FoodLocation = {nil,nil};
local DrinkLocation = {nil,nil};
local HearthstoneOnHand = false;
local HearthstoneLocation = {nil,nil};

-- Variables used in the management of demons			-- Portals? 		
local PortalType = nil;

-- Variables used for trading
local CryolysisTradeRequest = false;
local Trading = false;
local TradingNow = 0;

-- Variable containing the last called upon messages

-- Management of the tooltips Cryolysis allows (without the money frame)
local Original_GameTooltip_ClearMoney;

local Cryolysis_In = true;

------------------------------------------------------------------------------------------------------
-- FUNCTIONS CRYOLYSIS APPLIES WHEN YOU LOG IN
------------------------------------------------------------------------------------------------------


-- Function applied to login
function Cryolysis_OnLoad()
	
	-- Allows to locate spells? (Permet de repérer les sorts lancés)
--	Cryolysis_Hook("UseAction", "Cryolysis_UseAction", "before");
--	Cryolysis_Hook("CastSpell", "Cryolysis_CastSpell", "before");
--	Cryolysis_Hook("CastSpellByName", "Cryolysis_CastSpellByName", "before");
	
	-- Recording events intercepted by Cryolysis
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	CryolysisButton:RegisterEvent("BAG_UPDATE");
	CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
	CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
	CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	CryolysisButton:RegisterEvent("PLAYER_REGEN_DISABLED");
	CryolysisButton:RegisterEvent("PLAYER_REGEN_ENABLED");
	CryolysisButton:RegisterEvent("UNIT_PET");
	CryolysisButton:RegisterEvent("MERCHANT_SHOW");
	CryolysisButton:RegisterEvent("MERCHANT_CLOSED");
	CryolysisButton:RegisterEvent("UNIT_SPELLCAST_FAILED");
	CryolysisButton:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	CryolysisButton:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	CryolysisButton:RegisterEvent("UNIT_SPELLCAST_SENT");
	CryolysisButton:RegisterEvent("LEARNED_SPELL_IN_TAB");
	CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	CryolysisButton:RegisterEvent("PLAYER_TARGET_CHANGED");
	CryolysisButton:RegisterEvent("TRADE_REQUEST");
	CryolysisButton:RegisterEvent("TRADE_REQUEST_CANCEL");
	CryolysisButton:RegisterEvent("TRADE_SHOW");
	CryolysisButton:RegisterEvent("TRADE_CLOSED");
	
	-- Recording of the graphic components 
	CryolysisButton:RegisterForDrag("LeftButton");
	CryolysisButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	CryolysisButton:SetFrameLevel(1);

	-- recording console commands
	SlashCmdList["CryolysisCommand"] = Cryolysis_SlashHandler;
	SLASH_CryolysisCommand1 = "/cryo";
end


-- Function applied once parameters of the mods charged 
function Cryolysis_LoadVariables()
	if Loaded or UnitClass("player") ~= CRYOLYSIS_UNIT_MAGE then
		return
	end
	
	Cryolysis_Initialize();
	Loaded = true ;

	-- Detection of the type of demon present at connection 
--	DemonType = UnitCreatureFamily("pet");			-- Disabled.  No demons 
end

------------------------------------------------------------------------------------------------------
-- CRYOLYSIS FUNCTIONS
------------------------------------------------------------------------------------------------------

-- Function launched to the update of the interface (main) -- every 0.1 seconds 
function Cryolysis_OnUpdate()

	-- The function is used only if Cryolysis is initialized and the player is a mage
	if (not Loaded) and UnitClass("player") ~= CRYOLYSIS_UNIT_MAGE then
		return;
	end
	-- Only used if loaded and player is not a mage --

	
	-- Management of Provisions: Sorting every other second
	local curTime = GetTime();
	if ((curTime-ProvisionTime) >= 1) then
		-- Adjust timers
		ProvisionTime = curTime;		
		if Private.PolyWarning == true then 
			Private.PolyWarnTime = Private.PolyWarnTime - 1;
		end
		if CryolysisConfig.PolyBreak and Private.PolyBreakTime >= 0 then
			Private.PolyBreakTime = Private.PolyBreakTime -1;
			if Private.PolyBreakTime <= 0 then Private.PolyTarget = nil;  end
		end
		if Private.ManastoneCooldown > 0 then
			Private.ManastoneCooldown = Private.ManastoneCooldown - 1;
			Private.ManastoneCooldownText = Cryolysis_TimerFunction(Private.ManastoneCooldown);
		elseif Private.ManastoneCooldown <= 0 then
			Private.ManastoneCooldown = 0;
		    Private.ManastoneCooldownText = "";
		end
		if (ProvisionMP > 0) then
			Cryolysis_ProvisionSwitch("MOVE");
		end
	end
	Cryolysis_PolyCheck("warn");
		
	----------------------------------------------------------
	-- Management of mage spells
	----------------------------------------------------------
	
	-- Management of portal menu
	if Private.PortalShow then
		if GetTime() >= Private.AlphaPortalVar and Private.AlphaPortalMenu > 0 and (not Private.PortalVisible) then
			Private.AlphaPortalVar = GetTime() + 0.1;
			CryolysisPortalMenu1:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu2:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu3:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu4:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu5:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu6:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu7:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu8:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu9:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu10:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu11:SetAlpha(Private.AlphaPortalMenu);
			CryolysisPortalMenu12:SetAlpha(Private.AlphaPortalMenu);
			Private.AlphaPortalMenu = Private.AlphaPortalMenu - 0.1;
		end
		if Private.AlphaPortalMenu < 0.1 then
			Cryolysis_PortalMenu();
		end
	end

	-- Management of buff menu
	if Private.BuffShow then
		if GetTime() >= Private.AlphaBuffVar and Private.AlphaBuffMenu > 0 and (not Private.BuffVisible) then
			Private.AlphaBuffVar = GetTime() + 0.1;
			CryolysisBuffMenu1:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu2:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu3:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu4:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu5:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu6:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu7:SetAlpha(Private.AlphaBuffMenu);
			CryolysisBuffMenu8:SetAlpha(Private.AlphaBuffMenu);
			Private.AlphaBuffMenu = Private.AlphaBuffMenu - 0.1;
		end
		if Private.AlphaBuffMenu < 0.1 then
			Cryolysis_BuffMenu();
		end
	end
	
	-- Management of spell timers
	if (not CryolysisSpellTimerButton:IsVisible()) then
		ShowUIPanel(CryolysisSpellTimerButton);
	end
	local display = "";
	local update = false;
	if ((curTime - SpellCastTime) >= 1) then
		SpellCastTime = curTime;
		update = true;
	end
	
	-- updates buttons every second
	-- accepts the trade if transfer is in progress
	-- Parcours du tableau des Timers
	local GraphicalTimer = {texte = {}, TimeMax = {}, Time = {}, titre = {}, temps = {}, Gtimer = {}};
	if SpellTimer then
		for index = 1, table.getn(SpellTimer), 1 do
			if SpellTimer[index] then
				if (GetTime() <= SpellTimer[index].TimeMax) then
					-- Création de l'affichage des timers
					display, SpellGroup, GraphicalTimer, TimerTable = Cryolysis_DisplayTimer(display, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable);
				end
				-- Action every second
				if (update) then
					-- Finished timers are removed
					local TimeLocal = GetTime();
					if TimeLocal >= (SpellTimer[index].TimeMax - 0.5) and SpellTimer[index].TimeMax ~= -1 then
						if SpellTimer[index].Name ~= CRYOLYSIS_SPELL_TABLE[10].Name then
							SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
							index = 0;
							break;
						end
					end
					-- If the target of the spell is not reached (resists)
					if SpellTimer and (SpellTimer[index].Type == 4 or SpellTimer[index].Type == 5)
						and SpellTimer[index].Target == UnitName("target")
						then
						-- On triche pour laisser le temps au mob de bien sentir qu'il est débuffé ^^
						-- Cheats by leaving timer on mob to detect that it is debuffed
						if TimeLocal >= ((SpellTimer[index].TimeMax - SpellTimer[index].Time) + 2.5)
							and SpellTimer[index] ~= 6 then
							if not Cryolysis_UnitHasEffect("target", SpellTimer[index].Name) then
								SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
								index = 0;
								break;
							end
						end
					end
				end
			end
		end
	
	else
		for i = 1, 10, 1 do
			local frameName = "CryolysisTarget"..i.."Text";
			local frameItem = getglobal(frameName);
			if frameItem:IsShown() then
				frameItem:Hide();
			end
		end
	end

	if CryolysisConfig.ShowSpellTimers or CryolysisConfig.Graphical then
		-- If posting text timers
		if not CryolysisConfig.Graphical then
			-- Coloration de l'affichage des timers
			display = Cryolysis_MsgAddColor(display);
			-- Posting the timers
			CryolysisListSpells:SetText(display);
		else
			CryolysisListSpells:SetText("");			
		end
		for i = 4, table.getn(SpellGroup.Name) do
			SpellGroup.Visible[i] = false;
		end
	else
		if (CryolysisSpellTimerButton:IsVisible()) then
			CryolysisListSpells:SetText("");
			HideUIPanel(CryolysisSpellTimerButton);
		end
	end
--	if CryolysisConfig.CountType == 3 or CryolysisConfig.Circle == 3 or CryolysisConfig.ButtonText then
		-- Get evocation cooldown                                                                    
		local start, duration                                                                        
		if CRYOLYSIS_SPELL_TABLE[49].ID ~= nil then
			start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL);
		else
			start = 1;
			duration = 1;
		end
		if start > 0 and duration > 0 and EvocationUp == false then
			-- seconde is now our base number for evocation,
			-- Steal Evocation cooldown for other usages!
			local seconde = duration - ( GetTime() - start)				
			Private.EvocationCooldown = seconde;
			-- Set text on circle if evocation is selected			
			local affiche, minute, time
			if seconde <= 59 then
			    Private.EvocationCooldownText = tostring(floor(seconde))
				affiche = tostring(floor(seconde)).." sec";
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60);
				if seconde < 10 then
					time = "0"..tostring(floor(seconde));
				else
					time = tostring(floor(seconde));
				end
				affiche = minute..":"..time;
				Private.EvocationCooldownText = affiche;
			end
		else  -- Evocation isn't on cooldown 
			Private.EvocationCooldown = 0;
			Private.EvocationCooldownText = "";
		end
		-------------------------------------
		-- Posting main Cryolysis sphere	
		-------------------------------------
		local display
		if CryolysisConfig.CountType == 0 then     -- None
			CryolysisShardCount:SetText("");
		elseif CryolysisConfig.CountType == 1 then -- Food and Drink
			CryolysisShardCount:SetText(Count.Food.." / "..Count.Drink);
		elseif CryolysisConfig.CountType == 2 then -- Drink and Food
			CryolysisShardCount:SetText(Count.Drink.." / "..Count.Food);
		elseif CryolysisConfig.CountType == 3 then -- HP Current
			local color = CryolysisTimerColor(((UnitHealth("player") / UnitHealthMax("player")) * 100));
			display = Cryolysis_MsgAddColor(color..tostring(UnitHealth("player")));
			CryolysisShardCount:SetText(display);
		elseif CryolysisConfig.CountType == 4 then -- HP Percent
			local color = CryolysisTimerColor(((UnitHealth("player") / UnitHealthMax("player")) * 100));
			display = floor(UnitHealth("player") / UnitHealthMax("player") * 100);
			display = Cryolysis_MsgAddColor(color..tostring(display).."%");
			CryolysisShardCount:SetText(display);
		elseif CryolysisConfig.CountType == 5 then -- MP Current
			local color = CryolysisTimerColor(((UnitMana("player") / UnitManaMax("player")) * 100));
			display = tostring(UnitMana("player"));
			CryolysisShardCount:SetText(display);
		elseif CryolysisConfig.CountType == 6 then -- MP Percent
			local color = CryolysisTimerColor(((UnitMana("player") / UnitManaMax("player")) * 100));
			display = floor(UnitMana("player") / UnitManaMax("player") * 100);
			display = tostring(display).."%";
			CryolysisShardCount:SetText(display);
		elseif CryolysisConfig.CountType == 7 then -- Mana gem cooldown
			if Private.ManastoneCooldown > 0 then
				CryolysisShardCount:SetText(Private.ManastoneCooldownText);
			else 
				local display = "Ready";
--				for i=1, StoneMaxRank[2], 1 do
--					if Manastone.OnHand[i] then
--						local display = CRYOLYSIS_STONE_RANK2[i];
--					end
--				end
				CryolysisShardCount:SetText(display);
			end  
		elseif CryolysisConfig.CountType == 8 then 
			local start, duration
			if CRYOLYSIS_SPELL_TABLE[49].ID ~= nil then
				start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL);
			else
				start = 1;
				duration = 1;
			end
			if start > 0 and duration > 0 and EvocationUp == false then
				local seconde = duration - ( GetTime() - start)
				local affiche, minute, time
				if seconde <= 59 then
					affiche = tostring(floor(seconde)).." sec";
				else
					minute = tostring(floor(seconde/60))
					seconde = mod(seconde, 60);
					if seconde < 10 then
						time = "0"..tostring(floor(seconde));
					else
						time = tostring(floor(seconde));
					end
					affiche = minute..":"..time;
				end                                                 
				CryolysisShardCount:SetText(affiche);
			else
			    CryolysisShardCount:SetText("Ready");
			end
		end
		
--	end
	----------------------------------------
	-- Set outer circle display
	----------------------------------------
	local texture;
	-- If outer circle shows evocation cooldown
	if CryolysisConfig.Circle == 4 then
		if Private.EvocationCooldown > 0 then
			texture = 16 - (floor(Private.EvocationCooldown / (480/16)));
			CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Violet\\Shard"..texture);
		else
			CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Violet\\Shard32");
		end
	-- If outer circle shows Manastone cooldown
	elseif CryolysisConfig.Circle == 3 then
		if Private.ManastoneCooldown > 0 then
			texture = 16 - (floor(Private.ManastoneCooldown / (120/16)));
			CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Turquoise\\Shard"..texture);
		else
			CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Turquoise\\Shard32");
		end
	-- if outer circle shows MP
	elseif CryolysisConfig.Circle == 2 then
		texture = floor(UnitMana("player") / (UnitManaMax("player") / 16));
		if texture == 16 then texture = 32; end
		CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Bleu\\Shard"..texture);	
	-- If outer circle shows HP
	elseif CryolysisConfig.Circle == 1 then
		texture = floor(UnitHealth("player") / (UnitHealthMax("player") / 16));
		if texture == 16 then texture = 32; end
		CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Orange\\Shard"..texture);	
	elseif CryolysisConfig.Circle == 0 then
		CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Bleu\\Shard32");
	end
	Cryolysis_UpdateIcons();
end

-- Functions lauched according to the intercepted events
function Cryolysis_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		Cryolysis_In = true;
	elseif (event == "PLAYER_LEAVING_WORLD") then
		Cryolysis_In = false;
	end
		
	-- Traditional test:  Is the player a warlock?
	-- did the mod load?
	if (not Loaded) or (not Cryolysis_In) or UnitClass("player") ~= CRYOLYSIS_UNIT_MAGE then 
		return;
	end

	-- If bag concents changed, checks to make sure provisions are in the selected bag
	if (event == "BAG_UPDATE") then
---		Cryolysis_BagCheck(nil);
--  Removing.  Making bag update based on spellcasting
 		if (CryolysisConfig.ProvisionSort) then
			Cryolysis_ProvisionSwitch("CHECK");
		else
			Cryolysis_BagExplore();
		end
	-- Management of the end of spellcasting
-- Changed by Lomig :	elseif (event == "SPELLCAST_FAILED") or (event == "SPELLCAST_INTERRUPTED") then
	elseif (event == "UNIT_SPELLCAST_FAILED") or (event == "UNIT_SPELLCAST_INTERRUPTED") then
		-- added by Lomig
		if arg1 == "player" then
		-- end of adding
			SpellCastName = nil;
			SpellCastRank = nil;
			SpellTargetName = nil;
			SpellTargetLevel = nil;
		-- added by Lomig
		end
		-- end of adding



--[[ Commented by Lomig 12/12/06 2.00 GMT+1
	elseif (event == "SPELLCAST_STOP") then
		Cryolysis_PolyCheck("stop",SpellCastName,SpellTargetName);
		Cryolysis_SpellManagement();
-- I replace this function by this one :
--]]
	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") then
		SpellCastUnit, SpellCastName = arg1, arg2
		if SpellCastUnit == "player" then
			Cryolysis_PolyCheck("stop",SpellCastName,SpellTargetName);
			Cryolysis_SpellManagement();
		end

------ end of Lomig's changes.

--		Cryolysis_BagCheck(SpellCastName);

--[[ commented by Lomig 12/12/06 2.00 GMT+1
	-- When the mage begins to cast a spell, it grabs the name of the spell and saves the name of the spells target's level
	elseif (event == "SPELLCAST_START") then
		SpellCastName = arg1;
		SpellTargetName = UnitName("target");
		if not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end	
		Cryolysis_PolyCheck("start",SpellCastName,SpellTargetName);
		Cryolysis_ChatMessage(SpellCastName, SpellTargetName);
-- I replace this part by this one :
--]]

	elseif (event == "UNIT_SPELLCAST_SENT") then
		_, SpellCastName, SpellCastRank, SpellTargetName = arg1, arg2, arg3, arg4;
		if (not SpellTargetName or SpellTargetName == "") and UnitName("target") then
			SpellTargetName = UnitName("target");
		elseif not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end
		Cryolysis_PolyCheck("start",SpellCastName,SpellTargetName);
		Cryolysis_ChatMessage(SpellCastName, SpellTargetName);


------ end of Lomig's changes.


	-- When the mage stops casting, clear spell data
	-- Flag if the trade window is open, in order to be able to trade provisions automatically
	elseif event == "TRADE_REQUEST" or event == "TRADE_SHOW" then
		CryolysisTradeRequest = true;
	elseif event == "TRADE_REQUEST_CANCEL" or event == "TRADE_CLOSED" then
		CryolysisTradeRequest = false;
    elseif event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" then  -- WINTERSCHILL will go here
 		for creatureName, spell in string.gmatch(arg1, CRYOLYSIS_DEBUFF_SRCH) do
			-- Frostbite
			if spell == CRYOLYSIS_SPELL_TABLE[53].Name then
				SpellCastName = spell;
				SpellTargetName = creatureName;
    			Cryolysis_SpellManagement();
   			-- Winter's Chill
			elseif spell == CRYOLYSIS_SPELL_TABLE[54].Name
				or spell == CRYOLYSIS_SPELL_TABLE[55].Name
				or spell == CRYOLYSIS_SPELL_TABLE[56].Name
				or spell == CRYOLYSIS_SPELL_TABLE[57].Name
				or spell == CRYOLYSIS_SPELL_TABLE[58].Name then
    			for thistimer=table.getn(SpellTimer), 1, -1 do
					if 	SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[54].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[55].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[56].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[57].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[58].Name
						then
						SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
					end
				end
				SpellCastName = spell;
				SpellTargetName = creatureName;
				Cryolysis_SpellManagement();
   			-- Fire Vulnerability
			elseif spell == CRYOLYSIS_SPELL_TABLE[59].Name
				or spell == CRYOLYSIS_SPELL_TABLE[60].Name
				or spell == CRYOLYSIS_SPELL_TABLE[61].Name
				or spell == CRYOLYSIS_SPELL_TABLE[62].Name
				or spell == CRYOLYSIS_SPELL_TABLE[63].Name then
    			for thistimer=table.getn(SpellTimer), 1, -1 do
					if 	SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[59].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[60].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[61].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[62].Name
						or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[63].Name
						then
						SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
					end
				end
				SpellCastName = spell;
				SpellTargetName = creatureName;
				Cryolysis_SpellManagement();
			end
		end
	-- If mage learns a new spel/rank, the new information is obtained
	-- If the mage  learns new spell from buff or spell, button is recreated
	elseif (event == "LEARNED_SPELL_IN_TAB") then
		Cryolysis_SpellSetup();
		Cryolysis_CreateMenu();
		Cryolysis_ButtonSetup();
	
	-- At the end of combat, stop announcing Concentration
	-- And removes the timers for that mob
	elseif (event == "PLAYER_REGEN_ENABLED") then
		PlayerCombat = false;
		SpellGroup, SpellTimer, TimerTable = Cryolysis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable);
		for i = 1, 10, 1 do
			local frameName = "CryolysisTarget"..i.."Text";
			local frameItem = getglobal(frameName);
			if frameItem:IsShown() then
				frameItem:Hide();
			end
		end
--	-- When the mage changes demons					-- No demons! Disabling
--	elseif (event == "UNIT_PET" and arg1 == "player") then
--		Cryolysis_ChangeDemon();
	-- Peronsal actions -- "Buffs"
	elseif (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
		Cryolysis_SelfEffect("BUFF");
	-- Personal actions -- "Debuffs"
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_SELF" or event == "CHAT_MSG_SPELL_BREAK_AURA" then
		Cryolysis_SelfEffect("DEBUFF");
	elseif event == "CHAT_MSG_SPELL_AURA_GONE_OTHER" then
		for spell, creatureName in string.gmatch(arg1, CRYOLYSIS_POLY_SRCH) do
			Cryolysis_PolyCheck("break",spell,creatureName);
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
		PlayerCombat = true;
	elseif event == "MERCHANT_SHOW" then
		local MerchItems = GetMerchantNumItems()
		for item= 1, MerchItems do
			local itemString = GetMerchantItemInfo(item)
			if itemString == CRYOLYSIS_ITEM.ArcanePowder 
				or itemString == CRYOLYSIS_ITEM.RuneOfTeleportation
				or itemString == CRYOLYSIS_ITEM.RuneOfPortals then
				Cryolysis_RestockConfirm();
				break;
			end
		end
	elseif event == "MERCHANT_CLOSED" then
		StaticPopup_Hide("RESTOCK_CONFIRMATION");
	-- End of the loading screen
	end     
	return;
end

------------------------------------------------------------------------------------------------------
-- CRYOLYSIS FUNCTION "ON EVENT"
------------------------------------------------------------------------------------------------------

-- Events : PLAYER_ENTERING_WORLD and  PLAYER_LEAVING_WORLD
-- Function applied to each loading screen
-- When leaving a zone, stop supervising events
-- When done loading, starts monitoring again
-- Basically, speeds up loading time
function Cryolysis_RegisterManagement(RegistrationType)
	if RegistrationType == "IN" then
		CryolysisButton:RegisterEvent("BAG_UPDATE");
		CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		CryolysisButton:RegisterEvent("PLAYER_REGEN_DISABLED");
		CryolysisButton:RegisterEvent("PLAYER_REGEN_ENABLED");
		CryolysisButton:RegisterEvent("UNIT_PET");
		CryolysisButton:RegisterEvent("MERCHANT_SHOW");
		CryolysisButton:RegisterEvent("MERCHANT_CLOSED");
		CryolysisButton:RegisterEvent("UNIT_SPELLCAST_FAILED");
		CryolysisButton:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		CryolysisButton:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		CryolysisButton:RegisterEvent("UNIT_SPELLCAST_SENT");
		CryolysisButton:RegisterEvent("LEARNED_SPELL_IN_TAB");
		CryolysisButton:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		CryolysisButton:RegisterEvent("PLAYER_TARGET_CHANGED");
		CryolysisButton:RegisterEvent("TRADE_REQUEST");
		CryolysisButton:RegisterEvent("TRADE_REQUEST_CANCEL");
		CryolysisButton:RegisterEvent("TRADE_SHOW");
		CryolysisButton:RegisterEvent("TRADE_CLOSED");
	else
		CryolysisButton:UnregisterEvent("BAG_UPDATE");
		CryolysisButton:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
		CryolysisButton:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE");
		CryolysisButton:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF");
		CryolysisButton:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
		CryolysisButton:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
		CryolysisButton:UnregisterEvent("PLAYER_REGEN_DISABLED");
		CryolysisButton:UnregisterEvent("PLAYER_REGEN_ENABLED");
		CryolysisButton:UnregisterEvent("UNIT_PET");
		CryolysisButton:UnregisterEvent("MERCHANT_SHOW");
		CryolysisButton:UnregisterEvent("MERCHANT_CLOSED");
		CryolysisButton:UnRegisterEvent("UNIT_SPELLCAST_FAILED");
		CryolysisButton:UnRegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		CryolysisButton:UnRegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		CryolysisButton:UnRegisterEvent("UNIT_SPELLCAST_SENT");
		CryolysisButton:UnregisterEvent("LEARNED_SPELL_IN_TAB");
		CryolysisButton:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
		CryolysisButton:UnregisterEvent("PLAYER_TARGET_CHANGED");
		CryolysisButton:UnregisterEvent("TRADE_REQUEST");
		CryolysisButton:UnregisterEvent("TRADE_REQUEST_CANCEL");
		CryolysisButton:UnregisterEvent("TRADE_SHOW");
		CryolysisButton:UnregisterEvent("TRADE_CLOSED");
	end
	return;
end

function Cryolysis_SelfEffect(action)
	local nameTalent, icon, tier, column, currRank, maxRank
	if action == "BUFF" then
		-- Loading Evocation If it exists
		if  string.find(arg1, CRYOLYSIS_SPELL_TABLE[49].Name) and CRYOLYSIS_SPELL_TABLE[49].ID ~= nil then
			EvocationUp = false;
			CryolysisEvocationButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\Evocation-03");
		end
		if  string.find(arg1, CRYOLYSIS_SPELL_TABLE[23].Name) and CRYOLYSIS_SPELL_TABLE[15].ID ~= nil then
			IceBarrierUp = false;
			CryolysisBuffMenu4:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\IceBarrier-03");
		end
		if  string.find(arg1, CRYOLYSIS_SPELL_TABLE[15].Name) and CRYOLYSIS_SPELL_TABLE[15].ID ~= nil then
			FireWardUp = false;
			CryolysisBuffMenu5:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\FireWard-03");
		end
		if  string.find(arg1, CRYOLYSIS_SPELL_TABLE[20].Name) and CRYOLYSIS_SPELL_TABLE[20].ID ~= nil then
			FireWardUp = false;
			CryolysisBuffMenu5:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\FireWard-03");
		end
	else
		-- Change the mount button when mage is dismounted
		if Mount.Available then
			if string.find(arg1, Mount.Title) then
				CryolysisMounted = false;
				CryolysisTellMounted = true;
				CryolysisMountButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\MountButton"..Mount.Icon.."-01");
			end
		end
		if string.find(arg1, CRYOLYSIS_SPELL_TABLE[43].Name) then
		   SpellCastName = CRYOLYSIS_SPELL_TABLE[43].Name
		   Cryolysis_SpellManagement()
		   CombustionFade = true;
		end
		-- Change Evocation button when mage doesnt have Evocation up
--      if  string.find(arg1, CRYOLYSIS_SPELL_TABLE[49].Name) and CRYOLYSIS_SPELL_TABLE[49].ID ~= nil then
--			EvocationUp = false;
--			CryolysisEvocationButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\Evocation-01");
--		end
	end
	return;
end

-- event : SPELLCAST_STOP
-- Allows to manage all that once touches with the fates their successful incantation 
function Cryolysis_SpellManagement()
	local SortActif = false;
	if (SpellCastName) then
  		-- Loading of button when mage mounts?  NEEDS REVIEW
		if Mount.Available then
			if string.find(SpellCastName, Mount.Title) then
	  	        CryolysisMounted = true;
				return;
			end
		end
		-- If the spell is cold snap, remove frost timers
		if SpellCastName == CRYOLYSIS_SPELL_TABLE[42].Name and CRYOLYSIS_SPELL_TABLE[42].ID ~= nil then
			for thistimer=table.getn(SpellTimer), 1, -1 do
				if 	SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[9].Name
					or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[19].Name
					or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[20].Name
					or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[23].Name
					or SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[41].Name
					then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
				end
			end
		end
--		-- Pour les autres sorts castés, tentative de timer si valable
		for spell=1, table.getn(CRYOLYSIS_SPELL_TABLE), 1 do
			if SpellCastName == CRYOLYSIS_SPELL_TABLE[spell].Name then -- and not (spell == 10) then  <--- and the spell isn't Enslave Demon
				-- If a timer already exists, it is updated
				for thisspell=1, table.getn(SpellTimer), 1 do
					if SpellTimer[thisspell].Name == SpellCastName
						and SpellTimer[thisspell].Target == SpellTargetName
						and SpellTimer[thisspell].TargetLevel == SpellTargetLevel
						and CRYOLYSIS_SPELL_TABLE[spell].Type ~= 4
						then
						-- -- Si c'est sort lancé déjà présent sur un mob, on remet le timer à fond
						-- If the timer is already there, reapply it and put it on the bottom
							SpellTimer[thisspell].Time = CRYOLYSIS_SPELL_TABLE[spell].Length;
							SpellTimer[thisspell].TimeMax = floor(GetTime() + CRYOLYSIS_SPELL_TABLE[spell].Length);
							-- adjusts the duration for polymorph based on the rank
							if spell == 26 then
								if SpellCastRank == nil then SpellCastRank = CRYOLYSIS_SPELL_TABLE[26].Rank; end
								SpellTimer[thisspell].Time = SpellCastRank * 10 + 10;
								SpellTimer[thisspell].TimeMax = floor(GetTime() + (SpellCastRank * 10 + 10));
							end
						SortActif = true;
						break;
					end
					-- Si c'est un banish sur une nouvelle cible, on supprime le timer précédent
					-- If it is polymorph on a new target, remove the old polymorph timer
					if SpellTimer[thisspell].Name == SpellCastName
						and
							spell == 26
							or spell == 48
							or spell == 52
						and
							(SpellTimer[thisspell].Target ~= SpellTargetName
							or SpellTimer[thisspell].TargetLevel ~= SpellTargetLevel)
						then
						SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thisspell, SpellTimer, TimerTable);
						SortActif = false;
						break;
					end
					if SortActif then break; end
				end
				if not SortActif
					and CRYOLYSIS_SPELL_TABLE[spell].Type ~= 0
					then
					if spell == 26 then
						if SpellCastRank == nil then SpellCastRank = CRYOLYSIS_SPELL_TABLE[26].Rank; end
      						CRYOLYSIS_SPELL_TABLE[spell].Length = SpellCastRank * 10 + 10;
					end
					if spell ~= 43 or CombustionFade == true then
						SpellGroup, SpellTimer, TimerTable = Cryolysis_InsertTimerParTable(spell, SpellTargetName, SpellTargetLevel, SpellGroup, SpellTimer, TimerTable);
					    CombustionFade = false;
					end
					break;
				end
			end
		end
	end
	SpellCastName = nil;
	SpellCastRank = nil;
	return;
end

--  Prepares sound and announcements for polymorph
function Cryolysis_PolyCheck(type,spell,creatureName)
	if type == "start" then
		-- Send chat message for polymorph
	elseif type == "stop" then
	    if CryolysisConfig.PolyWarn and spell == CRYOLYSIS_SPELL_TABLE[26].Name
			or spell == CRYOLYSIS_SPELL_TABLE[48].Name
			or spell == CRYOLYSIS_SPELL_TABLE[52].Name then
			if SpellCastRank == nil then
				SpellCastRank = CRYOLYSIS_SPELL_TABLE[26].Rank
			end
			Private.PolyWarnTime = (SpellCastRank * 10 + 10) - CryolysisConfig.PolyWarnTime;
			Private.PolyBreakTime = SpellCastRank * 10 + 10;
			Private.PolyWarning = true;
			Private.PolyTarget = creatureName;
		end
	elseif type == "warn" then
	    if CryolysisConfig.Sound and CryolysisConfig.PolyWarn and Private.PolyWarning
			and Private.PolyWarnTime <= 0 then
			PlaySoundFile(CRYOLYSIS_SOUND.SheepWarn);
			Private.PolyWarning = false;
			Private.PolyWarnTime = 0;
		end
	elseif type == "break" then
		if spell == CRYOLYSIS_SPELL_TABLE[26].Name then
			if CryolysisConfig.Sound and CryolysisConfig.PolyBreak and Private.PolyTarget == creatureName then
				PlaySoundFile(CRYOLYSIS_SOUND.SheepBreak);
				Private.PolyTarget = nil;
			end
           	for thistimer=table.getn(SpellTimer), 1, -1 do
				if 	SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[26].Name
				    and SpellTimer[thistimer].Target == creatureName then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
					break;
				end
			end
			Private.PolyWarning = false;
			Private.PolyWarnTime = 0;
			Private.PolyTarget = nil;
		end
		if spell == CRYOLYSIS_SPELL_TABLE[48].Name then
			if CryolysisConfig.Sound and CryolysisConfig.PolyBreak and Private.PolyTarget == creatureName then
				PlaySoundFile(CRYOLYSIS_SOUND.PigBreak);
				Private.PolyTarget = nil;
			end
           	for thistimer=table.getn(SpellTimer), 1, -1 do
				if 	SpellTimer[thistimer].Name == CRYOLYSIS_SPELL_TABLE[48].Name
				    and SpellTimer[thistimer].Target == creatureName then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable);
					break;
				end
			end
			Private.PolyWarning = false;
			Private.PolyWarnTime = 0;
			Private.PolyTarget = nil;
		end
	end
end

--
function Cryolysis_ChatMessage(spell, creatureName)
	if not CryolysisConfig.ChatMsg then
	    return;
	else
		-- Mount
		if Mount.Available then
			if spell == Mount.Title then
				if CryolysisConfig.SteedMessage and string.find(SpellCastName, Mount.Title) then
	    			if not CryolysisConfig.SM then
						local tempnum = random(1, table.getn(CRYOLYSIS_STEED_MESSAGE));
						while tempnum == Private.SteedMess and table.getn(CRYOLYSIS_STEED_MESSAGE) >= 2 do
							tempnum = random(1, table.getn(CRYOLYSIS_STEED_MESSAGE));
						end
						Private.SteedMess = tempnum;
						Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_STEED_MESSAGE[tempnum], nil, nil, Mount.Title), "SAY");
					end
					CryolysisMountButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\MountButton"..Mount.Icon.."-02");
				end
			end
		end
		-- Polymorph
		if spell == CRYOLYSIS_SPELL_TABLE[26].Name
			or spell == CRYOLYSIS_SPELL_TABLE[48].Name
			or spell == CRYOLYSIS_SPELL_TABLE[52].Name then
   			if CryolysisConfig.PolyMessage then
			    if Private.PolyTarget ~= creatureName then
			   		if not CryolysisConfig.SM then
					    -- Sheep
						if spell == CRYOLYSIS_SPELL_TABLE[26].Name then
							local tempnum = random(1, table.getn(CRYOLYSIS_POLY_MESSAGE.Sheep));
							while tempnum == Private.PolyMess and table.getn(CRYOLYSIS_POLY_MESSAGE.Sheep) >= 2 do
								tempnum = random(1, table.getn(CRYOLYSIS_POLY_MESSAGE.Sheep));
							end
							Private.PolyMess = tempnum;
							Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_POLY_MESSAGE.Sheep[tempnum], creatureName), "GROUP");
						-- Pig
			 		    elseif spell == CRYOLYSIS_SPELL_TABLE[48].Name then
							local tempnum = random(1, table.getn(CRYOLYSIS_POLY_MESSAGE.Pig));
							while tempnum == Private.PolyMess and table.getn(CRYOLYSIS_POLY_MESSAGE.Pig) >= 2 do
								tempnum = random(1, table.getn(CRYOLYSIS_POLY_MESSAGE.Pig));
							end
							Private.PolyMess = tempnum;
							Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_POLY_MESSAGE.Pig[tempnum], creatureName), "GROUP");
						-- Turtle
						elseif spell == CRYOLYSIS_SPELL_TABLE[52].Name then
							local tempnum = random(1, table.getn(CRYOLYSIS_POLY_MESSAGE.Turtle));
							while tempnum == Private.PolyMess and table.getn(CRYOLYSIS_POLY_MESSAGE.Turtle) >= 2 do
								tempnum = random(1, table.getn(CRYOLYSIS_POLY_MESSAGE.Turtle));
							end
							Private.PolyMess = tempnum;
	      					Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_POLY_MESSAGE.Turtle[tempnum], creatureName), "GROUP");
			 		    end
	 				elseif CryolysisConfig.SM then
              			if spell == CRYOLYSIS_SPELL_TABLE[26].Name
						or spell == CRYOLYSIS_SPELL_TABLE[48].Name
				 		or spell == CRYOLYSIS_SPELL_TABLE[52].Name then
      						Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_SHORT_MESSAGES[2], creatureName), "GROUP");
						end
					end
				end
			end
		else
		    local port;
		    for i=1, 12, 1 do
		        if spell == CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].Name then
		            port = i;
		            break;
				end
			end
			if port == nil then return; end
            if CryolysisConfig.PortalMessage then
				if not CryolysisConfig.SM then
        			if port <= 6 then
   						local tempnum = random(1, table.getn(CRYOLYSIS_TELEPORT_MESSAGE));
						while tempnum == Private.PortalMess and table.getn(CRYOLYSIS_TELEPORT_MESSAGE) >= 2 do
							tempnum = random(1, table.getn(CRYOLYSIS_TELEPORT_MESSAGE));
						end
						Private.PortalMess = tempnum;
						Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_TELEPORT_MESSAGE[tempnum], nil, PortalName[port]), "GROUP");
					else
				    	local tempnum = random(1, table.getn(CRYOLYSIS_PORTAL_MESSAGE));
						while tempnum == Private.PortalMess and table.getn(CRYOLYSIS_PORTAL_MESSAGE) >= 2 do
							tempnum = random(1, table.getn(CRYOLYSIS_PORTAL_MESSAGE));
						end
						Private.PortalMess = tempnum;
						Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_PORTAL_MESSAGE[tempnum], nil, PortalName[port]), "GROUP");
					end
				elseif CryolysisConfig.SM then
					if port > 6 then
	    				Cryolysis_Msg(Cryolysis_MsgReplace(CRYOLYSIS_SHORT_MESSAGES[1], nil, PortalName[port]), "WORLD");
					end
				end
			end
		end
	end
end


-- Event: MERCHANT_SHOW
-- Checks to see if the player needs to restock
function Cryolysis_RestockConfirm()
	if CryolysisConfig.Restock then
    	if CryolysisConfig.RestockConfirm then
    		StaticPopup_Show("RESTOCK_CONFIRMATION");
    	else
    		Cryolysis_Restock()
    	end
    end
end
function Cryolysis_Restock()
	local MerchItems = GetMerchantNumItems()
	local RestockCount = { };
	local RestockNames = { 
		[1] = CRYOLYSIS_ITEM.RuneOfTeleportation; 
		[2] = CRYOLYSIS_ITEM.RuneOfPortals;
		[3] = CRYOLYSIS_ITEM.ArcanePowder; 
	};	
	for i=1, 6, 1 do
		if CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].ID ~= nil then
			RestockCount[1] = CryolysisConfig.RestockTeleport - Count.RuneOfTeleportation;
			break;
		end
	end
	for i=6, 12, 1 do
		if CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].ID ~= nil then
			RestockCount[2] = CryolysisConfig.RestockPortals - Count.RuneOfPortals;
			break;
		end
	end
	if CRYOLYSIS_SPELL_TABLE[2].ID ~= nil then
		RestockCount[3] = CryolysisConfig.RestockPowder - Count.ArcanePowder;
	end	
	for item= 1, MerchItems do
		for i = 1, table.getn(RestockCount) do
			local itemString = GetMerchantItemInfo(item)
			if itemString == RestockNames[i] and RestockCount[i] > 0 then
				Cryolysis_Msg(CRYOLYSIS_MESSAGE.Information.Restock..RestockCount[i].." "..RestockNames[i], "USER");
				BuyMerchantItem(item, RestockCount[i]);
			end
		end
	end
end

StaticPopupDialogs["RESTOCK_CONFIRMATION"] = {
    text = "Restock Reagents?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
	Cryolysis_Restock();
    end,
    OnShow = function()
	end,	
    timeout = 0,
};
                      

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF THE INTERFACE -- BONDS XML 
------------------------------------------------------------------------------------------------------

-- By right clicking on Cryolysis, one eats/drings or opens the control panels 
function Cryolysis_Toggle(button)
	
	--re-implemented in the 2.0 area (~line 2450)
	--the right click was left in for the menu
	if button == "LeftButton" then		
		if CryolysisConfig.Button == 1 then
	--		local HPPercent = floor(( UnitHealth("player") or 1 ) / ( UnitHealthMax("player") or 1)*100)
	--		local MPPercent = floor(( UnitMana("player") or 1 ) / ( UnitManaMax("player") or 1)*100)
	--		if HPPercent < CryolysisConfig.HPLimit then
	--			if Count.Food > 0 then
	--		    	UseContainerItem(FoodLocation[1], FoodLocation[2]);
	--			else
	--				Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoFood, "USER");
	--			end
	--		end
	--		if MPPercent < CryolysisConfig.MPLimit then
	--			if Count.Drink > 0 then
	--				UseContainerItem(DrinkLocation[1], DrinkLocation[2]);
	--			else
	--				Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoDrink, "USER");
	--			end
	--		end
--	--		Cryolysis_BagCheck("Provision");
		elseif CryolysisConfig.Button == 2 then
			Cryolysis_BuffCast(49);	
		else
			CastSpell(CRYOLYSIS_SPELL_TABLE[26].ID, "spell");
		end
		return;
	end
	
	if (CryolysisGeneralFrame:IsVisible()) then
		HideUIPanel(CryolysisGeneralFrame);
		return;
	else
		if CryolysisConfig.SM then
			Cryolysis_Msg("!!! Short Messages : <brightGreen>On", "USER");
		end
		ShowUIPanel(CryolysisGeneralFrame);
		CryolysisGeneralTab_OnClick(1);
		return;
	end
end

-- Function allowing the movement of elements of Cryolysis on the screen 
function Cryolysis_OnDragStart(button)
	if (button == "CryolysisIcon") then GameTooltip:Hide(); end
	button:StartMoving();
end

-- Function stopping the displacement of elements of Cryolysis on the screen 
function Cryolysis_OnDragStop(button)
	if (button == "CryolysisIcon") then Cryolysis_BuildTooltip("OVERALL"); end
	button:StopMovingOrSizing();
end

-- Function alternating Timers graphs and Timers texts 
function Cryolysis_HideGraphTimer()
	for i = 1, 50, 1 do
		local elements = {"Text", "Bar", "Texture", "OutText"}
		if CryolysisConfig.Graphical then
			if TimerTable[i] then
				for j = 1, 4, 1 do
					frameName = "CryolysisTimer"..i..elements[j];
					frameItem = getglobal(frameName);
					frameItem:Show();
				end
			end
		else
			for j = 1, 4, 1 do
				frameName = "CryolysisTimer"..i..elements[j];
				frameItem = getglobal(frameName);
				frameItem:Hide();
			end
		end
	end
end

-- Function managing the Sphere buttons
function Cryolysis_BuildTooltip(button, type, anchor)
    
	-- If the position of the sphere buttons is bad, bye bye!
	if not CryolysisConfig.CryolysisToolTip then
		return;
	end

	-- Looks to see if Evocation or Wards is up
	local start, duration, start2, duration2, start3, duration3, start4, duration4;
	if CRYOLYSIS_SPELL_TABLE[49].ID then
		start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL);
	else
		start = 1;
		duration = 1;
	end
	if CRYOLYSIS_SPELL_TABLE[15].ID then
		start2, duration2 = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[15].ID, BOOKTYPE_SPELL);
	else
		start2 = 1;
		duration2 = 1;
	end

	if CRYOLYSIS_SPELL_TABLE[20].ID then
		start3, duration3 = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[20].ID, BOOKTYPE_SPELL);
	else
		start3 = 1;
		duration3 = 1;
	end
	if CRYOLYSIS_SPELL_TABLE[23].ID then
		start4, duration4 = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[23].ID, BOOKTYPE_SPELL);
	else
		start4 = 1;
		duration4 = 1;
	end
	
	-- Creation of the Sphere buttons...
	GameTooltip:SetOwner(button, anchor);
	GameTooltip:SetText(CryolysisTooltipData[type].Label);
	-- ..... For the main Sphere

	if (type == "Main") then
		GameTooltip:AddLine(CryolysisTooltipData.Main.Food..Count.Food);
		GameTooltip:AddLine(CryolysisTooltipData.Main.Drink..Count.Drink);
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
		GameTooltip:AddLine(CryolysisTooltipData.Main.ArcanePowder..Count.ArcanePowder);
		GameTooltip:AddLine(CryolysisTooltipData.Main.LightFeather..Count.LightFeather);
	elseif (type == "Mount") then
		GameTooltip:SetText(CryolysisTooltipData[type].Label..Mount.Title.."|r");
		Cryolysis_MoneyToggle();
		CryolysisTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		local itemName = tostring(CryolysisTooltipTextLeft5:GetText());
  		if string.find(itemName, CRYOLYSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(CRYOLYSIS_TRANSLATION.Hearth.." - "..itemName);
		else
			GameTooltip:AddLine(CryolysisTooltipData["SpellTimer"].Right..GetBindLocation());
		end
	-- Manastone
	elseif (type == "Manastone") then
	    local ManastoneTooltip = {
			CRYOLYSIS_STONE_RANK2[1]..CryolysisTooltipData.Manastone.Text[4],
			CRYOLYSIS_STONE_RANK2[2]..CryolysisTooltipData.Manastone.Text[4],
			CRYOLYSIS_STONE_RANK2[3]..CryolysisTooltipData.Manastone.Text[4],
			CRYOLYSIS_STONE_RANK2[4]..CryolysisTooltipData.Manastone.Text[4],
		};
		for i = StoneMaxRank[2], 1, -1  do
		    if Manastone.Mode[i] == 2 then
		    	Cryolysis_MoneyToggle();
	           	local start, duration, enable = GetContainerItemCooldown(Manastone.Location[i][1], Manastone.Location[i][2]);
				if start > 0 and duration > 0 then
					local seconde = duration - ( GetTime() - start)
					local affiche, minute, time
					if seconde <= 59 then
						affiche = tostring(floor(seconde)).." sec";
					else
						minute = tostring(floor(seconde/60))
						seconde = mod(seconde, 60);
						if seconde < 10 then
							time = "0"..tostring(floor(seconde));
						else
							time = tostring(floor(seconde));
						end
						affiche = minute..":"..time;
					end
					GameTooltip:AddLine("Cooldown: "..affiche);
					GameTooltip:AddLine("");
   					break;
  				end
			end
		end
	 	for i = StoneMaxRank[2], 1, -1 do
            if i == StoneMaxRank[2] and Manastone.Mode[i] == 1 then
       			ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[1]..Manastone.MP[i].." Mana"
			elseif Manastone.Mode[i] == 1 and Manastone.Mode[i+1] == 2 then
		        ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[1]..Manastone.MP[i].." Mana"
			end
	   		if CryolysisConfig.ManaStoneOrder == 2 then
	    		for j = 1, StoneMaxRank[2], 1 do
					if Manastone.Mode[j] == 2 then
			       		ManaStoneNext = j;
					end
				end
				if Manastone.Mode[i] == 2 and i ~= ManaStoneNext then
				    ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[3];
				elseif i == ManaStoneNext and Manastone.Mode[i] == 2 then
                   	ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[2]..Manastone.Restore[i];
				end
      		elseif CryolysisConfig.ManaStoneOrder == 1 then
	    		for j = StoneMaxRank[2], 1, -1 do
					if Manastone.Mode[j] == 2 then
			       		ManaStoneNext = j;
					end
				end
				if Manastone.Mode[i] == 2 and i ~= ManaStoneNext then
				    ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData[type].Text[3];
				elseif i == ManaStoneNext and Manastone.Mode[i] == 2  then
                   	ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData[type].Text[2]..Manastone.Restore[i];
				end
   			end
		end
		for i = StoneMaxRank[2], 1, -1 do
			GameTooltip:AddLine(ManastoneTooltip[i]);
		end
	-- ..... For the timer buttons
	elseif (type == "SpellTimer") then
		Cryolysis_MoneyToggle();
		CryolysisTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2]);
		local itemName = tostring(CryolysisTooltipTextLeft5:GetText());
		GameTooltip:AddLine(CryolysisTooltipData[type].Text);
		if string.find(itemName, CRYOLYSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(CRYOLYSIS_TRANSLATION.Hearth.." - "..itemName);
		else
			GameTooltip:AddLine(CryolysisTooltipData[type].Right..GetBindLocation());
		end
		
	-- ..... For the Concentration button
	elseif (type == "Armor") then
		if CRYOLYSIS_SPELL_TABLE[22].ID then
			GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[22].Mana.." Mana");
		else
			GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[18].Mana.." Mana");
		end
		if CRYOLYSIS_SPELL_TABLE[24].ID ~= nil then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[24].Name.." ("..CRYOLYSIS_SPELL_TABLE[24].Mana.." Mana)"..CryolysisTooltipData.Alt.Right);
		end
	elseif (type == "FireWard") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[15].Mana.." Mana");
		if start2 > 0 and duration2 > 0 and not FireWardUp then
			local seconde = duration2 - ( GetTime() - start2)
			local affiche
			affiche = tostring(floor(seconde)).." sec";
			GameTooltip:AddLine("Cooldown : "..affiche);
		else
		    FireWardUp = true;
		end
		if CRYOLYSIS_SPELL_TABLE[20].ID ~= nil then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[20].Name.." ("..CRYOLYSIS_SPELL_TABLE[20].Mana.." Mana)"..CryolysisTooltipData.Alt.Right);
		end
	elseif (type == "IceBarrier") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[23].Mana.." Mana");
		if start4 > 0 and duration4 > 0 and not IceBarrierUp then
			local seconde = duration4 - ( GetTime() - start4)
			local affiche
			affiche = tostring(floor(seconde)).." sec";
			GameTooltip:AddLine("Cooldown : "..affiche);
		else
		    IceBarrierUp = true;
		end
		if CRYOLYSIS_SPELL_TABLE[25].ID ~= nil then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[25].Name.." ("..CRYOLYSIS_SPELL_TABLE[25].Mana.." Mana)"..CryolysisTooltipData.Alt.Right);
		end
	elseif (type == "ManaShield") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[25].Mana.." Mana");
	elseif (type == "DetectMagic") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[50].Mana.." Mana");
	elseif (type == "T:Org") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[38].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
	elseif (type == "T:UC") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[40].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
	elseif (type == "T:TB") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[39].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
	elseif (type == "T:IF") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[37].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
	elseif (type == "T:SW") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[51].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
	elseif (type == "T:Darn") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[36].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation);
	elseif (type == "P:Org") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[47].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
	elseif (type == "P:UC") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[31].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
	elseif (type == "P:TB") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[30].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
	elseif (type == "P:IF") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[28].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
	elseif (type == "P:SW") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[29].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
	elseif (type == "P:Darn") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[27].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals);
	elseif (type == "DampenMagic") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[13].Mana.." Mana");
		if CRYOLYSIS_SPELL_TABLE[1].ID ~= nil then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[1].Name.." ("..CRYOLYSIS_SPELL_TABLE[1].Mana.." Mana)"..CryolysisTooltipData.Alt.Right);
		end
	elseif (type == "ArcaneInt") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[4].Mana.." Mana");
		if CRYOLYSIS_SPELL_TABLE[2].ID ~= nil then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[2].Name.." ("..CRYOLYSIS_SPELL_TABLE[2].Mana.." Mana)"..CryolysisTooltipData.Alt.Right);
		end
	elseif (type == "Food") then
		GameTooltip:AddLine(CryolysisTooltipData[type].Right.." ("..CRYOLYSIS_SPELL_TABLE[10].Mana.." Mana)");
		GameTooltip:AddLine(CryolysisTooltipData[type].Middle);
		GameTooltip:AddLine(CRYOLYSIS_ITEM.Provision..CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]]..": "..Count.Food);
	elseif (type == "Drink") then
		GameTooltip:AddLine(CryolysisTooltipData[type].Right.." ("..CRYOLYSIS_SPELL_TABLE[11].Mana.." Mana)");
		GameTooltip:AddLine(CryolysisTooltipData[type].Middle);
		GameTooltip:AddLine(CRYOLYSIS_ITEM.Provision..CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]]..": "..Count.Drink);
	elseif (type == "SlowFall") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[35].Mana.." Mana");
		GameTooltip:AddLine(CryolysisTooltipData.Main.LightFeather..Count.LightFeather);
	elseif (type == "RemoveCurse") then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[33].Mana.." Mana");
	elseif (type == "Evocation") then
		if start > 0 and duration > 0 and EvocationUp == false then
			local seconde = duration - ( GetTime() - start)
			local affiche, minute, time
			if seconde <= 59 then
				affiche = tostring(floor(seconde)).." sec";
			else
				minute = tostring(floor(seconde/60))
				seconde = mod(seconde, 60);
				if seconde < 10 then
					time = "0"..tostring(floor(seconde));
				else
					time = tostring(floor(seconde));
				end
				affiche = minute..":"..time;
			end                                                 
			GameTooltip:AddLine("Cooldown: "..affiche);
		else
		    EvocationUp = true;
			GameTooltip:AddLine(CryolysisTooltipData.Evocation.Text);
		end
		
	elseif (type == "Buff") and Private.LastBuff ~= 0 then
		GameTooltip:AddLine(CryolysisTooltipData.LastSpell.Left..CRYOLYSIS_SPELL_TABLE[Private.LastBuff].Name..CryolysisTooltipData.LastSpell.Right);
	elseif (type == "Portal") and Private.LastPortal ~= 0 then
		GameTooltip:AddLine(CryolysisTooltipData.LastSpell.Left..CRYOLYSIS_SPELL_TABLE[PortalTempID[Private.LastPortal]].Name..CryolysisTooltipData.LastSpell.Right);
	end
	-- And done, Showing!
	GameTooltip:Show();
end
function Cryolysis_BuildSpellTooltip(button, side, anchor)
	local spell, type;
	if side == "Left" then 
		spell = CryolysisConfig.LeftSpell;
	else
		spell = CryolysisConfig.RightSpell;
	end
	if spell == 1 then
		if CRYOLYSIS_SPELL_TABLE[18].ID or CRYOLYSIS_SPELL_TABLE[22].ID then
			type = "Armor";
		end
	elseif spell == 2 then
		if CRYOLYSIS_SPELL_TABLE[4].ID then
			type = "ArcaneInt";
		end
	elseif spell == 3 then
		if CRYOLYSIS_SPELL_TABLE[13].ID then
			type = "DampenMagic";
		end
	elseif spell == 4 then
		if CRYOLYSIS_SPELL_TABLE[23].ID or CRYOLYSIS_SPELL_TABLE[25].ID then
			type = "Shield";
			Cryolysis_BuildShieldTooltip(button, anchor);
		end
	elseif spell == 5 then
		if CRYOLYSIS_SPELL_TABLE[15].ID then
			type = "FireWard";
		end
	elseif spell == 6 then
		if CRYOLYSIS_SPELL_TABLE[50].ID then
			type = "DetectMagic";
		end
	elseif spell == 7 then
	    if CRYOLYSIS_SPELL_TABLE[33].ID then
			type = "RemoveCurse";
	    end
	elseif spell == 8 then
	    if CRYOLYSIS_SPELL_TABLE[35].ID then
			type = "SlowFall";
		end
	end
	if spell ~= 4 then
		Cryolysis_BuildTooltip(button, type, anchor);
	end
end
function Cryolysis_BuildShieldTooltip(button, anchor)
	if CRYOLYSIS_SPELL_TABLE[23].ID then
    	Cryolysis_BuildTooltip(button, "IceBarrier", anchor);
    else
    	Cryolysis_BuildTooltip(button, "ManaShield", anchor);
    end
end
-- Function updating the Cryolysis buttons and giving the state of the Evocation button
function Cryolysis_UpdateIcons()
	local mana = UnitMana("player");
	if CRYOLYSIS_SPELL_TABLE[49].ID ~= nil then
  		local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL)
		if start > 0 and duration > 0 and EvocationUp == false then
			CryolysisEvocationButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\EvocationButton-03");
		else
		    EvocationUp = true;
		    CryolysisEvocationButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\EvocationButton-01");
		end
	end
	-- Mana Gem
	-----------------------------------------------

	-- Mode "I have one" (2)/"I do not have any" (1) 
	for i = 1, StoneMaxRank[2], 1 do
		if (Manastone.OnHand[i]) then
			Manastone.Mode[i] = 2;
		else
			Manastone.Mode[i] = 1;
		end
	end

	-- Preparation of manastone icon
	if StoneMaxRank[2] >= 1 then
		local currentStone = StoneMaxRank[2]; -- Highest rank stone available, or highest rank if none available
		local conjureStone = StoneMaxRank[2]; -- Next stone to be conjured
		local useableStone = 1; -- 0 = Stone not usable; 1 = usable
		-- Acquire the highest stone available as well as the next one to be conjured
		for i=1, StoneMaxRank[2], 1 do
			if Manastone.OnHand[i] then
				currentStone = i;
			else
				conjureStone = i;
			end
		end
		-- If we're using smallest stone first, find the lowest stone available.
		if CryolysisConfig.ManaStoneOrder == 1 then
			currentStone = 1;  -- Since we us mana agate first in this method, it is set as default icon
		   	for i=StoneMaxRank[2], 1, -1 do
		    	if Manastone.OnHand[i] then
		    	  	currentStone = i;
		    	  	-- conjure order is constant, so we don't need to check it again
		    	end
			end
		end
		-- Check to see if we have enough MP to conjure whatever stone is next.  This is displayed on the ring
		if mana >= Manastone.MP[conjureStone] then
			conjureStoneMP = 1;
		else
			conjureStoneMP = 0;
		end
		-- Check if the current stone is usable.  If it is on cooldown or not available, it is greyed
		if Private.ManastoneCooldown <= 0 and Manastone.OnHand[currentStone] then
			usableStone = 1
		else
			usableStone = 0
		end
		-- Put the parts together to display the icon!
		-- The default display is highest rank manastone, conjurable, and usable
		-- Cryolysis_Msg("Manastone0"..currentStone.."-"..conjureStoneMP..usableStone, "USER");
		CryolysisManastoneButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Manastone0"..currentStone.."-"..conjureStoneMP..usableStone);
	end

--	-- Food Button
--	-----------------------------------------------
	if StoneIDInSpellTable[4] ~= 0 then
		if Count.Food > 0 and not PlayerCombat then				-- Have Food and not in combat
			if CRYOLYSIS_SPELL_TABLE[10].Mana > mana then		-- No Mana
				CryolysisFoodButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Food0"..StoneMaxRank[4].."-01");
			else												-- Have Mana
				CryolysisFoodButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Food0"..StoneMaxRank[4].."-02");
			end
		else												-- No Food
			if CRYOLYSIS_SPELL_TABLE[10].Mana > mana then		-- No Mana
		        CryolysisFoodButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Food0"..StoneMaxRank[4].."-03");
		    else												-- Have Mana
		    	CryolysisFoodButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Food0"..StoneMaxRank[4].."-04");			
		    end
		end
	end
	-- Drink Button
	-----------------------------------------------

	-- Si la pierre est équipée, mode 3
	if StoneIDInSpellTable[3] ~= 0 then
		if Count.Drink > 0 and not PlayerCombat then 				-- Have Drink and not in combat
			if CRYOLYSIS_SPELL_TABLE[11].Mana > mana then		-- No Mana
				CryolysisDrinkButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Water0"..StoneMaxRank[3].."-01");
			else												-- Have Mana                                   
				CryolysisDrinkButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Water0"..StoneMaxRank[3].."-02");
			end
		else												-- No Drink
			if CRYOLYSIS_SPELL_TABLE[11].Mana > mana then		-- No Mana
		        CryolysisDrinkButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Water0"..StoneMaxRank[3].."-03");
		    else												-- Have Mana
		    	CryolysisDrinkButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Water0"..StoneMaxRank[3].."-04");			
		    end
		end
	end
	-- Portal button
	-----------------------------------------------
	
	-- ManaPortal variables goes teleports then portals, listed in this order:
	  -- Teleports
            -- Org, UC, TB, IF, SW, Darn
          -- Portals
            -- Org, UC, TB, IF, SW, Darn
	local ManaPortal = {"1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"};
	if mana ~= nil then
	-- Grey the button if not enough Mana
		for i = 1, 12, 1 do
			if CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].ID then
				if CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].Mana > mana or PlayerCombat then
					ManaPortal[i] = "3";
				end
			end
		end
	end
	-- Graying if out of reagents
--	if Soulshards == 0 then
--		for i = 2, 4, 1 do
--			ManaPet[i] = "3";
--		end
--	end
	if Count.RuneOfTeleportation == 0 then
		for i = 1, 6, 1 do
			ManaPortal[i] = "3";
		end
	end
	if Count.RuneOfPortals == 0 then
		for i = 7, 12, 1 do
			ManaPortal[i] = "3";                                  
		end
	end	
		CryolysisPortalMenu1:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\TeleportOrgrimmar-0"..ManaPortal[1]);
		CryolysisPortalMenu2:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\TeleportUndercity-0"..ManaPortal[2]);
		CryolysisPortalMenu3:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\TeleportThunderbluff-0"..ManaPortal[3]);
		CryolysisPortalMenu4:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\TeleportIronforge-0"..ManaPortal[4])
		CryolysisPortalMenu5:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\TeleportStormwind-0"..ManaPortal[5]);
		CryolysisPortalMenu6:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\TeleportDarnassus-0"..ManaPortal[6]);
		CryolysisPortalMenu7:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalOrgrimmar-0"..ManaPortal[7]);
		CryolysisPortalMenu8:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalUndercity-0"..ManaPortal[8]);
		CryolysisPortalMenu9:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalThunderbluff-0"..ManaPortal[9]);
		CryolysisPortalMenu10:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalIronforge-0"..ManaPortal[10])
		CryolysisPortalMenu11:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalStormwind-0"..ManaPortal[11]);
		CryolysisPortalMenu12:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalDarnassus-0"..ManaPortal[12]);
	-- Buff Buttons
	-----------------------------------------------
	
	if mana ~= nil then
	-- Coloration du bouton en grisé si pas assez de mana
		if Mount.Available and not CryolysisMounted then
--			if CRYOLYSIS_SPELL_TABLE[2].ID then
				if PlayerCombat then
					CryolysisMountButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\MountButton"..Mount.Icon.."-03");
				else
					CryolysisMountButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\MountButton"..Mount.Icon.."-01");
				end
--			else
--				if CRYOLYSIS_SPELL_TABLE[1].Mana > mana or PlayerCombat then
--					CryolysisMountButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\MountButton-03");
--				else
--					CryolysisMountButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\MountButton-01");
--				end
--			end
		end
		if CRYOLYSIS_SPELL_TABLE[18].ID then
			if CRYOLYSIS_SPELL_TABLE[18].Mana > mana then
				CryolysisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-03");
			else
				CryolysisBuffMenu1:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[4].ID then
			if CRYOLYSIS_SPELL_TABLE[4].Mana > mana then
				CryolysisBuffMenu2:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-03");
			else
				CryolysisBuffMenu2:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[13].ID then
			if CRYOLYSIS_SPELL_TABLE[13].Mana > mana then
				CryolysisBuffMenu3:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-03");
			else
				CryolysisBuffMenu3:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[25].ID then
			if CRYOLYSIS_SPELL_TABLE[25].Mana > mana then
				CryolysisBuffMenu4:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-03");
			else
				CryolysisBuffMenu4:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[23].ID then
			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[23].ID, "spell");
			if CRYOLYSIS_SPELL_TABLE[23].Mana > mana or
				start > 0 and duration > 0 and not IceBarrierUp then
				CryolysisBuffMenu4:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-03");
--				CryolysisBuffMenu4:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-02");
			else
				IceBarrierUp = true;
				CryolysisBuffMenu4:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-01");
--				CryolysisBuffMenu4:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-02");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[15].ID then
			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[15].ID, "spell");
			if CRYOLYSIS_SPELL_TABLE[15].Mana > mana or
			start > 0 and duration > 0 and not FireWardUp then
				CryolysisBuffMenu5:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FireWard-03");
			else
				FireWardUp = true
				CryolysisBuffMenu5:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FireWard-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[26].ID then
			if CRYOLYSIS_SPELL_TABLE[26].Mana > mana then
				CryolysisBuffMenu6:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-03");
			else
				CryolysisBuffMenu6:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[33].ID then
			if CRYOLYSIS_SPELL_TABLE[33].Mana > mana then
				CryolysisBuffMenu7:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-03");
			else
				CryolysisBuffMenu7:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-01");
			end
		end
		if CRYOLYSIS_SPELL_TABLE[35].ID then
			if CRYOLYSIS_SPELL_TABLE[35].Mana > mana then
				CryolysisBuffMenu8:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SlowFall-03");
			else
				CryolysisBuffMenu8:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SlowFall-01");
			end
		end
		-- if Wards is gray
--		if CRYOLYSIS_SPELL_TABLE[15].ID then
--			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[15].ID, "spell");
--			if start > 0 and duration > 0 and FireWardUp == false then
--				CryolysisBuffMenu4:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\FireWard-03");
--			else
--			    FireWardUp = true;
--				CryolysisBuffMenu4:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\FireWard-01");
--			end
--		end
		-- Timer Buttons
		-----------------------------------------------
		if HearthstoneLocation[1] then
			local start, duration, enable = GetContainerItemCooldown(HearthstoneLocation[1], HearthstoneLocation[2]);
			if duration > 20 and start > 0 then
				CryolysisSpellTimerButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SpellTimerButton-Cooldown");
			else
				CryolysisSpellTimerButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SpellTimerButton-Normal");
			end
		end

		-- Left Spell Button
		---------------------------------------------------
		if CryolysisConfig.LeftSpell == 1 and CRYOLYSIS_SPELL_TABLE[18].ID then
			if CRYOLYSIS_SPELL_TABLE[18].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-01");
			end
		elseif CryolysisConfig.LeftSpell == 2 and CRYOLYSIS_SPELL_TABLE[4].ID then
			if CRYOLYSIS_SPELL_TABLE[4].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-01");
			end
		elseif CryolysisConfig.LeftSpell == 3 and CRYOLYSIS_SPELL_TABLE[13].ID then
			if CRYOLYSIS_SPELL_TABLE[13].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-01");
			end
		elseif CryolysisConfig.LeftSpell == 4 and CRYOLYSIS_SPELL_TABLE[23].ID then
			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[23].ID, "spell");
			if CRYOLYSIS_SPELL_TABLE[23].Mana > mana or
				start > 0 and duration > 0 and not IceBarrierUp then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-03");
--				CryolysisBuffMenu4:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-02");
			else
				IceBarrierUp = true;
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-01");
--				CryolysisBuffMenu4:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-02");
			end
		elseif CryolysisConfig.LeftSpell == 4 and CRYOLYSIS_SPELL_TABLE[25].ID then
			if CRYOLYSIS_SPELL_TABLE[25].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-01");
			end
		elseif CryolysisConfig.LeftSpell == 5 and CRYOLYSIS_SPELL_TABLE[15].ID then
			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[15].ID, "spell");
			if CRYOLYSIS_SPELL_TABLE[15].Mana > mana or
			start > 0 and duration > 0 and FireWardUp == false then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FireWard-03");
			else
				FireWardUp = true
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FireWard-01");
			end
		elseif CryolysisConfig.LeftSpell == 6 and CRYOLYSIS_SPELL_TABLE[26].ID then
			if CRYOLYSIS_SPELL_TABLE[26].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-01");
			end
		elseif CryolysisConfig.LeftSpell == 7 and CRYOLYSIS_SPELL_TABLE[33].ID then
			if CRYOLYSIS_SPELL_TABLE[33].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-01");
			end
		elseif CryolysisConfig.LeftSpell == 8 and CRYOLYSIS_SPELL_TABLE[35].ID then
			if CRYOLYSIS_SPELL_TABLE[35].Mana > mana then
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SlowFall-03");
			else
				CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SlowFall-01");
			end
		else
			CryolysisLeftSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Shard");
		end
		
		-- Right Spell Button
		---------------------------------------------------
		if CryolysisConfig.RightSpell == 1 and CRYOLYSIS_SPELL_TABLE[18].ID then
			if CRYOLYSIS_SPELL_TABLE[18].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-01");
			end
		elseif CryolysisConfig.RightSpell == 2 and CRYOLYSIS_SPELL_TABLE[4].ID then
			if CRYOLYSIS_SPELL_TABLE[4].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-01");
			end
		elseif CryolysisConfig.RightSpell == 3 and CRYOLYSIS_SPELL_TABLE[13].ID then
			if CRYOLYSIS_SPELL_TABLE[13].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-01");
			end
		elseif CryolysisConfig.RightSpell == 4 and CRYOLYSIS_SPELL_TABLE[23].ID then
			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[23].ID, "spell");
			if CRYOLYSIS_SPELL_TABLE[23].Mana > mana or
				start > 0 and duration > 0 and not IceBarrierUp then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-03");
--				CryolysisBuffMenu4:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-02");
			else
				IceBarrierUp = true;
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-01");
--				CryolysisBuffMenu4:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-02");
			end
		elseif CryolysisConfig.RightSpell == 4 and CRYOLYSIS_SPELL_TABLE[25].ID then
			if CRYOLYSIS_SPELL_TABLE[25].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-01");
			end
		elseif CryolysisConfig.RightSpell == 5 and CRYOLYSIS_SPELL_TABLE[15].ID then
			local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[15].ID, "spell");
			if CRYOLYSIS_SPELL_TABLE[15].Mana > mana or
			start > 0 and duration > 0 and FireWardUp == false then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FireWard-03");
			else
				FireWardUp = true
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\FireWard-01");
			end
		elseif CryolysisConfig.RightSpell == 6 and CRYOLYSIS_SPELL_TABLE[26].ID then
			if CRYOLYSIS_SPELL_TABLE[26].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-01");
			end
		elseif CryolysisConfig.RightSpell == 7 and CRYOLYSIS_SPELL_TABLE[33].ID then
			if CRYOLYSIS_SPELL_TABLE[33].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-01");
			end
		elseif CryolysisConfig.RightSpell == 8 and CRYOLYSIS_SPELL_TABLE[35].ID then
			if CRYOLYSIS_SPELL_TABLE[35].Mana > mana then
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SlowFall-03");
			else
				CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SlowFall-01");
			end
		else
			CryolysisRightSpellButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Shard");			
		end
		Cryolysis_ButtonTextUpdate()
	end
end
------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF STONES AND STUFF
------------------------------------------------------------------------------------------------------

-- T'AS QU'A SAVOIR OU T'AS MIS TES AFFAIRES !
function Cryolysis_ProvisionSetup()
	ProvisionSlotID = 1;
	for slot=1, table.getn(ProvisionSlot), 1 do
		table.remove(ProvisionSlot, slot);
	end
	for slot=1, GetContainerNumSlots(CryolysisConfig.ProvisionContainer), 1 do
		table.insert(ProvisionSlot, nil);
	end
end


-- Function that looks for items to trade (Food/drink
function Cryolysis_TradeExplore(type)
  	for container=0, 4, 1 do
	    for slot=1, GetContainerNumSlots(container), 1 do
			Cryolysis_MoneyToggle();
   			CryolysisTooltip:SetBagItem(container, slot);
            local itemName = tostring(CryolysisTooltipTextLeft1:GetText());
            _, _, locked = GetContainerItemInfo(container, slot);
			if itemName == type and not locked then
				PickupContainerItem(container, slot);
	        	if ( CursorHasItem() ) then  
	        		if CryolysisTradeRequest then
	        			DropItemOnUnit("npc");
	        			break;
	        		else
	        			DropItemOnUnit("target");
	       				break;
					end
				end
			end
	    end
	end
end

-- function that searches for a mount
function MountCheck(itemName, container, slot)
	if UnitLevel("player") < 40 then
		return;
	end
	Mount.Available = false;
	for icon=1, table.getn(CRYOLYSIS_MOUNT_TABLE), 1 do
		for i=1, table.getn(CRYOLYSIS_MOUNT_TABLE[icon]), 1 do
			if itemName == CRYOLYSIS_MOUNT_TABLE[icon][i] then
			   	Mount.Available = true;
			   	Mount.Name = CRYOLYSIS_MOUNT_TABLE[icon][i];
				Mount.Title = Mount.Name;
			   	for p=1, table.getn(CRYOLYSIS_MOUNT_PREFIX), 1 do
			   	    if strfind(Mount.Name, CRYOLYSIS_MOUNT_PREFIX[p]) then
				    	Mount.Title = strsub(Mount.Name, strlen(CRYOLYSIS_MOUNT_PREFIX[p])+1);
				    	local mounttempname;

					end
			   	end
                Cryolysis_Msg("Mount Located: "..Mount.Title,"USER");
				if icon < 10 then
			   		Mount.Icon = "0"..icon;
			   	else
					Mount.Icon = icon;
			   	end
			   	Mount.Location = {container, slot}
			   	break;
			end
		end
	end
end


function Cryolysis_BagCheck(spell)
	local spellcheck = { 2, 10, 11, 38, 40, 39, 37, 51, 46, 47, 31, 30, 28, 29, 27 }
	local check = false;
	local itemName;
	--
	if spell == "Provision" then
	    check = true;
	else
 		for i=1, table.getn(spellcheck), 1 do
		    if spell == CRYOLYSIS_SPELL_TABLE[spellcheck[i]] then
				check = true;
				break;
			end
		end
	end
	if Count.Food > 0 then
	    Cryolysis_MoneyToggle();
		CryolysisTooltip:SetBagItem(FoodLocation[1], FoodLocation[2]);
		itemName = tostring(CryolysisTooltipTextLeft1:GetText());
		if itemName ~= FoodName then
		    check = true;
		end
	end
	if Count.Drink > 0 then
	    Cryolysis_MoneyToggle();
		CryolysisTooltip:SetBagItem(DrinkLocation[1], DrinkLocation[2]);
		itemName = tostring(CryolysisTooltipTextLeft1:GetText());
		if itemName ~= DrinkName then
		    check = true;
		end
	end
	if Mount.Available then
	    Cryolysis_MoneyToggle();
		CryolysisTooltip:SetBagItem(Mount.Location[1], Mount.Location[2]);
		itemName = tostring(CryolysisTooltipTextLeft1:GetText());
		if itemName ~= Mount.Name then
		    check = true;
		end
	end
 	if StoneMaxRank[2] ~= 0 then
 	    for i=1, StoneMaxRank[2], 1 do
 	    	Cryolysis_MoneyToggle();
			CryolysisTooltip:SetBagItem(Manastone.Location[i][1], Manastone.Location[i][2]);
			itemName = tostring(CryolysisTooltipTextLeft1:GetText());
			if string.find(itemName, CRYOLYSIS_ITEM.Manastone..CRYOLYSIS_STONE_RANK[i]) then
			    check = true;
			end
 	    end
	end
 	if check == true then
		if (CryolysisConfig.ProvisionSort) then
			Cryolysis_ProvisionSwitch("CHECK");
		else
			Cryolysis_BagExplore();
		end
	end
end
-- Funtion that inventories mage reagents: feathers, runes, powder, etc
function Cryolysis_BagExplore()
	local provision = Provision;
	Provision = 0;
	Count.Food = 0;
	Count.Drink = 0;
	Count.RuneOfTeleportation = 0;
	Count.RuneOfPortals = 0;
	Count.ArcanePowder = 0;
	Count.LightFeather = 0;
--	SoulstoneOnHand = false;
	Manastone.OnHand = { false, false, false, false };
--	FirestoneOnHand = false;
--	SpellstoneOnHand = false;
	HearthstoneOnHand = false;
	ItemOnHand = false;
	-- For each bag
	for container=0, 4, 1 do
		-- For each slot
		for slot=1, GetContainerNumSlots(container), 1 do
			Cryolysis_MoneyToggle();
			CryolysisTooltip:SetBagItem(container, slot);
			local itemName = tostring(CryolysisTooltipTextLeft1:GetText());
--			local itemSwitch = tostring(CryolysisTooltipTextLeft3:GetText());
--			local itemSwitch2 = tostring(CryolysisTooltipTextLeft4:GetText());
			if StoneMaxRank[4] ~= 0 then
				FoodName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]];
				if FoodLastName == nil then FoodLastName = FoodName; end
			end
			if StoneMaxRank[3] ~= 0 then
				DrinkName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]];
				if DrinkLastName == nil then DrinkLastName = DrinkName; end
			end
			-- If the bag is defined for provisions
			-- skip the value of the table whichr represents that bag slot (not the foodstuff)
			if (container == CryolysisConfig.ProvisionContainer) then
				if itemName ~= FoodName and itemName ~= DrinkName then
					ProvisionSlot[slot] = nil;
				end
			end
			-- In the case of a nonempty slot
			if itemName then
				-- Find the number of items in the slot
				local _, ItemCount = GetContainerItemInfo(container, slot);
				-- If it is a reagent, add it to the count
				if itemName == FoodName then  Count.Food = Count.Food + ItemCount;
				elseif itemName == DrinkName then Count.Drink = Count.Drink + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.ArcanePowder then Count.ArcanePowder = Count.ArcanePowder + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.LightFeather then Count.LightFeather = Count.LightFeather + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.RuneOfTeleportation then Count.RuneOfTeleportation = Count.RuneOfTeleportation + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.RuneOfPortals then Count.RuneOfPortals = Count.RuneOfPortals + ItemCount;
				end
				-- Same thing for Mana Gem
				if string.find(itemName, CRYOLYSIS_ITEM.Manastone) then
					for i = 1, StoneMaxRank[2], 1 do
						if string.find(itemName, CRYOLYSIS_ITEM.Manastone..CRYOLYSIS_STONE_RANK[i]) then
							Manastone.OnHand[i] = true;
							Manastone.Location[i] = {container,slot};
						end
					end
				end
--				-- And again for Food
				if StoneMaxRank[4] ~= 0 then
					if string.find(itemName, FoodName) then
						FoodLocation = {container,slot};
					end
				end
				-- Drink
				if StoneMaxRank[3] ~= 0 then
					if string.find(itemName, DrinkName) then
						DrinkLocation = {container,slot};
					end
				end
				-- Hearthstone
				if HearthstoneLocation == {container,slot} and itemName ~= CRYOLYSIS_ITEM.Hearthstone
				    or HearthstoneOnHand == false then
					if string.find(itemName, CRYOLYSIS_ITEM.Hearthstone) then
						HearthstoneOnHand = true;
						HearthstoneLocation = {container,slot};
					end
				end
				-- Mount
    			if Mount.Location[1] == container and Mount.Location[2] == slot and itemName ~= Mount.Name then
					Mount.Available = false;
				end
				if Mount.Available == false and CryolysisConfig.StonePosition[8] == true then
				 	MountCheck(itemName, container, slot);
				end
			end
		end
	end
	-- Update as a whole!!
	Cryolysis_UpdateIcons();

	-- If there are more provisions than the defined bag can hold, warn the player
	if (Provision > provision and Provision == GetContainerNumSlots(CryolysisConfig.ProvisionContainer)) then
		if (ProvisionsDestroy) then
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Bag.FullPrefix..GetBagName(CryolysisConfig.SoulshardContainer)..CRYOLYSIS_MESSAGE.Bag.FullDestroySuffix);
		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Bag.FullPrefix..GetBagName(CryolysisConfig.SoulshardContainer)..CRYOLYSIS_MESSAGE.Bag.FullSuffix);
		end
	end
end

-- -- Function which makes it possible to find/arrange the provisions in the bags 
function Cryolysis_ProvisionSwitch(type)
	for container = 0, 4, 1 do
		if container ~= CryolysisConfig.ProvisionContainer then
			for slot=1, GetContainerNumSlots(container), 1 do
				Cryolysis_MoneyToggle();
				CryolysisTooltip:SetBagItem(container, slot);
				local itemInfo = tostring(CryolysisTooltipTextLeft1:GetText());
				if itemInfo == FoodLastName
					or itemInfo == DrinkLastName then				    
					if (type == "CHECK") then
						ProvisionMP = ProvisionMP + 1;
					elseif (type == "MOVE") then
						ProvisionMP = ProvisionMP - 1;                                      
						Cryolysis_FindSlot(container, slot,itemInfo);

					end
				elseif type == "MOVE" and ProvisionMP > 0 then
					ProvisionMP = ProvisionMP - 1;
				end
			end
		end
	end
	-- For having all to move, it is necessary to find the sites of the food, drinks, etc, etc… 
	Cryolysis_BagExplore();
end

--During the movement of the provisions, it is necessary to find a new site with the moved objects:) 
function Cryolysis_FindSlot(ProvisionIndex, ProvisionSlot, itemInfo)
	local full = true; 																		-- Saying the provision bag is full
	for slot=1, GetContainerNumSlots(CryolysisConfig.ProvisionContainer), 1 do				-- go through every slot in the provision bag
		Cryolysis_MoneyToggle();															-- Ignore money!
 		CryolysisTooltip:SetBagItem(CryolysisConfig.ProvisionContainer, slot);				-- Make the item name in the provision bag
 		local foodstuff = tostring(CryolysisTooltipTextLeft1:GetText());					-- Make easy to use item name (foodstuff)
		local _, ItemCount = GetContainerItemInfo(CryolysisConfig.ProvisionContainer, slot);-- Get How many items are in that slot
--		if string.find(foodstuff, FoodLastName) == nil and  string.find(foodstuff, DrinkLastName) == nil
		if string.find(foodstuff, FoodLastName) ~= nil and ItemCount < 20 and foodstuff == itemInfo 
            or string.find(foodstuff, DrinkLastName) ~= nil and ItemCount < 20 and foodstuff == itemInfo
			or string.find(foodstuff, CRYOLYSIS_ITEM.Provision) == nil then						-- If that item isn't food or drink
				PickupContainerItem(ProvisionIndex, ProvisionSlot);							-- Pick up the food/drink in the other bag
				PickupContainerItem(CryolysisConfig.ProvisionContainer, slot);				-- Pick up this item, effectively swapping
	--			ProvisionSlot[ProvisionSlotID] = slot;										-- Say there is food/drink in that slot
				ProvisionSlotID = ProvisionSlotID + 1										-- add to slot counter
				if (CursorHasItem()) then													-- If somethign is still on hand
					if ProvisionIndex == 0 then 											-- If the food/drink WAS in the backpack
						PutItemInBackpack();												-- Put the new item in the backpack
					else																	-- otherwise
						PutItemInBag(19 + ProvisionIndex);									-- put it in another bag
					end																		-- done
				end																			-- done
--			end
			full = false;																	-- bag isn't full
			break;
		end
	end
	-- Destruction of the provisions in excess if the option is activated 
	if (full and CryolysisConfig.ProvisionDestroy) then
		PickupContainerItem(ProvisionIndex, ProvisionSlot);
		if (CursorHasItem()) then DeleteCursorItem(); end
	end
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF SPELLS
------------------------------------------------------------------------------------------------------



-- Show or Hide the spell button to each new learned spell
function Cryolysis_ButtonSetup()
	if CryolysisConfig.CryolysisLockServ then
		Cryolysis_NoDrag();
		Cryolysis_UpdateButtonsScale();
	else
		HideUIPanel(CryolysisPortalMenuButton);
		HideUIPanel(CryolysisBuffMenuButton);
		HideUIPanel(CryolysisMountButton);
		HideUIPanel(CryolysisFoodButton);
		HideUIPanel(CryolysisDrinkButton);
		HideUIPanel(CryolysisManastoneButton);
		HideUIPanel(CryolysisEvocationButton);
		HideUIPanel(CryolysisLeftSpellButton);
		HideUIPanel(CryolysisRightSpellButton);
        if (CryolysisConfig.StonePosition[1]) and StoneIDInSpellTable[4] ~= 0 then
			ShowUIPanel(CryolysisFoodButton);
		end
		if (CryolysisConfig.StonePosition[2]) and StoneIDInSpellTable[3] ~= 0 then
			ShowUIPanel(CryolysisDrinkButton);
		end
		if (CryolysisConfig.StonePosition[3]) and StoneIDInSpellTable[2] ~= 0 then
			ShowUIPanel(CryolysisManastoneButton);
		end
		if (CryolysisConfig.StonePosition[4]) then
		    ShowUIPanel(CryolysisLeftSpellButton);
		end
		if (CryolysisConfig.StonePosition[5]) and StoneIDInSpellTable[1] ~= 0 then
			ShowUIPanel(CryolysisEvocationButton);
		end
		if (CryolysisConfig.StonePosition[6]) then
		    ShowUIPanel(CryolysisRightSpellButton);
		end
		if (CryolysisConfig.StonePosition[7]) and BuffMenuCreate ~= {} then
			ShowUIPanel(CryolysisBuffMenuButton);
		end
		if (CryolysisConfig.StonePosition[8]) and Mount.Available then
			ShowUIPanel(CryolysisMountButton);
		end
		if (CryolysisConfig.StonePosition[9]) and PortalMenuCreate ~= {} then
			ShowUIPanel(CryolysisPortalMenuButton);
		end
	end
end

																

-- My favorite function! It makes the list of the spells known by the mage, and classifies them by rank
-- For the stones, it selects the highest rank
function Cryolysis_SpellSetup()
	
	local StoneType = {CRYOLYSIS_ITEM.Evocation, CRYOLYSIS_ITEM.Manastone, CRYOLYSIS_ITEM.Drink, CRYOLYSIS_ITEM.Food};
	local nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(3,7)
	local CurrentStone = {
		ID = {},
		Name = {},
		subName = {}
	};

	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {}
	};
	
	local spellID = 1;
	local Invisible = 0;
	local InvisibleID = 0;

	-- Looks through all spells known by the mage
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL);
		if not spellName then
			do break end
		end
		-- For the spells with numbered ranks , compares for each spell ranks 1 to 1    
		-- The higher rank is preserved 
		if (string.find(subSpellName, CRYOLYSIS_TRANSLATION.Rank)) then
			local found = false;
			local rank = tonumber(strsub(subSpellName, 6, strlen(subSpellName)));
			for index=1, table.getn(CurrentSpells.Name), 1 do
				if (CurrentSpells.Name[index] == spellName) then
			found = true;
					if (CurrentSpells.subName[index] < rank) then
						CurrentSpells.ID[index] = spellID;
						CurrentSpells.subName[index] = rank;
					end
					break;
				end
			end
			-- The largest ranks of each numbered spell with row are inserted in the table
			if (not found) then
				table.insert(CurrentSpells.ID, spellID);
				table.insert(CurrentSpells.Name, spellName);
				table.insert(CurrentSpells.subName, rank);
			end
		end
		-- Check to see if it is a mana gem.  if it is, note it and its information
		for i=1, table.getn(CRYOLYSIS_MANASTONE_NAMES), 1 do
		    if spellName == CRYOLYSIS_MANASTONE_NAMES[i] then
		        StoneMaxRank[2] = i;
		        Manastone.RankID[i] = spellID;
			end
		end
		spellID = spellID + 1;
	end

	-- One inserts in the table the stones with the highest rank
	for stoneID=1, table.getn(StoneType), 1 do
		if StoneMaxRank[stoneID] ~= 0 then
			table.insert(CRYOLYSIS_SPELL_TABLE, {
				ID = CurrentStone.ID[stoneID],
				Name = CurrentStone.Name[stoneID],
				Rank = 0,
				CastTime = 0,
				Length = 0,
				Type = 0,
			});
			StoneIDInSpellTable[stoneID] = table.getn(CRYOLYSIS_SPELL_TABLE);
		end
	end
	-- Updates the list of the spells with the new ranks
	for spell=1, table.getn(CRYOLYSIS_SPELL_TABLE), 1 do
		for index = 1, table.getn(CurrentSpells.Name), 1 do
			if (CRYOLYSIS_SPELL_TABLE[spell].Name == CurrentSpells.Name[index])
				and CRYOLYSIS_SPELL_TABLE[spell].ID ~= StoneIDInSpellTable[3]
				then
					CRYOLYSIS_SPELL_TABLE[spell].ID = CurrentSpells.ID[index];
					CRYOLYSIS_SPELL_TABLE[spell].Rank = CurrentSpells.subName[index];
			end
   		end
	end

	-- Updates the duration of each spell according to its rank
	for index=1, table.getn(CRYOLYSIS_SPELL_TABLE), 1 do
		if (index == 26) then -- For Polymorph
			if CRYOLYSIS_SPELL_TABLE[index].ID ~= nil then
				CRYOLYSIS_SPELL_TABLE[index].Length = CRYOLYSIS_SPELL_TABLE[index].Rank * 10 + 10;
			end
		end
		if (index == 21) then  -- For Frost bolt
			nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(3,7);
			if CRYOLYSIS_SPELL_TABLE[index].ID ~= nil and CRYOLYSIS_SPELL_TABLE[index].Rank <=7 then
    			CRYOLYSIS_SPELL_TABLE[index].Length = ceil(4.5 + currRank + (CRYOLYSIS_SPELL_TABLE[index].Rank * 0.5));
   			else 
			   	CRYOLYSIS_SPELL_TABLE[index].Length = CRYOLYSIS_SPELL_TABLE[index].Length + currRank
			end
		end
		if (index == 16) then  -- for Fireball
			if CRYOLYSIS_SPELL_TABLE[index].ID ~= nil and CRYOLYSIS_SPELL_TABLE[index].Rank <= 3 then
				CRYOLYSIS_SPELL_TABLE[index].Length = 6;
			end
		end
		if (index == 14) then  -- For fireblast
			if CRYOLYSIS_SPELL_TABLE[index].ID ~= nil then
				_, _, _, _, currRank, maxRank = GetTalentInfo(2,7);
				CRYOLYSIS_SPELL_TABLE[index].Length = 8 - (currRank * 0.5);		
			end
		end
		if (index == 19) then   -- For frost nova
			if CRYOLYSIS_SPELL_TABLE[index].ID ~= nil then
				_, _, _, _, currRank, maxRank = GetTalentInfo(3,6);
				CRYOLYSIS_SPELL_TABLE[index].Length = 25 - (currRank * 2);
			end
		end
	end

	for spellID=1, MAX_SPELLS, 1 do
        local spellName, subSpellName = GetSpellName(spellID, "spell");
		if (spellName) then
			for index=1, table.getn(CRYOLYSIS_SPELL_TABLE), 1 do
				if CRYOLYSIS_SPELL_TABLE[index].Name == spellName then
					Cryolysis_MoneyToggle();
					CryolysisTooltip:SetSpell(spellID, 1);
					local _, _, ManaCost = string.find(CryolysisTooltipTextLeft2:GetText(), "(%d+)");
					if not CRYOLYSIS_SPELL_TABLE[index].ID then
						CRYOLYSIS_SPELL_TABLE[index].ID = spellID;
					end
					CRYOLYSIS_SPELL_TABLE[index].Mana = tonumber(ManaCost);
				end
			end
		end
	end
--	if CRYOLYSIS_SPELL_TABLE[1].ID or CRYOLYSIS_SPELL_TABLE[2].ID then
--		MountAvailable = true;
--	else
--		MountAvailable = false;
--	end
--
	if CRYOLYSIS_SPELL_TABLE[10].ID ~= nil then
		StoneMaxRank[4] = CRYOLYSIS_SPELL_TABLE[10].Rank
		StoneIDInSpellTable[4] = CRYOLYSIS_SPELL_TABLE[10].ID
	end
	if CRYOLYSIS_SPELL_TABLE[11].ID ~= nil then
		StoneMaxRank[3] = CRYOLYSIS_SPELL_TABLE[11].Rank
		StoneIDInSpellTable[3] = CRYOLYSIS_SPELL_TABLE[11].ID
	end
	if CRYOLYSIS_SPELL_TABLE[49].ID ~= nil then
		StoneMaxRank[1] = CRYOLYSIS_SPELL_TABLE[49].Rank
		StoneIDInSpellTable[1] = CRYOLYSIS_SPELL_TABLE[49].ID
	end

--Button Action Definitions added here to port to 2.0

-- CenterButton

   CryolysisButton:SetAttribute("type1", "macro")
   t=UnitLevel("player");
   drinkLevel = (t / 10) - ((t % 10)/10) + 1;
   foodLevel = (t / 10) - ((t % 10)/10) + 1;
   CryolysisButton:SetAttribute("macrotext1", "/use Conjured" .. CRYOLYSIS_DRINK_RANK[drinkLevel] .. "\n/use Conjured" .. CRYOLYSIS_FOOD_RANK[foodLevel]);

-- Evocation Button

    CryolysisEvocationButton:SetAttribute("type1", "spell");
    CryolysisEvocationButton:SetAttribute("*unit", "target");
    CryolysisEvocationButton:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[49].Name);
    
-- Water Button
    CryolysisDrinkButton:SetAttribute("type1", "macro");
    t=UnitLevel("player");
    t = (t / 10) - ((t % 10)/10) + 1;
    CryolysisDrinkButton:SetAttribute("macrotext1", "/use Conjured" .. CRYOLYSIS_DRINK_RANK[t]);
    -- Do not know why you do not use the "spell" and you use the macro /cast. Anyway, it won't work on non-English Client.
    -- Changed by Lomig :
    CryolysisDrinkButton:SetAttribute("type2", "spell");
    CryolysisDrinkButton:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[11].Name);

-- Food Button
    CryolysisFoodButton:SetAttribute("type1", "macro");
    t = UnitLevel("player") - 2;
    t = (t / 10) - ((t % 10)/10) + 1;
    CryolysisFoodButton:SetAttribute("macrotext1", "/use Conjured" .. CRYOLYSIS_FOOD_RANK[t]);
    -- Do not know why you do not use the "spell" and you use the macro /cast. Anyway, it won't work on non-English Client.
    -- Changed by Lomig :
    CryolysisFoodButton:SetAttribute("type2", "spell");
    CryolysisFoodButton:SetAttribute("spell2",  CRYOLYSIS_SPELL_TABLE[10].Name);
    
-- Manastone Button
    CryolysisManastoneButton:SetAttribute("type1", "macro");
    t = UnitLevel("player") - 28;
    t = (t / 10) - ((t % 10)/10) + 1;
    CryolysisManastoneButton:SetAttribute("macrotext1", "/use Mana" .. CRYOLYSIS_STONE_RANK[t]);
    CryolysisManastoneButton:SetAttribute("type2", "spell");
    -- CryolysisManastoneButton:SetAttribute("macrotext2", "/cast Conjure Mana" .. CRYOLYSIS_STONE_RANK[t]);	
	-- Changed by Lomig : You are forgetting people who do not play on English Client...
	-- My code instead (must be working, but I do not have a mage to check)
	if StoneIDInSpellTable[2] > 0 then
		CryolysisManastoneButton:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[StoneIDInSpellTable[2]].Name);
	end



-- Buff Spells
    CryolysisBuffMenu1:SetAttribute("type1", "spell");
    CryolysisBuffMenu1:SetAttribute("*unit", "target");
    CryolysisBuffMenu1:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[22].Name);
    
    CryolysisBuffMenu2:SetAttribute("type1", "spell");
    CryolysisBuffMenu2:SetAttribute("*unit", "target");
    CryolysisBuffMenu2:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[4].Name);
    
    CryolysisBuffMenu3:SetAttribute("type1", "spell");
    CryolysisBuffMenu3:SetAttribute("*unit", "target");
    CryolysisBuffMenu3:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[13].Name);
    CryolysisBuffMenu3:SetAttribute("type2", "spell");
    CryolysisBuffMenu3:SetAttribute("*unit", "target");
    CryolysisBuffMenu3:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[1].Name);

    CryolysisBuffMenu4:SetAttribute("type1", "spell");
    CryolysisBuffMenu4:SetAttribute("*unit", "target");
    CryolysisBuffMenu4:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[23].Name);

    CryolysisBuffMenu5:SetAttribute("type1", "spell");
    CryolysisBuffMenu5:SetAttribute("*unit", "target");
    CryolysisBuffMenu5:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[15].Name);
    CryolysisBuffMenu5:SetAttribute("type2", "spell");
    CryolysisBuffMenu5:SetAttribute("*unit", "target");
    CryolysisBuffMenu5:SetAttribute("spell2", CRYOLYSIS_SPELL_TABLE[20].Name);

    CryolysisBuffMenu6:SetAttribute("type1", "spell");
    CryolysisBuffMenu6:SetAttribute("*unit", "target");
    CryolysisBuffMenu6:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[50].Name);

    CryolysisBuffMenu7:SetAttribute("type1", "spell");
    CryolysisBuffMenu7:SetAttribute("*unit", "target");
    CryolysisBuffMenu7:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[33].Name);
    
    CryolysisBuffMenu8:SetAttribute("type1", "spell");
    CryolysisBuffMenu8:SetAttribute("*unit", "target");
    CryolysisBuffMenu8:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[35].Name);
    
--Portal Buttons
    CryolysisPortalMenu1:SetAttribute("type1", "spell");
    CryolysisPortalMenu1:SetAttribute("*unit", "target");
    CryolysisPortalMenu1:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[38].Name);

    CryolysisPortalMenu2:SetAttribute("type1", "spell");
    CryolysisPortalMenu2:SetAttribute("*unit", "target");
    CryolysisPortalMenu2:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[40].Name);

    CryolysisPortalMenu3:SetAttribute("type1", "spell");
    CryolysisPortalMenu3:SetAttribute("*unit", "target");
    CryolysisPortalMenu3:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[39].Name);

    CryolysisPortalMenu4:SetAttribute("type1", "spell");
    CryolysisPortalMenu4:SetAttribute("*unit", "target");
    CryolysisPortalMenu4:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[37].Name);

    CryolysisPortalMenu5:SetAttribute("type1", "spell");
    CryolysisPortalMenu5:SetAttribute("*unit", "target");
    CryolysisPortalMenu5:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[51].Name);

    CryolysisPortalMenu6:SetAttribute("type1", "spell");
    CryolysisPortalMenu6:SetAttribute("*unit", "target");
    CryolysisPortalMenu6:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[46].Name);

    CryolysisPortalMenu7:SetAttribute("type1", "spell");
    CryolysisPortalMenu7:SetAttribute("*unit", "target");
    CryolysisPortalMenu7:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[47].Name);

    CryolysisPortalMenu8:SetAttribute("type1", "spell");
    CryolysisPortalMenu8:SetAttribute("*unit", "target");
    CryolysisPortalMenu8:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[31].Name);

    CryolysisPortalMenu9:SetAttribute("type1", "spell");
    CryolysisPortalMenu9:SetAttribute("*unit", "target");
    CryolysisPortalMenu9:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[30].Name);

    CryolysisPortalMenu10:SetAttribute("type1", "spell");
    CryolysisPortalMenu10:SetAttribute("*unit", "target");
    CryolysisPortalMenu10:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[28].Name);

    CryolysisPortalMenu11:SetAttribute("type1", "spell");
    CryolysisPortalMenu11:SetAttribute("*unit", "target");
    CryolysisPortalMenu11:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[29].Name);

    CryolysisPortalMenu12:SetAttribute("type1", "spell");
    CryolysisPortalMenu12:SetAttribute("*unit", "target");
    CryolysisPortalMenu12:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[27].Name);
end

-- Function of extraction of attribute of spells
-- F(type=string, string, int) -> Spell=table
function Cryolysis_FindSpellAttribute(type, attribute, array)
	for index=1, table.getn(CRYOLYSIS_SPELL_TABLE), 1 do
		if string.find(CRYOLYSIS_SPELL_TABLE[index][type], attribute) then return CRYOLYSIS_SPELL_TABLE[index][array]; end
	end
	return nil;
end

-- Function to cast Shadowbolt with the Shadow Trance button
-- Needs to know the highest rank
--function Cryolysis_CastShadowbolt()
--	local spellID = Cryolysis_FindSpellAttribute("Name", CRYOLYSIS_NIGHTFALL.BoltName, "ID");
--	if (spellID) then
--		CastSpell(spellID, "spell");
--	else
--		Cryolysis_Msg(CRYOLYSIS_NIGHTFALL_TEXT.NoBoltSpell, "USER");
--	end
--end

------------------------------------------------------------------------------------------------------
-- OTHER FUNCTIONS
------------------------------------------------------------------------------------------------------

-- Update text on Cryolysis buttons
function Cryolysis_ButtonTextUpdate()
	if CryolysisConfig.EvocationCooldownText then
		CryolysisEvocationCooldown:SetText(Private.EvocationCooldownText);
	else
		CryolysisEvocationCooldown:SetText("");
	end
	if CryolysisConfig.ManastoneCooldownText then
		CryolysisManastoneCooldown:SetText(Private.ManastoneCooldownText);
	else
		CryolysisManastoneCooldown:SetText("");
	end
	if CryolysisConfig.FoodCountText then
		CryolysisFoodCount:SetText(Count.Food);
	else
		CryolysisFoodCount:SetText("");
	end
	if CryolysisConfig.DrinkCountText then
		CryolysisDrinkCount:SetText(Count.Drink);
	else
		CryolysisDrinkCount:SetText("");
	end
	if CryolysisConfig.PowderCountText then
		CryolysisPowderCount:SetText(Count.ArcanePowder);
	else
		CryolysisPowderCount:SetText("");
	end
	if CryolysisConfig.FeatherCountText then
		CryolysisFeatherCount:SetText(Count.LightFeather);
	else
		CryolysisFeatherCount:SetText("");
	end
	if CryolysisConfig.RuneCountText then
		CryolysisTeleportCount1:SetText(Count.RuneOfTeleportation);
		CryolysisTeleportCount2:SetText(Count.RuneOfTeleportation);
		CryolysisTeleportCount3:SetText(Count.RuneOfTeleportation);
		CryolysisTeleportCount4:SetText(Count.RuneOfTeleportation);
		CryolysisTeleportCount5:SetText(Count.RuneOfTeleportation);
		CryolysisTeleportCount6:SetText(Count.RuneOfTeleportation);
		CryolysisPortalCount1:SetText(Count.RuneOfPortals);
		CryolysisPortalCount2:SetText(Count.RuneOfPortals);
		CryolysisPortalCount3:SetText(Count.RuneOfPortals);
		CryolysisPortalCount4:SetText(Count.RuneOfPortals);
		CryolysisPortalCount5:SetText(Count.RuneOfPortals);
		CryolysisPortalCount6:SetText(Count.RuneOfPortals);
	else
		CryolysisTeleportCount1:SetText("");
		CryolysisTeleportCount2:SetText("");
		CryolysisTeleportCount3:SetText("");
		CryolysisTeleportCount4:SetText("");
		CryolysisTeleportCount5:SetText("");
		CryolysisTeleportCount6:SetText("");
		CryolysisPortalCount1:SetText("");
		CryolysisPortalCount2:SetText("");
		CryolysisPortalCount3:SetText("");
		CryolysisPortalCount4:SetText("");
		CryolysisPortalCount5:SetText("");
		CryolysisPortalCount6:SetText("");
		
	end	
end

-- Converts seconds into minutes:seconds
function Cryolysis_TimerFunction(seconde)
	local affiche, minute, time
	if seconde <= 59 then
		return tostring(floor(seconde));
	else
		minute = tostring(floor(seconde/60))
		seconde = mod(seconde, 60);
		if seconde < 10 then
			time = "0"..tostring(floor(seconde));
		else
			time = tostring(floor(seconde));
		end
		affiche = minute..":"..time;
		return affiche;
	end		
end

-- Scans the players target, the player, and their party/raid for curses and removes the first one found.
function Cryolysis_Decursive()
	local group, size, unit, cursed, debuffDispelType, debuffName;
	if GetNumRaidMembers() > 0 then
		group = "raid";
		size = GetNumRaidMembers();
	else
		group = "party";
		size = GetNumPartyMembers();
	end
	if cursed == nil then
		debuffDispelType = nil;
		for i=-1, size, 1 do
			-- Check target first
			if i == -1 then
				if (UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player")) then
					unit = "target";
				else
					unit = "player"
				end
			-- Check player next
			elseif i == 0 then
				unit = "player";
			-- Then check everyone else
			else
				unit = group..i;
			end
			for index=1, 16, 1 do
				_, _, debuffDispelType = UnitDebuff(unit, index, 1);
				if debuffDispelType == "Curse" then
					cursed = unit;
					Cryolysis_MoneyToggle();
					CryolysisTooltip:SetUnitDebuff(unit, index);
					debuffName = tostring(CryolysisTooltipTextLeft1:GetText());
					break;
				end
			end
		end
	end
	if cursed ~= nil then
		TargetUnit(cursed);
		CastSpell(CRYOLYSIS_SPELL_TABLE[33].ID, "spell");
		Cryolysis_Msg(Cryolysis_MsgAddColor("Decurse attempt: <darkBlue>"..UnitName("target").."<white> afflicted by <purple>"..debuffName.."<white>."), "USER");
		TargetLastTarget();
	else
		Cryolysis_Msg("No curses found", "USER");
	end
end

-- Function to know if a unit undergoes an effect 
-- F(string, string)->bool
function Cryolysis_UnitHasEffect(unit, effect)
	local index = 1;
	while UnitDebuff(unit, index) do
		Cryolysis_MoneyToggle();
		CryolysisTooltip:SetUnitDebuff(unit, index);
		local DebuffName = tostring(CryolysisTooltipTextLeft1:GetText());
   		if (string.find(DebuffName, effect)) then
			return true;
		end
		index = index+1;
	end
	return false;
end

-- Function to check the presence of a buff on the unit.
-- Strictly identical to UnitHasEffect, but as WoW distinguishes Buff and DeBuff, so we have to.
function Cryolysis_UnitHasBuff(unit, effect)
	local index = 1;
	while UnitBuff(unit, index) do
	-- Here we'll cheat a little. checking a buff or debuff return the internal spell name, and not the name we give at start
		-- So we use an API widget that will use the internal name to return the known name.
		-- For example, the "Curse of Agony" spell is internaly known as "Spell_Shadow_CurseOfSargeras". Much easier to use the first one than the internal one.
		Cryolysis_MoneyToggle();
		CryolysisTooltip:SetUnitBuff(unit, index);
		local BuffName = tostring(CryolysisTooltipTextLeft1:GetText());
   		if (string.find(BuffName, effect)) then
			return true;
		end
		index = index+1;
	end
	return false;
end


-- Allows the player to get concentration
--function Cryolysis_UnitHasConcentration()
--	local ID = -1;
--	for buffID = 0, 24, 1 do
--		local buffTexture = GetPlayerBuffTexture(buffID);
--		if buffTexture == nil then break end
--		if strfind(buffTexture, "Spell_Shadow_Manaburn") then
--			ID = buffID;
--			break
--		end
--	end
--	ConcentrationID = ID;
--end

-- Function to manage the actions carried out by Cryolysis with the click on a button 
function Cryolysis_UseItem(type,button)
	Cryolysis_MoneyToggle();
	CryolysisTooltip:SetBagItem("player", 17);
	local rightHand = tostring(CryolysisTooltipTextLeft1:GetText());

	-- Function to use a hearthstone in the inventory   
	-- If there is one in the inventory and you right-click
	if type == "Hearthstone" and button == "RightButton" then
		if (HearthstoneOnHand) then
			-- Use
			UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
			-- If there isn't one in the inventory and you right-click
		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoHearthStone, "USER");
		end
	-- If you click on  the Mana gem :
	elseif type == "Manastone" and button == "LeftButton" then      -- ***FLAGFLAGFLAG***
--		if Manastone.Mode[1] == 1
--			and Manastone.Mode[2] == 1
--			and Manastone.Mode[3] == 1
--			and Manastone.Mode[4] == 1 then   -- No Manastone on hand
--			if StoneMaxRank[2] ~= 0 then      -- Create if you know the spell
--    			CastSpell(Manastone.RankID[StoneMaxRank[2]], "spell");
--			else                                     -- Tell user they can't create
--				Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoManaStoneSpell, "USER");
--		end
		if (UnitMana("player") == UnitManaMax("player")) then   -- Max mana! Not going to waste it
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.FullMana, "USER");
	    elseif CryolysisConfig.ManaStoneOrder == 2 then
        	for i = StoneMaxRank[2], 1, -1 do
				-- If there is one in the inventory
		    	if Manastone.OnHand[i] then
					local start, duration, enable = GetContainerItemCooldown(Manastone.Location[i][1], Manastone.Location[i][2]);
					if start > 0 and duration > 0 then
					    Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.ManaStoneCooldown, "USER");
					    break;
					else
						SpellStopCasting();
						UseContainerItem(Manastone.Location[i][1], Manastone.Location[i][2]);
     				 	Private.ManastoneCooldown = 120;
     				 	SpellCastName = "Mana Gem";
					 	break;
					end
				end
			end
		elseif CryolysisConfig.ManaStoneOrder == 1 then
       	for i = 1, StoneMaxRank[2], 1  do
			-- If there is one in the inventory
	    	if Manastone.OnHand[i] then
				local start, duration, enable = GetContainerItemCooldown(Manastone.Location[i][1], Manastone.Location[i][2]);
				if start > 0 and duration > 0 then
				    Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.ManaStoneCooldown, "USER");
				    break;
				else
					SpellStopCasting();
					UseContainerItem(Manastone.Location[i][1], Manastone.Location[i][2]);
     				SpellCastName = "Mana Gem";
   					break;
					end
				end
			end
		end
	elseif type == "Manastone" and button == "RightButton" then
		for i = StoneMaxRank[2], 1, -1 do
		    if Manastone.Mode[i] == 1 then
				CastSpell(Manastone.RankID[i], "spell");
				break;
			end
		end
 		 
	-- Now for food
 	elseif type == "Food" and button == "LeftButton" then
		if Count.Food > 0 then
			UseContainerItem(FoodLocation[1], FoodLocation[2]);
--			Cryolysis_BagCheck("Provision");
		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoFood, "USER");
		end
	elseif type == "Food" and button == "RightButton" then
	    if (UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player")) then
			for i=StoneMaxRank[4], 1, -1 do
				local var = i * 10 - 15
				if UnitLevel("target") >= var then
					DoEmote("stand");
					CastSpellByName("Conjure Food(Rank "..i..")");
					FoodLastRank = i;
					FoodLastName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_FOOD_RANK[i];
					break;
				end
			end
		else
			Cryolysis_BuffCast(10);
			FoodLastRank = StoneMaxRank[4];
			FoodLastName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]];
			
		end
	elseif type == "Food" and button == "MiddleButton" then 
		if Count.Food > 0 then
			if (UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player"))
			or CryolysisTradeRequest then
				Cryolysis_TradeExplore(FoodLastName);
			end
		end
	
	
	-- And for drinks
	elseif type == "Drink" and button == "LeftButton" then
		if Count.Drink > 0 then
			UseContainerItem(DrinkLocation[1], DrinkLocation[2]);
--			Cryolysis_BagCheck("Provision");
		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoDrink, "USER");
		end
	elseif type == "Drink" and button == "RightButton" then
        if (UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player")) then
			for i=StoneMaxRank[3], 1, -1 do
				local var = i * 10 - 15
			    if UnitLevel("target") >= var then
			        DoEmote("stand");
					CastSpellByName("Conjure Water(Rank "..i..")");
			        DrinkLastRank = i;
			        DrinkLastName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_DRINK_RANK[i];
			        break;
				end
			end
		else
			Cryolysis_BuffCast(11);
			DrinkLastRank = StoneMaxRank[3];
			DrinkLastName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]];
		end
	elseif type == "Drink" and button == "MiddleButton" then
		if Count.Drink > 0 then
			if (UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player")) 
			or CryolysisTradeRequest then
				Cryolysis_TradeExplore(DrinkLastName);
			end
		end
	-- Mount button
	elseif type == "Mount" and button == "LeftButton" then
		-- Soit c'est la monture épique
		if Mount.Available then
   			UseContainerItem(Mount.Location[1], Mount.Location[2]);
			Cryolysis_OnUpdate();
		-- Soit c'est la monture classique
		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoRiding, "USER");
		end
	elseif type == "Mount" and button == "RightButton" then
	    if (HearthstoneOnHand) then
			-- Use
			UseContainerItem(HearthstoneLocation[1], HearthstoneLocation[2]);
			-- If there isn't one in the inventory and you right-click
		else
			Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.NoHearthStone, "USER");
		end
	end
end


function Cryolysis_MoneyToggle()
	for index=1, 10 do
		local text = getglobal("CryolysisTooltipTextLeft"..index);
			--text:SetText(nil);
			text = getglobal("CryolysisTooltipTextRight"..index);
			--text:SetText(nil);
	end
	CryolysisTooltip:Hide();
	CryolysisTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
end

function Cryolysis_GameTooltip_ClearMoney()
    -- Intentionally empty; don't clear money while we use hidden tooltips
end


--Function to place the buttons around Cryolysis (and to grow/shrink the interface…) 
function Cryolysis_UpdateButtonsScale()
	local NBRScale = (100 + (CryolysisConfig.CryolysisButtonScale - 85)) / 100;
	if CryolysisConfig.CryolysisButtonScale <= 95 then
		NBRScale = 1.1;
	end
	if CryolysisConfig.CryolysisLockServ then
		Cryolysis_ClearAllPoints();
		HideUIPanel(CryolysisPortalMenuButton);
		HideUIPanel(CryolysisBuffMenuButton);
		HideUIPanel(CryolysisMountButton);
		HideUIPanel(CryolysisFoodButton);
		HideUIPanel(CryolysisDrinkButton);
		HideUIPanel(CryolysisManastoneButton);
		HideUIPanel(CryolysisEvocationButton);
		HideUIPanel(CryolysisLeftSpellButton);
		HideUIPanel(CryolysisRightSpellButton);
		local indexScale = -18;
		for index=1, 9, 1 do
			if CryolysisConfig.StonePosition[index] then
				if index == 1 and StoneIDInSpellTable[4] ~= 0 then
					CryolysisFoodButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisFoodButton);
					indexScale = indexScale + 36;
				end
				if index == 2 and StoneIDInSpellTable[3] ~= 0 then
					CryolysisDrinkButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisDrinkButton);
					indexScale = indexScale + 36;
				end
				if index == 3 and StoneIDInSpellTable[2] ~= 0 then
					CryolysisManastoneButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisManastoneButton);
					indexScale = indexScale + 36;
				end
				if index == 4 then
					CryolysisLeftSpellButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisLeftSpellButton);
					indexScale = indexScale + 36;
				end
				if index == 5 and StoneIDInSpellTable[1] ~= 0 then
					CryolysisEvocationButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisEvocationButton);
					indexScale = indexScale + 36;
				end	
				if index == 6 then
					CryolysisRightSpellButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisRightSpellButton);
					indexScale = indexScale + 36;
				end
				if index == 7 and BuffMenuCreate ~= {} then
					CryolysisBuffMenuButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisBuffMenuButton);
					indexScale = indexScale + 36;
				end
				if index == 8 and Mount.Available then
					CryolysisMountButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisMountButton);
					indexScale = indexScale + 36;
				end
				if index == 9 and PortalMenuCreate ~= {} then
					CryolysisPortalMenuButton:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(CryolysisConfig.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(CryolysisConfig.CryolysisAngle-indexScale)));
					ShowUIPanel(CryolysisPortalMenuButton);
					indexScale = indexScale + 36;
				end
			end
		end
	end
end 



-- Function (XML) to restore the buttons around the sphere
function Cryolysis_ClearAllPoints()
	CryolysisFoodButton:ClearAllPoints();
	CryolysisDrinkButton:ClearAllPoints();
	CryolysisManastoneButton:ClearAllPoints();
	CryolysisLeftSpellButton:ClearAllPoints();
	CryolysisEvocationButton:ClearAllPoints();
	CryolysisRightSpellButton:ClearAllPoints();
	CryolysisMountButton:ClearAllPoints();
	CryolysisPortalMenuButton:ClearAllPoints();
	CryolysisBuffMenuButton:ClearAllPoints();
end

-- Function (XML) to extend the NoDrag property () principal button of Cryolysis on all its buttons 
function Cryolysis_NoDrag()
	CryolysisFoodButton:RegisterForDrag("");
	CryolysisDrinkButton:RegisterForDrag("");
	CryolysisManastoneButton:RegisterForDrag("");
	CryolysisLeftSpellButton:RegisterForDrag("");
	CryolysisEvocationButton:RegisterForDrag("");
	CryolysisRightSpellButton:RegisterForDrag("");
	CryolysisMountButton:RegisterForDrag("");
	CryolysisPortalMenuButton:RegisterForDrag("");
	CryolysisBuffMenuButton:RegisterForDrag("");
end

-- Function (XML) opposite of above
function Cryolysis_Drag()
	CryolysisFoodButton:RegisterForDrag("LeftButton");
	CryolysisDrinkButton:RegisterForDrag("LeftButton");
	CryolysisManastoneButton:RegisterForDrag("LeftButton");
	CryolysisLeftSpellButton:RegisterForDrag("LeftButton");
	CryolysisEvocationButton:RegisterForDrag("LeftButton");
	CryolysisRightSpellButton:RegisterForDrag("LeftButton");
	CryolysisMountButton:RegisterForDrag("LeftButton");
	CryolysisPortalMenuButton:RegisterForDrag("LeftButton");
	CryolysisBuffMenuButton:RegisterForDrag("LeftButton");
end

-- Opening of the buff menu
function Cryolysis_BuffMenu(button)
	if button == "RightButton" and Private.LastBuff ~= 0 then
		Cryolysis_BuffCast(Private.LastBuff);
		return;
	end
	Private.BuffMenuShow = not Private.BuffMenuShow;
	if not Private.BuffMenuShow then
		Private.BuffShow = false;
		Private.BuffVisible = false;
		CryolysisBuffMenuButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\BuffMenuButton-01");
		BuffMenuCreate[1]:ClearAllPoints();
		BuffMenuCreate[1]:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		Private.AlphaBuffMenu = 1;
	else
		Private.BuffShow = true;
		CryolysisBuffMenuButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\BuffMenuButton-02");
		-- If right click, the menu of buff remains open 
		if button == "MiddleButton" then
			Private.BuffVisible = true;
		end
		-- If there aren't any buffs, don't do anything
		if BuffMenuCreate == nil then
			return;
		end
		-- If not the icons are displayed
		CryolysisBuffMenu1:SetAlpha(1);
		CryolysisBuffMenu2:SetAlpha(1);
		CryolysisBuffMenu3:SetAlpha(1);
		CryolysisBuffMenu4:SetAlpha(1);
		CryolysisBuffMenu5:SetAlpha(1);
		CryolysisBuffMenu6:SetAlpha(1);
		CryolysisBuffMenu7:SetAlpha(1);
		CryolysisBuffMenu8:SetAlpha(1)
		BuffMenuCreate[1]:ClearAllPoints();		
		BuffMenuCreate[1]:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31) , CryolysisConfig.BuffMenuAnchor);
		Private.AlphaPortalVar = GetTime() + 3;
		Private.AlphaBuffVar = GetTime() + 6;
	end
end

-- Opening the Portal menu
function Cryolysis_PortalMenu(button)
	if button == "RightButton" and Private.LastPortal ~= 0 then
		Cryolysis_PortalCast(Private.LastPortal);
		return;
	end
	-- If they aren't any teleport spells dont do anything
	if PortalMenuCreate[1] == nil then
		return;
	end

	Private.PortalMenuShow = not Private.PortalMenuShow;
	if not Private.PortalMenuShow then
		Private.PortalShow = false;
		Private.PortalVisible = false;
		CryolysisPortalMenuButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalMenuButton-01");
		PortalMenuCreate[1]:ClearAllPoints();
		PortalMenuCreate[1]:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		Private.AlphaPortalMenu = 1;
	else
		Private.PortalShow = true;
		CryolysisPortalMenuButton:SetNormalTexture("Interface\\Addons\\Cryolysis\\UI\\PortalMenuButton-02");
		-- If right click, the portal menu remains open 
		if button == "MiddleButton" then
			Private.PortalVisible = true;
		end
		-- Sinon on affiche les icones (on les déplace sur l'écran)
		CryolysisPortalMenu1:SetAlpha(1);
		CryolysisPortalMenu2:SetAlpha(1);
		CryolysisPortalMenu3:SetAlpha(1);
		CryolysisPortalMenu4:SetAlpha(1);
		CryolysisPortalMenu5:SetAlpha(1);
		CryolysisPortalMenu6:SetAlpha(1);
		CryolysisPortalMenu7:SetAlpha(1);
		CryolysisPortalMenu8:SetAlpha(1);
		CryolysisPortalMenu9:SetAlpha(1);
		CryolysisPortalMenu10:SetAlpha(1);
		CryolysisPortalMenu11:SetAlpha(1);
		CryolysisPortalMenu12:SetAlpha(1);
		PortalMenuCreate[1]:ClearAllPoints();		
		PortalMenuCreate[1]:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31) , CryolysisConfig.PortalMenuAnchor);
		Private.AlphaPortalVar = GetTime() + 3;
	end
end

-- Whenever the spell book changes, when the mod loads, and when the menu is rotated eith the spell menus
function Cryolysis_CreateMenu()
	PortalMenuCreate = {};
	BuffMenuCreate = {};
	local menuVariable = nil;
	local PortalButtonPosition = 0;
	local BuffButtonPosition = 0;
	
	-- Hide portal menu
	for i = 1, 12, 1 do
		menuVariable = getglobal("CryolysisPortalMenu"..i);
		menuVariable:Hide();
	end
	-- Hide buff menu
	for i = 1, 8, 1 do
		menuVariable = getglobal("CryolysisBuffMenu"..i);
		menuVariable:Hide();
	end
	-- Start placing portals on the menu
	if CRYOLYSIS_SPELL_TABLE[38].ID then
		menuVariable = getglobal("CryolysisPortalMenu1");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 1;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[40].ID then
		menuVariable = getglobal("CryolysisPortalMenu2");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 2;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[39].ID then
		menuVariable = getglobal("CryolysisPortalMenu3");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 3;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[47].ID then
		menuVariable = getglobal("CryolysisPortalMenu7");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 7;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[31].ID then
		menuVariable = getglobal("CryolysisPortalMenu8");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 8;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[30].ID then
		menuVariable = getglobal("CryolysisPortalMenu9");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 9;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[37].ID then
		menuVariable = getglobal("CryolysisPortalMenu4");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 4;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[51].ID then
		menuVariable = getglobal("CryolysisPortalMenu5");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 5;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[46].ID then
		menuVariable = getglobal("CryolysisPortalMenu6");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 6;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[28].ID then
		menuVariable = getglobal("CryolysisPortalMenu10");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 10;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[29].ID then
		menuVariable = getglobal("CryolysisPortalMenu11");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 11;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[27].ID then
		menuVariable = getglobal("CryolysisPortalMenu12");
		menuVariable:ClearAllPoints();
		if PortalButtonPosition == 0 then 
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / CryolysisConfig.PortalMenuPos) * 31), 0);
		end
		PortalButtonPosition = 12;
		table.insert(PortalMenuCreate, menuVariable);
	end
	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are displayed
	for i = 1, table.getn(PortalMenuCreate), 1 do
		ShowUIPanel(PortalMenuCreate[i]);
	end



	-- If Ice Armor exists, it is posted on the buff menu
	if CRYOLYSIS_SPELL_TABLE[22].ID or CRYOLYSIS_SPELL_TABLE[18].ID then
		menuVariable = getglobal("CryolysisBuffMenu1");
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		BuffButtonPosition = 1;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[4].ID then
		menuVariable = getglobal("CryolysisBuffMenu2");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 2;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[13].ID then
		menuVariable = getglobal("CryolysisBuffMenu3");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 3;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[25].ID or CRYOLYSIS_SPELL_TABLE[23].ID then
		menuVariable = getglobal("CryolysisBuffMenu4");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 4;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[15].ID then
		menuVariable = getglobal("CryolysisBuffMenu5");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 5;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[50].ID then
		menuVariable = getglobal("CryolysisBuffMenu6");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 6;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[33].ID then
		menuVariable = getglobal("CryolysisBuffMenu7");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 7;
		table.insert(BuffMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[35].ID then
		menuVariable = getglobal("CryolysisBuffMenu8");
		menuVariable:ClearAllPoints();
		if BuffButtonPosition == 0 then
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", 3000, 3000);
		else
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / CryolysisConfig.BuffMenuPos) * 31), 0);
		end
		BuffButtonPosition = 8;
		table.insert(BuffMenuCreate, menuVariable);
	end

	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are posted 
	for i = 1, table.getn(BuffMenuCreate), 1 do
		ShowUIPanel(BuffMenuCreate[i]);
	end
end


-- management of spell button casting
function Cryolysis_SpellButtonCast(side, click)
	local spell, type;
	if side == "Left" then 
		spell = CryolysisConfig.LeftSpell;
	else
		spell = CryolysisConfig.RightSpell;
	end
	-- assign spell based on settings
	if spell == 1 then
		type = 22; -- Ice armor, mage armor
	elseif spell == 2 then
		type = 4;  -- Arcane Int, Arcane Brill
	elseif spell == 3 then
		type = 13; -- Dampen magic, Amplify magic
	elseif spell == 4 then
		type = 23; -- ice barrier, mana shield
	elseif spell == 5 then
		type = 15; -- Fire ward, frost ward;
	elseif spell == 6 then
		type = 50; -- Detect magic
	elseif spell == 7 then
		type = 33; -- Decurse
	elseif spell == 8 then
		type = 35; -- Slow fall
	end
	Cryolysis_BuffCast(type, click);
end
-- management of buff menu casting
function Cryolysis_BuffCast(type, click)
    DoEmote("stand");
	local TargetEnemy = false;
	if not UnitIsFriend("player","target") or not UnitExists("target") then
		if type ~= 50 and type ~= 10 and type ~= 11 and type ~= 49 and type ~= 23 and type ~= 25 then
			TargetUnit("player");
			TargetEnemy = true;
		end
	end
	-- If the mage has frost armor but not ice armor
	if not CRYOLYSIS_SPELL_TABLE[type].ID and type ~= 23 then
		CastSpell(CRYOLYSIS_SPELL_TABLE[18].ID, "spell");
	elseif click == "RightButton" then
		-- Ice armor or Mage armor
		if type == 22 and CRYOLYSIS_SPELL_TABLE[24].ID ~= nil then
			CastSpell(CRYOLYSIS_SPELL_TABLE[24].ID, "spell");
			Private.LastBuff = 24;
		-- Arcane Intellect or Arcane Brilliance
		elseif type == 4 and CRYOLYSIS_SPELL_TABLE[2].ID ~= nil then
			CastSpellByName(CRYOLYSIS_SPELL_TABLE[2].Name);
			Private.LastBuff = 2;
		-- Dampen or Amplify Magic
		elseif type == 13 and CRYOLYSIS_SPELL_TABLE[1].ID ~= nil then
			CastSpell(CRYOLYSIS_SPELL_TABLE[1].ID, "spell");
			Private.LastBuff = 1;
		-- Ice barrier or mana shield
		elseif type == 23 and CRYOLYSIS_SPELL_TABLE[25].ID ~= nil then
			CastSpell(CRYOLYSIS_SPELL_TABLE[25].ID, "spell");
		-- Fire Ward or Frost Ward
		elseif type == 15 and CRYOLYSIS_SPELL_TABLE[20].ID ~= nil then
			CastSpell(CRYOLYSIS_SPELL_TABLE[20].ID, "spell");
			Private.LastBuff = 20;				
		elseif type == 33 then
			Cryolysis_Decursive();
		else
			CastSpell(CRYOLYSIS_SPELL_TABLE[type].ID, "spell");
			Private.LastBuff = type;
		end
	else
		if type == 4  then
			--for i=pairs(CRYOLYSIS_SPELL_TABLE[4].Rank, 1, -1) do
			--	local MinLev = (i * 14) - 24
			--	if UnitLevel("target") >= MinLev then
					CastSpellByName(CRYOLYSIS_SPELL_TABLE[4].Name);--.."("..CRYOLYSIS_TRANSLATION.Rank.." "..i..")");
			--		break;
			--	end
			--end
		elseif type == 33 then
			Cryolysis_Decursive();
		elseif type == 23 then
			if CRYOLYSIS_SPELL_TABLE[23].ID then
				CastSpell(CRYOLYSIS_SPELL_TABLE[23].ID, "spell");
			else
				CastSpell(CRYOLYSIS_SPELL_TABLE[25].ID, "spell");
			end
		else
			CastSpellByName(CRYOLYSIS_SPELL_TABLE[type].Name);
		end
		if type ~= 10 and type ~= 11 and type ~= 49 then Private.LastBuff = type; end
	end
	if TargetEnemy then TargetLastTarget(); end
	AlphaBuffMenu = 1;
	AlphaBuffVar = GetTime() + 3;
end

-- Management of portal menu casting
function Cryolysis_PortalCast(type, click)
	if type <=6 and Count.RuneOfTeleportation == 0 then
		Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.RuneOfTeleportationNotPresent, "USER");
		return;
	elseif type >= 7 and Count.RuneOfPortals == 0 then
		Cryolysis_Msg(CRYOLYSIS_MESSAGE.Error.RuneOfPortalsNotPresent, "USER");
		return;
	end
	Private.LastPortal = type;
	CastSpell(CRYOLYSIS_SPELL_TABLE[PortalTempID[type]].ID, "spell");
	Private.AlphaPortalMenu = 1;
	Private.AlphaPortalVar = GetTime() + 3;
end
-- Function allowing the display of the various pages of the config menu
function CryolysisGeneralTab_OnClick(id)
	local TabName;
	for index=1, 5, 1 do
		TabName = getglobal("CryolysisGeneralTab"..index);
		if index == id then
			TabName:SetChecked(1);
		else
			TabName:SetChecked(nil);
		end
	end
	if id == 1 then
		ShowUIPanel(CryolysisProvisionMenu);
		HideUIPanel(CryolysisMessageMenu);
		HideUIPanel(CryolysisButtonMenu);
		HideUIPanel(CryolysisTimerMenu);
		HideUIPanel(CryolysisGraphOptionMenu);
		CryolysisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		CryolysisGeneralPageText:SetText(CRYOLYSIS_CONFIGURATION.Menu1);
	elseif id == 2 then
		HideUIPanel(CryolysisProvisionMenu);
		ShowUIPanel(CryolysisMessageMenu);
		HideUIPanel(CryolysisButtonMenu);
		HideUIPanel(CryolysisTimerMenu);
		HideUIPanel(CryolysisGraphOptionMenu);
		CryolysisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		CryolysisGeneralPageText:SetText(CRYOLYSIS_CONFIGURATION.Menu2);
	elseif id == 3 then
		HideUIPanel(CryolysisProvisionMenu);
		HideUIPanel(CryolysisMessageMenu);
		ShowUIPanel(CryolysisButtonMenu);
		HideUIPanel(CryolysisTimerMenu);
		HideUIPanel(CryolysisGraphOptionMenu);
		CryolysisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		CryolysisGeneralPageText:SetText(CRYOLYSIS_CONFIGURATION.Menu3);
	elseif id == 4 then
		HideUIPanel(CryolysisProvisionMenu);
		HideUIPanel(CryolysisMessageMenu);
		HideUIPanel(CryolysisButtonMenu);
		ShowUIPanel(CryolysisTimerMenu);
		HideUIPanel(CryolysisGraphOptionMenu);
		CryolysisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		CryolysisGeneralPageText:SetText(CRYOLYSIS_CONFIGURATION.Menu4);
	elseif id == 5 then
		HideUIPanel(CryolysisProvisionMenu);
		HideUIPanel(CryolysisMessageMenu);
		HideUIPanel(CryolysisButtonMenu);
		HideUIPanel(CryolysisTimerMenu);
		ShowUIPanel(CryolysisGraphOptionMenu);
		CryolysisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon");
		CryolysisGeneralPageText:SetText(CRYOLYSIS_CONFIGURATION.Menu5);
	end
end



-- Bon, pour pouvoir utiliser le Timer sur les sorts instants, j'ai été obligé de m'inspirer de Cosmos
-- Comme je ne voulais pas rendre le mod dépendant de Sea, j'ai repris ses fonctions
-- Apparemment, la version Stand-Alone de ShardTracker a fait pareil :) :)
Cryolysis_Hook = function (orig,new,type)
	if(not type) then type = "before"; end
	if(not Hx_Hooks) then Hx_Hooks = {}; end
	if(not Hx_Hooks[orig]) then
		Hx_Hooks[orig] = {}; Hx_Hooks[orig].before = {}; Hx_Hooks[orig].before.n = 0; Hx_Hooks[orig].after = {}; Hx_Hooks[orig].after.n = 0; Hx_Hooks[orig].hide = {}; Hx_Hooks[orig].hide.n = 0; Hx_Hooks[orig].replace = {}; Hx_Hooks[orig].replace.n = 0; Hx_Hooks[orig].orig = getglobal(orig);
	else
		for key,value in pairs(Hx_Hooks[orig][type]) do if(value == getglobal(new)) then return; end end
	end
	Cryolysis_Push(Hx_Hooks[orig][type],getglobal(new)); setglobal(orig,function(...) Cryolysis_HookHandler(orig,arg); end);
end

Cryolysis_HookHandler = function (name,arg)
	local called = false; local continue = true; local retval;
	for key,value in pairs(Hx_Hooks[name].hide) do
		if(type(value) == "function") then if(not value(arg)) then continue = false; end called = true; end
	end
	if(not continue) then return; end
	for key,value in pairs(Hx_Hooks[name].before) do
		if(type(value) == "function") then value(arg); called = true; end
	end
	continue = false;
	local replacedFunction = false;
	for key,value in pairs(Hx_Hooks[name].replace) do
		if(type(value) == "function") then
			replacedFunction = true; if(value(arg)) then continue = true; end called = true;
		end
	end
	if(continue or (not replacedFunction)) then retval = Hx_Hooks[name].orig(arg); end
	for key,value in pairs(Hx_Hooks[name].after) do
		if(type(value) == "function") then value(arg); called = true;end
	end
	if(not called) then setglobal(name,Hx_Hooks[name].orig); Hx_Hooks[name] = nil; end
	return retval;
end

function Cryolysis_Push (table,val)
	if(not table or not table.n) then return nil; end
	table.n = table.n+1;
	table[table.n] = val;
end

function Cryolysis_UseAction(id, number, onSelf)
	Cryolysis_MoneyToggle();
	CryolysisTooltip:SetAction(id);
	local tip = tostring(CryolysisTooltipTextLeft1:GetText());
	if tip then
		SpellCastName = tip;
		SpellTargetName = UnitName("target");
		if not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end
	end
end

function Cryolysis_CastSpell(spellId, spellbookTabNum)
--	local Name, Rank = GetSpellName(spellId, spellbookTabNum);
--	if Rank ~= nil then
--  		local _, _, Rank2 = string.find(Rank, "(%d+)");
--        	SpellCastRank = tonumber(Rank2);
--	end
--	SpellCastName = Name;
--
--	SpellTargetName = UnitName("target");
--	if not SpellTargetName then
--		SpellTargetName = "";
--	end
--	SpellTargetLevel = UnitLevel("target");
--	if not SpellTargetLevel then
--		SpellTargetLevel = "";
--	end
end

function Cryolysis_CastSpellByName(Spell)
--	local _, _, Name = string.find(Spell, "(.+)%(");
--	local _, _, Rank = string.find(Spell, "([%d]+)");
--
--	if Rank ~= nil then
--    		local _, _, Rank2 = string.find(Rank, "(%d+)");
--      	SpellCastRank = tonumber(Rank2);
--	end
--
--	if not Name then
--		_, _, Name = string.find(Spell, "(.+)");
--	end
--	SpellCastName = Name;
--
--	SpellTargetName = UnitName("target");
--	if not SpellTargetName then
--		SpellTargetName = "";
--	end
--	SpellTargetLevel = UnitLevel("target");
--	if not SpellTargetLevel then
--		SpellTargetLevel = "";
--	end
end

function CryolysisTimer(nom, duree)
	local Cible = UnitName("target");
	local Niveau = UnitLevel("target");
	local truc = 6;
	if not Cible then
		Cible = "";
		truc = 2;
	end
	if not Niveau then
		Niveau = "";
	end

	SpellGroup, SpellTimer, TimerTable = CryolysisTimerX(nom, duree, truc, Cible, Niveau, SpellGroup, SpellTimer, TimerTable);
end

function CryolysisSpellCast(name)
	if string.find(name, "coa") then
		SpellCastName = CRYOLYSIS_SPELL_TABLE[22].Name;
		SpellTargetName = UnitName("target");
		if not SpellTargetName then
			SpellTargetName = "";
		end
		SpellTargetLevel = UnitLevel("target");
		if not SpellTargetLevel then
			SpellTargetLevel = "";
		end
		CastSpell(CRYOLYSIS_SPELL_TABLE[22].ID, "spell");
	end	
end
