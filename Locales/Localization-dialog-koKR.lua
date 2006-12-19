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
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Cryolysis_Localization_Dialog_Kr()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_Kr();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "환기 재사용시간",
		["Manastone"] = "마나석 재사용시간"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "예";
				[false] = "아니오";
			},
			Hellspawn = {
				[true] = "켜기";
				[false] = "끄기";
			},
			["Food"] = "창조된 음식: ",
			["Drink"] = "창조된 음료: ",
			["RuneOfTeleportation"] = "순간이동 룬: ",
			["RuneOfPortals"] = "차원이동 룬: ",
			["ArcanePowder"] = "불가사의한 가루: ",
			["LightFeather"] = "가벼운 깃털: ",
			["Manastone"] = "마나석: ",
  		},
		["Alt"] = {
			Left = "우클릭 ",
			Right = "",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSoulstone|r",
			Text = {"창조","사용","사용된것","대기중"}			
		},
		["Manastone"] = {
			Label = "|c00FFFFFFMana Gem|r",
			Text = {": 창조 - ",": 회복 ", ": 대기중", ": Unavailable"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFF주문 지속시간|r",
			Text = "대상에 있는 주문 지속시간과 재사용대기시간",
			Right = "우클릭으로 생명석을 사용 "
		},
		["Armor"] = {
			Label = "|c00FFFFFFIce 갑옷|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFFMage 갑옷|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFF신비한 지능|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFF신비한 총명함|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFF마법 감쇠|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFF마법 증폭|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFF저속 낙하|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFF화염계 수호|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFF냉기계 수호|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFF음식 창조|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFF음료 창조|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFF환기|r",
			Text = "Use"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFF얼음 회오리|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFF마법 감지|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFF저주 해제|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFF탈것: "
		},
		["Buff"] = {
			Label = "|c00FFFFFF주문 메뉴|r\n가운데 클릭으로 메뉴열기"
		},
		["Portal"] = {
			Label = "|c00FFFFFF포탈 메뉴|r\n가운데 클릭으로 메뉴열기"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFF순간이동: 오그리마|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFF순간이동: 언더시티|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFF순간이동: 썬더블러프|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFF순간이동: 아이언포지|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFF순간이동: 스톰윈드|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFF순간이동: 다르나서스|r"
		},
		["P:Org"] = {
		    Label = "|c00FFFFFF차원이동의 문: 오그리마|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFF차원이동의 문: 언더시티|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFF차원이동의 문: 썬더블러프|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFF차원이동의 문: 아이언포지|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFF차원이동의 문: 스톰윈드|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFF차원이동의 문: 다르나서스|r"
		},
		["EvocationCooldown"] = "우클릭으로 빠른 시전",
		["LastSpell"] = {
			Left = "우클릭으로 재시전 ",      -- <--
			Right = "",
		},
		["Food"] = {
			Label = "|c00FFFFFF음식|r",
			Right = "우클릭으로 창조",
			Middle = "가운데클릭으로 거래",
		},
		["Drink"] = {
			Label = "|c00FFFFFF음료|r",
			Right = "우클릭으로 창조",
			Middle = "가운데클릭으로 거래",
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
			["RuneOfTeleportationNotPresent"] = "순간이동룬이 필요합니다.",
			["RuneOfPortals"] = "차원이동의 룬이 필요합니다.",
			["LightFeatherNotPresent"] = "가벼운 깃털이 필요합니다.",
			["ArcanePowderNotPresent"] = "불가사의한 가루가 필요합니다.",
			["NoRiding"] = "탈것을 가지고 있지 않습니다.",
			["NoFoodSpell"] = "음식 창조 주문이 없습니다.",
			["NoDrinkSpell"] = "음료 창조 주문이 없습니다.",
			["NoManaStoneSpell"] = "마나석을 가지고 있지 않습니다.",
			["NoEvocationSpell"] = "환기 주문이 없습니다.",
			["FullMana"] = "이미 마나가 가득차서 사용할수 없습니다",
			["BagAlreadySelect"] = "오류 : 이 가방은 이미 선택되었습니다.",
			["WrongBag"] = "오류 : 숫자는 0에서 4까지만 가능합니다.",
			["BagIsNumber"] = "오류 : 숫자를 입력해주십시오",
			["NoHearthStone"] = "오류 : 가방에 생명석이 없습니다.",
			["NoFood"] = "오류 : 가방에 창조된 최고등급의 음식이 없습니다.",
			["NoDrink"] = "오류 : 가방에 창조된 최고등급의 음료가 없습니다.",
			["ManaStoneCooldown"] = "오류 : 마나석이 재사용대기중입니다.",
			["NoSpell"] = "오류 : 그 주문은 배우지 않았습니다.",
		},
		["Bag"] = {
			["FullPrefix"] = "당신의 ",
			["FullSuffix"] = " 은 가득찼습니다",
			["FullDestroySuffix"] = " 은 가득찼습니다; 다음 음식/음료는 파괴됩니다",
			["SelectedPrefix"] = " 을 선택했습니다. ",
			["SelectedSuffix"] = " 당신의 음식와 음료를 유지합니다."
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo를 치면 설정 메뉴가 뜹니다",
			["TooltipOn"] = "툴팁이 켜짐" ,
			["TooltipOff"] = "툴팁이 꺼짐",
			["MessageOn"] = "메세지 켜짐",
			["MessageOff"] = "메세지 꺼짐",
			["MessagePosition"] = "<- Cryolysis의 시스템 메세지는 여기에 나타날것입니다. ->",
			["DefaultConfig"] = "<lightYellow>기본설정이 로드됨.",
			["UserConfig"] = "<lightYellow>설정이 로드됨."
		},
		["Help"] = {
			"/cryo recall -- Cryolysis와 모든 버튼을 화면중앙에 위치시킵니다.",
			"/cryo sm -- 짧은 레이드에 맞게끔 메세지를 조정합니다",
			"/cryo reset -- 기본 설정사항을 복원 로드합니다.",
			"/cryo toggle -- 주 Cryolysis 버튼을 숨기거나 보이게합니다.",	
		},
		["EquipMessage"] = "장비 ",
		["SwitchMessage"] = " 대신 ",
		["Information"] = {
			["PolyWarn"] = "변이가 풀리기 직전",
			["PolyBreak"] = "변이가 풀림...",
			["Restock"] = "구입함 ",
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "주황색",
		["Blue"] = "청색",
		["Pink"] = "분홍색",
		["Orange"] = "오렌지색",
		["Turquoise"] = "보라색",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Credits"] = "Brought to you by The Cryolysis: Reborn Developement Team",
		["Menu1"] = "물품 설정",
		["Menu2"] = "메세지 설정",
		["Menu3"] = "버튼 설정",
		["Menu4"] = "타이머 설정",
		["Menu5"] = "그래픽 설정",
		["MainRotation"] = "Cryolysis 각도 선택",
		["ProvisionMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ProvisionMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "음식과 음료를 지정된 가방에 넣습니다.",
		["ProvisionDestroy"] = "가방이 가득차면 음식과 음료를 파괴.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "노란색 대신에 하얀색 텍스트를 표시",
		["TimerDirection"] = "타이머들을 위쪽방향으로 표시",
		["TranseWarning"] = "기절상태일때 경고",
		["SpellTime"] = "주문 지속시간을 켬",
		["AntiFearWarning"] = "대상이 공포면역일때 경고",
		["GraphicalTimer"] = "타이머를 텍스트 대신 그래픽으로 표시",	
		["TranceButtonView"] = "드래그할 숨겨진 버튼 표시",
		["ButtonLock"] = "Cryolysis원 주변버튼을 잠금",
		["MainLock"] = "Cryolysis원을 잠금.",
		["BagSelect"] = "음식과 음료를 담을 가방을 선택",
		["ManaStoneMenu"] = "마나석 메뉴를 왼쪽으로 위치시킴",
		["BuffMenu"] = "버프메뉴를 왼쪽으로 이동시킴",
		["PortalMenu"] = "차원이동메뉴를 왼쪽으로 이동시킴",
		["STimerLeft"] = "타이머를 버튼 왼쪽으로 이동시킴",
		["ShowCount"] = "Cryolysis에 물품수 표시",
		["CountType"] = "원에 이벤트 표시",
		["Food"] = "음식 한계점",
		["Sound"] = "사운드 활성화",
		["ShowMessage"] = "무작위 음성",
		["ShowPortalMessage"] = "무작위 음성 활성화 (차원이동)",
		["ShowSteedMessage"] = "무작위 음성 활성화 (탈것)",
		["ShowPolyMessage"] = "무작위 음성 활성화 (변이)",
		["ChatType"] = "Cryolysis 메세지를 시스템메세지로 선언",
		["CryolysisSize"] = "주 Cryolysis 버튼의 크기",
		["StoneScale"] = "다른버튼들의 크기",
		["PolymorphSize"] = "변이 버튼의 크기",
		["TranseSize"] = "Transe 와 Anti-fear 버튼들의 크기",
		["Skin"] = "음료 한계점",
		["ManaStoneOrder"] = "이 마나석을 먼저 사용",
		["Show"] = {
			["Text"] = "버튼 보이기:",
			["Food"] = "음식 버튼",
			["Drink"] = "음료 버튼",
			["Manastone"] = "마나석 버튼",
			["LeftSpell"] = "왼쪽 주문 버튼",
			["Evocation"] = "환기",
			["RightSpell"] = "오른쪽 주문 버튼",
			["Steed"] = "탈것",
			["Buff"] = "주문 메뉴",
			["Portal"] = "차원이동 메뉴",
			["Tooltips"] = "툴팁 보이기",
			["Spelltimer"] = "주문 타이머 버튼"
		},
		["Text"] = {
			["Text"] = "버튼위:",
			["Food"] = "음식수량",
			["Drink"] = "음료수량",
			["Manastone"] = "마나석 재사용시간",
			["Evocation"] = "환기 재사용시간",
			["Powder"] = "불가사의한 가루",
			["Feather"] = "가벼운 깃털",
			["Rune"] = "차원이동 룬",
		},
		["QuickBuff"] = "마우스 오버시에 버튼을 열고/닫음",
		["Count"] = {
			["None"] = "없음",
			["Provision"] = "음식과 음료",
			["Provision2"] = "음료와 음식",
			["Health"] = "현재 체력",
			["HealthPercent"] = "체력 퍼센트",
			["Mana"] = "현재 마나",
			["ManaPercent"] = "마나 퍼센트",
			["Manastone"] = "마나석 재사용시간",
			["Evocation"] = "환기 재사용시간",
		},
		["Circle"] = {
			["Text"] = "원에 이벤트를 표시",
			["None"] = "없음",
			["HP"] = "체력수치",
			["Mana"] = "마나",
            ["Manastone"] = "마나석 재사용시간",
			["Evocation"] = "환기 재사용시간",

		},
		["Button"] = {
			["Text"] = "주버튼 기능",
			["Consume"] = "물빵 먹기",
			["Evocation"] = "환기사용",
			["Polymorph"] = "변이시전",
			["Manastone"] = "마나석",
		},
		["Restock"] = {
			["Restock"] = "자동으로 재료 구입",
			["Confirm"] = "구입하기전에 확인",			
		},
		["Polymorph"] = {
			["Warn"] = "변이가 풀리기전에 경고",
			["Break"] = "변이가 풀리기전에 알림",
		},
		["ButtonText"] = "버튼위에 재료수량을 표시",
		["Anchor"] = {
			["Text"] = "메뉴 위치 포인트",
			["Above"] = "위쪽",
			["Center"] = "중앙",
			["Below"] = "아래쪽"
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
