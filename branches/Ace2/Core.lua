-- In a well written Ace2 mod, this variable, which defines our entire addon, will
-- be the only global variable our addon creates.
Cryolysis = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local _G = getfenv(0)

-- PeriodicTable-2.0 is a database of item IDs sorted by categories.  See the
-- libraries lua file and you'll see what I mean.
local PT = AceLibrary("PeriodicTable-2.0")

-- This registers the names of our saved variables with AceDB-2.0.
-- See the TOC file if you're wondering how I came up with them.
-- From this point forward, our general saved variables are in the
-- Cryolysis.db.profile table, and the per character variable is the
-- Cryolysis.db.char table.
Cryolysis:RegisterDB("CryoDB", "CryoPCDB")
Cryolysis:RegisterDefaults("profile", {
	shortMsgs = false,
})


do
	Cryolysis.consumables = {}
	Cryolysis.reagents = {}
	Cryolysis.manaStones = {}
	
	-- If you looked through the PeriodicTable-2.0 file, you saw that the
	-- item IDs were in strings, not table values. This is, again, for efficiency.
	-- PT:GetSetTable() splits the string at each " " and puts the values into a table,
	-- which it returns for us.  I'm simply going through the table, pulling out the
	-- item IDs, and sticking them in our consumables table.
	local tbl = PT:GetSetTable("Food - Bread Conjured")
	for k, v in next, tbl do
		Cryolysis.consumables[k..":"..v] = 0
	end
	tbl = PT:GetSetTable("Water - Conjured")
	for k, v in next, tbl do
		Cryolysis.consumables[k..":"..v] = 0
	end
	tbl = PT:GetSetTable("Reagent - Mage")
	for k, v in next, tbl do
		Cryolysis.reagents[k..":"..v] = 0
	end
	tbl = PT:GetSetTable("Mana Stone")
	for k, v in next, tbl do
		Cryolysis.manaStones[k..":"..v] = 0
	end
	tbl = nil
end

Cryolysis.events = {
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
	"TRADE_REQUEST",
	"TRADE_REQUEST_CANCEL",
	"TRADE_SHOW",
	"TRADE_CLOSED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN"
}

-- Called @ ADDON_LOADED
function Cryolysis:OnInitialize()
	-- This is a table set up in a specific structure known as an
	-- "AceOptions Table".  This is the structure that AceConsole-2.0
	-- uses to set up chat commands.  This will replace the
	-- Cryolysis_SlashHandler() function.
	self:RegisterChatCommand({"/Cryolysis", "/Cryo"}, {
		type = "group",
		args = {
			["Recall"] = {  -- EX: "/cryo Recall"
				name = "Recall", type = "execute",
				desc = "Center Cryolysis and all of its buttons in the middle of the screen.",
				func = function()
					if ( _G["CryolysisButton"] ) then
						_G["CryolysisButton"]:ClearAllPoints()
						_G["CryolysisButton"]:SetPoint("CENTER", _G["UIParent"], "CENTER",0,0)
					end
					if ( _G["CryolysisSpellTimerButton"] ) then
						_G["CryolysisSpellTimerButton"]:ClearAllPoints()
						_G["CryolysisSpellTimerButton"]:SetPoint("CENTER", _G["UIParent"], "CENTER", 0, 0)
					end
				end
			},
			["SM"] = {
				name = "Short Messages", type = "toggle",
				desc = "Replace messages with a short, raid-friendly version.",
				get = function() return Cryolysis.db.profile.shortMsgs end,
				set = function()
					Cryolysis.db.profile.shortMsgs = not Cryolysis.db.profile.shortMsgs
					if ( not Cryolysis.db.profile.shortMsgs ) then
						CryolysisLocalization()
					else
						CRYOLYSIS_Evocation_ALERT_MESSAGE = CRYOLYSIS_SHORT_MESSAGES[1]
						CRYOLYSIS_INVOCATION_MESSAGES = CRYOLYSIS_SHORT_MESSAGES[2]
					end
				end
			},
			["Reset"] = {
				name = "Reset", type = "execute",
				desc = "Restore and reload default Cryolysis configurations.",
				func = function()
					CryolysisConfig.Version = "reboot"
					Cryolysis_Loaded = false
					Cryolysis_LoadVariables()
				end
			}
		}
	})
end

-- Called @ PLAYER_LOGIN
function Cryolysis:OnEnable()
	-- We register events in the :OnEnable() function because we don't want our mod to be listening to events
	-- if it's disabled.  When :OnDisable() is called, Ace2 automatically unregisters the events for us.
	
	-- This is one of the cooler functions of AceEvent-2.0.  "RegisterBucketEvent()" does the same thing as 
	-- "RegisterEvent()".  I can't find the right words to explain it; see http://tinyurl.com/yfcs57 for more info.
	self:RegisterBucketEvent("BAG_UPDATE", 2)
	
	-- Eventually this will iterate through the entire Cryolysis.events table, but we must do it one-by-one.
	-- for i = 1, 1, 1 do
	-- 	self:RegisterEvent(self.events[i])
	-- end
end

-- This is called when the player does "/Cryolysis standby"
function Cryolysis:OnDisable()
	if ( _G["CryolysisButton"]:IsVisible() ) then
		HideUIPanel(_G["CryolysisButton"])
	else
		ShowUIPanel(_G["CryolysisButton"])
	end
end

function Cryolysis:BAG_UPDATE(...)
	-- Since this is a Bucket event, this is being called AT MOST every two seconds.  This helps
	-- if it's fired several times within two seconds, as is done when the player logs in.
	for k in next, self.consumables do
		self.consumables[k] = GetItemCount( strsplit(":", k) )
	end
	for k in next, self.reagents do
		self.reagents[k] = GetItemCount( strsplit(":", k) )
	end
end