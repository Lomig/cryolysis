-- In a well written Ace2 mod, this variable, which defines our entire addon, will
-- be the only global variable our addon creates.
Cryolysis = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0")
local _G = getfenv(0)

-- This registers the names of our saved variables with AceDB-2.0.
-- See the TOC file if you're wondering how I came up with them.
-- From this point forward, our general saved variables are in the
-- Cryolysis.db.profile table, and the per character variable is the
-- Cryolysis.db.char table.
-- P.S.: "CryoPCDB" stands for "Cryo Per Character Data Base"
Cryolysis:RegisterDB("CryoDB", "CryoPCDB")

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

function Cryolysis:OnInitialize()
end

function Cryolysis:OnEnable()
end

function Cryolysis:OnDisable()
end