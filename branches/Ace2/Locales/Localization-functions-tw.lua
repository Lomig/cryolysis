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



------------------------------------------------
-- Traditional Chinese  VERSION FUNCTIONS --- Nightly@布蘭�?�德
------------------------------------------------
--
if ( GetLocale() == "zhTW" ) then

CRYOLYSIS_UNIT_MAGE = "法師";

function Cryolysis_SpellTableBuild()
CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法增效",				Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法光�?",				Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔爆術",				Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法智慧",				Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法飛彈",				Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?擊波",				Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "閃�?�術",				Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "暴風雪",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰�?術",				Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造食術",				Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造水術",				Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "法術�??制",				Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔法抑制",				Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�焰�?擊",				Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防護�?�焰�?界",			Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?��?�術",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "烈焰風暴",				Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "霜甲術",				Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰霜新星",				Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防護冰霜�?界",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰箭",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰甲術",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰護體",				Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔甲術",				Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "法力護盾",				Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "變形術",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?門：�?��?蘇斯",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?門：�?��?堡",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?門：暴風城",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?門：雷霆崖",		Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?門：幽暗城",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "炎爆術",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "解除次級詛咒",			Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�燒",				Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "緩�?�術",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：�?��?蘇斯",		Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：�?��?堡",			Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：奧格瑪",			Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：雷霆崖",				Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：幽暗城",			Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰�?障",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "急速冷�?�",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "燃燒",					Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "氣定神閒",				Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "祕法強化",				Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：�?��?蘇斯",			Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?門：奧格瑪",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "變豬術",				Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "喚醒",				Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�測魔法",				Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "傳�?：暴風城",				Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "變龜術",				Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "霜寒刺骨",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響",	Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(2)",	Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(3)",	Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(4)",	Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒效果的影響(5)",	Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易傷效果的影響",	Length = 30,	Type = 6},
    [60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易傷效果的影響(2)",	Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易傷效果的影響(3)",	Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易傷效果的影響(4)",	Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易傷效果的影響(5)",	Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法寶石",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰�?",					Length = 5,		Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰霜新星",				Length = 8,		Type = 6},	
	[67] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Poly Diminished",		Length = 15,	Type = 6},
};
end
Cryolysis_SpellTableBuild();
-- Type 0 = No Timer
-- Type 1 = Principle permanent timer
-- Type 2 = permanent timer
-- Type 3 = Cooldown Timer
-- Type 4 = Debuff Timer
-- Type 5 = Combat Timer
-- Type 6 = Non-cast debuff.  Not to be removed by normal means
CRYOLYSIS_ITEM = {
	["LightFeather"] = "輕羽毛",
	["ArcanePowder"] = "魔粉",
	["RuneOfTeleportation"] = "傳�?符文",
	["RuneOfPortals"] = "傳�?門符文",
	["Manastone"] = "法力",
	["Hearthstone"] = "�?石",
	["Provision"] = "製造",
	["Evocation"] = "喚醒",
	["Drink"] = "造水術",
	["Food"] = "造食術",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = " 魔法鬆餅",
	[2] = " 魔法麵包",
	[3] = " 魔法黑麵包",
	[4] = " 魔法粗麵包",
	[5] = " 魔法酵�?",
	[6] = " 魔法甜麵包", 
	[7] = " 魔法肉桂麵包",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = " 魔法水",
	[2] = " 魔法淡水",
	[3] = " 魔法純淨水",
	[4] = " 魔法泉水",
	[5] = " 魔法礦泉水",
	[6] = " 魔法蘇打水",
	[7] = " 魔法晶水",
};
CRYOLYSIS_STONE_RANK = {
	[1] = "瑪瑙",		-- Rank Minor
	[2] = "翡翠",		-- Rank Lesser
	[3] = "黄水晶",	-- Rank Greater
	[4] = "紅寶石"		-- Rank Major
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "�法力瑪瑙",		-- Rank Minor
	[2] = "�法力翡翠",		-- Rank Lesser
	[3] = "�法力黄水晶",	-- Rank Greater
	[4] = "�法力紅寶石"		-- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "製造�法力瑪瑙",
	[2] = "製造魔法翡翠",
	[3] = "製造魔法黃水晶",
	[4] = "製造魔法紅寶石"
};
	

CRYOLYSIS_CREATE = {
	[1] = "喚醒",
	[2] = "製造魔法寶石",
	[3] = "造水術",
	[4] = "造食術"
};

CRYOLYSIS_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "霜狼嗥�?�者的號角" }, 
	-- [2] Ram Icon
	{ "雷矛�?用�??騎", "黑山羊", "黑色戰羊", "棕山羊", "白山羊", "�?�山羊", "迅�?�棕山羊", "迅�?��?�山羊", "迅�?�白山羊", },
	-- [3] Raptor Icon            
	{ "拉扎什迅猛�?", "迅�?��?色迅猛�?", "迅�?�綠色迅猛�?", "迅�?�橙色迅猛�?", "黑色戰鬥迅猛�?之哨", "綠色迅猛�?之哨", "象牙迅猛�?之哨", "紅色迅猛�?之哨", "�?�色迅猛�?之哨", "紫色迅猛�?之哨" },
	-- [4] Yellow Tiger Icon
	{ "迅�?�祖利安猛虎" },
	-- [5] Undead Horse Icon
	{ "�?色骸骨�?馬", "�?色骷�?戰馬", "死亡�?馬的�?繩", "棕色骸骨�?馬", "綠色骸骨�?馬", "紫色骷�?戰馬", "紅色骸骨�?馬", "紅色骷�?戰馬" },
	-- [6] Mechanostrider Icon
	{ "黑色作戰機械陸行鳥", "�?色機械陸行鳥", "綠色機械陸行鳥", "冰�?色機械陸行鳥A型", "紅色機械陸行鳥", "迅�?�綠色機械陸行鳥", "迅�?�白色機械陸行鳥", "迅�?�黃色機械陸行鳥", "未塗色的機械陸行鳥", "白色機械陸行鳥A型" },
	-- [7] Brown Horse Icon
	{ "黑馬�?繩", "棕馬�?繩", "栗色馬�?繩", "�?色馬�?繩", "雜色馬�?繩", "迅�?�棕馬", "迅�?��?色馬", "迅�?�白馬", "白馬�?繩" },
	-- [8] Brown Kodo Icon
	{ "黑色作戰科多�?�", "棕色科多�?�", "大型棕色科多�?�" },
	-- [9] War Steed Icon
	{ "黑色戰駒�?繩" },
	-- [10] Gray Kodo Icon
	{ "�?�色科多�?�", "大型�?�色科多�?�", "大型白色科多�?�" },
	-- [11] Green Kodo Icon 
	{ "綠色科多�?�", "�?色科多�?�" },
	-- [12] White Wolf Icon    
	{ "北極狼號角", "�??狼號角", "迅�?��?�狼號角", "迅�?�森林狼號角" },
	-- [13] Black Wolf Icon    
	{ "黑色戰狼號角", "棕狼號角", "赤狼號角", "迅�?�棕狼號角", "森林狼號角" },
	-- [14] Black Tiger Icon   
	{ "黑色戰豹�?繩", "�?紋夜刃豹�?繩" },
	-- [15] White Tiger Icon   
	{ "霜刃豹�?繩", "夜刃豹�?繩", "斑點霜刃豹�?繩", "�?紋霜刃豹�?繩", "迅�?�霜刃豹�?繩", "迅�?�霧刃豹�?繩", "迅�?�雷刃豹�?繩" },
	-- [16] Red Tiger Icon
	{ "冬泉霜刃豹�?繩" },
	-- [17] Black Qiraji Resonating Crystal
	{ "黑色其拉共鳴水晶" },
}

CRYOLYSIS_MOUNT_PREFIX = {
	"號角",
	"之哨",
	"�?繩",	
}

CRYOLYSIS_AQMOUNT_TABLE = {
	"�?色其拉共鳴水晶",
 	"綠色其拉共鳴水晶",
 	"紅色其拉共鳴水晶",
	"黃色其拉共鳴水晶",
}
CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "冷�?�時間",
	["Hearth"] = "�?石",
	["Rank"] = "等級",
};
end
