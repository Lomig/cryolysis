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

CRYOLYSIS_UNIT_MAGE = "������";

-- Word to search for Fire Vulnerability and Winter's chill  first (.+) is the target, second is the spell
CRYOLYSIS_DEBUFF_SRCH = "(.+) �� (.+)�� ���� �ɸ�."
CRYOLYSIS_POLY_SRCH = "(.+) �� (.+)���� �����."

function Cryolysis_SpellTableBuild()
	CRYOLYSIS_SPELL_TABLE = {
	[1] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "���� ����",			Length = 600,	Type = 0},
	[2] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ź��� �Ѹ���",		Length = 3600,	Type = 0},
	[3] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ź��� ����",		Length = 0,		Type = 0},
	[4] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ź��� ����",		Length = 1800,	Type = 0},
	[5] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ź��� ȭ��",		Length = 0,		Type = 0},
	[6] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "ȭ�� ��ǳ",			Length = 45,	Type = 3},
	[7] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "����",					Length = 15,	Type = 3},
	[8] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "������",				Length = 0,		Type = 0},
	[9] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ñ� ��ǳ",			Length = 10,	Type = 3},
	[10] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� â��",			Length = 0,		Type = 0},
	[11] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� â��",			Length = 0,		Type = 0},
	[12] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",			Length = 30,	Type = 3},
	[13] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",			Length = 600,	Type = 0},
	[14] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "ȭ�� �ۿ�",			Length = 8,		Type = 3},
	[15] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "ȭ���� ��ȣ",				Length = 30,	Type = 3},
	[16] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "ȭ����",				Length = 8,		Type = 5},
	[17] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ұ��",			Length = 8,		Type = 3},
	[18] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ñ� ����",			Length = 300,	Type = 0},
	[19] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ȸ����",			Length = 25,	Type = 3},
	[20] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ñ�� ��ȣ",			Length = 30,	Type = 3},
	[21] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ȭ��",				Length = 9,		Type = 5},
	[22] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",				Length = 300,	Type = 0},
	[23] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",			Length = 30,	Type = 3},
	[24] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "������ ����",			Length = 300,	Type = 0},
	[25] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ��ȣ��",			Length = 60,	Type = 0},
	[26] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "����",				Length = 50,	Type = 2},
	[27] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵��� ��: �ٸ�������",		Length = 0,		Type = 0},
	[28] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵��� ��: ���̾�����",		Length = 0,		Type = 0},
	[29] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵��� ��: ��������",		Length = 0,		Type = 0},
	[30] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵��� ��: �������",	Length = 0,		Type = 0},
	[31] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵��� ��: �����Ƽ",		Length = 0,		Type = 0},
	[32] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "�ҵ��� �ۿ�",				Length = 12,	Type = 5},
	[33] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ϱ� ���� ����",	Length = 0,		Type = 0},
	[34] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���¿��",			Length = 0,			Type = 0},
	[35] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",				Length = 30,	Type = 0},
	[36] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: �ٸ�������",	Length = 0,		Type = 0},
	[37] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: ���̾�����",	Length = 0,		Type = 0},
	[38] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: ���׸���",	Length = 0,		Type = 0},
	[39] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: �������",	Length = 0,	Type = 0},
	[40] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: �����Ƽ",	Length = 0,		Type = 0},
	[41] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",			Length = 300,		Type = 3},
	[42] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ż��� ����",			Length = 600,		Type = 3},
	[43] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "��ȭ",			Length = 180,	Type = 3},
	[44] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "����",		Length = 180,	Type = 3},
	[45] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�ź��� ���� ��ȭ",			Length = 180,	Type = 3},
	[46] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: �ٸ�������",		Length = 0,	Type = 0},
	[47] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵��� ��: ���׸���",		Length = 0,		Type = 0},
	[48] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "����: ����",		Length = 50,	Type = 2},
	[49] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "ȯ��",			Length = 480,		Type = 3},
	[50] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "���� ����",			Length = 120,	Type = 5},
	[51] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil, 
		Name = "�����̵�: ��������",		Length = 0,	Type = 0},
	[52] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "����: �ź���",		Length = 50,	Type = 2},
	[53] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "����",				Length = 5,		Type = 6},
	[54] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ȥ���� ����",		Length = 15,	Type = 6},
	[55] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ȥ���� ���� (2)",	Length = 15,	Type = 6},
	[56] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ȥ���� ���� (3)",	Length = 15,	Type = 6},
	[57] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ȥ���� ���� (4)",	Length = 15,	Type = 6},
	[58] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "Ȥ���� ���� (5)",	Length = 15,	Type = 6},
	[59] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "ȭ�� ���׷� ��ȭ",	Length = 30,	Type = 6},
    [60] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "ȭ�� ���׷� ��ȭ (2)",Length = 30,	Type = 6},
	[61] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "ȭ�� ���׷� ��ȭ (3)",Length = 30,	Type = 6},
	[62] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "ȭ�� ���׷� ��ȭ (4)",Length = 30,	Type = 6},
	[63] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "ȭ�� ���׷� ��ȭ (5)",Length = 30,	Type = 6},
	[64] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "������",				Length = 120,	Type = 3},
	[65] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "������",				Length = 5,		Type = 6},
	[66] = {ID = nil, Rank = nil, CastTime = nil, Mana = nil,
		Name = "���� ȸ����",			Length = 8,		Type = 6},
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
	["LightFeather"] = "������ ����",
	["ArcanePowder"] = "�Ұ������� ����",
	["RuneOfTeleportation"] = "�����̵��� ��",
	["RuneOfPortals"] = "�����̵��� ��",
	["Manastone"] = "����",
	["Hearthstone"] = "����",
	["Provision"] = "â����",
	["Evocation"] = "ȯ��",
	["Drink"] = "����",
	["Food"] = "����",
};

CRYOLYSIS_FOOD_RANK = {
	" ����",
	" �Ļ�",
	" �滧",
	" ȣ�л�",
	" ȿ��",
	" �ѻ�", 
	" ���� �ѻ�",
};

CRYOLYSIS_DRINK_RANK = {
	[1] = " ����",
	[2] = " ���ϼ�",
	[3] = " ������",
	[4] = " ��õ��",
	[5] = " ��õ��",
	[6] = " ź���",
	[7] = " ������",
};

CRYOLYSIS_STONE_RANK = {
	[1] = " ����",		-- Rank Minor
	[2] = " ����",		-- Rank Lesser
	[3] = " Ȳ����",	-- Rank Greater
	[4] = " ���"		-- Rank Major
};

CRYOLYSIS_STONE_RANK2 = {
        [1] = "���� ����",        -- Rank Minor
        [2] = "���� ����",        -- Rank Lesser
        [3] = "���� Ȳ����",    -- Rank Greater
        [4] = "���� ���"        -- Rank Major
};

CRYOLYSIS_MANASTONE_NAMES = {
	[1] = "���� ���� â��",
	[2] = "���� ���� â��",
	[3] = "���� Ȳ���� â��",
	[4] = "���� ��� â��"
};
	
CRYOLYSIS_CREATE = {
	[1] = "ȯ��",
	[2] = "����",
	[3] = "���� â��",
	[4] = "���� â��"
};

CRYOLYSIS_MOUNT_TABLE = {
	-- [1] ���� �������� ������
	{ "���� �������� ����" }, 
	-- [2] ��� ������
	{ "��������ũ �������", "���� ���", "���� �������", "���� ���", "���� ���", "ȸ�� ���", "���� ���� ���", "���� ȸ�� ���", "���� ��� ���", "��� ���", },
	-- [3] ���� ������            
	{ "���� �����ڽ� ����", "���� Ǫ�� ����", "���� ��� ����", "���� ��Ȳ�� ����", "���� �������� ȣ����", "��� ���� ȣ����", "��ƻ� ���� ȣ����", "���� ������ ���� ȣ����", "û�ϻ� ���� ȣ����", "����� ���� ȣ����" },
	-- [4] ��� ȣ���� ������
	{ "���� �ٸ��� ȣ����" },
	-- [5] �𵥵� �� ������
	{ "������ ���� ���", "���� �ذ�", "��� �ذ񱺸�", "����� �ذ� ����", "���� �ذ�", "���� �����ذ�" },
	-- [6] ���Ÿ�� ������
	{ "���� �������Ÿ��", "Ǫ�� ���Ÿ��", "������� ���Ÿ��", "����û�� ���Ÿ��", "���� ���Ÿ��", "���� ��� ���Ÿ��", "���� ��� ���Ÿ��", "���� ����� ���Ÿ��", "��ö ���Ÿ��", "��� ���Ÿ��" },
	-- [7] ������ ������
	{ "�渶 ����", "������ ����", "���丶 ����", "Ȳ�丶 ����", "���� ����", "���� ������", "���� Ȳ�丶", "���� �鸶", "�鸶 ����" },
	-- [8] ���� �ڵ� ������
	{ "���� �����ڵ�", "���� �ڵ�", "�Ŵ��� ���� �ڵ�" },
	-- [9] �������� ������
	{ "���� ��������" },
	-- [10] ȸ�� �ڵ� ������
	{ "ȸ�� �ڵ�", "�Ŵ��� ȸ�� �ڵ�", "�Ŵ��� ��� �ڵ�" },
	-- [11] ��� �ڵ� ������ 
	{ "��� �ڵ�", "û�� �ڵ�" },
	-- [12] ȸ�� ���� ������    
	{ "�ϱ� ���� ���Ǹ�", "������ ���� ���Ǹ�", "���� ȸ�� ���� ���Ǹ�", "���� ȸ���� ���� ���Ǹ�" },
	-- [13] �������� ������    
	{ "���� �������� ���Ǹ�", "���� ���� ���Ǹ�", "���� ���� ���Ǹ�", "���� ���� ���� ���Ǹ�", "ȸ���� ���� ���Ǹ�" },
	-- [14] ����ȣ���� ������   
	{ "���� ����ȣ���� ���", "�ٹ�����ȣ ���" },
	-- [15] ��ȣ ������   
	{ "��ȣ ���", "��ȣ ���", "�����̺�ȣ ���", "�ٹ��̺�ȣ ���", "���� �ܿ��ȣ ���", "���� �Ȱ�ȣ���� ���", "���� ��ǳȣ���� ���" },
	-- [16] �ܿ��ȣ ������
	{ "�ܿ��ȣ ���" },
	-- [17] Black Qiraji Resonating Crystal
	{ "������ ���� ������ ����" },
}
CRYOLYSIS_MOUNT_PREFIX = {
	"���Ǹ�",
	"ȣ����",
	"���",	
}
CRYOLYSIS_AQMOUNT_TABLE = {
	"������ Ǫ�� ������ ����",
 	"������ ��� ������ ����",
 	"������ ���� ������ ����",
	"������ ��� ������ ����",
}
CRYOLYSIS_AQMOUNT_NAME = {
	"���� ������ ��ũ ��ȯ",
	"Ǫ�� ������ ��ũ ��ȯ",
 	"��� ������ ��ũ ��ȯ",
 	"���� ������ ��ũ ��ȯ",
	"��� ������ ��ũ ��ȯ",
}

CRYOLYSIS_TRANSLATION = {
	["Cooldown"] = "���� ���ð�",
	["Hearth"] = "����",
	["Rank"] = "���",
	["Invisible"] = "����ȭ ����",
	["LesserInvisible"] = "�ϱ� ����ȭ ����",
	["GreaterInvisible"] = "��� ����ȭ ����",
	["SoulLinkGain"] = "You gain Soul Link.",
	["SacrificeGain"] = "You gain Sacrifice.",
	["SummoningRitual"] = "��ȯ �ǽ�"
};
end
