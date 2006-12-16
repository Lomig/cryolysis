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
--
-- Version 12.12.2006
------------------------------------------------------------------------------------------------------
local L = AceLibrary("AceLocale-2.2"):new("Cryolysis")

-- I'm not sure if you're familiar with the GlobalStrings.lua file that Blizzard provides.
-- If not, you have to extract it out of your Interface.mpq file.  Anyway, what it is is
-- a list of hundreds of strings localized strings and patterns.  These patterns are already
-- defined in the GlobalStrings.lua file as the following two variables, so we have no
-- need to define them and worry about translating them properly.  Plus, strings cannot be
-- purged from Lua memory as tables can.  So it's really important to avoid defining strings
-- at all costs.
CRYOLYSIS_DEBUFF_SRCH = AURAADDEDOTHERHARMFUL -- "%s is afflicted by %s."
CRYOLYSIS_POLY_SRCH = AURAREMOVEDOTHER -- "%s fades from %s."

CryolysisData = {
	["Version"] = "2.0",
	["Author"] = "The Cryolysis: Reborn Team",
	["AppName"] = "Cryolysis: Reborn"
}
CryolysisData.Label = CryolysisData.AppName.." "..CryolysisData.Version

L:RegisterTranslations("enUS", function()
	return {
		
		["Use Main Cryolysis Button"] = "Use Main Cryolysis Button",
		
		["Use Evocation"] = "Use Evocation",
		["Use Mana Gem"] = "Use Mana Gem",
		["Conjure Mana Gem"] = "Conjure Mana Gem",
		
		["Use Drink"] = "Use Drink",
		["Trade Drink"] = "Trade Drink",
		["Conjure Drink"] =  "Conjure Drink",
		
		["Use Food"] = "Use Food",
		["Trade Food"] = "Trade Food",
		["Conjure Food"] = "Conjure Food",
		
		["Recast Last Buff"] = "Recast Last Buff",
		["Recast Last Portal"] = "Recast Last Portal",
		["Steed"] = "Steed",
		["Hearthstone"] = "Hearthstone",
		
		["Left Spell Button: Main Function"] = "Left Spell Button: Main Function",
		["Left Spell Button: Secondary Function"] = "Left Spell Button: Secondary Function",
		["Right Spell Button: Main Function"] = "Right Spell Button: Main Function",
		["Right Spell Button: Secondary Function"] = "Right Spell Button: Secondary Function"
		
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		
		["Use Main Cryolysis Button"] = "使用Cryolysis主按钮",
		
		["Use Evocation"] = "使用唤醒",
		["Use Mana Gem"] = "使用法力水晶",
		["Conjure Mana Gem"] = "制造法力水晶",
		
		["Use Drink"] = "使用饮水",
		["Trade Drink"] = "交易饮水",
		["Conjure Drink"] =  "制造饮水",
		
		["Use Food"] = "使用食物",
		["Trade Food"] = "交易食物",
		["Conjure Food"] = "制造食物",
		
		["Recast Last Buff"] = "重新施放最近一次施放的BUFF",
		["Recast Last Portal"] = "重新开启最近一次开启的传送门",
		["Steed"] = "座骑",
		["Hearthstone"] = "炉石",
		
		["Left Spell Button: Main Function"] = "左施法按钮：主功能",
		["Left Spell Button: Secondary Function"] = "左施法按钮：第二功能",
		["Right Spell Button: Main Function"] = "右施法按钮：主功能",
		["Right Spell Button: Secondary Function"] = "右施法按钮：第二功能"
		
	}
end)

L:RegisterTranslations("zhTW", function()
	return {
		
		["Use Main Cryolysis Button"] = "使用主要 Cryolysis 按鈕",
		
		["Use Evocation"] = "使用喚醒",
		["Use Mana Gem"] = "使用法力寶石",
		["Conjure Mana Gem"] = "製造法力寶石",
		
		["Use Drink"] = "喝水",
		["Trade Drink"] = "交易 - 飲料",
		["Conjure Drink"] =  "造水術",
		
		["Use Food"] = "進食",
		["Trade Food"] = "交易 - 食物",
		["Conjure Food"] = "造食術",
		
		["Recast Last Buff"] = "重新施放增益魔法",
		["Recast Last Portal"] = "重新施放傳送門",
		["Steed"] = "坐騎",
		["Hearthstone"] = "爐石",
		
		["Left Spell Button: Main Function"] = "左鍵施法按鈕：主要功能",
		["Left Spell Button: Secondary Function"] = "左鍵施法按鈕：次要功能",
		["Right Spell Button: Main Function"] = "右鍵施法按鈕：主要功能",
		["Right Spell Button: Secondary Function"] = "右鍵施法按鈕：次要功能"
		
	}
end)

-- Raccourcis claviers
BINDING_HEADER_CRYO_BIND = "Cryolysis"
   
BINDING_NAME_CRYOLYSISLEFT = L["Use Main Cryolysis Button"]

BINDING_NAME_EVOCATION = L["Use Evocation"]
BINDING_NAME_MANASTONELEFT = L["Use Mana Gem"]
BINDING_NAME_MANASTONERIGHT = L["Conjure Mana Gem"]

BINDING_NAME_DRINKLEFT = L["Use Drink"]
BINDING_NAME_DRINKMIDDLE = L["Trade Drink"]
BINDING_NAME_DRINKRIGHT = L["Conjure Drink"]

BINDING_NAME_FOODLEFT = L["Use Food"]
BINDING_NAME_FOODMIDDLE = L["Trade Food"]
BINDING_NAME_FOODRIGHT = L["Conjure Food"]

BINDING_NAME_LASTBUFF = L["Recast Last Buff"]
BINDING_NAME_LASTPORTAL = L["Recast Last Portal"]
BINDING_NAME_STEED = L["Steed"]
BINDING_NAME_HEARTH = L["Hearthstone"]

BINDING_NAME_LEFTSPELLLEFT = L["Left Spell Button: Main Function"]
BINDING_NAME_LEFTSPELLRIGHT = L["Left Spell Button: Secondary Function"]
BINDING_NAME_RIGHTSPELLLEFT = L["Right Spell Button: Main Function"]
BINDING_NAME_RIGHTSPELLRIGHT = L["Right Spell Button: Secondary Function"]
