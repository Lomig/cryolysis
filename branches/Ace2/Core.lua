-- In a well written Ace2 mod, this variable, which defines our entire addon, will
-- be the only global variable our addon creates.
Cryolysis = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
local _G = getfenv(0)

-- This registers the names of our saved variables with AceDB-2.0.
-- See the TOC file if you're wondering how I came up with them.
-- From this point forward, our general saved variables are in the
-- Cryolysis.db.profile table, and the per character variable is the
-- Cryolysis.db.char table.
Cryolysis:RegisterDB("CryoDB", "CryoPCDB")
Cryolysis:RegisterDefaults("profile", {
	shortMsgs = false,
})

-- This is a table set up in a specific structure known as an
-- "AceOptions Table".  This is the structure that AceConsole-2.0
-- uses to set up chat commands.  This will replace the
-- Cryolysis_SlashHandler() function.
Cryolysis.chatCommands = {
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
}

Cryolysis.events = {
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
	"TRADE_REQUEST",
	"TRADE_REQUEST_CANCEL",
	"TRADE_SHOW",
	"TRADE_CLOSED",
	"VARIABLES_LOADED",
	"PLAYER_LOGIN"
}

-- Called @ ADDON_LOADED
function Cryolysis:OnInitialize()
	self:RegisterChatCommand({"/Cryolysis", "/Cryo"}, self.chatCommands)
end

-- Called @ PLAYER_LOGIN
function Cryolysis:OnEnable()
end

-- This is called when the player does "/Cryolysis standby"
function Cryolysis:OnDisable()
	if ( _G["CryolysisButton"]:IsVisible() ) then
		HideUIPanel(_G["CryolysisButton"])
	else
		ShowUIPanel(_G["CryolysisButton"])
	end
end