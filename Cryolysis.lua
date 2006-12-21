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
Cryo = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Cryolysis")
local BS = AceLibrary("Babble-Spell-2.2")
local M = AceLibrary("Metrognome-2.0")
local D = AceLibrary("Deformat-2.0")
local _G = getfenv(0)

Cryo:RegisterDB("CryoDB", "CryoPCDB")
Cryo:RegisterDefaults("profile", {
	Version = CryolysisData.Version,       	-- The version from Localization.lua
	ProvisionContainer = 4,                 -- Where food/water is stored.  furthest bag on the keft
	ProvisionSort = true,                   -- Sort food and drink
	ProvisionDestroy = false,               -- Destroy Excess food and dirnk
	ConcentrationAlert = true,				-- Unused
	ShowSpellTimers = true,					-- Show spell timers
	ShowSpellTimerButton = true,           -- Hidden anchor
	ShowCooldowns = true,
	ShowDurations = true,
	ShowPolymorph = true,
	ShowSpellEffects = true,
	HPLimit = 85,								-- Eat food when under this amount
	MPLimit = 100,								-- Drink water when under this amount
	Button = 1,									-- Main button function.  1 = eat/drink, 2 = Evocation, 3 = polymorph
	Circle = 2,									-- Outside circle display.  0 = None 1 = HP, 2 = Mana, 3 = Evocation
	ManaStoneOrder = 2,         				-- 1 Weakest manastone first  2 Greatest manastone first
	ButtonText = true,							-- Show item count on buttons
	FoodCountText = true,						-- Show food count
	DrinkCountText = true,						-- Show drink count
	PowderCountText = false,                    -- Show arcane powder count
	FeatherCountText = true,                    -- Show light feather count
	RuneCountText = false,                      -- Show Rune of teleportation/portals count
	ManastoneCooldownText = true,               -- Show Mana gem cooldown
	EvocationCooldownText = false,              -- Show evocation cooldown
	CryolysisLockServ = true,
	CryolysisAngle = 180,   --          \/          \/
	StonePosition = {true, true, true, true, true, true, true, true, true},
	StoneLocation = {
		"CryolysisFoodButton",
		"CryolysisDrinkButton",
		"CryolysisManaStoneButton",
		"CryolysisLeftSpellButton",
		"CryolysisEvocationButton",
		"CryolysisRightSpellButton",
		"CryolysisBuffMenuButton",
		"CryolysisMountButton",
		"CryolysisPortalMenuButton",
	},
	CryolysisToolTip = true,
	LeftSpell = 4,
	RightSpell = 5,
	NoDragAll = false,
	ManaStoneMenuPos = 34,
	ManaStoneMenuAnchor = 26,
	PortalMenuPos = 34,
	PortalMenuAnchor = -6,
	BuffMenuPos = 34,
	BuffMenuAnchor = 20,
	ChatMsg = true,
	ChatType = true,
	CryolysisLanguage = GetLocale(),
	ShowCount = true,
	CountType = 5,                  -- Inside sphere display.  1 = none, 2 = food/drink, 3 = Evocation cooldown
	ConcentrationScale = 100,
	CryolysisButtonScale = 100,
	CryolysisStoneScale = 100,
	CryolysisColor = "Aqua",
	Sound = true,
	SpellTimerPos = 1,
	SpellTimerJust = "LEFT",
	Food = 1,                       -- I dont remember what this is
	Graphical = true,
	Yellow = true,
	SensListe = 1,
	SM = false,                         -- Short message
	QuickBuff = false,
	PolyScale = 100,
	PolyWarn = true,
	PolyBreak = true,
	PolyWarnTime = 7,
	PolyMessage = true,
	PortalMessage = true,
	TeleportMessage = true,
	SteedMessage = false,
	CooldownTimers = true,
	CombatTimers = true,
	Restock	= true,					-- Ask me if I want to restock.  If false, don't restock at all
	RestockConfirm = true,			-- Don't bother asking, just restock
	RestockTeleport = 10,			-- Restock to 10 Rune of Teleportation
	RestockPortals = 10,			-- Restock to 10 Rune of Portals
	RestockPowder = 20,				-- Restock to 20 Arcane Powder
	Skin = 1,
	AutoSkin = 0
})
Cryo:RegisterDefaults("char", {
	-- Menus : Allows recasting of the last spell by middle clicking
	LastPortal = 0,
	LastBuff = 0,
	PortalMess = nil,
	-- For Polymorph alerts
	PolyTarget = nil,
	PolyWarning = false,
	PolyWarnTime = 0,
	PolyMess = nil,
	PolyBreakTime = 0,

	-- ADDED by Eternally777, 12/11/2006@11:13EST
	highestWaterId = 0,
	highestWaterCount = 0,
	waterRanks = { 8079, 8078, 8077, 3772, 2136, 2288, 5350 }, -- Item IDs for Mage conjured water, in order from highest amount of mana restored to lowest.  ORDER DOES MATTER

	highestFoodId = 0,
	highestFoodCount = 0,
	foodRanks = { 22895, 8076, 8075, 1487, 1114, 1113, 5349 }, -- Item IDs for Mage conjured bread, in order from highest amount of health restored to lowest.  ORDER DOES MATTER

	manaStones = { 5513, 5514, 8007, 8008 },
	hasManaStones = { false, false, false, false },

	-- Cooldown vars
	EvocationCooldown = 0,
	EvocationCooldownText = "",
	ManastoneCooldown = 0,
	ManastoneCooldownText = "",
	ColdsnapCooldown = 0,
	ColdsnapCooldownText = "",
	IceblockCooldown = 0,
	IceblockCooldownText = "",

	-- Message vars
	PortalMess = 0,
	SteedMess = 0,
	RezMess = 0,
	TPMess = 0,
	-- Other vars
	Sitting = false,
	checkInv = true,
 	LoadCheck = true,
 	AQ = false,
 	ChatSilence = false
})

Cryo.textureDir = "Interface\\AddOns\\Cryolysis\\UI\\%s"

Cryolysis_Loaded = false

CryolysisBinding = {}
CryolysisBinding2 = {}
CryolysisAlreadyBind={}

-- Detect installation of mod
local CryolysisRL = true

-- Initialization of the variables used by Cryolysis for spells
local SpellCastName = nil
local SpellCastRank = nil
local SpellTargetName = nil
local SpellTargetLevel = nil
local SpellCastTime = 0
local CombustionFade = false
local PoMFade = false
-- Initialization of the tables to manage timers
-- One for spell timers, one for mob groups, and the last allows the association of a timer and graphic frame
-- Le dernier permet l'association d'un timer �une frame graphique
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

local debuff = {
	-- Winter's Chill
	chillCount = 0;
	chillDuration = 0;
	chillChance = 1.00;
	chillApplied = 0;
	-- Fire Vulnerability
	fireCount = 1;
	fireDuration = 1;
	fireChance = 1.00;
	fireApplied = 0;
	-- Polymorph Diminishing returns
	drTarget = nil;
	drApplied = 0;
	drDuration = 15;
	drPlayer = false;
	drReset = 0;
};

-- Localizations moved to their respective files
local PortalTempID = {38, 40, 39, 37, 51, 46, 47, 31, 30, 28, 29, 27}
local PortalName = {
	L["Orgrimmar"], L["Undercity"], L["Thunder Bluff"], L["Ironforge"], L["Stormwind"], L["Darnassus"],  -- 1-6, Teleports
	L["Orgrimmar"], L["Undercity"], L["Thunder Bluff"], L["Ironforge"], L["Stormwind"], L["Darnassus"]   -- 7-12, Portals
}

-- List Buttons available for the mage in each menu
local PortalMenuCreate = {}
local BuffMenuCreate = {}
local ManaStoneMenuCreate = {}
CryolysisButtonTexture = {
	["Skin"] = 0,
	["Text"] = "",
	["Circle"] = 0,
	["Stones"] = { ["Base"] = {}, ["Highlight"] = {}, ["Text"] = {}, ["Other"] = {}, ["Other2"] = {} },
	["Portalmenu"] = { ["Base"] = {}, ["Highlight"] = {}, ["Other"] = {} },
	["Buffmenu"] = { ["Base"] = {}, ["Highlight"] = {}, ["Other"] = {} }
}
CryolysisSpellButtons = {
	{ ["ID"] = 22, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\FrostArmor-0" 	},
	{ ["ID"] = 04, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\ArcaneIntellect-0" 	},
	{ ["ID"] = 13, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\DampenMagic-0" 	},
	{ ["ID"] = 23, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\IceBarrier-0" 	},
	{ ["ID"] = 15, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\FireWard-0" 		},
	{ ["ID"] = 26, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\DetectMagic-0" 	},
	{ ["ID"] = 33, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\RemoveCurse-0" 	},
	{ ["ID"] = 35, ["Texture"] = "Interface\\AddOns\\Cryolysis\\UI\\SlowFall-0" 		}
}

for i=1, 10, 1 do
	CryolysisButtonTexture.Stones.Base[i] = 0
	CryolysisButtonTexture.Stones.Highlight[i] = 0
	CryolysisButtonTexture.Stones.Other[i] = 0
	CryolysisButtonTexture.Stones.Other2[i] = 0
end
for i=1, 8, 1 do
	CryolysisButtonTexture.Portalmenu.Base[i] = 0
	CryolysisButtonTexture.Portalmenu.Highlight[i] = 0
	CryolysisButtonTexture.Portalmenu.Other[i] = 0
end
for i=1, 13, 1 do
	CryolysisButtonTexture.Buffmenu.Base[i] = 0
	CryolysisButtonTexture.Buffmenu.Highlight[i] = 0
	CryolysisButtonTexture.Buffmenu.Other[i] = 0
end
local Skin = { "Bleu", "Orange", "Turquoise", "Violet" }

-- Variable uses to manage mounting
local Mount = {
 	Name = "none";
	Title = "none";
	Icon = nil;
	Location = {nil, nil};
	Available = false;
	AQChecked = false;
	AQMount = false;
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
	ArcanePowder = 0;
	LightFeather = 0;
	Food = 0;
	Drink = 0;
	FoodLastRank = nil;
	FoodLastName = "none";
	DrinkLastRank = nil;
	DrinkLastName = "none";
}
-- Variables used for the Spell button mangement and use of the reagents
local StoneIDInSpellTable = {0, 0, 0, 0}
local Manastone = {
	["OnHand"] = {false, false, false, false},
	["Location"] = {
		{nil, nil},
		{nil, nil},
		{nil, nil},
		{nil, nil}
	},
	["Mode"] = { 1, 1, 1, 1 },
	["MP"] = { 530, 800, 1130, 1470 },
	["Restore"] = { "375-425", "550-650", "775-925", "1000-1200" },
	["RankID"] = { nil, nil, nil, nil },
	["currentStone"] = 0, -- Highest rank stone available, or highest rank if none available
	["conjureStone"] = 1, -- Next stone to be conjured
	["useableStone"] = 0, -- 0 = Stone not useable; 1 = usable
	["conjureStoneMP"] = 0
}
local StoneMaxRank = {0, 0, 0, 0}
local FoodLocation = { nil, nil }
local DrinkLocation = { nil, nil }
local HearthstoneOnHand = false
local HearthstoneLocation = { nil, nil }

-- Variables used in the management of demons			-- Portals?
local PortalType = nil;

-- Variables used for trading
local CryolysisTradeRequest = false;
local Trading = false;
local TradingNow = 0;

-- Additional variables moved here to try to reduce garbage
local curTime = GetTime();
local timerDisplay = "";
local update = false;
local frameName;
local frameItem;
local Sphere = { ["display"] = "", ["color"] = 0, ["texture"] = 0, ["skin"] = "" }
local SortActif;
-- Texture Information for reordering organization
Cryolysis_ReorderTexture = { };
HideUIPanel(CryolysisRightSpellButton);
-- Management of the tooltips Cryolysis allows (without the money frame)
local Original_GameTooltip_ClearMoney;

local Cryolysis_In = true;

local cryoEvents = {
	"BAG_UPDATE",
	"CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE",
	"CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS",
	"CHAT_MSG_SPELL_AURA_GONE_SELF",
	"CHAT_MSG_SPELL_AURA_GONE_OTHER",
	"CHAT_MSG_SPELL_BREAK_AURA",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
	"MERCHANT_SHOW",
	"MERCHANT_CLOSED",
	"UNIT_SPELLCAST_FAILED",
	"UNIT_SPELLCAST_INTERRUPTED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_SPELLCAST_SENT",
	"LEARNED_SPELL_IN_TAB",
	"CHAT_MSG_SPELL_SELF_DAMAGE",
	"PLAYER_TARGET_CHANGED",
	"TRADE_REQUEST_CANCEL",
	"TRADE_SHOW",
	"TRADE_CLOSED",
	"VARIABLES_LOADED"
}

------------------------------------------------------------------------------------------------------
-- FUNCTIONS CRYOLYSIS APPLIES WHEN YOU LOG IN
------------------------------------------------------------------------------------------------------
function Cryo:OnInitialize()
	local _, class = UnitClass("player")
	self.UnitClass = class
	if ( self.UnitClass ~= "MAGE" ) then
		return
	end
	M:Register("Cryo_UpdateFunc", Cryo.CryolysisButton_OnUpdate, 0.1, self)
end

function Cryo:OnEnable()
	self:LoadVariables()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterBucketEvent("BAG_UPDATE", 1)
	
	self:RegisterEvent("UNIT_SPELLCAST_FAILED", "SpellFailed")
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", "SpellFailed")
	
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("UNIT_SPELLCAST_SENT")
	
	self:RegisterEvent("TRADE_SHOW")
	self:RegisterEvent("TRADE_CLOSED")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("MERCHANT_CLOSED")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_SELF", "AuraGoneSelf")
	self:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA", "AuraGoneSelf")
	self:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER")
	self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
end

function Cryo:OnDisable()
end

-- Function applied to login
function Cryo:CryolysisButton_OnLoad()

	-- Recording of the graphic components
	CryolysisButton:RegisterForDrag("LeftButton")
	CryolysisButton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	CryolysisButton:SetFrameLevel(1)

	-- recording console commands
	SlashCmdList["CryolysisCommand"] = Cryolysis_SlashHandler
	SLASH_CryolysisCommand1 = "/cryo"
end

-- Function applied once parameters of the mods charged
function Cryo:LoadVariables()
	local _, class = UnitClass("player")
	if (( Cryolysis_Loaded ) or ( class ~= "MAGE" )) then
		return
	end
	Cryo_Init()
	Cryolysis_Loaded = true
end

------------------------------------------------------------------------------------------------------
-- CRYOLYSIS FUNCTIONS
------------------------------------------------------------------------------------------------------

-- Function launched to the update of the interface (main) -- every 0.1 seconds
function Cryo:CryolysisButton_OnUpdate()
	if (( not Cryolysis_Loaded ) and ( self.UnitClass ~= "MAGE" )) then
		return
	end
	
	if ( Cryo.db.char.LoadCheck ) then
		self:BagExplore()
		self:UpdateButtonsScale()
		Cryo.db.char.LoadCheck = false
 	end
	-- Management of Provisions: Sorting every second
	curTime = GetTime()
	if (( curTime - ProvisionTime ) >= 1 ) then
		-- Adjust timers
		ProvisionTime = curTime
		if ( Cryo.db.char.PolyWarning == true ) then
			Cryo.db.char.PolyWarnTime = Cryo.db.char.PolyWarnTime - 1
		end
		if (( Cryo.db.profile.PolyBreak ) and ( Cryo.db.char.PolyBreakTime >= 0 )) then
			Cryo.db.char.PolyBreakTime = Cryo.db.char.PolyBreakTime - 1
			if ( Cryo.db.char.PolyBreakTime <= 0 ) then
				Cryo.db.char.PolyTarget = nil
			end
		end
		if ( Cryo.db.char.ManastoneCooldown > 0 ) then
			Cryo.db.char.ManastoneCooldown = Cryo.db.char.ManastoneCooldown - 1
			Cryo.db.char.ManastoneCooldownText = self:TimerFunction(Cryo.db.char.ManastoneCooldown)
		elseif ( Cryo.db.char.ManastoneCooldown <= 0 ) then
			Cryo.db.char.ManastoneCooldown = 0
			Cryo.db.char.ManastoneCooldownText = ""
		end
		if ( ProvisionMP > 0 ) then
			self:ProvisionSwitch("MOVE")
		end
	end
	-- Management of Polymorph stuff
	self:PolyCheck("warn")
	if (( curTime >= debuff.drReset ) and ( debuff.drPlayer )) then
		debuff.drTarget = nil
		debuff.drApplied = 0
		debuff.drDuration = 15
		debuff.drPlayer = false
		debuff.drReset = 0
		SpellCastName = CRYOLYSIS_SPELL_TABLE[67].Name
		SpellTargetName = creatureName
		self:SpellManagement()
	end
	----------------------------------------------------------
	-- Management of mage spells
	----------------------------------------------------------
	-- Management of spell timers
	if (( Cryo.db.profile.ShowSpellTimerButton ) and ( not CryolysisSpellTimerButton:IsVisible() )) then
		ShowUIPanel(CryolysisSpellTimerButton)
	elseif (( not Cryo.db.profile.ShowSpellTimerButton ) and ( CryolysisSpellTimerButton:IsVisible() )) then
		HideUIPanel(CryolysisSpellTimerButton)
	end
	timerDisplay = ""
	update = false
	if (( curTime - SpellCastTime ) >= 1 ) then
		SpellCastTime = curTime
		update = true
	end
--[[ TIMERS, O NOEZ!!!!11!one!																			
	if ( Cryo.db.profile.ShowSpellTimers ) then
		-- updates buttons every second
		if ( Cryo.db.profile.ShowSpellTimers ) then
			local GraphicalTimer = { texte = {}, TimeMax = {}, Time = {}, titre = {}, temps = {}, Gtimer = {} }
			if ( SpellTimer[1] ~= nil ) then
				for index = 1, #SpellTimer, 1 do
					if ( SpellTimer[index] ) then
						if ( curTime <= SpellTimer[index].TimeMax ) then
							timerDisplay, SpellGroup, GraphicalTimer, TimerTable = Cryolysis_DisplayTimer(timerDisplay, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable)
						end
						-- Action every second
						if ( update ) then
							-- Finished timers are removed
							if (( curTime >= ( SpellTimer[index].TimeMax - 0.5 )) and ( SpellTimer[index].TimeMax ~= -1 )) then
								if ( SpellTimer[index].Name ~= CRYOLYSIS_SPELL_TABLE[10].Name ) then
									SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable)
									index = 0
									break
								end
							end
							-- If the target of the spell is not reached (resists)
							if (( SpellTimer ) and ( SpellTimer[index].Type == 4 ) or ( SpellTimer[index].Type == 5 ) and ( SpellTimer[index].Target == UnitName("target") )) then
								-- Cheats by leaving timer on mob to detect that it is debuffed
								if ( curTime >= (( SpellTimer[index].TimeMax - SpellTimer[index].Time ) + 2.5 ) and ( SpellTimer[index] ~= 6 )) then
									if ( not self:UnitHasEffect("target", SpellTimer[index].Name) ) then
										SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable)
										index = 0
										break
									end
								end
							end
						end
					end
				end
			else
				for i = 1, 10, 1 do
					if ( _G["CryolysisTarget"..i.."Text"]:IsShown() ) then
						_G["CryolysisTarget"..i.."Text"]:Hide()
					end
				end
			end
			if Cryo.db.profile.ShowSpellTimers or Cryo.db.profile.Graphical then
				-- If posting text timers
				if ( not Cryo.db.profile.Graphical ) then
					timerDisplay = Cryo:MsgAddColor(timerDisplay)
					-- Posting the timers
					CryolysisListSpells:SetText(timerDisplay)
				else
					CryolysisListSpells:SetText("")
				end
				for i = 4, #SpellGroup.Name do
					SpellGroup.Visible[i] = false
				end
			else
				if ( CryolysisSpellTimerButton:IsVisible() ) then
					CryolysisListSpells:SetText("")
					HideUIPanel(CryolysisSpellTimerButton)
				end
			end
		end
	end
 END TIMER SECTION																				]]
	-- Upcate Evocation cooldown
	local start, duration = 1, 1
	if ( CRYOLYSIS_SPELL_TABLE[49].ID ~= nil ) then
		start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL)
	end
	if (( start > 0 ) and ( duration > 0 ) and ( EvocationUp == false )) then
  		Cryo.db.char.EvocationCooldown = ( duration - curTime - start )
		Cryo.db.char.EvocationCooldownText = self:TimerFunction(Cryo.db.char.EvocationCooldown)
	else  -- Evocation isn't on cooldown
		Cryo.db.char.EvocationCooldown = 0
		Cryo.db.char.EvocationCooldownText = ""
	end
	self:UpdateIcons()
end

function Cryo:PLAYER_ENTERING_WORLD()
	Cryolysis_In = true
	Cryo.db.char.LoadCheck = true
end

function Cryo:PLAYER_LEAVING_WORLD()
	Cryolysis_In = false
	Cryo.db.char.LoadCheck = false
end

function Cryo:BAG_UPDATE(...)
	if ( Cryo.db.char.LoadCheck ) then
		return
	end
	if ( Cryo.db.char.checkInv ) then
		self:BagCheck("Force")
		Cryo.db.char.checkInv = false
	else
		self:BagCheck()
	end
end

function Cryo:SpellFailed(unit)
	if ( unit == "player" ) then
		SpellCastName = nil
		SpellCastRank = nil
		SpellTargetName = nil
		SpellTargetLevel = nil
	end
end

function Cryo:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, ...)
	SpellCastUnit, SpellCastName = unit, spellName
	if ( unit == "player" ) then
		self:PolyCheck("stop", SpellCastName, SpellTargetName)
		self:BagCheck(SpellCastName)
		self:SpellManagement()
		Cryo.db.char.Sitting = false
	end
end

function Cryo:UNIT_SPELLCAST_SENT(unit, spell, rank, target)
	_, SpellCastName, SpellCastRank, SpellTargetName = unit, spell, rank, target or UnitName("target") or ""
	SpellTargetLevel = UnitLevel("target") or ""
	self:PolyCheck("start", SpellCastName, SpellTargetName)
	self:ChatMessage(SpellCastName, SpellTargetName)
end

function Cryo:TRADE_SHOW()
	CryolysisTradeRequest = true
	self:BagCheck("Force")
end

function Cryo:TRADE_CLOSED()
	CryolysisTradeRequest = false
	self:BagCheck("Update")
	self:ButtonTextUpdate()
end

function Cryo:LEARNED_SPELL_IN_TAB(...)
	self:SpellSetup()
	self:CreateMenu()
	self:ButtonSetup()
end

function Cryo:PLAYER_REGEN_ENABLED()
	PlayerCombat = false
	if ( Cryo.db.profile.ShowSpellTimers ) then
		SpellGroup, SpellTimer, TimerTable = Cryolysis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable)
		for i = 1, 10, 1 do
			if ( _G["CryolysisTarget"..i.."Text"]:IsShown() ) then
				_G["CryolysisTarget"..i.."Text"]:Hide()
			end
		end
	end
end

function Cryo:PLAYER_REGEN_DISABLED()
	if ( _G["CryolysisGeneralFrame"]:IsVisible() ) then
		_G["CryolysisGeneralFrame"]:Hide()
	end
	PlayerCombat = true
end

function Cryo:MERCHANT_SHOW()
	local Purchase, display, color = false, false
	for item = 1, GetMerchantNumItems(), 1 do
		local _, _, id = string.find(GetMerchantItemLink(item), "item:(%d+):")
		id = tonumber(id)
		if ( id == 17031 ) then
			self:BagCheck("Force")
			for i = 1, 6, 1 do
				if ( CRYOLYSIS_SPELL_TABLE[ PortalTempID[i] ].ID ) then
					display = true
					color = (( Count.RuneOfTeleportation / Cryo.db.profile.RestockTeleport ) * 100)
					if (( Cryo.db.profile.RestockTeleport - Count.RuneOfTeleportation ) > 0) then
						Purchase = true
						break
					end
				end
			end
			if ( display ) then
				Cryo:Msg( Cryo:MsgAddColor(CRYOLYSIS_ITEM.RuneOfTeleportation..": "..CryolysisTimerColor(color)..Count.RuneOfTeleportation.."/"..Cryo.db.profile.RestockTeleport), "USER" )
				display = false
			end
		elseif ( id == 17032 ) then
			self:BagCheck("Force")
			for i = 7, 12, 1 do
				if ( CRYOLYSIS_SPELL_TABLE[ PortalTempID[i] ].ID ) then
					display = true
					color = (( Count.RuneOfPortals / Cryo.db.profile.RestockPortals ) * 100)
					if (( Cryo.db.profile.RestockPortals - Count.RuneOfPortals ) > 0) then
						Purchase = true
						break
					end
				end
			end
			if ( display ) then
				Cryo:Msg( Cryo:MsgAddColor(CRYOLYSIS_ITEM.RuneOfPortals..": "..CryolysisTimerColor(color)..Count.RuneOfPortals.."/"..Cryo.db.profile.RestockPortals), "USER" )
				display = false
			end
		elseif ( id == 17020 ) then
			self:BagCheck("Force")
			if ( CRYOLYSIS_SPELL_TABLE[2].ID ) then
				display = true
				color = (( Count.ArcanePowder / Cryo.db.profile.RestockPowder ) * 100)
				if (( Cryo.db.profile.RestockPowder - Count.ArcanePowder ) > 0) then
			        Purchase = true
				end
			end
			if ( display ) then
				Cryo:Msg( Cryo:MsgAddColor(CRYOLYSIS_ITEM.ArcanePowder..": "..CryolysisTimerColor(color)..Count.ArcanePowder.."/"..Cryo.db.profile.RestockPowder), "USER" )
				display = false
			end
			if ( Purchase ) then
				self:BagExplore()
				if ( Cryo.db.profile.Restock ) then
					if ( Cryo.db.profile.RestockConfirm ) then
						StaticPopup_Show("RESTOCK_CONFIRMATION")
					else
						self:Restock()
					end
				end
			end
		end
	end
end

function Cryo:MERCHANT_CLOSED()
	StaticPopup_Hide("RESTOCK_CONFIRMATION")
	self:BagExplore()
end

function Cryo:ZONE_CHANGED_NEW_AREA()
	if (( string.find(GetRealZoneText(), "Ahn'Qiraj") ) and ( not string.find(GetRealZoneText(), "Gates") ) and ( not string.find(GetRealZoneText(), "Ruins") )) then
		if ( Cryo.db.char.AQ == false ) then
			Cryo.db.char.AQ = true
			Mount.AQChecked = false
			self:BagCheck("Force")
		end
	elseif ( Cryo.db.char.AQ == true ) then
		Cryo.db.char.AQ = false
		Mount.AQMount = false
		Mount.AQChecked = false
		Mount.Available = false
		self:BagCheck("Force")
	end
end

function Cryo:CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS(msg, ...)
	-- Using Deformat-2.0 here to extract the spell name by matching the global string with the message. See: http://www.wowace.com/wiki/Deformat-2.0
	local spell = D(msg, AURAADDEDSELFHELPFUL)
	if ( spell ) then
		if (( spell == BS["Evocation"] ) and ( self:PlayerHasSpell(BS["Evocation"]) )) then
			EvocationUp = false
			CryolysisEvocationButton:SetNormalTexture( string.format(self.textureDir, "Evocation-03") )
		elseif (( spell == BS["Ice Barrier"] ) and ( self:PlayerHasSpell(BS["Ice Barrier"]) )) then
			IceBarrierUp = false
			CryolysisBuffMenu4:SetNormalTexture( string.format(self.textureDir, "IceBarrier-03") )
		elseif (( spell == BS["Fire Ward"] ) and ( self:PlayerHasSpell(BS["Fire Ward"]) )) then
			FireWardUp = false
			CryolysisBuffMenu5:SetNormalTexture( string.format(self.textureDir, "FireWard-03") )
		elseif (( spell == BS["Frost Ward"] ) and ( self:PlayerHasSpell(BS["Frost Ward"]) )) then
			FireWardUp = false
			CryolysisBuffMenu5:SetNormalTexture( string.format(self.textureDir, "FireWard-03") )
		end
	end
end

function Cryo:AuraGoneSelf(msg, ...) --Called on "CHAT_MSG_SPELL_AURA_GONE_SELF" and "CHAT_MSG_SPELL_BREAK_AURA" events.
	local spell = D(msg, AURAREMOVEDSELF)
	if ( spell ) then
		if ( spell == BS["Combustion"] ) then
			SpellCastName = BS["Combustion"]
			CombustionFade = true
		end
		if ( spell == BS["Presence of Mind"] ) then
			SpellCastName = BS["Presence of Mind"]
			PoMFade = true
		end
		if (( CombustionFade == true ) or ( PoMFade == true )) then
			self:SpellManagement()
		end
	end
end

function Cryo:CHAT_MSG_SPELL_AURA_GONE_OTHER(msg, ...)
	local spell, creature = D(msg, AURAREMOVEDOTHER)
	if (( spell ) and ( creature )) then
		self:PolyCheck("break", spell, creature)
	end
end

function Cryo:CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE(msg, ...)
	local creature, spell = D(msg, AURAADDEDOTHERHARMFUL)
	if (( creature ) and ( spell )) then
		-- Frostbite
		if ( spell == BS["Frostbite"] ) then
			SpellCastName = spell
			SpellTargetName = creatureName
			self:SpellManagement()
   		-- Winter's Chill
		elseif ( string.find(spell, BS["Winter's Chill"]) ) then
			for i = #SpellTimer, 1, -1 do
				if ( string.find(SpellTimer[i].Name, BS["Winter's Chill"]) ) then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(i, SpellTimer, TimerTable)
				end
			end
			SpellCastName = spell
			SpellTargetName = creatureName
			self:SpellManagement()
   		-- Fire Vulnerability
		elseif ( string.find(spell, BS["Fire Vulnerability"]) ) then
			for i = #SpellTimer, 1, -1 do
				if ( string.find(SpellTimer[i].Name, BS["Fire Vulnerability"]) ) then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(i, SpellTimer, TimerTable)
				end
			end
			SpellCastName = spell
			SpellTargetName = creatureName
			self:SpellManagement()
			debuff.fireApplied = debuff.fireApplied + 1
			debuff.fireCount = debuff.fireCount + 1
			debuff.fireDuration = 30
		elseif ( spell == BS["Frost Nova"] ) then
			SpellCastName = CRYOLYSIS_SPELL_TABLE[66].Name
			SpellTargetName = CRYOLYSIS_SPELL_TABLE[19].Name
			SpellTargetLevel = ""
			self:SpellManagement()
		end
	end
end

------------------------------------------------------------------------------------------------------
-- CRYOLYSIS FUNCTION "ON EVENT"
------------------------------------------------------------------------------------------------------
function Cryo:SpellManagement()
	SortActif = false
	if ( SpellCastName ) then
		if ( Mount.Available ) then
			if ( string.find(SpellCastName, Mount.Title) ) then
				CryolysisMounted = true
				return
			end
		end
		-- If the spell is cold snap, remove frost timers
		if ( Cryo.db.profile.ShowSpellTimers ) then
			if (( SpellCastName == CRYOLYSIS_SPELL_TABLE[42].Name ) and ( CRYOLYSIS_SPELL_TABLE[42].ID ~= nil )) then
				for i = #SpellTimer, 1, -1 do
					if (( SpellTimer[i].Name == BS["Cone of Cold"] ) or ( SpellTimer[i].Name == BS["Frost Nova"] ) or ( SpellTimer[i].Name == BS["Frost Ward"] )
					   or ( SpellTimer[i].Name == BS["Ice Barrier"] ) or ( SpellTimer[i].Name == BS["Ice Block"] )) then
						SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(i, SpellTimer, TimerTable)
					end
				end
			end
			for spell in ipairs(CRYOLYSIS_SPELL_TABLE) do
				if ( not CRYOLYSIS_SPELL_TABLE[spell].Name ) then
					DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..spell)
				end
				local isPolySpell
				if (( CRYOLYSIS_SPELL_TABLE[spell].Name ) and ( string.find(CRYOLYSIS_SPELL_TABLE[spell].Name, BS["Polymorph"]) )) then
					isPolySpell = true
				end
				if ( SpellCastName == CRYOLYSIS_SPELL_TABLE[spell].Name ) then
					for i = 1, #SpellTimer, 1 do
						if (( SpellTimer[i].Name == SpellCastName ) and ( SpellTimer[i].Target == SpellTargetName )
						   and ( SpellTimer[i].TargetLevel == SpellTargetLevel ) and ( CRYOLYSIS_SPELL_TABLE[spell].Type ~= 4 )) then
							-- If the timer is already there, reapply it and put it on the bottom
							SpellTimer[i].Time = CRYOLYSIS_SPELL_TABLE[spell].Length
							SpellTimer[i].TimeMax = math.floor(GetTime() + CRYOLYSIS_SPELL_TABLE[spell].Length)
							-- adjusts the duration for polymorph based on the rank
							if ( isPolySpell ) then
								if ( SpellCastRank == nil ) then
									SpellCastRank = CRYOLYSIS_SPELL_TABLE[26].Rank
								end
								SpellTimer[i].Time, SpellTimer[i].TimeMax = self:PvPPoly(SpellTargetName)
							end
							SortActif = true
							break
						end
						-- If it is polymorph on a new target, remove the old polymorph timer
						if (( SpellTimer[i].Name == SpellCastName ) and ( isPolySpell ) and ( SpellTimer[i].Target ~= SpellTargetName )
						   or ( SpellTimer[i].TargetLevel ~= SpellTargetLevel )) then
							SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(i, SpellTimer, TimerTable);
							SortActif = false
							break
						end
						if ( SortActif ) then
							break
						end
					end
					if (( not SortActif ) and ( CRYOLYSIS_SPELL_TABLE[spell].Type ~= 0 )) then
						if ( isPolySpell ) then
							CRYOLYSIS_SPELL_TABLE[spell].Length = self:PvPPoly(SpellTargetName)
						end
						if (( spell ~= 43 or CombustionFade ) or ( spell ~= 44 or PoMFade )) then
							SpellGroup, SpellTimer, TimerTable = Cryolysis_InsertTimerParTable(spell, SpellTargetName, SpellTargetLevel, SpellGroup, SpellTimer, TimerTable)
							CombustionFade = false
						end
						break
					end
				end
			end
		end
	end
	SpellCastName = nil
	SpellCastRank = nil
end

--  Prepares sound and announcements for polymorph
function Cryo:PolyCheck(Type, spell, creatureName)
	if ( Type == "start" ) then
		-- Send chat message for polymorph
	elseif Type == "stop" then
		if (( Cryo.db.profile.PolyWarn ) and ( string.find(spell, BS["Polymorph"]) )) then
			-- End of adding (error 1147: attempt to perform arithmatic on a nil value)
			if (( SpellCastRank == nil ) and ( string.find(CRYOLYSIS_SPELL_TABLE[26].Rank, "(%d+)") )) then
				SpellCastRank = CRYOLYSIS_SPELL_TABLE[26].Rank
			else
				SpellCastRank = 1
			end
			Cryo.db.char.PolyWarnTime = ( string.find(SpellCastRank, "(%d+)") * 10 + 10) - Cryo.db.profile.PolyWarnTime
			Cryo.db.char.PolyBreakTime = string.find(SpellCastRank, "(%d+)") * 10 + 10
			Cryo.db.char.PolyWarning = true
			Cryo.db.char.PolyTarget = creatureName
		end
	elseif ( Type == "warn" ) then
		if (( Cryo.db.profile.Sound ) and ( Cryo.db.profile.PolyWarn ) and ( Cryo.db.char.PolyWarning ) and ( Cryo.db.char.PolyWarnTime <= 0 )) then
			PlaySoundFile(CRYOLYSIS_SOUND.SheepWarn)
			Cryo.db.char.PolyWarning = false
			Cryo.db.char.PolyWarnTime = 0
		end
	elseif (( Type == "break" ) and ( creatureName == Cryo.db.char.PolyTarget )) then
		if ( spell == BS["Polymorph"] ) then
			if (( Cryo.db.profile.Sound ) and ( Cryo.db.profile.PolyBreak ) and ( Cryo.db.char.PolyTarget == creatureName )) then
				PlaySoundFile(CRYOLYSIS_SOUND.SheepBreak)
				Cryo.db.char.PolyTarget = nil
			end
			for i = #SpellTimer, 1, -1 do
				if (( SpellTimer[i].Name == BS["Polymorph"] ) and ( SpellTimer[i].Target == creatureName )) then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(i, SpellTimer, TimerTable)
					break
				end
			end
			Cryo.db.char.PolyWarning = false
			Cryo.db.char.PolyWarnTime = 0
			Cryo.db.char.PolyTarget = nil
		elseif ( spell == BS["Polymorph: Pig"] ) then
			if (( Cryo.db.profile.Sound ) and ( Cryo.db.profile.PolyBreak ) and ( Cryo.db.char.PolyTarget == creatureName )) then
				PlaySoundFile(CRYOLYSIS_SOUND.PigBreak)
				Cryo.db.char.PolyTarget = nil
			end
			for i = #SpellTimer, 1, -1 do
				if (( SpellTimer[thistimer].Name == BS["Polymorph: Pig"] ) and ( SpellTimer[thistimer].Target == creatureName )) then
					SpellTimer, TimerTable = Cryolysis_RetraitTimerParIndex(thistimer, SpellTimer, TimerTable)
					break
				end
			end
			Cryo.db.char.PolyWarning = false
			Cryo.db.char.PolyWarnTime = 0
			Cryo.db.char.PolyTarget = nil
		end
		if (( debuff.drPlayer ) and ( creatureName == debuff.drTarget )) then
			debuff.drReset = GetTime() + 15
			SpellCastName = CRYOLYSIS_SPELL_TABLE[67].Name
			SpellTargetName = creatureName
			self:SpellManagement()
		end
	end
end

-- Adjusts the duration of Polymorph for PvP
function Cryo:PvPPoly(target)
	local retarget = false
	if ( UnitName("target") ~= target ) then
	--	TargetByName(target, true)
		retarget = true
	end
	if ( UnitIsPlayer("target") ) then
		if ( retarget ) then
	--	TargetLastTarget()
		end
		if ( debuff.drTarget ~= target ) then
			debuff.drTarget = target
			debuff.drApplied = 0
			debuff.drDuration = 15
			debuff.drPlayer = true
		end
		debuff.drDuration = 15 * (1 - ( debuff.drApplied * 0.25 ))
		debuff.drApplied = debuff.drApplied + 1
		if ( debuff.drApplied >= 4 ) then
			return 0, GetTime()
		else
			debuff.drReset = GetTime() + debuff.drDuration + 15
			return debuff.drDuration, math.floor(GetTime() + debuff.drDuration)
		end
	else
		if ( retarget ) then
		--	TargetLastTarget()
		end
		if ( SpellCastRank == nil ) then
			SpellCastRank = CRYOLYSIS_SPELL_TABLE[26].Rank
		end
		return string.find(SpellCastRank, "(%d+)") * 10 + 10, math.floor(GetTime() + (string.find(SpellCastRank, "(%d+)") * 10 + 10))
	end
end

--
function Cryo:ChatMessage(spell, creatureName)
 	if (( Cryo.db.char.ChatSilence ) or ( not Cryo.db.profile.ChatMsg )) then
		Cryo.db.char.ChatSilence = false
		return
	end
	-- Mount
	if ( Mount.Available ) then
		if ( spell == Mount.Title ) then
			if (( Cryo.db.profile.SteedMessage ) and ( string.find(SpellCastName, Mount.Title) )) then
	   			if ( not Cryo.db.profile.SM ) then
					local tempNum = math.random(1, #CRYOLYSIS_STEED_MESSAGE)
					while (( tempNum == Cryo.db.char.SteedMess ) and ( #CRYOLYSIS_STEED_MESSAGE >= 2 )) do
						tempNum = math.random(1, #CRYOLYSIS_STEED_MESSAGE)
					end
					Cryo.db.char.SteedMess = tempNum
					Cryo:Msg(Cryolysis_MsgReplace(CRYOLYSIS_STEED_MESSAGE[tempNum], nil, nil, Mount.Title), "SAY")
				end
				CryolysisMountButton:SetNormalTexture( string.format(self.textureDir, "MountButton"..Mount.Icon.."-02") )
			end
		end
	end
	-- Polymorph
	local isPolySpell = false
	if ( string.find(spell, BS["Polymorph"]) ) then
		if ( Cryo.db.profile.PolyMessage ) then
			if ( Cryo.db.char.PolyTarget ~= creatureName ) then
		   		if ( not Cryo.db.profile.SM ) then
					local i
					-- Sheep
					if ( spell == BS["Polymorph"] ) then
						i = math.random(1, #CRYOLYSIS_POLY_MESSAGE.Sheep)
						while (( i == Cryo.db.char.PolyMess ) and ( #CRYOLYSIS_POLY_MESSAGE.Sheep >= 2 )) do
							i = math.random(1, #CRYOLYSIS_POLY_MESSAGE.Sheep)
						end
						Cryo.db.char.PolyMess = i
						Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_POLY_MESSAGE.Sheep[i], creatureName), "GROUP" )
					-- Pig
					elseif ( spell == BS["Polymorph: Pig"] ) then
						i = math.random(1, #CRYOLYSIS_POLY_MESSAGE.Pig)
						while (( i == Cryo.db.char.PolyMess ) and ( #CRYOLYSIS_POLY_MESSAGE.Pig >= 2 )) do
							i = math.random(1, #CRYOLYSIS_POLY_MESSAGE.Pig)
						end
						Cryo.db.char.PolyMess = i
						Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_POLY_MESSAGE.Pig[i], creatureName), "GROUP" )
					-- Turtle
					elseif spell == CRYOLYSIS_SPELL_TABLE[52].Name then
						i = math.random(1, #(CRYOLYSIS_POLY_MESSAGE.Turtle))
						while i == Cryo.db.char.PolyMess and #(CRYOLYSIS_POLY_MESSAGE.Turtle) >= 2 do
							i = math.random(1, #(CRYOLYSIS_POLY_MESSAGE.Turtle))
						end
						Cryo.db.char.PolyMess = i
	     					Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_POLY_MESSAGE.Turtle[i], creatureName), "GROUP" )
					end
				elseif ( Cryo.db.profile.SM ) then
             			if ( string.find(spell, BS["Polymorph"]) ) then
      					Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_SHORT_MESSAGES[2], creatureName), "GROUP" )
					end
				end
			end
		end
	elseif ( spell == CRYOLYSIS_SPELL_TABLE[65].Name ) then
		local i = math.random(1, #CRYOLYSIS_FREEZE_MESSAGE)
		while (( i == Cryo.db.char.PolyMess ) and ( #CRYOLYSIS_FREEZE_MESSAGE >= 2 )) do
			i = math.random(1, #CRYOLYSIS_FREEZE_MESSAGE)
		end
		Cryo.db.char.PolyMess = i
		Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_FREEZE_MESSAGE[i], creatureName), "SAY" )
	-- Portals
	else
		local port
		for i in ipairs(PortalTempID) do
			if ( spell == CRYOLYSIS_SPELL_TABLE[ PortalTempID[i] ].Name ) then
				port = i
				break
			end
		end
		if ( not port ) then
			return
		end
		if ( Cryo.db.profile.PortalMessage ) then
			if ( not Cryo.db.profile.SM ) then
				if ( port <= 6 ) then
					local i = math.random(1, #CRYOLYSIS_TELEPORT_MESSAGE)
					while (( i == Cryo.db.char.PortalMess ) and ( #CRYOLYSIS_TELEPORT_MESSAGE >= 2 )) do
						i = math.random(1, #CRYOLYSIS_TELEPORT_MESSAGE)
					end
					Cryo.db.char.PortalMess = i
					Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_TELEPORT_MESSAGE[i], nil, PortalName[port]), "GROUP" )
				else
					local i = math.random(1, #CRYOLYSIS_PORTAL_MESSAGE)
					while (( i == Cryo.db.char.PortalMess ) and ( #CRYOLYSIS_PORTAL_MESSAGE >= 2 )) do
						i = math.random(1, #CRYOLYSIS_PORTAL_MESSAGE)
					end
					Cryo.db.char.PortalMess = i
					Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_PORTAL_MESSAGE[i], nil, PortalName[port]), "GROUP" )
				end
			else
				if ( port > 6 ) then
					Cryo:Msg( Cryolysis_MsgReplace(CRYOLYSIS_SHORT_MESSAGES[1], nil, PortalName[port]), "WORLD" )
				end
			end
		end
	end
end

function Cryo:Restock()
	local RestockCount = {}
	local RestockNames = { 17031, 17032, 17020 }
	for i = 1, 6, 1 do
		if ( CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].ID ) then
			RestockCount[1] = Cryo.db.profile.RestockTeleport - Count.RuneOfTeleportation
			break
		end
	end
	for i = 6, 12, 1 do
		if ( CRYOLYSIS_SPELL_TABLE[PortalTempID[i]].ID ) then
			RestockCount[2] = Cryo.db.profile.RestockPortals - Count.RuneOfPortals
			break
		end
	end
	if ( CRYOLYSIS_SPELL_TABLE[2].ID ) then
		RestockCount[3] = Cryo.db.profile.RestockPowder - Count.ArcanePowder
	end
	for item = 1, GetMerchantNumItems(), 1 do
		for i = 1, #RestockCount, 1 do
			local _, _, id = string.find(GetMerchantItemLink(item), "item:(%d+):")
			id = tonumber(id)
			if (( id == RestockNames[i] ) and ( RestockCount[i] > 0 )) then
				Cryo:Msg( CRYOLYSIS_MESSAGE.Information.Restock..RestockCount[i].." "..RestockNames[i], "USER" )
				local buycycles = math.floor(RestockCount[i] / 10) + 1
				for cycle = 1, buycycles, 1 do
					if ( RestockCount[i] > 10 ) then
						BuyMerchantItem(item, 10)
						RestockCount[i] = RestockCount[i] - 10
					elseif ( RestockCount[i] > 0 ) then
						BuyMerchantItem(item, RestockCount[i])
						RestockCount[i] = RestockCount[i] - RestockCount[i]
					end
					self:BagCheck("Update")
				end
			end
		end
	end
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF THE INTERFACE -- BONDS XML
------------------------------------------------------------------------------------------------------
-- Created by Lomig from the Cryolysis_Toggle() function.
function Cryo:UpdateMainButtonAttributes()
	CryolysisButton:SetAttribute("type2", "Toggle");
	CryolysisButton.Toggle = function () Cryo:ToggleOptions(); end
	if Cryo.db.profile.Button == 1 then
		CryolysisButton:SetAttribute("type1", "macro");
		local itemName1, ItemName2 = nil, nil;
		if Count.Food > 0 and FoodLocation[1] then
			itemName1 = GetItemInfo(GetContainerItemLink(FoodLocation[1], FoodLocation[2]))
		end
		if Count.Drink > 0 and DrinkLocation[1] then
			itemName2 = GetItemInfo(GetContainerItemLink(DrinkLocation[1], DrinkLocation[2]))
		end
		if itemName1 and itemName2 then
			CryolysisButton:SetAttribute("macrotext1", "/use "..itemName1.."\n/use "..itemName2)
		elseif itemName1 then
			CryolysisButton:SetAttribute("macrotext1", "/use "..itemName1);
		elseif itemName1 then
			CryolysisButton:SetAttribute("macrotext1", "/use "..itemName2);
		end
	elseif Cryo.db.profile.Button == 2 then
		CryolysisButton:SetAttribute("type1", "spell");
		CryolysisButton:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[49].Name);
	elseif Cryo.db.profile.Button == 3 then
		local morphs = {26, 48, 52};
		local availableMorphs = {};
		local spells = 0;
		for i=1, #morphs, 1 do
			if CRYOLYSIS_SPELL_TABLE[morphs[i]].ID then
				spells = spells + 1;
				availableMorphs[spells] = morphs[i];
			end
		end
		CryolysisButton:SetAttribute("type1", "spell");
		CryolysisButton:SetAttribute("spell1", CRYOLYSIS_SPELL_TABLE[availableMorphs[math.random(1, #availableMorphs)]].Name);
	elseif Cryo.db.profile.Button == 4 then
		CryolysisButton:SetAttribute("type1", "item");
		if Cryo.db.profile.ManaStoneOrder == 2 then
			for i = StoneMaxRank[2], 1, -1 do
				-- If there is one in the inventory
				if Manastone.OnHand[i] then
					local itemName, _, _, _, _, _, _, _ , _, _ = GetItemInfo(GetContainerItemLink(Manastone.Location[i][1], Manastone.Location[i][2]));
					CryolysisButton:SetAttribute("item1", itemName);
					break;
				end
			end
		elseif Cryo.db.profile.ManaStoneOrder == 1 then
			for i = 1, StoneMaxRank[2], 1  do
				-- If there is one in the inventory
				if Manastone.OnHand[i] then
					local itemName, _, _, _, _, _, _, _ , _, _ = GetItemInfo(GetContainerItemLink(Manastone.Location[i][1], Manastone.Location[i][2]));
					CryolysisButton:SetAttribute("item1", itemName);
					break;
				end
			end
		end
		CryolysisButton:SetAttribute("ctrl-type1", "spell");
		for i = StoneMaxRank[2], 1, -1 do
			if Manastone.Mode[i] == 1 then
				local spellName = GetSpellName(Manastone.RankID[i], "spell");
				CryolysisButton:SetAttribute("ctrl-spell1", spellName);
				break;
			end
		end
	elseif Cryo.db.profile.Button == 5 then
		CryolysisButton:SetAttribute("type1", "spell")
		CryolysisButton:SetAttribute("spell", CRYOLYSIS_SPELL_TABLE[7].Name)
	end
end

-- By right clicking on Cryolysis, one eats/drings or opens the control panels
function Cryo:ToggleOptions()
	if ( not InCombatLockdown() ) then
		if ( CryolysisGeneralFrame:IsVisible() ) then
			HideUIPanel(CryolysisGeneralFrame)
		else
			if ( Cryo.db.profile.SM ) then
				Cryo:Msg("!!! Short Messages : <brightGreen>On", "USER")
			end
			ShowUIPanel(CryolysisGeneralFrame)
			self:GeneralTab_OnClick(1)
		end
	end
end

-- Function allowing the movement of elements of Cryolysis on the screen
function Cryo:OnDragStart(b)
	if ( b == "CryolysisIcon" ) then
		GameTooltip:Hide()
	end
	b:StartMoving()
end

-- Function stopping the displacement of elements of Cryolysis on the screen
function Cryo:OnDragStop(b)
	if ( b == "CryolysisIcon" ) then
		self:BuildTooltip("OVERALL")
	end
	b:StopMovingOrSizing()
end

-- Function alternating Timers graphs and Timers texts
function Cryo:HideGraphTimer()
	for i = 1, 50, 1 do
		local elements = { "Text", "Bar", "Texture", "OutText" }
		if ( Cryo.db.profile.Graphical ) then
			if ( TimerTable[i] ) then
				for j = 1, 4, 1 do
					_G[ "CryolysisTimer"..i..elements[j] ]:Show()
				end
			end
		else
			for j = 1, 4, 1 do
				_G[ "CryolysisTimer"..i..elements[j] ]:Hide()
			end
		end
	end
end

-- Function managing the Sphere buttons
function Cryo:BuildTooltip(button, Type, anchor)
	-- If the position of the sphere buttons is bad, bye bye!
	if ( not Cryo.db.profile.CryolysisToolTip ) then
		return
	end
	-- Looks to see if Evocation or Wards is up
	local start, duration = 1, 1
	if ( CRYOLYSIS_SPELL_TABLE[49].ID ) then
		start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL)
	end
	local start2, duration2 = 1, 1
	if ( CRYOLYSIS_SPELL_TABLE[15].ID ) then
		start2, duration2 = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[15].ID, BOOKTYPE_SPELL)
	end
	local start3, duration3 = 1, 1
	if CRYOLYSIS_SPELL_TABLE[20].ID then
		start3, duration3 = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[20].ID, BOOKTYPE_SPELL)
	end
	local start4, duration4 = 1, 1
	if CRYOLYSIS_SPELL_TABLE[23].ID then
		start4, duration4 = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[23].ID, BOOKTYPE_SPELL)
	end
	-- Creation of the Sphere buttons...
	GameTooltip:SetOwner(button, anchor)
	GameTooltip:SetText(CryolysisTooltipData[Type].Label)
	-- ..... For the main Sphere
	if ( Type == "Main" ) then
		GameTooltip:AddLine(CryolysisTooltipData.Main.Food..Count.Food)
		GameTooltip:AddLine(CryolysisTooltipData.Main.Drink..Count.Drink)
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
		GameTooltip:AddLine(CryolysisTooltipData.Main.ArcanePowder..Count.ArcanePowder)
		GameTooltip:AddLine(CryolysisTooltipData.Main.LightFeather..Count.LightFeather)
	elseif ( Type == "Mount" ) then
		GameTooltip:SetText(CryolysisTooltipData[Type].Label..Mount.Title.."|r")
		self:MoneyToggle()
		CryolysisTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2])
		local itemName = tostring(CryolysisTooltipTextLeft5:GetText())
		if string.find(itemName, CRYOLYSIS_TRANSLATION.Cooldown) then
			GameTooltip:AddLine(CRYOLYSIS_TRANSLATION.Hearth.." - "..itemName)
		else
			GameTooltip:AddLine(CryolysisTooltipData["SpellTimer"].Right..GetBindLocation())
		end
	-- Manastone
	elseif ( Type == "Manastone" ) then
		local ManastoneTooltip = {
			CRYOLYSIS_STONE_RANK2[1]..CryolysisTooltipData.Manastone.Text[4],
			CRYOLYSIS_STONE_RANK2[2]..CryolysisTooltipData.Manastone.Text[4],
			CRYOLYSIS_STONE_RANK2[3]..CryolysisTooltipData.Manastone.Text[4],
			CRYOLYSIS_STONE_RANK2[4]..CryolysisTooltipData.Manastone.Text[4],
		}
		for i = StoneMaxRank[2], 1, -1  do
			if ( Manastone.Mode[i] == 2 ) then
				self:MoneyToggle()
				local start, duration, enable = GetContainerItemCooldown(Manastone.Location[i][1], Manastone.Location[i][2])
				if (( start > 0 ) and ( duration > 0 )) then
					local seconde = duration - ( GetTime() - start )
					local affiche, minute, Time
					if ( seconde <= 59 ) then
						affiche = tostring(math.floor(seconde)).." sec"
					else
						minute = tostring(math.floor(seconde/60))
						seconde = math.fmod(seconde, 60)
						if ( seconde < 10 ) then
							Time = "0"..tostring(math.floor(seconde))
						else
							Time = tostring(math.floor(seconde))
						end
						affiche = minute..":"..Time
					end
					GameTooltip:AddLine("Cooldown: "..affiche)
					GameTooltip:AddLine("")
					break
				end
			end
		end
		for i = StoneMaxRank[2], 1, -1 do
			if (( i == StoneMaxRank[2] ) and ( Manastone.Mode[i] == 1 )) then
				ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[1]..Manastone.MP[i].." Mana"
			elseif (( Manastone.Mode[i] == 1 ) and ( Manastone.Mode[i + 1] == 2 )) then
				ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[1]..Manastone.MP[i].." Mana"
			end
			if ( Cryo.db.profile.ManaStoneOrder == 2 ) then
				for j = 1, StoneMaxRank[2], 1 do
					if ( Manastone.Mode[j] == 2 ) then
						ManaStoneNext = j
					end
				end
				if (( Manastone.Mode[i] == 2 ) and ( i ~= ManaStoneNext )) then
					ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[3]
				elseif (( i == ManaStoneNext ) and ( Manastone.Mode[i] == 2 )) then
					ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData.Manastone.Text[2]..Manastone.Restore[i]
				end
			elseif ( Cryo.db.profile.ManaStoneOrder == 1 ) then
				for j = StoneMaxRank[2], 1, -1 do
					if ( Manastone.Mode[j] == 2 ) then
						ManaStoneNext = j
					end
				end
				if (( Manastone.Mode[i] == 2 ) and ( i ~= ManaStoneNext )) then
					ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData[Type].Text[3]
				elseif (( i == ManaStoneNext ) and ( Manastone.Mode[i] == 2 )) then
					ManastoneTooltip[i] = CRYOLYSIS_STONE_RANK2[i]..CryolysisTooltipData[Type].Text[2]..Manastone.Restore[i]
				end
			end
		end
		for i = StoneMaxRank[2], 1, -1 do
			GameTooltip:AddLine(ManastoneTooltip[i])
		end
	-- ..... For the timer buttons
	elseif ( Type == "SpellTimer" ) then
		self:MoneyToggle()
		CryolysisTooltip:SetBagItem(HearthstoneLocation[1], HearthstoneLocation[2])
		local itemName = tostring(CryolysisTooltipTextLeft5:GetText())
		GameTooltip:AddLine(CryolysisTooltipData[Type].Text)
		if ( string.find(itemName, CRYOLYSIS_TRANSLATION.Cooldown) ) then
			GameTooltip:AddLine(CRYOLYSIS_TRANSLATION.Hearth.." - "..itemName)
		else
			GameTooltip:AddLine(CryolysisTooltipData[Type].Right..GetBindLocation())
		end
	-- ..... For the Concentration button
	elseif ( Type == "Armor" ) then
		if ( CRYOLYSIS_SPELL_TABLE[22].ID ) then
			GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[22].Mana.." Mana")
		else
			GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[18].Mana.." Mana")
		end
		if ( CRYOLYSIS_SPELL_TABLE[24].ID ) then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[24].Name.." ("..CRYOLYSIS_SPELL_TABLE[24].Mana.." Mana)"..CryolysisTooltipData.Alt.Right)
		end
	elseif ( Type == "FireWard" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[15].Mana.." Mana")
		if (( start2 > 0 ) and ( duration2 > 0 ) and ( not FireWardUp )) then
			local seconde = duration2 - ( GetTime() - start2 )
			GameTooltip:AddLine("Cooldown : ".. math.floor(seconde) .." sec")
		else
			FireWardUp = true
		end
		if ( CRYOLYSIS_SPELL_TABLE[20].ID ) then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[20].Name.." ("..CRYOLYSIS_SPELL_TABLE[20].Mana.." Mana)"..CryolysisTooltipData.Alt.Right)
		end
	elseif ( Type == "IceBarrier" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[23].Mana.." Mana")
		if (( start4 > 0 ) and ( duration4 > 0 ) and ( not IceBarrierUp )) then
			local seconde = duration4 - ( GetTime() - start4)
			GameTooltip:AddLine("Cooldown : "..math.floor(seconde).." sec")
		else
		    IceBarrierUp = true
		end
		if CRYOLYSIS_SPELL_TABLE[25].ID ~= nil then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[25].Name.." ("..CRYOLYSIS_SPELL_TABLE[25].Mana.." Mana)"..CryolysisTooltipData.Alt.Right)
		end
	elseif ( Type == "ManaShield" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[25].Mana.." Mana")
	elseif ( Type == "DetectMagic" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[50].Mana.." Mana")
	elseif ( Type == "T:Org" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[38].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
	elseif ( Type == "T:UC" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[40].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
	elseif ( Type == "T:TB" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[39].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
	elseif ( Type == "T:IF" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[37].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
	elseif ( Type == "T:SW" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[51].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
	elseif ( Type == "T:Darn" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[36].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfTeleportation..Count.RuneOfTeleportation)
	elseif ( Type == "P:Org" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[47].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
	elseif ( Type == "P:UC" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[31].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
	elseif ( Type == "P:TB" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[30].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
	elseif ( Type == "P:IF" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[28].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
	elseif ( Type == "P:SW" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[29].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
	elseif ( Type == "P:Darn" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[27].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.RuneOfPortals..Count.RuneOfPortals)
	elseif ( Type == "DampenMagic" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[13].Mana.." Mana")
		if ( CRYOLYSIS_SPELL_TABLE[1].ID ) then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[1].Name.." ("..CRYOLYSIS_SPELL_TABLE[1].Mana.." Mana)"..CryolysisTooltipData.Alt.Right)
		end
	elseif ( Type == "ArcaneInt" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[4].Mana.." Mana")
		if ( CRYOLYSIS_SPELL_TABLE[2].ID ) then
			GameTooltip:AddLine(CryolysisTooltipData.Alt.Left..CRYOLYSIS_SPELL_TABLE[2].Name.." ("..CRYOLYSIS_SPELL_TABLE[2].Mana.." Mana)"..CryolysisTooltipData.Alt.Right)
		end
	elseif ( Type == "Food" ) then
		GameTooltip:AddLine(CryolysisTooltipData[Type].Right.." ("..CRYOLYSIS_SPELL_TABLE[10].Mana.." Mana)")
		GameTooltip:AddLine(CryolysisTooltipData[Type].Middle)
		if ( Cryo.db.profile.CryolysisLanguage == "frFR" ) then
			GameTooltip:AddLine(CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]]..CRYOLYSIS_ITEM.Provision..": "..Count.Food)
		else
			GameTooltip:AddLine(CRYOLYSIS_ITEM.Provision..CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]]..": "..Count.Food)
		end
	elseif ( Type == "Drink" ) then
		GameTooltip:AddLine(CryolysisTooltipData[Type].Right.." ("..CRYOLYSIS_SPELL_TABLE[11].Mana.." Mana)")
		GameTooltip:AddLine(CryolysisTooltipData[Type].Middle)
		if ( Cryo.db.profile.CryolysisLanguage == "frFR" ) then
			GameTooltip:AddLine(CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]]..CRYOLYSIS_ITEM.Provision..": "..Count.Drink)
		else
			GameTooltip:AddLine(CRYOLYSIS_ITEM.Provision..CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]]..": "..Count.Drink)
		end
	elseif ( Type == "SlowFall" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[35].Mana.." Mana")
		GameTooltip:AddLine(CryolysisTooltipData.Main.LightFeather..Count.LightFeather)
	elseif ( Type == "RemoveCurse" ) then
		GameTooltip:AddLine(CRYOLYSIS_SPELL_TABLE[33].Mana.." Mana")
	elseif ( Type == "Evocation" ) then
		if (( start > 0 ) and ( duration > 0 ) and ( EvocationUp == false )) then
			local seconde = duration - ( GetTime() - start)
			local affiche, minute, Time
			if ( seconde <= 59 ) then
				affiche = tostring(math.floor(seconde)).." sec"
			else
				minute = tostring(math.floor(seconde/60))
				seconde = math.fmod(seconde, 60)
				if ( seconde < 10 ) then
					Time = "0"..tostring(math.floor(seconde))
				else
					Time = tostring(math.floor(seconde))
				end
				affiche = minute..":"..Time
			end
			GameTooltip:AddLine("Cooldown: "..affiche)
		else
			EvocationUp = true
			GameTooltip:AddLine(CryolysisTooltipData.Evocation.Text)
		end
	elseif (( Type == "Buff" ) and ( Cryo.db.char.LastBuff ~= 0 )) then
		GameTooltip:AddLine(CryolysisTooltipData.LastSpell.Left..CRYOLYSIS_SPELL_TABLE[Cryo.db.char.LastBuff].Name..CryolysisTooltipData.LastSpell.Right)
	elseif (( Type == "Portal" ) and ( Cryo.db.char.LastPortal ~= 0 )) then
		GameTooltip:AddLine(CryolysisTooltipData.LastSpell.Left..CRYOLYSIS_SPELL_TABLE[PortalTempID[Cryo.db.char.LastPortal]].Name..CryolysisTooltipData.LastSpell.Right)
	end
	-- And done, Showing!
	GameTooltip:Show()
end

function Cryo:BuildSpellTooltip(button, side, anchor)
	local spell, Type
	if ( side == "Left" ) then
		spell = Cryo.db.profile.LeftSpell
	else
		spell = Cryo.db.profile.RightSpell
	end
	if ( spell == 1 ) then
		if (( CRYOLYSIS_SPELL_TABLE[18].ID ) or ( CRYOLYSIS_SPELL_TABLE[22].ID )) then
			Type = "Armor"
		end
	elseif (( spell == 2 ) and ( CRYOLYSIS_SPELL_TABLE[4].ID )) then
		Type = "ArcaneInt"
	elseif (( spell == 3 ) and ( CRYOLYSIS_SPELL_TABLE[13].ID )) then
		Type = "DampenMagic"
	elseif ( spell == 4 ) then
		if (( CRYOLYSIS_SPELL_TABLE[23].ID ) or ( CRYOLYSIS_SPELL_TABLE[25].ID )) then
			Type = "Shield"
			self:BuildShieldTooltip(button, anchor)
		end
	elseif (( spell == 5 ) and ( CRYOLYSIS_SPELL_TABLE[15].ID )) then
		Type = "FireWard"
	elseif (( spell == 6 ) and ( CRYOLYSIS_SPELL_TABLE[50].ID )) then
		Type = "DetectMagic"
	elseif (( spell == 7 ) and ( CRYOLYSIS_SPELL_TABLE[33].ID )) then
		Type = "RemoveCurse"
	elseif (( spell == 8 ) and ( CRYOLYSIS_SPELL_TABLE[35].ID )) then
		Type = "SlowFall"
	end
	if (( spell ~= 4 ) and ( Type )) then
		self:BuildTooltip(button, Type, anchor)
	end
end

function Cryo:BuildShieldTooltip(button, anchor)
	if ( CRYOLYSIS_SPELL_TABLE[23].ID ) then
		Cryo:BuildTooltip(button, "IceBarrier", anchor)
	else
		Cryo:BuildTooltip(button, "ManaShield", anchor)
	end
end

-- Function updating the Cryolysis buttons and giving the state of the Evocation button
function Cryo:UpdateIcons()
	local mana = UnitMana("player")
	local texture
	for i = 1, 9, 1 do
		if ( CryolysisButtonTexture.Stones.Highlight[i] ~= Cryo.db.profile.Skin ) then
			local f = _G[ Cryo.db.profile.StoneLocation[i] ]
			if ( f ) then
				f:SetHighlightTexture("Interface\\Addons\\Cryolysis\\UI\\BaseMenu-02")
				texture = f:GetHighlightTexture()
				texture:SetBlendMode("BLEND") -- use "ADD" for additive highlight
				f:SetHighlightTexture(texture)
				CryolysisButtonTexture.Stones.Highlight[i] = Cryo.db.profile.Skin
			end
		end
	end
	-------------------------------------
	-- Posting main Cryolysis sphere
	-------------------------------------
 	if ( Cryo.db.profile.CountType == 0 ) then -- None
		Sphere.display = ""
	elseif ( Cryo.db.profile.CountType == 1 ) then -- Food and Drink
		Sphere.display = Count.Food.." / "..Count.Drink
	elseif ( Cryo.db.profile.CountType == 2 ) then -- Drink and Food
		Sphere.display = Count.Drink.." / "..Count.Food
	elseif ( Cryo.db.profile.CountType == 3 ) then -- HP Current
		Sphere.color = CryolysisTimerColor(((UnitHealth("player") / UnitHealthMax("player")) * 100))
		Sphere.display = Cryo:MsgAddColor(Sphere. 	color..tostring(UnitHealth("player")))
	elseif ( Cryo.db.profile.CountType == 4 ) then -- HP Percent
		Sphere.color = CryolysisTimerColor(((UnitHealth("player") / UnitHealthMax("player")) * 100))
		Sphere.display = math.floor(UnitHealth("player") / UnitHealthMax("player") * 100)
		Sphere.display = Cryo:MsgAddColor(Sphere.color .. tostring(Sphere.display).."%")
	elseif ( Cryo.db.profile.CountType == 5 ) then -- MP Current
		Sphere.display = tostring(UnitMana("player"))
	elseif ( Cryo.db.profile.CountType == 6 ) then -- MP Percent
		Sphere.display = math.floor(UnitMana("player") / UnitManaMax("player") * 100)
		Sphere.display = tostring(Sphere.display).."%"
	elseif ( Cryo.db.profile.CountType == 7 ) then -- Mana gem cooldown
		Sphere.display = string.gsub("A1 B2 C3 D4",tostring(Manastone.currentStone),"("..tostring(Manastone.currentStone)..")")
		for i=4, 1, -1 do
			if ( Manastone.OnHand[i] ) then
				Sphere.display = string.gsub(Sphere.display,string.char(64+i),"<lightGreen2>")
			elseif (( PlayerCombat ) and ( Cryo.db.profile.Button == 4 )) then
				Sphere.display = string.gsub(Sphere.display,string.char(64+i),"<brightGreen>")
			elseif ( not Manastone.RankID[i] ) then
				Sphere.display = string.gsub(Sphere.display," "..string.char(64+i)..tostring(i),"")
			else
				Sphere.display = string.gsub(Sphere.display,string.char(64+i),"<red>")
			end
		end
		if ( Cryo.db.char.ManastoneCooldown > 0 ) then
			Sphere.display = Cryo.db.char.ManastoneCooldownText.."\n"..Sphere.display
		end
	elseif ( Cryo.db.profile.CountType == 8 ) then
 		if ( CRYOLYSIS_SPELL_TABLE[49].ID ) then
			start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL)
		else
			start = 1
			duration = 1
		end
		if (( start > 0 ) and ( duration > 0 ) and ( EvocationUp == false )) then
			Sphere.display = self:TimerFunction(duration - ( GetTime() - start))
		else
			Sphere.display = "Ready"
		end
	end
	-- Display!
	if ( CryolysisButtonTexture.Text ~= Sphere.display ) then
		CryolysisShardCount:SetText(Cryo:MsgAddColor(Sphere.display))
		CryolysisButtonTexture.Text = Sphere.display;
	end
	----------------------------------------
	-- Set outer circle display
	----------------------------------------
	-- If outer circle shows evocation cooldown

	if ( Cryo.db.profile.Circle == 4 ) then
		Sphere.skin = "Violet";
		if ( Cryo.db.char.EvocationCooldown > 0 ) then
			Sphere.texture = 16 - (math.floor(Cryo.db.char.EvocationCooldown / (480/16)));
		else
			Sphere.texture = 32;
		end
	-- If outer circle shows Manastone cooldown
	elseif ( Cryo.db.profile.Circle == 3 ) then
		Sphere.skin = "Turquoise";
		if ( Cryo.db.char.ManastoneCooldown > 0 ) then
			Sphere.texture = 16 - (math.floor(Cryo.db.char.ManastoneCooldown / (120/16)));
		else
			Sphere.texture = 32;
		end
	-- if outer circle shows MP
	elseif ( Cryo.db.profile.Circle == 2 ) then
		Sphere.skin = "Bleu";
		Sphere.texture = math.floor(UnitMana("player") / (UnitManaMax("player") / 16));
		if ( Sphere.texture == 16 ) then
			Sphere.texture = 32
		end
	-- If outer circle shows HP
	elseif ( Cryo.db.profile.Circle == 1 ) then
		Sphere.skin = "Orange";
		Sphere.texture = math.floor(UnitHealth("player") / (UnitHealthMax("player") / 16));
		if ( Sphere.texture == 16 ) then
			Sphere.texture = 32
		end
	elseif ( Cryo.db.profile.Circle == 0 ) then
		Sphere.skin = "Bleu";
		Sphere.texture = 32;
	end
	if ( CryolysisButtonTexture.Circle ~= Sphere.texture ) then
		CryolysisButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\"..Sphere.skin.."\\Shard"..Sphere.texture);
		CryolysisButtonTexture.Circle = Sphere.texture;
	end

	-- Evocation Button
	-----------------------------------------------
	if ( CRYOLYSIS_SPELL_TABLE[49].ID ) then
  		local start, duration = GetSpellCooldown(CRYOLYSIS_SPELL_TABLE[49].ID, BOOKTYPE_SPELL)
		if (( start > 0 ) and ( duration > 0 ) and ( not EvocationUp )) then
			if ( CryolysisButtonTexture.Stones.Base[5] ~= 3 ) then
				CryolysisEvocationButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\EvocationButton-03");
				CryolysisButtonTexture.Stones.Base[5] = 3;
			end
		elseif ( CryolysisButtonTexture.Stones.Base[5] ~= 1 ) then
		    CryolysisEvocationButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\EvocationButton-01");
			CryolysisButtonTexture.Stones.Base[5] = 1;
		end
	end


--	-- Food Button
--	-----------------------------------------------
	if ( StoneIDInSpellTable[4] ) then
		if (( Count.Food > 0 ) and ( not PlayerCombat )) then				-- Have Food and not in combat
			texture = 1;
		else
			texture = 3;
		end
		if ( CRYOLYSIS_SPELL_TABLE[10].Mana > mana ) then		-- No Mana
			CryolysisFoodButton:UnlockHighlight()
		else												-- Have Mana
			CryolysisFoodButton:LockHighlight()
		end
		if ( CryolysisButtonTexture.Stones.Base[1] ~= texture ) then
			CryolysisFoodButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Food0"..StoneMaxRank[4].."-0"..texture);
			CryolysisButtonTexture.Stones.Base[1] = texture;
		end
	end
	-- Drink Button
	-----------------------------------------------

	-- Si la pierre est �uip�, mode 3
	if ( StoneIDInSpellTable[3] ) then
		if (( Count.Drink > 0 ) and ( not PlayerCombat )) then				-- Have Food and not in combat
			texture = 1;
		else
			texture = 3;
		end
		if ( CRYOLYSIS_SPELL_TABLE[11].Mana > mana ) then		-- No Mana
			CryolysisDrinkButton:UnlockHighlight()
		else												-- Have Mana
			CryolysisDrinkButton:LockHighlight()
		end
		if ( CryolysisButtonTexture.Stones.Base[2] ~= texture ) then
			CryolysisDrinkButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Water0"..StoneMaxRank[3].."-0"..texture);
			CryolysisButtonTexture.Stones.Base[2] = texture;
		end
	end

	-- Mana Gem
	-----------------------------------------------
	-- Mode "I have one" (2)/"I do not have any" (1)
	for i = 1, StoneMaxRank[2], 1 do
		if ( Manastone.OnHand[i] ) then
			Manastone.Mode[i] = 2;
		else
			Manastone.Mode[i] = 1;
		end
	end
	-- Preparation of manastone icon
	if ( StoneMaxRank[2] >= 1 ) then
		-- Acquire the highest stone available as well as the next one to be conjured
		Manastone.currentStone = StoneMaxRank[2]; -- Highest rank stone available, or highest rank if none available
		Manastone.conjureStone = StoneMaxRank[2]; -- Next stone to be conjured
		Manastone.useableStone = 0; -- 0 = Stone not useable; 1 = usable
		Manastone.conjureStoneMP = 0;
		for i=1, StoneMaxRank[2], 1 do
			if ( Manastone.OnHand[i] ) then
				Manastone.currentStone = i;
			else
				Manastone.conjureStone = i;
			end
		end
		-- If we're using smallest stone first, find the lowest stone available.
		if ( Cryo.db.profile.ManaStoneOrder == 1 ) then
			Manastone.currentStone = 1;  -- Since we us mana agate first in this method, it is set as default icon
		   	for i=StoneMaxRank[2], 1, -1 do
		    	if ( Manastone.OnHand[i] ) then
		    	  	Manastone.currentStone = i;
		    	  	-- conjure order is constant, so we don't need to check it again
		    	end
			end
		end
		-- Check to see if we have enough MP to conjure whatever stone is next.  This is displayed on the ring
		if ( mana >= Manastone.MP[Manastone.conjureStone] ) then
			Manastone.conjureStoneMP = 1;
		else
			Manastone.conjureStoneMP = 0;
		end
		-- Check if the current stone is useable.  If it is on cooldown or not available, it is greyed
		if (( Cryo.db.char.ManastoneCooldown <= 0 ) and ( Manastone.OnHand[Manastone.currentStone] )) then
			Manastone.useableStone = 1
		else
			Manastone.useableStone = 0
		end
		-- Put the parts together to display the icon!
		-- The default display is highest rank manastone, conjurable, and useable
		-- Cryo:Msg("Manastone0"..currentStone.."-"..conjureStoneMP..useableStone, "USER");
		if CryolysisButtonTexture.Stones.Base[3] ~= Manastone.currentStone
			or CryolysisButtonTexture.Stones.Other[3] ~= Manastone.conjureStoneMP
			or CryolysisButtonTexture.Stones.Other2[3] ~= Manastone.useableStone then
			CryolysisManaStoneButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\Manastone0"..Manastone.currentStone.."-"..Manastone.conjureStoneMP..Manastone.useableStone);
			CryolysisButtonTexture.Stones.Base[3] = Manastone.currentStone;
			CryolysisButtonTexture.Stones.Other[3] = Manastone.conjureStoneMP;
			CryolysisButtonTexture.Stones.Other2[3] = Manastone.useableStone;
		end
	end

	-- Mount Button
	-----------------------------------------------
	if ( IsMounted() ) then
		CryolysisMountButton:LockHighlight();
	elseif ( Mount.Available ) then
		CryolysisMountButton:UnlockHighlight();
		if ( PlayerCombat ) then
			if ( CryolysisButtonTexture.Stones.Base[8] ~= 3 ) then
				CryolysisMountButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\MountButton"..Mount.Icon.."-03");
				CryolysisButtonTexture.Stones.Base[8] = 3;
			end
		elseif ( CryolysisButtonTexture.Stones.Base[8] ~= 1 ) then
			CryolysisMountButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\MountButton"..Mount.Icon.."-01");
			CryolysisButtonTexture.Stones.Base[8] = 1;
		end
	end

	-- Timer Buttons
	-----------------------------------------------
	if ( HearthstoneLocation[1] ) then
		start, duration, enable = GetContainerItemCooldown(HearthstoneLocation[1], HearthstoneLocation[2]);
		if (( duration > 20 ) and ( start > 0 )) then
			if ( CryolysisButtonTexture.Stones.Base[10] ~= 1 ) then
				CryolysisSpellTimerButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SpellTimerButton-Cooldown");
				CryolysisButtonTexture.Stones.Base[10] = 1;
			end
		elseif ( CryolysisButtonTexture.Stones.Base[10] ~= 2 ) then
			CryolysisSpellTimerButton:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\SpellTimerButton-Normal");
			CryolysisButtonTexture.Stones.Base[10] = 2;
		end
	end

	-- Spell Buttons
	---------------------------------------------------
	local spellButton = {"CryolysisLeftSpellButton", nil, "CryolysisRightSpellButton"};
	local spellNumber = { Cryo.db.profile.LeftSpell, nil, Cryo.db.profile.RightSpell };
	local spellEnable, texture;
	local alternative = false;
	for button = 1, 3, 2 do
		for spell = 1, #CryolysisSpellButtons, 1 do
			if ( spellNumber[button] == spell ) then
				spellEnable = false;
				alternative = false;
				texture = 1;
				if ( CRYOLYSIS_SPELL_TABLE[CryolysisSpellButtons[spell].ID].ID ~= nil ) then
					spellEnable = true;
					if ( CRYOLYSIS_SPELL_TABLE[CryolysisSpellButtons[spell].ID].Mana > mana ) then
						texture = 3
					end
				elseif (( spell == 4 ) and ( CRYOLYSIS_SPELL_TABLE[CryolysisSpellButtons[spell].ID].ID == nil )) then
					if ( CRYOLYSIS_SPELL_TABLE[25].ID ) then
						spellEnable = true;
						alternative = true;
						if ( CRYOLYSIS_SPELL_TABLE[25].Mana > mana ) then
							texture = 3
						end
					end
				end
				break;
			end
		end
		if ( spellEnable ) then
			_G[ spellButton[button] ]:Enable()
		else
			texture = 3;
			_G[ spellButton[button] ]:Disable();
		end
		if ( CryolysisButtonTexture.Stones.Base[3 + button] ~= texture ) then
			if ( alternative ) then
				_G[ spellButton[button] ]:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\ManaShield-0"..texture);
			else
				_G[ spellButton[button] ]:SetNormalTexture(CryolysisSpellButtons[spellNumber[button]].Texture..texture);
			end
			CryolysisButtonTexture.Stones.Base[3 + button] = texture;
		end
	end
	if ( Cryolysis_ReorderTexture[1] ) then
		for i=1, 9, 1 do
			Cryolysis_ReorderTexture[i] = tostring( _G[Cryo.db.profile.StoneLocation[i] ]:GetNormalTexture():GetTexture());
		end
	end
	self:ButtonTextUpdate()
end

-- Allows User to sort Button Order
Reorder = {}
Reorder.Table = {} -- numerically indexed table of anything (just a texture in this case)
function Reorder.OnLoad()
	Reorder.Selected = 0
	Reorder.UpdateOrder()
end

function Reorder.OnClick()
	local id = this:GetID()
	if Reorder.Selected == id then
		Reorder.Selected = 0
	else
		Reorder.Selected = id
	end
	Reorder.UpdateOrder()
end

function Reorder.ValidateButtons()
	ReorderLeft:Disable()
	ReorderRight:Disable()
	if Reorder.Selected>1 then
		ReorderLeft:Enable()
	end
	if Reorder.Selected>0 and Reorder.Selected<9 then
		ReorderRight:Enable()
	end
end

function Reorder.UpdateOrder()
	for i = 1, 9, 1 do
		if Reorder.Selected==i then
			_G["Reorder"..i]:LockHighlight()
		else
			_G["Reorder"..i]:UnlockHighlight()
		end
		_G["Reorder"..i.."Icon"]:SetTexture(Cryolysis_ReorderTexture[i])
	end
	Reorder.ValidateButtons()
end

-- moves Reorder.Table entry from Reorder.Select in dir direction (1 or -1)
function Reorder.Move_OnClick(dir)
	local id = Reorder.Selected
	local temp = Cryolysis_ReorderTexture[id]
	local temp2 = Cryo.db.profile.StoneLocation[id]
	Cryolysis_ReorderTexture[id] = Cryolysis_ReorderTexture[id + dir]
	Cryolysis_ReorderTexture[id + dir] = temp
	Cryo.db.profile.StoneLocation[id] = Cryo.db.profile.StoneLocation[id + dir]
	Cryo.db.profile.StoneLocation[id + dir] = temp2
	Reorder.Selected = Reorder.Selected + dir
	Reorder.UpdateOrder()
	Cryo:UpdateButtonsScale()
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF STONES AND STUFF
------------------------------------------------------------------------------------------------------
-- T'AS QU'A SAVOIR OU T'AS MIS TES AFFAIRES !
function Cryo:ProvisionSetup()
	ProvisionSlotID = 1
	for slot = 1, #ProvisionSlot, 1 do
		table.remove(ProvisionSlot, slot)
	end
	for slot = 1, GetContainerNumSlots(Cryo.db.profile.ProvisionContainer), 1 do
		table.insert(ProvisionSlot, nil)
	end
end

-- Function that looks for items to trade (Food/drink
function Cryo:TradeExplore(Type)
  	for container = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(container), 1 do
			self:MoneyToggle();
   			CryolysisTooltip:SetBagItem(container, slot);
			local itemName = tostring(CryolysisTooltipTextLeft1:GetText());
			_, _, locked = GetContainerItemInfo(container, slot);
			if itemName == Type and not locked then
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
function Cryo:MountCheck(itemName, container, slot)
	if UnitLevel("player") < 40 then
		return
	end
	if Cryo.db.char.AQ == true then
		if self:AQMountCheck(itemName, container, slot) or Mount.AQMount then
			return
		end
	end
	for icon=1, #CRYOLYSIS_MOUNT_TABLE, 1 do
		for i=1, #CRYOLYSIS_MOUNT_TABLE[icon], 1 do
			if itemName == CRYOLYSIS_MOUNT_TABLE[icon][i] then
			   	Mount.Available = true;
			   	Mount.Name = CRYOLYSIS_MOUNT_TABLE[icon][i];
				Mount.Title = Mount.Name;
			   	for p = 1, #CRYOLYSIS_MOUNT_PREFIX, 1 do
					if string.find(Mount.Name, CRYOLYSIS_MOUNT_PREFIX[p]) then
						Mount.Title = string.sub(Mount.Name, string.len(CRYOLYSIS_MOUNT_PREFIX[p])+1);
					end
			   	end
				Cryo:Msg("Mount Located: "..Mount.Title,"USER");
				if icon < 10 then
			   		Mount.Icon = "0"..icon;
			   	else
					Mount.Icon = icon;
			   	end

			   	Mount.Location = {container, slot}
				Cryolysis_UpdateMountButton(Mount.Title, "Normal")
			   	break;
			end
		end
	end
end

function Cryo:AQMountCheck(itemName, container, slot)
	for i=1, #CRYOLYSIS_AQMOUNT_TABLE, 1 do
		if itemName == CRYOLYSIS_AQMOUNT_TABLE[i] then
		   	Mount.Available = true;
		   	Mount.Name = CRYOLYSIS_AQMOUNT_TABLE[i];
			Mount.Title = CRYOLYSIS_AQMOUNT_NAME[i+1];
			Cryo:Msg("AQ Mount Located: "..Mount.Title,"USER");
			Mount.Icon = "A"..i;
		   	Mount.Location = {container, slot}
			Cryolysis_UpdateMountButton(Mount.Title, "AQ");
		   	Mount.AQMount = true;
		   	return true;
		end
	end
end

function Cryo:BagCheck(spell)
	local spellcheck = { 2, 10, 11, 38, 40, 39, 37, 51, 46, 47, 31, 30, 28, 29, 27, 35 } -- Spells that change inv.  Portals, Conjure, mana gems, etc
	local check = false;
	local itemName;
	--
	if ( spell == "Force" ) then
	    check = true;
	elseif ( spell == "Update" ) then
		Cryo.db.char.checkInv = true;
	elseif ( spell ) then
 		for i = 1, #spellcheck, 1 do
			if ( spell == CRYOLYSIS_SPELL_TABLE[spellcheck[i]].Name ) then
				self:BagCheck("Update");
				break;
			end
		end
		for i = 1, #CRYOLYSIS_MANASTONE_NAMES, 1 do
			if ( spell == CRYOLYSIS_MANASTONE_NAMES[i] ) then
				self:BagCheck("Update");
				break;
			end
		end
	end
	if (( not check ) and ( Count.Food > 0 )) then
		self:MoneyToggle();
		CryolysisTooltip:SetBagItem(FoodLocation[1], FoodLocation[2]);
		itemName = tostring(CryolysisTooltipTextLeft1:GetText());
		if ( itemName ~= FoodName ) then
			check = true;
		end
	end
	if ( not check and  Count.Drink > 0 ) then
		self:MoneyToggle();
		CryolysisTooltip:SetBagItem(DrinkLocation[1], DrinkLocation[2]);
		itemName = tostring(CryolysisTooltipTextLeft1:GetText());
		if ( itemName ~= DrinkName ) then
			check = true;
		end
	end
	if ( not check and Mount.Available ) then
		self:MoneyToggle();
		CryolysisTooltip:SetBagItem(Mount.Location[1], Mount.Location[2]);
		itemName = tostring(CryolysisTooltipTextLeft1:GetText());
		if ( itemName ~= Mount.Name ) then
			check = true;
			Mount.Checked = false;
		end
	end
 	if ( not check and StoneMaxRank[2] ~= 0 ) then
		for i=1, StoneMaxRank[2], 1 do
			if ( Manastone.OnHand[i] ) then
				self:MoneyToggle();
				CryolysisTooltip:SetBagItem(Manastone.Location[i][1], Manastone.Location[i][2]);
				itemName = tostring(CryolysisTooltipTextLeft1:GetText());
				if ( not string.find(itemName, CRYOLYSIS_ITEM.Manastone..CRYOLYSIS_STONE_RANK[i]) ) then
					check = true;
				end
			end
		end
	end
 	if ( check == true ) then
		if ( Cryo.db.profile.ProvisionSort ) then
			self:ProvisionSwitch("CHECK")
		else
			self:BagExplore()
		end
	end
end
-- Funtion that inventories mage reagents: feathers, runes, powder, etc
function Cryo:BagExplore()
	local provision = Provision;
	Provision = 0;
	Count.Food = 0;
	Count.Drink = 0;
	Count.RuneOfTeleportation = 0;
	Count.RuneOfPortals = 0;
	Count.ArcanePowder = 0;
	Count.LightFeather = 0;
	Manastone.OnHand = { false, false, false, false }
	HearthstoneOnHand = false;
	ItemOnHand = false;
	-- For each bag
	for container=0, 4, 1 do
		-- For each slot
		for slot=1, GetContainerNumSlots(container), 1 do
			self:MoneyToggle();
			CryolysisTooltip:SetBagItem(container, slot);
			local itemName = tostring(CryolysisTooltipTextLeft1:GetText());
--			local itemSwitch = tostring(CryolysisTooltipTextLeft3:GetText());
--			local itemSwitch2 = tostring(CryolysisTooltipTextLeft4:GetText());
			if ( StoneMaxRank[4] ~= 0 ) then
				if ( (Cryo.db.profile.CryolysisLanguage == "zhCN") or (Cryo.db.profile.CryolysisLanguage == "zhTW") ) then
					FoodName = string.sub(CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]], 2, string.len(CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]]));
				elseif ( Cryo.db.profile.CryolysisLanguage == "frFR" ) then
					FoodName = CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]]..CRYOLYSIS_ITEM.Provision;
				else
					FoodName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_FOOD_RANK[StoneMaxRank[4]];
				end
				if ( Count.FoodLastName == "none" ) then Count.FoodLastName = FoodName; end
			end
			if ( StoneMaxRank[3] ~= 0 ) then
				if ( (Cryo.db.profile.CryolysisLanguage == "zhCN") or (Cryo.db.profile.CryolysisLanguage == "zhTW") ) then
					DrinkName = string.sub(CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]], 2, string.len(CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]]));
				elseif ( Cryo.db.profile.CryolysisLanguage == "frFR" ) then
					DrinkName = CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]]..CRYOLYSIS_ITEM.Provision;
				else
					DrinkName = CRYOLYSIS_ITEM.Provision..CRYOLYSIS_DRINK_RANK[StoneMaxRank[3]];
				end
				if ( Count.DrinkLastName == "none" ) then Count.DrinkLastName = DrinkName; end
			end
			-- If the bag is defined for provisions
			-- skip the value of the table whichr represents that bag slot (not the foodstuff)
			if (container == Cryo.db.profile.ProvisionContainer) then
				if itemName ~= FoodName and itemName ~= DrinkName then
					ProvisionSlot[slot] = nil;
				end
			end
			-- In the case of a nonempty slot
			if itemName ~= "nil" then
				-- Find the number of items in the slot
				local _, ItemCount = GetContainerItemInfo(container, slot);
				-- If it is a reagent, add it to the count
				if itemName == FoodName then
					Count.Food = Count.Food + ItemCount;
				elseif itemName == DrinkName then
					Count.Drink = Count.Drink + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.ArcanePowder then
					Count.ArcanePowder = Count.ArcanePowder + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.LightFeather then
					Count.LightFeather = Count.LightFeather + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.RuneOfTeleportation then
					Count.RuneOfTeleportation = Count.RuneOfTeleportation + ItemCount;
				elseif itemName == CRYOLYSIS_ITEM.RuneOfPortals then
					Count.RuneOfPortals = Count.RuneOfPortals + ItemCount;
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
						CryolysisSpellTimerButton:SetAttribute("type2", "item");
						CryolysisSpellTimerButton:SetAttribute("item2", CRYOLYSIS_ITEM.Hearthstone);
						CryolysisMountButton:SetAttribute("type2", "item");
						CryolysisMountButton:SetAttribute("item2", CRYOLYSIS_ITEM.Hearthstone);
					end
				end
				-- Mount
				if Mount.Location[1] == container and Mount.Location[2] == slot and itemName ~= Mount.Name then
					Mount.Available = false;
				end
				if Cryo.db.char.AQ and not Mount.AQChecked and not Mount.AQMount then
					Mount.Available = false;
				end
				if not Mount.Available and not Mount.Checked then
				 	self:MountCheck(itemName, container, slot);
				end
			end
		end
	end
	if Cryo.db.char.AQ then
		Mount.AQChecked = true;
	end
	Mount.Checked = true;
	-- Update as a whole!!
	Cryo:UpdateIcons();

	-- If there are more provisions than the defined bag can hold, warn the player
	if (Provision > provision and Provision == GetContainerNumSlots(Cryo.db.profile.ProvisionContainer)) then
		if (ProvisionsDestroy) then
			Cryo:Msg(CRYOLYSIS_MESSAGE.Bag.FullPrefix..GetBagName(Cryo.db.profile.SoulshardContainer)..CRYOLYSIS_MESSAGE.Bag.FullDestroySuffix);
		else
			Cryo:Msg(CRYOLYSIS_MESSAGE.Bag.FullPrefix..GetBagName(Cryo.db.profile.SoulshardContainer)..CRYOLYSIS_MESSAGE.Bag.FullSuffix);
		end
	end

	-- Added by Lomig to replace the toggle function
	self:UpdateMainButtonAttributes();
	-- End of adding
end

-- -- Function which makes it possible to find/arrange the provisions in the bags
function Cryo:ProvisionSwitch(Type)
	for container = 0, 4, 1 do
		if ( container ~= Cryo.db.profile.ProvisionContainer ) then
			for slot = 1, GetContainerNumSlots(container), 1 do
				self:MoneyToggle()
				CryolysisTooltip:SetBagItem(container, slot)
				local itemInfo = tostring(CryolysisTooltipTextLeft1:GetText())
				if itemInfo == Count.FoodLastName
					or itemInfo == Count.DrinkLastName then
					if (Type == "CHECK") then
						ProvisionMP = ProvisionMP + 1
					elseif (Type == "MOVE") then
						ProvisionMP = ProvisionMP - 1
      					self:BagCheck("Update")
						self:FindSlot(container, slot,itemInfo)
					end
				end
			end
		end
	end
	self:BagExplore()
end

--During the movement of the provisions, it is necessary to find a new site with the moved objects:)
function Cryo:FindSlot(ProvisionIndex, ProvisionSlot, itemInfo)
	local full = true; 																		-- Saying the provision bag is full
	local foodstuff, StackCount;
	for slot=1, GetContainerNumSlots(Cryo.db.profile.ProvisionContainer), 1 do				-- go through every slot in the provision bag
		self:MoneyToggle();															-- Ignore money!
 		CryolysisTooltip:SetBagItem(Cryo.db.profile.ProvisionContainer, slot);				-- Make the item name in the provision bag
		foodstuff = tostring(CryolysisTooltipTextLeft1:GetText());							-- Make easy to use item name (foodstuff)
		_, StackCount = GetContainerItemInfo(Cryo.db.profile.ProvisionContainer, slot);		-- Get How many items are in that slot
		if string.find(foodstuff, Count.FoodLastName) ~= nil and StackCount < 20 and foodstuff == itemInfo
            or string.find(foodstuff, Count.DrinkLastName) ~= nil and StackCount < 20 and foodstuff == itemInfo
			or string.find(foodstuff, CRYOLYSIS_ITEM.Provision) == nil then						-- If that item isn't food or drink
				PickupContainerItem(ProvisionIndex, ProvisionSlot);							-- Pick up the food/drink in the other bag
				PickupContainerItem(Cryo.db.profile.ProvisionContainer, slot);				-- Pick up this item, effectively swapping
	--			ProvisionSlot[ProvisionSlotID] = slot;										-- Say there is food/drink in that slot
				ProvisionSlotID = ProvisionSlotID + 1										-- add to slot counter
				if (CursorHasItem()) then													-- If somethign is still on hand
					if ProvisionIndex == 0 then 											-- If the food/drink WAS in the backpack
						PutItemInBackpack();												-- Put the new item in the backpack
					else																	-- otherwise
						PutItemInBag(19 + ProvisionIndex);									-- put it in another bag
					end																		-- done
				end																			-- done
			full = false;																	-- bag isn't full
			break;
		end
	end
	-- Destruction of the provisions in excess if the option is activated
	if (full and Cryo.db.profile.ProvisionDestroy) then
		PickupContainerItem(ProvisionIndex, ProvisionSlot);
		if (CursorHasItem()) then DeleteCursorItem(); end
	end
end

------------------------------------------------------------------------------------------------------
-- FUNCTIONS OF SPELLS
------------------------------------------------------------------------------------------------------
-- Show or Hide the spell button to each new learned spell
function Cryo:ButtonSetup()
	if ( Cryo.db.profile.CryolysisLockServ ) then
		self:DragControl(false)
		self:UpdateButtonsScale()
	else
		for i, v in ipairs(Cryo.db.profile.StoneLocation) do
			HideUIPanel(_G[v])
		end
		if Cryo.db.profile.StonePosition[1] and StoneIDInSpellTable[4] then
			ShowUIPanel(CryolysisFoodButton)
		end
		if Cryo.db.profile.StonePosition[2] and StoneIDInSpellTable[3] then
			ShowUIPanel(CryolysisDrinkButton)
		end
		if Cryo.db.profile.StonePosition[3] and ManaStoneMenuCreate[1] then
			ShowUIPanel(CryolysisManaStoneButton)
		end
		if Cryo.db.profile.StonePosition[4] then
		    ShowUIPanel(CryolysisLeftSpellButton)
		end
		if Cryo.db.profile.StonePosition[5] and StoneIDInSpellTable[1] then
			ShowUIPanel(CryolysisEvocationButton)
		end
		if Cryo.db.profile.StonePosition[6] then
		    ShowUIPanel(CryolysisRightSpellButton)
		end
		if Cryo.db.profile.StonePosition[7] and BuffMenuCreate[1] then
			ShowUIPanel(CryolysisBuffMenuButton)
		end
		if Cryo.db.profile.StonePosition[8] then
			ShowUIPanel(CryolysisMountButton)
		end
		if Cryo.db.profile.StonePosition[9] and PortalMenuCreate[1] then
			ShowUIPanel(CryolysisPortalMenuButton)
		end
	end
end

-- My favorite function! It makes the list of the spells known by the mage, and classifies them by rank
-- For the stones, it selects the highest rank
function Cryo:SpellSetup()
	Cryolysis_SpellTableBuild()
	StoneIDInSpellTable = {0, 0, 0, 0}
	local StoneType = {CRYOLYSIS_ITEM.Evocation, CRYOLYSIS_ITEM.Manastone, CRYOLYSIS_ITEM.Drink, CRYOLYSIS_ITEM.Food}
	local nameTalent, icon, tier, column, currRank, maxRank = GetTalentInfo(3,7)
	local CurrentStone = {
		ID = {},
		Name = {},
		subName = {}
	}

	local CurrentSpells = {
		ID = {},
		Name = {},
		subName = {}
	}

	
	local Invisible = 0
	local InvisibleID = 0

	local spellID = 1
	while true do
		local spellName, subSpellName = GetSpellName(spellID, BOOKTYPE_SPELL)
		if not spellName then
			break
		end
		if ( string.find(subSpellName, RANK) ) then
			local found = false
			local _, _, rank = string.find(subSpellName, RANK.."%s(%d+)")
			rank = tonumber(rank)
			for index = 1, #CurrentSpells.Name, 1 do
				if ( CurrentSpells.Name[index] == spellName ) then
					found = true
					if (CurrentSpells.subName[index] < rank) then
						CurrentSpells.ID[index] = spellID
						CurrentSpells.subName[index] = rank
					end
					break
				end
			end
			-- The largest ranks of each numbered spell with row are inserted in the table
			if ( not found ) then
				table.insert(CurrentSpells.ID, spellID)
				table.insert(CurrentSpells.Name, spellName)
				table.insert(CurrentSpells.subName, rank)
			end
		end
		-- Check to see if it is a mana gem.  if it is, note it and its information
		for i = 1, #CRYOLYSIS_MANASTONE_NAMES, 1 do
			if spellName == CRYOLYSIS_MANASTONE_NAMES[i] then
				if i > StoneMaxRank[2] then
					StoneMaxRank[2] = i;
				end
		        Manastone.RankID[i] = spellID;
			end
		end
		spellID = spellID + 1;
	end

	-- One inserts in the table the stones with the highest rank
	for stoneID=1, #(StoneType), 1 do
		if StoneMaxRank[stoneID] ~= 0 then
			table.insert(CRYOLYSIS_SPELL_TABLE, {
				ID = CurrentStone.ID[stoneID],
				Name = CurrentStone.Name[stoneID],
				Rank = 0,
				CastTime = 0,
				Length = 0,
				Type = 0,
			});
			StoneIDInSpellTable[stoneID] = #(CRYOLYSIS_SPELL_TABLE);
		end
	end
	-- Updates the list of the spells with the new ranks
	for spell=1, #(CRYOLYSIS_SPELL_TABLE), 1 do
		for index = 1, #(CurrentSpells.Name), 1 do
			if (CRYOLYSIS_SPELL_TABLE[spell].Name == CurrentSpells.Name[index])
				and CRYOLYSIS_SPELL_TABLE[spell].ID ~= StoneIDInSpellTable[3]
				then
					CRYOLYSIS_SPELL_TABLE[spell].ID = CurrentSpells.ID[index];
					CRYOLYSIS_SPELL_TABLE[spell].Rank = CurrentSpells.subName[index];
			end
   		end
	end

	-- Updates the duration of each spell according to its rank
	for index=1, #(CRYOLYSIS_SPELL_TABLE), 1 do
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
			for index=1, #(CRYOLYSIS_SPELL_TABLE), 1 do
				if CRYOLYSIS_SPELL_TABLE[index].Name == spellName then
					self:MoneyToggle();
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

	for i=1, #(StoneIDInSpellTable), 1 do
		if StoneIDInSpellTable[i] == 0 then StoneIDInSpellTable[i] = nil end
	end

end

------------------------------------------------------------------------------------------------------
-- OTHER FUNCTIONS
------------------------------------------------------------------------------------------------------
-- Update text on Cryolysis buttons
function Cryo:ButtonTextUpdate()
	for i, v in ipairs(Cryo.db.char.waterRanks) do
		local c = GetItemCount(v)
		if ( c > 0 ) then
			Cryo.db.char.highestWaterId = v
			Cryo.db.char.highestWaterCount = c
			CryolysisDrinkCount:SetText(c)
			Count.Drink = c
			break
		end
	end
	Cryolysis_UpdateDrinkButtonAttributes()
	for i, v in ipairs(Cryo.db.char.foodRanks) do
		local c = GetItemCount(v)
		if ( c > 0 ) then
			Cryo.db.char.highestFoodId = v
			Cryo.db.char.highestFoodCount = c
			CryolysisFoodCount:SetText(c)
			Count.Food = c
			break
		end
	end
	Cryolysis_UpdateFoodButtonAttributes()
	for i, v in ipairs(Cryo.db.char.manaStones) do
		local c = GetItemCount(v)
		if ( c > 0 ) then
			c = true
		end
		Cryo.db.char.hasManaStones[i] = c
	end
	if Cryo.db.profile.EvocationCooldownText then
		CryolysisEvocationCooldown:SetText(Cryo.db.char.EvocationCooldownText);
	else
		CryolysisEvocationCooldown:SetText("");
	end
	if Cryo.db.profile.ManastoneCooldownText then
		CryolysisManastoneCooldown:SetText(Cryo.db.char.ManastoneCooldownText);
	else
		CryolysisManastoneCooldown:SetText("");
	end
	if Cryo.db.profile.PowderCountText then
		CryolysisPowderCount:SetText(Count.ArcanePowder);
	else
		CryolysisPowderCount:SetText("");
	end
	if Cryo.db.profile.FeatherCountText then
		CryolysisFeatherCount:SetText(Count.LightFeather);
	else
		CryolysisFeatherCount:SetText("");
	end
end

-- Converts seconds into minutes:seconds
function Cryo:TimerFunction(seconde)
	local affiche, minute, Time
	if seconde <= 59 then
		return tostring(math.floor(seconde))
	else
		minute = tostring(math.floor(seconde/60))
		seconde = math.fmod(seconde, 60);
		if seconde < 10 then
			Time = "0"..tostring(math.floor(seconde))
		else
			Time = tostring(math.floor(seconde))
		end
		affiche = minute..":"..Time
		return affiche
	end
end

-- Function to know if a unit undergoes an effect
-- F(string, string)->bool
function Cryo:UnitHasEffect(unit, effect)
	local i = 1
	while UnitDebuff(unit, i) do
		local name = UnitDebuff(unit, i)
   		if ( string.find(name, effect) ) then
			return true
		end
		i = i + 1
	end
end

function Cryo:Trade(Type)
	if ( Count[Type] > 0 ) then
		if ( UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") and UnitName("target") ~= UnitName("player") ) or CryolysisTradeRequest then
			self:TradeExplore(Count[Type.."LastName"])
		end
	end
end

function Cryo:MoneyToggle()
	for index = 1, 10 do
		local text = _G["CryolysisTooltipTextLeft"..index]
		if ( text ) then
			text:SetText(nil);
		end
		text = _G["CryolysisTooltipTextRight"..index]
		if ( text ) then
			text:SetText(nil);
		end
	end
	CryolysisTooltip:Hide();
	CryolysisTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
end

--Function to place the buttons around Cryolysis (and to grow/shrink the interface)
function Cryo:UpdateButtonsScale()
	local NBRScale = (100 + (Cryo.db.profile.CryolysisButtonScale - 85)) / 100
	if Cryo.db.profile.CryolysisButtonScale <= Cryo.db.profile.CryolysisStoneScale then
		NBRScale = 1.1
	end
	if Cryo.db.profile.CryolysisLockServ then
		self:ClearAllPoints()
		for i in ipairs(Cryo.db.profile.StoneLocation) do
			local f = _G[ Cryo.db.profile.StoneLocation[i] ]
			if ( f ) then
				f:Hide()
			end
		end
		local indexScale = -18
		local DoesSpellExists = {
			StoneIDInSpellTable[4],
			StoneIDInSpellTable[3],
			ManaStoneMenuCreate[1],
			true,
			StoneIDInSpellTable[1],
			true,
			BuffMenuCreate[1],
			Mount.Available,
			PortalMenuCreate[1]
		}
		for index in ipairs(Cryo.db.profile.StoneLocation) do
			if (( Cryo.db.profile.StoneLocation[index] ) and ( DoesSpellExists[index] )) then
				local f = _G[ Cryo.db.profile.StoneLocation[index] ]
				if ( f ) then
					f:SetPoint("CENTER", "CryolysisButton", "CENTER", ((40 * NBRScale) * cos(Cryo.db.profile.CryolysisAngle-indexScale)), ((40 * NBRScale) * sin(Cryo.db.profile.CryolysisAngle-indexScale)))
					f:SetScale(Cryo.db.profile.CryolysisStoneScale / 100)
					f:Show()
					indexScale = indexScale + 36
				end
			end
		end
	end
end

-- Function (XML) to restore the buttons around the sphere
function Cryo:ClearAllPoints()
	for i in ipairs(Cryo.db.profile.StoneLocation) do
		local f = _G[ Cryo.db.profile.StoneLocation[i] ]
		if ( f ) then
			f:ClearAllPoints()
		end
	end
end

function Cryo:DragControl(allowed)
	if ( allowed ) then
		allowed = "LeftButton"
	else
		allowed = ""
	end
	for i in ipairs(Cryo.db.profile.StoneLocation) do
		local f = _G[ Cryo.db.profile.StoneLocation[i] ]
		if ( f ) then
			f:RegisterForDrag(allowed)
		end
	end
end

-- Whenever the spell book changes, when the mod loads, and when the menu is rotated eith the spell menus
function Cryo:CreateMenu()
	ManaStoneMenuCreate = {}
	PortalMenuCreate = {}
	BuffMenuCreate = {}
	local menuVariable
	local ManaStoneButtonPosition = 0
	local PortalButtonPosition = 0
	local BuffButtonPosition = 0

	local types = { "ManaStone", "Buff", "Portal" }
	
	local f
	for i = 1, 12, 1 do
		for j = 1, 3, 1 do
			f = _G["Cryolysis"..types[j].."Menu"..i]
			if ( f ) then
				f:Hide()
			end
		end
	end
	
	for i = 1, 4, 1 do
		if ( Manastone.RankID[i] ) then
			f = _G["CryolysisManaStoneMenu"..i]
			f:ClearAllPoints()
			f:SetPoint("CENTER", "CryolysisManaStoneMenu"..ManaStoneButtonPosition, "CENTER", ((36 / Cryo.db.profile.ManaStoneMenuPos) * 31), 0)
			f:SetScale(Cryo.db.profile.CryolysisStoneScale / 100)
			ManaStoneButtonPosition = i
			table.insert(ManaStoneMenuCreate, f)
		end
	end

	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are displayed
	if ( ManaStoneMenuCreate[1] ) then
		ManaStoneMenuCreate[1]:ClearAllPoints()
		ManaStoneMenuCreate[1]:SetPoint("CENTER", "CryolysisManaStoneButton", "CENTER", ((36 / Cryo.db.profile.ManaStoneMenuPos) * 31), Cryo.db.profile.ManaStoneMenuAnchor)
		for i in ipairs(ManaStoneMenuCreate) do
			f = ManaStoneMenuCreate[i]
			f:Show()
			CryolysisManaStoneMenu0:SetAttribute("addchild", f)
			f:SetAttribute("showstates", "!0,*")
			f:SetAttribute("anchorchild", CryolysisManaStoneMenu0)
			f:SetAttribute("childstate", (i + 1))
			f:SetAttribute("newstate", "0")
		end
	end

	-- Start placing portals on the menu
	if CRYOLYSIS_SPELL_TABLE[38].ID then
		menuVariable = _G["CryolysisPortalMenu1"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 1;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[40].ID then
		menuVariable = _G["CryolysisPortalMenu2"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 2;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[39].ID then
		menuVariable = _G["CryolysisPortalMenu3"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 3;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[47].ID then
		menuVariable = _G["CryolysisPortalMenu7"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 7;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[31].ID then
		menuVariable = _G["CryolysisPortalMenu8"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 8;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[30].ID then
		menuVariable = _G["CryolysisPortalMenu9"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 9;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[37].ID then
		menuVariable = _G["CryolysisPortalMenu4"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 4;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[51].ID then
		menuVariable = _G["CryolysisPortalMenu5"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 5;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[46].ID then
		menuVariable = _G["CryolysisPortalMenu6"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 6;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[28].ID then
		menuVariable = _G["CryolysisPortalMenu10"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 10;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[29].ID then
		menuVariable = _G["CryolysisPortalMenu11"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 11;
		table.insert(PortalMenuCreate, menuVariable);
	end
	if CRYOLYSIS_SPELL_TABLE[27].ID then
		menuVariable = _G["CryolysisPortalMenu12"];
		menuVariable:ClearAllPoints();
		menuVariable:SetPoint("CENTER", "CryolysisPortalMenu"..PortalButtonPosition, "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), 0);
		menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100);
		PortalButtonPosition = 12;
		table.insert(PortalMenuCreate, menuVariable);
	end
	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are displayed
	if PortalMenuCreate[1] then
		PortalMenuCreate[1]:ClearAllPoints();
		PortalMenuCreate[1]:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31), Cryo.db.profile.PortalMenuAnchor);
		for i = 1, #PortalMenuCreate, 1 do
			f = PortalMenuCreate[i]
			f:Show();
			CryolysisPortalMenu0:SetAttribute("addchild", f)
			f:SetAttribute("showstates", "!0,*")
			f:SetAttribute("anchorchild", CryolysisPortalMenu0)
			f:SetAttribute("childstate", (i + 1))
			f:SetAttribute("newstate", "0")
		end
	end

	local buffAssociations = { 22, 4, 13, 25, 15, 50, 33, 35 }
	for i, v in ipairs(buffAssociations) do
		local bool
		if ( CRYOLYSIS_SPELL_TABLE[v].ID ) then
			bool = true
		end
		if (( i == 1 ) and ( not bool ) and ( CRYOLYSIS_SPELL_TABLE[18].ID )) then
			bool = true
		end
		if ( bool ) then
			menuVariable = _G["CryolysisBuffMenu"..i]
			menuVariable:ClearAllPoints()
			menuVariable:SetPoint("CENTER", "CryolysisBuffMenu"..BuffButtonPosition, "CENTER", ((36 / Cryo.db.profile.BuffMenuPos) * 31), 0)
			menuVariable:SetScale(Cryo.db.profile.CryolysisStoneScale / 100)
			BuffButtonPosition = i
			table.insert(BuffMenuCreate, menuVariable)
		end
	end

	-- Now that all the buttons are placed the ones beside the others (out of the screen), the available ones are posted
	if BuffMenuCreate[1] then
		BuffMenuCreate[1]:ClearAllPoints();
		BuffMenuCreate[1]:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", ((36 / Cryo.db.profile.BuffMenuPos) * 31),Cryo.db.profile.BuffMenuAnchor);
		for i = 1, #BuffMenuCreate, 1 do
			f = BuffMenuCreate[i];
			f:Show();
			CryolysisBuffMenu0:SetAttribute("addchild", f)
			f:SetAttribute("showstates", "!0,*")
			f:SetAttribute("anchorchild", CryolysisBuffMenu0)
			f:SetAttribute("childstate", (i + 1))
			f:SetAttribute("newstate", "0")
		end
	end

	-- Spell attribute updates (Eternally777 @ 12:45 GMT 12/13/2006):
	Cryolysis_UpdateLeftSpellAttributes()
	Cryolysis_UpdateEvocationAttributes()
	Cryolysis_UpdateRightSpellAttributes()
	Cryolysis_UpdateBuffButtonAttributes()
	Cryolysis_UpdatePortalButtonAttributes(PortalTempID)
	Cryolysis_UpdateManaStoneButtonAttributes(Manastone, Cryo.db.char.manaStones)
end

-- Function allowing the display of the various pages of the config menu
function Cryo:GeneralTab_OnClick(id)
	local panels = { _G["CryolysisProvisionMenu"], _G["CryolysisMessageMenu"], _G["CryolysisButtonMenu"], _G["CryolysisTimerMenu"], _G["CryolysisGraphOptionMenu"] }
	local TabName
	for i = 1, 5, 1 do
		TabName = _G["CryolysisGeneralTab"..i]
		if ( i == id ) then
			TabName:SetChecked(1)
			panels[i]:Show()
			_G["CryolysisGeneralPageText"]:SetText(CRYOLYSIS_CONFIGURATION["Menu"..i])
		else
			TabName:SetChecked(nil)
			panels[i]:Hide()
		end
	end
	CryolysisGeneralIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
end

function CryolysisTimer(name, duration)
	local target = UnitName("target") or ""
	local level = UnitLevel("target") or ""
	local foo = 6
	SpellGroup, SpellTimer, TimerTable = CryolysisTimerX(name, duration, foo, target, level, SpellGroup, SpellTimer, TimerTable)
end

-- This function is to automate our version numbers a little bit.  When using
-- an SVN server, you can set a property on any file so that when you upload a
-- new version, the SVN parses the file and replaces every instance of the string
-- "dollar-sign Rev dollar-sign" with that files revision.  This function will
-- automatically append the highest revision # it finds to the end of
-- CryolysisData.Version.
function Cryolysis_UpdateRevisions(fileName, svnRev)
	local _, _, rev = string.find(svnRev, "(%d+)")
	rev = tonumber(rev) or 0
	if ( not CryolysisRevisions ) then
		CryolysisRevisions = { [fileName] = rev }
	else
		CryolysisRevisions[fileName] = rev
	end
	local Max = 0
	for k, v in next, CryolysisRevisions do
		if (( Max ) and ( v > Max ) or ( not Max )) then
			Max = v
		end
	end
	if ( string.len(Max) > 2 ) then
		Max = string.sub(Max, 1, 1).."."..string.sub(Max, 2)
	else
		Max = "0."..Max
	end
	CryolysisData.Version = "2."..Max
	CryolysisData.Label = CryolysisData.AppName.." "..CryolysisData.Version
	CryolysisVersion:SetText(CryolysisData.Label)
end

function Cryo:ChangeOfsy(Action, Menu)
	local tbl
	if ( Menu == "Buff" ) then
		tbl = BuffMenuCreate
	elseif ( Menu == "Portal" ) then
		tbl = PortalMenuCreate
	elseif ( Menu == "ManaStone" ) then
		tbl = ManaStoneMenuCreate
	end
	if ( Menu == "Buff" ) then
		if ( Action == "Enter" ) then
			for i in ipairs(BuffMenuCreate) do
				f = BuffMenuCreate[i]
				f:Show()
			end
		elseif ( Action == "Leave" ) then
			for i in ipairs(BuffMenuCreate) do
				f = BuffMenuCreate[i]
				f:Hide()
			end
		elseif ( Action == "ValueChange" ) then
			CryolysisBuffMenu1:ClearAllPoints()
			CryolysisBuffMenu1:SetPoint("CENTER", "CryolysisBuffMenuButton", "CENTER", ((36 / Cryo.db.profile.BuffMenuPos) * 31),Cryo.db.profile.BuffMenuAnchor)
		end
	elseif ( Menu == "Portal" ) then
		if ( Action == "Enter" ) then
			for i=1, #PortalMenuCreate, 1 do
				f = PortalMenuCreate[i]
				f:Show()
			end
		elseif ( Action == "Leave" ) then
			for i=1, #PortalMenuCreate, 1 do
				f = PortalMenuCreate[i]
				f:Hide()
			end
		elseif ( Action == "ValueChange" ) then
			CryolysisPortalMenu1:ClearAllPoints()
			CryolysisPortalMenu1:SetPoint("CENTER", "CryolysisPortalMenuButton", "CENTER", ((36 / Cryo.db.profile.PortalMenuPos) * 31),Cryo.db.profile.PortalMenuAnchor)
		end
	elseif ( Menu == "ManaStone" ) then
		if ( Action == "Enter" ) then
			for i=1, #ManaStoneMenuCreate, 1 do
				f = ManaStoneMenuCreate[i]
				f:Show()
			end
		elseif ( Action == "Leave" ) then
			for i=1, #ManaStoneMenuCreate, 1 do
				f = ManaStoneMenuCreate[i]
				f:Hide()
			end
		elseif ( Action == "ValueChange" ) then
			CryolysisManaStoneMenu1:ClearAllPoints()
			CryolysisManaStoneMenu1:SetPoint("CENTER", "CryolysisManaStoneButton", "CENTER", ((36 / Cryo.db.profile.ManaStoneMenuPos) * 31),Cryo.db.profile.ManaStoneMenuAnchor)
		end
	end
	if ( Action == "Leave" ) then
		Cryo:CreateMenu()
	end
end

function Cryo:PlayerHasSpell(spell)
	for i in ipairs(CRYOLYSIS_SPELL_TABLE) do
		if ( CRYOLYSIS_SPELL_TABLE[i].Name == spell ) then
			if ( CRYOLYSIS_SPELL_TABLE[i].ID ) then
				return CRYOLYSIS_SPELL_TABLE[i]
			end
			break
		end
	end
end

Cryolysis_UpdateRevisions("Cryolysis.lua", "$Rev$")