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



------------------------------------------------------------------------------------------------------
-- POSTING FUNCTIONS (CONSOLE, CHAT, MESSAGE SYSTEM) 
------------------------------------------------------------------------------------------------------
local COLORS = {
	["white"] = "FFFFFF",
	["lightBlue"] = "99CCFF",
	["brightGreen"] = "00FF00",
	["lightGreen2"] = "66FF66",
	["lightGreen1"] = "99FF66",
	["yellowGreen"] = "CCFF66",
	["lightYellow"] = "FFFF66",
	["darkYellow"] = "FFCC00",
	["lightOrange"] = "FFCC66",
	["dirtyOrange"] = "FF9933",
	["darkOrange"] = "FF6600",
	["redOrange"] = "FF3300",
	["red"] = "FF0000",
	["lightRed"] = "FF5555",
	["lightPurple1"] = "FFC4FF",
	["lightPurple2"] = "FF99FF",
	["purple"] = "FF50FF",
	["darkPurple1"] = "FF00FF",
	["darkPurple2"] = "B700B7",
	["close"] = "|r"
}

function Cryo:Msg(msg, Type)
	if (( msg ) and ( Type )) then
		-- If the message type is "USER" then the message is displayed
		if ( Type == "USER" ) then
			-- Colorize the message
			msg = Cryo:MsgAddColor(msg)
			self:Print(msg)
		-- If the Type of the message is “WORLD”, the message will be sent in raid, failing this in group, and failing this in local chat
		elseif (Type == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID")
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY")
			else
				SendChatMessage(msg, "SAY")
			end
		elseif (Type == "GROUP") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID")
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY")
			end
		-- If the message Type is "PARTY", then display to group
		elseif (Type == "PARTY") then
			SendChatMessage(msg, "PARTY")
		-- If the message Type is "PARTY", then display to raid
		elseif (Type == "RAID") then
			SendChatMessage(msg, "RAID")
		elseif (Type == "SAY") then
		-- Otherwise send to local chat
			SendChatMessage(msg, "SAY")
		end
	end
end

------------------------------------------------------------------------------------------------------
-- ... COLORIZATION!
------------------------------------------------------------------------------------------------------
-- Define Colors easily
function Cryo:MsgAddColor(msg)
	for k in next, COLORS do
		if ( string.find(msg, "<"..k..">") ) then
			string.gsub(msg, "<"..k..">", "|cff"..COLORS[k])
		end
	end
--[[
	msg = string.gsub(msg, "<white>", "|CFFFFFFFF")
	msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF")
	msg = string.gsub(msg, "<brightGreen>", "|CFF00FF00")
	msg = string.gsub(msg, "<lightGreen2>", "|CFF66FF66")
	msg = string.gsub(msg, "<lightGreen1>", "|CFF99FF66")
	msg = string.gsub(msg, "<yellowGreen>", "|CFFCCFF66")
	msg = string.gsub(msg, "<lightYellow>", "|CFFFFFF66")
	msg = string.gsub(msg, "<darkYellow>", "|CFFFFCC00")
	msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66")
	msg = string.gsub(msg, "<dirtyOrange>", "|CFFFF9933")
	msg = string.gsub(msg, "<darkOrange>", "|CFFFF6600")
	msg = string.gsub(msg, "<redOrange>", "|CFFFF3300")
	msg = string.gsub(msg, "<red>", "|CFFFF0000")
	msg = string.gsub(msg, "<lightRed>", "|CFFFF5555")
	msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF")
	msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF")
	msg = string.gsub(msg, "<purple>", "|CFFFF50FF")
	msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF")
	msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7")
	msg = string.gsub(msg, "<close>", "|r")
	msg = string.gsub(msg, "<darkBlue>", "|C2D59E9FF")
]]
	return msg
end

-- Insert in the timers of the codes of colouring according to the percentage of remaining time
function CryolysisTimerColor(percent)
	local color = "<brightGreen>"   -- |C2D47E7FF
	if (percent < 10) then
		color = "<red>"             -- |C26FBF8FF
	elseif (percent < 20) then
		color = "<redOrange>"       -- |C28D8F5FF
	elseif (percent < 30) then
		color = "<darkOrange>"      -- |C28C6F4FF      350
	elseif (percent < 40) then
		color = "<dirtyOrange>"     -- |C29B5F2FF       300
	elseif (percent < 50) then
		color = "<darkYellow>"      -- |C2AA2EFFF
	elseif (percent < 60) then
		color = "<lightYellow>"     -- |C2A90EEFF
	elseif (percent < 70) then
		color = "<yellowGreen>"     -- |C2B7EECFF
	elseif (percent < 80) then
		color = "<lightGreen1>"     -- |C2C6BEBFF
	elseif (percent < 90) then
		color = "<lightGreen2>"    -- |C2D59E9FF
	end
	return color
end

------------------------------------------------------------------------------------------------------
-- USER-FRIENDLY VARIABLES WHEN DISPLAYING CHAT
------------------------------------------------------------------------------------------------------
function Cryolysis_MsgReplace(msg, target, portal, mount)
	msg = string.gsub(msg, "<player>", UnitName("player"))
	if target then
		msg = string.gsub(msg, "<target>", target)
	end
	if portal then
		msg = string.gsub(msg, "<portal>", portal)
	end
	if mount then
		msg = string.gsub(msg, "<mount>", mount)
	end
	return msg
end

Cryolysis_UpdateRevisions("CryolysisMessage.lua", "$Rev$")
