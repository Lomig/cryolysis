﻿--[[
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
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Cryolysis_Localization_Dialog_Kr()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_Kr();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "ȯ�� ����ð�",
		["Manastone"] = "������ ����ð�"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "��";
				[false] = "�ƴϿ�";
			},
			Hellspawn = {
				[true] = "�ѱ�";
				[false] = "����";
			},
			["Food"] = "â���� ����: ",
			["Drink"] = "â���� ����: ",
			["RuneOfTeleportation"] = "�����̵� ��: ",
			["RuneOfPortals"] = "�����̵� ��: ",
			["ArcanePowder"] = "�Ұ������� ����: ",
			["LightFeather"] = "������ ����: ",
			["Manastone"] = "������: ",
  		},
		["Alt"] = {
			Left = "��Ŭ�� ",
			Right = "",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"â��","���","���Ȱ�","�����"}			
		},
		["Manastone"] = {
			Label = "|c00FFFFFFMana Gem|r",
			Text = {": â�� - ",": ȸ�� ", ": �����", ": Unavailable"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF�ֹ� ���ӽð�|r",
			Text = "��� �ִ� �ֹ� ���ӽð��� ������ð�",
			Right = "��Ŭ������ ������ ��� "
		},
		["Armor"] = {
			Label = "|c00FFFFFFIce ����|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFFMage ����|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFF�ź��� ����|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFF�ź��� �Ѹ���|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFF���� ����|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFF���� ����|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFF���� ����|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFFȭ���� ��ȣ|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFF�ñ�� ��ȣ|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFF���� â��|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFF���� â��|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFFȯ��|r",
			Text = "Use"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFF���� ȸ����|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFF���� ����|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFF���� ����|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFŻ��: "
		},
		["Buff"] = {
			Label = "|c00FFFFFF�ֹ� �޴�|r\n��� Ŭ������ �޴�����"
		},
		["Portal"] = {
			Label = "|c00FFFFFF��Ż �޴�|r\n��� Ŭ������ �޴�����"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFF�����̵�: ���׸���|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFF�����̵�: �����Ƽ|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFF�����̵�: �������|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFF�����̵�: ���̾�����|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFF�����̵�: ��������|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFF�����̵�: �ٸ�������|r"
		},
		["P:Org"] = {
		    Label = "|c00FFFFFF�����̵��� ��: ���׸���|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFF�����̵��� ��: �����Ƽ|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFF�����̵��� ��: �������|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFF�����̵��� ��: ���̾�����|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFF�����̵��� ��: ��������|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFF�����̵��� ��: �ٸ�������|r"
		},
		["EvocationCooldown"] = "��Ŭ������ ���� ����",
		["LastSpell"] = {
			Left = "��Ŭ������ ����� ",      -- <--
			Right = "",
		},
		["Food"] = {
			Label = "|c00FFFFFF����|r",
			Right = "��Ŭ������ â��",
			Middle = "���Ŭ������ �ŷ�",
		},
		["Drink"] = {
			Label = "|c00FFFFFF����|r",
			Right = "��Ŭ������ â��",
			Middle = "���Ŭ������ �ŷ�",
		},
	};


	CRYOLYSIS_SOUND = {
		["SheepWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep01.mp3",
		["SheepBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep02.mp3",
		["PigWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig01.mp3",
		["PigBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig02.mp3",
	};

	CRYOLYSIS_MESSAGE = {
		["Error"] = {
			["RuneOfTeleportationNotPresent"] = "�����̵����� �ʿ��մϴ�.",
			["RuneOfPortals"] = "�����̵��� ���� �ʿ��մϴ�.",
			["LightFeatherNotPresent"] = "������ ������ �ʿ��մϴ�.",
			["ArcanePowderNotPresent"] = "�Ұ������� ���簡 �ʿ��մϴ�.",
			["NoRiding"] = "Ż���� ������ ���� �ʽ��ϴ�.",
			["NoFoodSpell"] = "���� â�� �ֹ��� �����ϴ�.",
			["NoDrinkSpell"] = "���� â�� �ֹ��� �����ϴ�.",
			["NoManaStoneSpell"] = "�������� ������ ���� �ʽ��ϴ�.",
			["NoEvocationSpell"] = "ȯ�� �ֹ��� �����ϴ�.",
			["FullMana"] = "�̹� ������ �������� ����Ҽ� �����ϴ�",
			["BagAlreadySelect"] = "���� : �� ������ �̹� ���õǾ����ϴ�.",
			["WrongBag"] = "���� : ���ڴ� 0���� 4������ �����մϴ�.",
			["BagIsNumber"] = "���� : ���ڸ� �Է����ֽʽÿ�",
			["NoHearthStone"] = "���� : ���濡 ������ �����ϴ�.",
			["NoFood"] = "���� : ���濡 â���� �ְ����� ������ �����ϴ�.",
			["NoDrink"] = "���� : ���濡 â���� �ְ����� ���ᰡ �����ϴ�.",
			["ManaStoneCooldown"] = "���� : �������� ���������Դϴ�.",
			["NoSpell"] = "���� : �� �ֹ��� ����� �ʾҽ��ϴ�.",
		},
		["Bag"] = {
			["FullPrefix"] = "����� ",
			["FullSuffix"] = " �� ����á���ϴ�",
			["FullDestroySuffix"] = " �� ����á���ϴ�; ���� ����/����� �ı��˴ϴ�",
			["SelectedPrefix"] = " �� �����߽��ϴ�. ",
			["SelectedSuffix"] = " ����� ���Ŀ� ���Ḧ �����մϴ�."
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo�� ġ�� ���� �޴��� ��ϴ�",
			["TooltipOn"] = "������ ����" ,
			["TooltipOff"] = "������ ����",
			["MessageOn"] = "�޼��� ����",
			["MessageOff"] = "�޼��� ����",
			["MessagePosition"] = "<- Cryolysis�� �ý��� �޼����� ���⿡ ��Ÿ�����Դϴ�. ->",
			["DefaultConfig"] = "<lightYellow>�⺻������ �ε��.",
			["UserConfig"] = "<lightYellow>������ �ε��."
		},
		["Help"] = {
			"/cryo recall -- Cryolysis�� ��� ��ư�� ȭ���߾ӿ� ��ġ��ŵ�ϴ�.",
			"/cryo sm -- ª�� ���̵忡 �°Բ� �޼����� �����մϴ�",
			"/cryo reset -- �⺻ ���������� ���� �ε��մϴ�.",
			"/cryo toggle -- �� Cryolysis ��ư�� ����ų� ���̰��մϴ�.",	
		},
		["EquipMessage"] = "��� ",
		["SwitchMessage"] = " ��� ",
		["Information"] = {
			["PolyWarn"] = "���̰� Ǯ���� ����",
			["PolyBreak"] = "���̰� Ǯ��...",
			["Restock"] = "������ ",
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "��Ȳ��",
		["Blue"] = "û��",
		["Pink"] = "��ȫ��",
		["Orange"] = "��������",
		["Turquoise"] = "�����",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Credits"] = "Brought to you by The Cryolysis: Reborn Developement Team",
		["Menu1"] = "��ǰ ����",
		["Menu2"] = "�޼��� ����",
		["Menu3"] = "��ư ����",
		["Menu4"] = "Ÿ�̸� ����",
		["Menu5"] = "�׷��� ����",
		["MainRotation"] = "Cryolysis ���� ����",
		["ProvisionMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ProvisionMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "���İ� ���Ḧ ������ ���濡 �ֽ��ϴ�.",
		["ProvisionDestroy"] = "������ �������� ���İ� ���Ḧ �ı�.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "����� ��ſ� �Ͼ�� �ؽ�Ʈ�� ǥ��",
		["TimerDirection"] = "Ÿ�̸ӵ��� ���ʹ������� ǥ��",
		["TranseWarning"] = "���������϶� ���",
		["SpellTime"] = "�ֹ� ���ӽð��� ��",
		["AntiFearWarning"] = "����� �����鿪�϶� ���",
		["GraphicalTimer"] = "Ÿ�̸Ӹ� �ؽ�Ʈ ��� �׷������� ǥ��",	
		["TranceButtonView"] = "�巡���� ������ ��ư ǥ��",
		["ButtonLock"] = "Cryolysis�� �ֺ���ư�� ���",
		["MainLock"] = "Cryolysis���� ���.",
		["BagSelect"] = "���İ� ���Ḧ ���� ������ ����",
		["ManaStoneMenu"] = "������ �޴��� �������� ��ġ��Ŵ",
		["BuffMenu"] = "�����޴��� �������� �̵���Ŵ",
		["PortalMenu"] = "�����̵��޴��� �������� �̵���Ŵ",
		["STimerLeft"] = "Ÿ�̸Ӹ� ��ư �������� �̵���Ŵ",
		["ShowCount"] = "Cryolysis�� ��ǰ�� ǥ��",
		["CountType"] = "���� �̺�Ʈ ǥ��",
		["Food"] = "���� �Ѱ���",
		["Sound"] = "���� Ȱ��ȭ",
		["ShowMessage"] = "������ ����",
		["ShowPortalMessage"] = "������ ���� Ȱ��ȭ (�����̵�)",
		["ShowSteedMessage"] = "������ ���� Ȱ��ȭ (Ż��)",
		["ShowPolyMessage"] = "������ ���� Ȱ��ȭ (����)",
		["ChatType"] = "Cryolysis �޼����� �ý��۸޼����� ����",
		["CryolysisSize"] = "�� Cryolysis ��ư�� ũ��",
		["StoneScale"] = "�ٸ���ư���� ũ��",
		["PolymorphSize"] = "���� ��ư�� ũ��",
		["TranseSize"] = "Transe �� Anti-fear ��ư���� ũ��",
		["Skin"] = "���� �Ѱ���",
		["ManaStoneOrder"] = "�� �������� ���� ���",
		["Show"] = {
			["Text"] = "��ư ���̱�:",
			["Food"] = "���� ��ư",
			["Drink"] = "���� ��ư",
			["Manastone"] = "������ ��ư",
			["LeftSpell"] = "���� �ֹ� ��ư",
			["Evocation"] = "ȯ��",
			["RightSpell"] = "������ �ֹ� ��ư",
			["Steed"] = "Ż��",
			["Buff"] = "�ֹ� �޴�",
			["Portal"] = "�����̵� �޴�",
			["Tooltips"] = "���� ���̱�",
			["Spelltimer"] = "�ֹ� Ÿ�̸� ��ư"
		},
		["Text"] = {
			["Text"] = "��ư��:",
			["Food"] = "���ļ���",
			["Drink"] = "�������",
			["Manastone"] = "������ ����ð�",
			["Evocation"] = "ȯ�� ����ð�",
			["Powder"] = "�Ұ������� ����",
			["Feather"] = "������ ����",
			["Rune"] = "�����̵� ��",
		},
		["QuickBuff"] = "���콺 �����ÿ� ��ư�� ����/����",
		["Count"] = {
			["None"] = "����",
			["Provision"] = "���İ� ����",
			["Provision2"] = "����� ����",
			["Health"] = "���� ü��",
			["HealthPercent"] = "ü�� �ۼ�Ʈ",
			["Mana"] = "���� ����",
			["ManaPercent"] = "���� �ۼ�Ʈ",
			["Manastone"] = "������ ����ð�",
			["Evocation"] = "ȯ�� ����ð�",
		},
		["Circle"] = {
			["Text"] = "���� �̺�Ʈ�� ǥ��",
			["None"] = "����",
			["HP"] = "ü�¼�ġ",
			["Mana"] = "����",
            ["Manastone"] = "������ ����ð�",
			["Evocation"] = "ȯ�� ����ð�",

		},
		["Button"] = {
			["Text"] = "�ֹ�ư ���",
			["Consume"] = "���� �Ա�",
			["Evocation"] = "ȯ����",
			["Polymorph"] = "���̽���",
			["Manastone"] = "������",
		},
		["Restock"] = {
			["Restock"] = "�ڵ����� ��� ����",
			["Confirm"] = "�����ϱ����� Ȯ��",			
		},
		["Polymorph"] = {
			["Warn"] = "���̰� Ǯ�������� ���",
			["Break"] = "���̰� Ǯ�������� �˸�",
		},
		["ButtonText"] = "��ư���� �������� ǥ��",
		["Anchor"] = {
			["Text"] = "�޴� ��ġ ����Ʈ",
			["Above"] = "����",
			["Center"] = "�߾�",
			["Below"] = "�Ʒ���"
		},
		["SpellButton"] = {	
			["Armor"] = CRYOLYSIS_SPELL_TABLE[22].Name.."/"..CRYOLYSIS_SPELL_TABLE[24].Name, -- "Ice Armor / Mage Armor"
			["ArcaneInt"] = CRYOLYSIS_SPELL_TABLE[4].Name.."/"..CRYOLYSIS_SPELL_TABLE[2].Name, --"Arcane Int / Arcane Brilliance",
			["DampenMagic"] = CRYOLYSIS_SPELL_TABLE[13].Name.."/"..CRYOLYSIS_SPELL_TABLE[1].Name, -- "Dampen Magic / Amplify Magic",
			["IceBarrier"] = CRYOLYSIS_SPELL_TABLE[23].Name.."/"..CRYOLYSIS_SPELL_TABLE[25].Name, -- "Ice Barrier / Mana Shield",
			["FireWard"] = CRYOLYSIS_SPELL_TABLE[15].Name.."/"..CRYOLYSIS_SPELL_TABLE[20].Name, -- "Fire Ward / Frost Ward",
			["DetectMagic"] = CRYOLYSIS_SPELL_TABLE[50].Name, -- "Detect Magic"
			["RemoveCurse"] = CRYOLYSIS_SPELL_TABLE[33].Name, -- Remove Lesser curse
			["SlowFall"] = CRYOLYSIS_SPELL_TABLE[35].Name, -- Slow Fall
		},		
	};
	CRYOLYSIS_BINDING = {
		["Current"] = " is currently bound to ",
		["Confirm"] = "Do you want to bind ",
		["To"] = " to ",
		["Yes"] = "Yes",
		["No"] = "No",
		["InCombat"] = "Sorry, you can't change key bindings while in combat.",
		["Binding"] = "Bindings",
		["Unbind"] = "Unbind",
		["Cancel"] = "Cancel",
		["Press"] = "Press a key to bind...\n\n",
		["Now"] = "Currently: ",
		["NotBound"] = "Not Bound",
	};
end                                                         
