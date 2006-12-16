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

-- Only one instance of each of the global strings that used to be here could be found in all the files,
-- so I just inserted them directly.

CryolysisData = {
	["Version"] = "2.0",
	["Author"] = "The Cryolysis: Reborn Team",
	["AppName"] = "Cryolysis: Reborn"
}
CryolysisData.Label = CryolysisData.AppName.." "..CryolysisData.Version

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
