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
-- First changes for the BC Live patch, with all our thanks : Ayumi of Stormscale
--
------------------------------------------------------------------------------------------------------



------------------------------------------------
-- GERMAN VERSION FUNCTIONS --
------------------------------------------------
--
if GetLocale() == "deDE" then

function Cryolysis_SpellTableBuild()
CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Magie verst\195\164rken",		Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Arkane Brillanz",			Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Arkane Explosion",			Length = 0,	Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Arkane Intelligenz",			Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Arkane Geschosse",			Length = 0,	Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Druckwelle",				Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Blinzeln",				Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Blizzard",				Length = 0,	Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "K\195\164ltekegel",			Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Essen herbeizaubern",			Length = 0,	Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Wasser herbeizaubern",			Length = 0,	Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Gegenzauber",				Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Magie d\195\164mpfen",			Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerschlag",				Length = 8,	Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerzauberschutz",			Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerball",				Length = 8,	Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Flammensto\195\159",			Length = 8,	Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frostr\195\188stung",			Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frostnova",				Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frostzauberschutz",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frostblitz",				Length = 9,	Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Eisr\195\188stung",			Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Eisbarriere",				Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Magische R\195\188stung",		Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Manaschild",				Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verwandlung",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Portal: Darnassus",			Length = 0,	Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Portal: Eisenschmiede",			Length = 0,	Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Portal: Sturmwind",			Length = 0,	Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Portal: Donnerfels",			Length = 0,	Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Portal: Unterstadt",			Length = 0,	Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Pyroschlag",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Geringen Fluch entfernen",		Length = 0,	Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Versengen",	     		 	Length = 0,	Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Langsamer Fall",			Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Darnassus",		Length = 0,	Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Eisenschmiede",		Length = 0,	Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Orgrimmar",		Length = 0,	Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Donnerfels", 		 Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Unterstadt",		Length = 0,	Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Eisblock",				Length = 300,	Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "K\195\164lteeinbruch",			Length = 600,	Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verbrennung",				Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Geistesgegenwart",			Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Arkanes Pulver",			Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Darnassus",		Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Portal: Orgrimmar",			Length = 0,	Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verwandlung: Schwein",			Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Hervorrufung",				Length = 480,	Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Magie entdecken",			Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Teleportieren: Sturmwind",		Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Verwandlung: Schildkr\195\182te",	Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Erfrierung",				Length = 5,	Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winterk\195\164lte",			Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winterk\195\164lte (2)",		Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winterk\195\164lte (3)",		Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winterk\195\164lte (4)",		Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Winterk\195\164lte (5)",		Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerverwundbarkeit",			Length = 30,	Type = 6},
    [60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerverwundbarkeit (2)",		Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerverwundbarkeit (3)",		Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerverwundbarkeit (4)",		Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Feuerverwundbarkeit (5)",		Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Mana Gem",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Freeze",				Length = 5,	Type = 5},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Frost nova",				Length = 8,	Type = 6},
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Poly Diminished",			Length = 15,	Type = 6},
	[68] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Exodar",		Length = 0,		Type = 0},
	[69] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Shattrath",		Length = 0,		Type = 0},
	[70] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Exodar",		Length = 0,		Type = 0},
	[71] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleportieren: Shattrath",		Length = 0,		Type = 0},
	[72] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Portal: Silbermond",		Length = 0,		Type = 0},
	[73] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "Teleport: Silbermond",		Length = 0,		Type = 0},
};
end
Cryolysis_SpellTableBuild()
-- Type 0 = No Timer
-- Type 1 = Principle permanent timer
-- Type 2 = permanent timer
-- Type 3 = Cooldown Timer
-- Type 4 = Debuff Timer
-- Type 5 = Combat Timer

CRYOLYSIS_ITEM = {
	["LightFeather"] = "Leichte Feder",
	["ArcanePowder"] = "Arkanes Pulver",
	["RuneOfTeleportation"] = "Rune der Teleportation",
	["RuneOfPortals"] = "Rune der Portale",
	["Manastone"] = "Mana",
	["Hearthstone"] = "Ruhestein",
	["Provision"] = "Herbeigezauberte",
	["Evocation"] = "Hervorrufung",
	["Drink"] = "Wasser",
	["Food"] = "Essen",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = "r Muffin",
	[2] = "s Brot",
	[3] = "s Roggenbrot",
	[4] = "r Pumpernickel",
	[5] = "r Sauerteig",
	[6] = "s Milchbr\195\182tchen",
	[7] = " Zimtschnecke",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = "s Wasser",
	[2] = "s frisches Wasser",
	[3] = "s gel\195\164utertes Wasser",
	[4] = "s Quellwasser",
	[5] = "s Mineralwasser",
	[6] = "s Sprudelwasser",
	[7] = "s Kristallwasser",
	[8] = "s Astralwasser",
};
CRYOLYSIS_STONE_RANK = {
	[1] = "achat",		-- Rank Minor
	[2] = "jadestein",	-- Rank Lesser
	[3] = "citrin",	      -- Rank Greater
	[4] = "rubin",		-- Rank Major
	[5] = "smaragd"
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "Manaachat",		-- Rank Minor
	[2] = "Jadestein",	-- Rank Lesser
	[3] = "Manajadestein",	      -- Rank Greater
	[4] = "Manarubin",		-- Rank Major
	[5] = "Manasmaragd"
};
CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "Manaachat herbeizaubern",
	[2] = "Manajadestein herbeizaubern",
	[3] = "Manacitrin herbeizaubern",
	[4] = "Manarubin herbeizaubern",
	[5] = "Manasmaragd herbeizaubern"
};

CRYOLYSIS_CREATE = {
	[1] = "Hervorrufung",
	[2] = "Manastein herbeizaubern",
	[3] = "Wasser herbeizaubern",
	[4] = "Essen herbeizaubern"
};
CRYOLYSIS_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "Horn des Frostwolfheulers" },
	-- [2] Ram Icon
	{ "Streitwidder der Stormpike", "Schwarzer Widder", "Schwarzer Kriegswidder", "Brauner Widder", "Frostwidder", "Grauer Widder", "Schneller brauner Widder", "Schneller grauer Widder", "Schneller wei\195\159er Widder", },
	-- [3] Raptor Icon
	{ "Schneller Razzashiraptor", "Schneller blauer Raptor", "Schneller olivfarbener Raptor", "Schneller orangener Raptor", "Pfeife des schwarzen Kriegsraptors", "Pfeife des smaragdfarbenen Raptors", "Pfeife des elfenbeinfarbenen Raptors", "Pfeife des scheckigen roten Raptors", "Pfeife des t\195\188rkisfarbenen Raptors", "Pfeife des violetten Raptors" },
	-- [4] Yellow Tiger Icon
	{ "Schneller zulianischer Tiger" },
	-- [5] Undead Horse Icon
	{ "Blaues Skelettpferd",  "Blaues Skelettschlachtross", "Z\195\188gel des Todesstreitrosses", "Braunes Skelettpferd", "Gr\195\188nes Skelettschlachtross", "Purpurnes Skelettschlachtross", "Rotes Skelettpferd", "Rotes Skelettschlachtross" },
	-- [6] Blue Mechanostrider Icon
	{ "Schwarzer Schlachtenschreiter", "Blauer Roboschreiter", "Gr\195\188ner Roboschreiter", "Eisblauer Roboschreiter Mod. A", "Roter Roboschreiter", "Schneller gr\195\188ner Roboschreiter", "Schneller we\195\159er Roboschreiter", "Schneller gelber Roboschreiter", "Unlackierter Roboschreiter", "Wei\195\159 Roboschreiter Mod. A" },
	-- [7] Brown Horse Icon
	{ "Schwarzes Schlachtrosszaumzeug", "Braunes Pferd", "Kastanienbraune Stute", "Palominozaumzeug", "Schecke", "Schneller Brauner", "Schnelles Palomino", "Schnelles wei\195\159es Ross", "Schimmelzaumzeug" },
	-- [8] Brown Kodo Icon
	{ "Schwarzer Kriegskodo", "Brauner Kodo", "Gro\195\159er brauner Kodo" },
	-- [9] War Steed Icon
	{ "Schwarzes Schlachtross" },
	-- [10] Gray Kodo Icon
	{ "Grauer Kodo", "Gro\195\159er grauer Kodo", "Gro\195\159er wei\195\159er Kodo" },
	-- [11] Green Kodo Icon
	{ "Gr\195\188ner Kodo", "Graublauer Kodo" },
	-- [12] White Wolf Icon
	{ "Horn des arktischen Wolfs", "Horn des Terrorwolfs", "Horn des schnellen Grauwolfs", "Horn des schnellen Waldwolfs" },
	-- [13] Black Wolf Icon
	{ "Horn des schwarzen Kriegswolfs", "Horn des braunen Wolfs", "Horn des roten Wolfs", "Horn des schnellen braunen Wolfs", "Horn des Waldwolfs" },
	-- [14] Black Tiger Icon
	{ "Z\195\188gel des schwarzen Kriegstigers", "Z\195\188gel des gestreiften Nachts\195\164blers" },
	-- [15] White Tiger Icon
	{ "Z\195\188gel des Frosts\195\164blers", "Z\195\188gel des Nachts\195\164blers", "Z\195\188gel des gefleckten Frosts\195\164blers", "Z\195\188gel des gestreiften Frosts\195\164blers", "Z\195\188gel des schnellen Frosts\195\164blers", "Z\195\188gel des schnellen Schattens\195\164blers", "Z\195\188gel des schnellen Sturms\195\164blers" },
	-- [16] Red Tiger Icon
	{ "Reins of the Winterspring Frostsaber" },
	-- [17] Black Qiraji Resonating Crystal
	{ "Black Qiraji Resonating Crystal" },
}

-- Prefix on mount item that is not in the buff name
CRYOLYSIS_MOUNT_PREFIX = {
	"Horn des ",
	"Pfeife des ",
	"Z\195\188gel des ",
}

CRYOLYSIS_AQMOUNT_TABLE = {
	"Blue Qiraji Resonating Crystal",
 	"Green Qiraji Resonating Crystal",
 	"Red Qiraji Resonating Crystal",
	"Yellow Qiraji Resonating Crystal",
}
CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "Abklingzeit",
	["Hearth"] = "Ruhestein",
	["Rank"] = "Rang",
};
end

