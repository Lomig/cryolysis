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
-- ENGLISH  VERSION FUNCTIONS --
------------------------------------------------
--
if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

CRYOLYSIS_UNIT_MAGE = "마법사";

-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+) 은 (.+)에 의해 걸림."
CRYOLYSIS_POLY_SRCH = "(.+) 은 (.+)에서 사라짐."

function Cryolysis_SpellTableBuild()
	CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "마법 증폭",			Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "신비한 총명함",		Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "신비한 폭팔",		Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "신비한 지능",		Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "신비한 화살",		Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "화염 폭풍",			Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "점멸",					Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "눈보라",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "냉기 돌풍",			Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "음식 창조",			Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "음료 창조",			Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "마법 차단",			Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "마법 감쇠",			Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "화염 작열",			Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "화염계 수호",				Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "화염구",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "불기둥",			Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "냉기 갑옷",			Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "얼음 회오리",			Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "냉기계 수호",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "얼음 화살",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "얼음 갑옷",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "얼음 방패",			Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "마법사 갑옷",			Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "마나 보호막",			Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "변이",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "차원이동의 문: 다르나서스",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "차원이동의 문: 아이언포지",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "차원이동의 문: 스톰윈드",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "차원이동의 문: 썬더블러프",	Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "차원이동의 문: 언더시티",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "불덩이 작열",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "하급 저주 해제",	Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "불태우기",			Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "저속 낙하",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 다르나서스",	Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 아이언포지",	Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 오그리마",	Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 썬더블러프",	Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 언더시티",	Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "얼음 방패",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "매서운 한파",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "발화",			Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "냉정",		Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "신비한 마법 강화",			Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 다르나서스",		Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "차원이동의 문: 오그리마",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "변이: 돼지",		Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "환기",			Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "마법 감지",			Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "순간이동: 스톰윈드",		Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "변이: 거북이",		Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "동상",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "혹한의 추위",		Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "혹한의 추위 (2)",	Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "혹한의 추위 (3)",	Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "혹한의 추위 (4)",	Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "혹한의 추위 (5)",	Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "화염 저항력 약화",	Length = 30,	Type = 6},
    [60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "화염 저항력 약화 (2)",Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "화염 저항력 약화 (3)",Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "화염 저항력 약화 (4)",Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "화염 저항력 약화 (5)",Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "마나석",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "얼어붙음",				Length = 5,		Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "얼음 회오리",			Length = 8,		Type = 6},
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
	["LightFeather"] = "가벼운 깃털",
	["ArcanePowder"] = "불가사의한 가루",
	["RuneOfTeleportation"] = "순간이동의 룬",
	["RuneOfPortals"] = "차원이동의 룬",
	["Manastone"] = "마나",
	["Hearthstone"] = "생명석",
	["Provision"] = "창조된",
	["Evocation"] = "환기",
	["Drink"] = "음료",
	["Food"] = "음식",
};

CRYOLYSIS_FOOD_RANK = {
	" 머핀",
	" 식빵",
	" 흑빵",
	" 호밀빵",
	" 효모빵",
	" 롤빵", 
	" 계피 롤빵",
};

CRYOLYSIS_DRINK_RANK = {
	[1] = " 샘물",
	[2] = " 지하수",
	[3] = " 정제수",
	[4] = " 용천수",
	[5] = " 광천수",
	[6] = " 탄산수",
	[7] = " 결정수",
};

CRYOLYSIS_STONE_RANK = {
	[1] = " 마노",		-- Rank Minor
	[2] = " 비취",		-- Rank Lesser
	[3] = " 황수정",	-- Rank Greater
	[4] = " 루비"		-- Rank Major
};

CRYOLYSIS_STONE_RANK2 = {
        [1] = "마나 마노",        -- Rank Minor
        [2] = "마나 비취",        -- Rank Lesser
        [3] = "마나 황수정",    -- Rank Greater
        [4] = "마나 루비"        -- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "마나 마노 창조",
	[2] = "마나 비취 창조",
	[3] = "마나 황수정 창조",
	[4] = "마나 루비 창조"
};
	
CRYOLYSIS_CREATE = {
	[1] = "환기",
	[2] = "마나",
	[3] = "음료 창조",
	[4] = "음식 창조"
};

CRYOLYSIS_MOUNT_TABLE = {
	-- [1] 전투 서리늑대 아이콘
	{ "전투 서리늑대 마구" }, 
	-- [2] 산양 아이콘
	{ "스톰파이크 전투산양", "검은 산양", "검은 전투산양", "갈색 산양", "서리 산양", "회색 산양", "날쌘 갈색 산양", "날쌘 회색 산양", "날쌘 흰색 산양", "흰색 산양", },
	-- [3] 랩터 아이콘            
	{ "날쌘 래즈자쉬 렙터", "날쌘 푸른 렙터", "날쌘 녹색 랩터", "날쌘 주황색 랩터", "검은 전투랩터 호루라기", "녹색 랩터 호루라기", "상아색 랩터 호루라기", "붉은 점박이 랩터 호루라기", "청록색 랩터 호루라기", "보라색 랩터 호루라기" },
	-- [4] 노란 호랑이 아이콘
	{ "날쌘 줄리안 호랑이" },
	-- [5] 언데드 말 아이콘
	{ "죽음의 군마 고삐", "갈색 해골마", "녹색 해골군마", "보라색 해골 군마", "붉은 해골마", "붉은 전투해골마" },
	-- [6] 기계타조 아이콘
	{ "검은 전투기계타조", "푸른 기계타조", "형광녹색 기계타조", "투명청색 기계타조", "빨간 기계타조", "날쌘 녹색 기계타조", "날쌘 흰색 기계타조", "날쌘 노란색 기계타조", "강철 기계타조", "흰색 기계타조" },
	-- [7] 갈색마 아이콘
	{ "흑마 마구", "갈색마 마구", "적토마 마구", "황토마 마구", "적마 마구", "날쌘 갈색마", "날쌘 황토마", "날쌘 백마", "백마 마구" },
	-- [8] 갈색 코도 아이콘
	{ "검은 전투코도", "갈색 코도", "거대한 갈색 코도" },
	-- [9] 전투군마 아이콘
	{ "검은 전투군마" },
	-- [10] 회색 코도 아이콘
	{ "회색 코도", "거대한 회색 코도", "거대한 흰색 코도" },
	-- [11] 녹색 코도 아이콘 
	{ "녹색 코도", "청색 코도" },
	-- [12] 회색 늑대 아이콘    
	{ "북극 늑대 뿔피리", "광포한 늑대 뿔피리", "날쌘 회색 늑대 뿔피리", "날쌘 회갈색 늑대 뿔피리" },
	-- [13] 전투늑대 아이콘    
	{ "검은 전투늑대 뿔피리", "갈색 늑대 뿔피리", "붉은 늑대 뿔피리", "날쌘 갈색 늑대 뿔피리", "회갈색 늑대 뿔피리" },
	-- [14] 전투호랑이 아이콘   
	{ "검은 전투호랑이 고삐", "줄무늬흑호 고삐" },
	-- [15] 빙호 아이콘   
	{ "빙호 고삐", "흑호 고삐", "점박이빙호 고삐", "줄무늬빙호 고삐", "날쌘 겨울빙호 고삐", "날쌘 안개호랑이 고삐", "날쌘 폭풍호랑이 고삐" },
	-- [16] 겨울빙호 아이콘
	{ "겨울빙호 고삐" },
	-- [17] Black Qiraji Resonating Crystal
	{ "공명의 검은 퀴라지 수정" },
}
CRYOLYSIS_MOUNT_PREFIX = {
	"뿔피리",
	"호루라기",
	"고삐",	
}
CRYOLYSIS_AQMOUNT_TABLE = {
	"공명의 푸른 퀴라지 수정",
 	"공명의 녹색 퀴라지 수정",
 	"공명의 붉은 퀴라지 수정",
	"공명의 노란 퀴라지 수정",
}
CRYOLYSIS_AQMOUNT_NAME = {
	"검은 퀴라지 탱크 소환",
	"푸른 퀴라지 탱크 소환",
 	"녹색 퀴라지 탱크 소환",
 	"붉은 퀴라지 탱크 소환",
	"노란 퀴라지 탱크 소환",
}

CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "재사용 대기시간",
	["Hearth"] = "생명석",
	["Rank"] = "등급",
	["Invisible"] = "투명화 감지",
	["LesserInvisible"] = "하급 투명화 감지",
	["GreaterInvisible"] = "상급 투명화 감지",
	["SoulLinkGain"] = "You gain Soul Link.",
	["SacrificeGain"] = "You gain Sacrifice.",
	["SummoningRitual"] = "소환 의식"
};
end
