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

CryolysisData = {
	["Version"] = "2.0",
	["Author"] = "The Cryolysis: Reborn Team",
	["AppName"] = "Cryolysis: Reborn"
}
CryolysisData.Label = CryolysisData.AppName.." "..CryolysisData.Version

-- Raccourcis claviers
BINDING_HEADER_CRYO_BIND = "Cryolysis";
   
BINDING_NAME_CRYOLYSISLEFT = "Use Main Cryolysis Button";

BINDING_NAME_EVOCATION = "Use Evocation";
BINDING_NAME_MANASTONELEFT = "Use Mana Gem";
BINDING_NAME_MANASTONERIGHT = "Conjure Mana Gem";

BINDING_NAME_DRINKLEFT = "Use Drink";
BINDING_NAME_DRINKMIDDLE = "Trade Drink";
BINDING_NAME_DRINKRIGHT =  "Conjure Drink";

BINDING_NAME_FOODLEFT = "Use Food";
BINDING_NAME_FOODMIDDLE = "Trade Food";
BINDING_NAME_FOODRIGHT = "Conjure Food";

BINDING_NAME_LASTBUFF = "Recast Last Buff";
BINDING_NAME_LASTPORTAL = "Recast Last Portal";
BINDING_NAME_STEED = "Steed";
BINDING_NAME_HEARTH = "Hearthstone";

BINDING_NAME_LEFTSPELLLEFT = "Left Spell Button: Main Function";
BINDING_NAME_LEFTSPELLRIGHT = "Left Spell Button: Secondary Function";
BINDING_NAME_RIGHTSPELLLEFT = "Right Spell Button: Main Function";
BINDING_NAME_RIGHTSPELLRIGHT = "Right Spell Button: Secondary Function";


if GetLocale() == "zhCN" then

BINDING_NAME_CRYOLYSISLEFT = "使用Cryolysis主按钮";

BINDING_NAME_EVOCATION = "使用唤醒";
BINDING_NAME_MANASTONELEFT = "使用法力水晶";
BINDING_NAME_MANASTONERIGHT = "制造法力水晶";

BINDING_NAME_DRINKLEFT = "使用饮水";
BINDING_NAME_DRINKMIDDLE = "交易饮水";
BINDING_NAME_DRINKRIGHT =  "制造饮水";

BINDING_NAME_FOODLEFT = "使用食物";
BINDING_NAME_FOODMIDDLE = "交易食物";
BINDING_NAME_FOODRIGHT = "制造食物";

BINDING_NAME_LASTBUFF = "重新施放最近一次施放的BUFF";
BINDING_NAME_LASTPORTAL = "重新开启最近一次开启的传送门";
BINDING_NAME_STEED = "座骑";
BINDING_NAME_HEARTH = "炉石";

BINDING_NAME_LEFTSPELLLEFT = "左施法按钮：主功能";
BINDING_NAME_LEFTSPELLRIGHT = "左施法按钮：第二功能";
BINDING_NAME_RIGHTSPELLLEFT = "右施法按钮：主功能";
BINDING_NAME_RIGHTSPELLRIGHT = "右施法按钮：第二功能";

end


if ( GetLocale() == "zhTW" ) then
------------------------------------------------
-- Traditional Chinese  VERSION TEXTS  - Nightly@布蘭卡德
------------------------------------------------

-- Raccourcis claviers
BINDING_NAME_CRYOLYSISLEFT = "使用主要 Cryolysis 按鈕";

BINDING_NAME_EVOCATION = "使用喚醒";
BINDING_NAME_MANASTONELEFT = "使用法力寶石";
BINDING_NAME_MANASTONERIGHT = "製造法力寶石";

BINDING_NAME_DRINKLEFT = "喝水";
BINDING_NAME_DRINKMIDDLE = "交易 - 飲料";
BINDING_NAME_DRINKRIGHT =  "造水術";

BINDING_NAME_FOODLEFT = "進食";
BINDING_NAME_FOODMIDDLE = "交易 - 食物";
BINDING_NAME_FOODRIGHT = "造食術";

BINDING_NAME_LASTBUFF = "重新施放增益魔法";
BINDING_NAME_LASTPORTAL = "重新施放傳送門";
BINDING_NAME_STEED = "坐騎";
BINDING_NAME_HEARTH = "爐石";

BINDING_NAME_LEFTSPELLLEFT = "左鍵施法按鈕：主要功能";
BINDING_NAME_LEFTSPELLRIGHT = "左鍵施法按鈕：次要功能";
BINDING_NAME_RIGHTSPELLLEFT = "右鍵施法按鈕：主要功能";
BINDING_NAME_RIGHTSPELLRIGHT = "右鍵施法按鈕：次要功能";

end
