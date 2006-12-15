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
-- SIMPLIFIED CHINESE VERSION FUNCTIONS --
------------------------------------------------

if GetLocale() == "zhCN" then

CRYOLYSIS_UNIT_MAGE = "法师";

-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+)�?�到了(.+)效果的影�?。"
CRYOLYSIS_POLY_SRCH = "(.+)效果从(.+)身上消失。"

function Cryolysis_SpellTableBuild()
CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法增效",				Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术光辉",				Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔爆术",				Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术智慧",				Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术飞弹",				Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冲击波",				Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "闪现",					Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "暴风雪",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰锥术",				Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造食术",				Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "造水术",				Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔法�??制",				Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔法抑制",				Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�焰冲击",				Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防护�?�焰结界",			Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?��?�术",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "烈焰风暴",				Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "霜甲术",				Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰霜新星",				Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "防护冰霜结界",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰箭",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "冰甲术",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰护体",				Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "魔甲术",				Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "法力护盾",				Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�形术",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?门：达纳�?斯",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?门：�?炉堡",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?门：暴风城",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?门：雷霆崖",		Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?门：幽暗城",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "炎爆术",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "解除次级诅咒",			Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�烧",				Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "缓�?�术",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：达纳�?斯",		Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：�?炉堡",			Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：奥格瑞玛",		Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：雷霆崖",				Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：幽暗城",			Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "寒冰�?障",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "急速冷�?�",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "燃烧",					Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "气定神闲",				Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "奥术强化",				Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：达纳�?斯",			Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?门：奥格瑞玛",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�?�形术：猪",			Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "唤醒",				Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "侦测魔法",				Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "传�?：暴风城",				Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�形术：龟",			Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "刺骨寒冰",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒",				Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (2)",			Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (3)",			Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (4)",			Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "深冬之寒 (5)",			Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易伤",				Length = 30,	Type = 6},
	[60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易伤 (2)",			Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易伤 (3)",			Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, 		CastTime = nil, Mana = nil,
		Name = "�?�焰易伤 (4)",			Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�?�焰易伤 (5)",			Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "魔法水晶",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "冰冻",					Length = 5,		Type = 6},
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
	["LightFeather"] = "轻羽毛",
	["ArcanePowder"] = "魔粉",
	["RuneOfTeleportation"] = "传�?符文",
	["RuneOfPortals"] = "传�?门符文",
	["Manastone"] = "法力",
	["Hearthstone"] = "炉石",
	["Provision"] = "制造",
	["Evocation"] = "唤醒",
	["Drink"] = "魔法水",
	["Food"] = "魔法食物",
};
CRYOLYSIS_FOOD_RANK = {
	[1] = " 魔法�?�饼",
	[2] = " 魔法�?�包",
	[3] = " 魔法黑�?�包",
	[4] = " 魔法粗�?�包",
	[5] = " 魔法酵�?",
	[6] = " 魔法甜�?�包", 
	[7] = " 魔法肉桂�?�包",
};
CRYOLYSIS_DRINK_RANK = {
	[1] = " 魔法水",
	[2] = " 魔法淡水",
	[3] = " 魔法纯净水",
	[4] = " 魔法泉水",
	[5] = " 魔法矿泉水",
	[6] = " 魔法�?打水",
	[7] = " 魔法晶水",
};
CRYOLYSIS_STONE_RANK = {
	[1] = "玛瑙",		-- Rank Minor
	[2] = "翡翠",		-- Rank Lesser
	[3] = "黄水晶",		-- Rank Greater
	[4] = "红�?石",		-- Rank Major
};
CRYOLYSIS_STONE_RANK2 = {
	[1] = "魔法玛瑙",		-- Rank Minor
	[2] = "�法力翡翠",		-- Rank Lesser
	[3] = "�法力黄水晶",		-- Rank Greater
	[4] = "�法力红�?石",		-- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "制造魔法玛瑙",
	[2] = "制造魔法翡翠",
	[3] = "制造魔法黄水晶",
	[4] = "制造魔法红�?石",
};	


CRYOLYSIS_CREATE = {
	[1] = "唤醒",
	[2] = "制造魔法�?石",
	[3] = "造水术",
	[4] = "造食术",
};

CRYOLYSIS_MOUNT_TABLE = {
	-- [1] Frostwolf Howler Icon
	{ "霜狼嗥�?�者的�?�角" }, 
	-- [2] Ram Icon
	{ "雷矛军用�??骑", "黑山羊", "黑色战羊", "棕山羊", "白山羊", "�?�山羊", "迅�?�棕山羊", "迅�?��?�山羊", "迅�?�白山羊", },
	-- [3] Raptor Icon            
	{ "拉扎什迅猛龙", "迅�?��?色迅猛龙", "迅�?�绿色迅猛龙", "迅�?�橙色迅猛龙", "黑色战斗迅猛龙之哨", "绿色迅猛龙之哨", "象牙迅猛龙之哨", "红色迅猛龙之哨", "�?�色迅猛龙之哨", "紫色迅猛龙之哨" },
	-- [4] Yellow Tiger Icon
	{ "迅�?�祖利安猛虎" },
	-- [5] Undead Horse Icon
	{ "�?色骸骨军马", "�?色骷髅战马", "死亡军马的缰绳", "棕色骸骨军马", "绿色骸骨军马", "紫色骷髅战马", "红色骸骨军马", "红色骷髅战马" },
	-- [6] Mechanostrider Icon
	{ "黑色作战机械陆行鸟", "�?色机械陆行鸟", "绿色机械陆行鸟", "冰�?色机械陆行鸟A型", "红色机械陆行鸟", "迅�?�绿色机械陆行鸟", "迅�?�白色机械陆行鸟", "迅�?�黄色机械陆行鸟", "未涂色的机械陆行鸟", "白色机械陆行鸟A型" },
	-- [7] Brown Horse Icon
	{ "黑马缰绳", "棕马缰绳", "栗色马缰绳", "�?色马缰绳", "�?�色马缰绳", "迅�?�棕马", "迅�?��?色马", "迅�?�白马", "白马缰绳" },
	-- [8] Brown Kodo Icon
	{ "黑色作战科多兽", "棕色科多兽", "大型棕色科多兽" },
	-- [9] War Steed Icon
	{ "黑色战驹缰绳" },
	-- [10] Gray Kodo Icon
	{ "�?�色科多兽", "大型�?�色科多兽", "大型白色科多兽" },
	-- [11] Green Kodo Icon 
	{ "绿色科多兽", "�?色科多兽" },
	-- [12] White Wolf Icon    
	{ "北�?狼�?�角", "�??狼�?�角", "迅�?��?�狼�?�角", "迅�?�森林狼�?�角" },
	-- [13] Black Wolf Icon    
	{ "黑色战狼�?�角", "棕狼�?�角", "赤狼�?�角", "迅�?�棕狼�?�角", "森林狼�?�角" },
	-- [14] Black Tiger Icon   
	{ "黑色战豹缰绳", "�?�纹夜刃豹缰绳" },
	-- [15] White Tiger Icon   
	{ "霜刃豹缰绳", "夜刃豹缰绳", "斑点霜刃豹缰绳", "�?�纹霜刃豹缰绳", "迅�?�霜刃豹缰绳", "迅�?�雾刃豹缰绳", "迅�?�雷刃豹缰绳" },
	-- [16] Red Tiger Icon
	{ "冬泉霜刃豹缰绳" },
	-- [17] Black Qiraji Resonating Crystal
	{ "黑色其拉共鸣水晶" },
}

CRYOLYSIS_MOUNT_PREFIX = {
	"�?�角",
	"之哨",
	"缰绳",	
}

CRYOLYSIS_AQMOUNT_TABLE = {
	"�?色其拉共鸣水晶",
 	"绿色其拉共鸣水晶",
 	"红色其拉共鸣水晶",
	"黄色其拉共鸣水晶",
}
CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "冷�?�时间",
	["Hearth"] = "炉石",
	["Rank"] = "等级",
};

end
