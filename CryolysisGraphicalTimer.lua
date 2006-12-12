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

-- Fuction of displaying the timers
-- Table is in this form:
-- Table {
	-- texte = "Name of mob or spell",
	-- TimeMax = "TimeMax of spell",
	-- Time = "Time of spell",
	-- titre = "true if title, false if not",
	-- temps = "numerical timer",
	-- Gtimer = "Number of the associated timer (between 1 and 65)"
-- }
function CryolysisAfficheTimer(tableau, pointeur)
	-- One defines the place or will apparaitra the first frame   
	-- Declares that the first frame is the first mob
	
	if tableau ~= nil then
		local TimerTarget = 0;
		local yPosition = CryolysisConfig.SensListe * 5;

		local PositionTitre = {};

		if CryolysisConfig.SensListe > 0 then
			PositionTitre = {11, 13};
		else
			PositionTitre = {-13, -11};
		end
			
	
		for index =  1, table.getn(tableau.texte), 1 do
			-- If the entry is a title of mob 
			if tableau.titre[index] then
				-- On change de groupe de mob
				TimerTarget = TimerTarget + 1;
				if TimerTarget ~= 1 then yPosition = yPosition - PositionTitre[1]; end
				if TimerTarget == 11 then TimerTarget = 1; end
				-- Title displayed
				local frameName = "CryolysisTarget"..TimerTarget.."Text";
				local frameItem = getglobal(frameName);
				-- Place the left corner of the frame compared to the center button of the spell timer
				frameItem:ClearAllPoints();
				frameItem:SetPoint(CryolysisConfig.SpellTimerJust, "CryolysisSpellTimerButton", "CENTER", CryolysisConfig.SpellTimerPos * 23, yPosition);
				yPosition = yPosition - PositionTitre[2];
				-- The frame is named then displayed
				frameItem:SetText(tableau.texte[index]);
				if not frameItem:IsShown() then
					frameItem:Show();
				end
			else
				-- Similar for DoTs
				local JustifInverse = "LEFT";
				if CryolysisConfig.SpellTimerJust == "LEFT" then JustifInverse = "RIGHT"; end	
			
				local frameName1 = "CryolysisTimer"..tableau.Gtimer[index].."Text";
				local frameItem1 = getglobal(frameName1);
				local frameName2 = "CryolysisTimer"..tableau.Gtimer[index].."Bar";
				local frameItem2 = getglobal(frameName2);
				local frameName3 = "CryolysisTimer"..tableau.Gtimer[index].."Texture";
				local frameItem3 = getglobal(frameName3);
				local frameName4 = "CryolysisTimer"..tableau.Gtimer[index].."Spark";
				local frameItem4 = getglobal(frameName4);
				local frameName5 = "CryolysisTimer"..tableau.Gtimer[index].."OutText";
				local frameItem5 = getglobal(frameName5);
			
				frameItem1:ClearAllPoints();
				frameItem1:SetPoint(CryolysisConfig.SpellTimerJust, "CryolysisSpellTimerButton", "CENTER", CryolysisConfig.SpellTimerPos * 23, yPosition + 1);
				if CryolysisConfig.Yellow then
					frameItem1:SetTextColor(1, 0.82, 0);
				else
					frameItem1:SetTextColor(1, 1, 1);
				end
				frameItem1:SetJustifyH("LEFT");
				frameItem1:SetText(tableau.texte[index]);
					frameItem2:ClearAllPoints();
				frameItem2:SetPoint(CryolysisConfig.SpellTimerJust, "CryolysisSpellTimerButton", "CENTER", CryolysisConfig.SpellTimerPos * 23, yPosition);
				frameItem2:SetMinMaxValues(tableau.TimeMax[index] - tableau.Time[index], tableau.TimeMax[index]);
				frameItem2:SetValue(2 * tableau.TimeMax[index] - (tableau.Time[index] + floor(GetTime())));
				local r, g;
				local b = 37/255;
				local PercentColor = (tableau.TimeMax[index] - floor(GetTime())) / tableau.Time[index]
				if PercentColor > 0.5 then
					r = (49/255) + (((1 - PercentColor) * 2) * (1 - (49/255)));
     				g = 207/255;
				else
					r = 1.0;
   					g = (207/255) - (0.5 - PercentColor) * 2 * (207/255);
				end
				frameItem2:SetStatusBarColor(r, g, b)
					frameItem3:ClearAllPoints();
				frameItem3:SetPoint(CryolysisConfig.SpellTimerJust, "CryolysisSpellTimerButton", "CENTER", CryolysisConfig.SpellTimerPos * 23, yPosition);
				frameItem5:ClearAllPoints();
				frameItem5:SetTextColor(1, 1, 1);
				frameItem5:SetJustifyH(CryolysisConfig.SpellTimerJust);
				frameItem5:SetPoint(CryolysisConfig.SpellTimerJust, frameItem2, JustifInverse, CryolysisConfig.SpellTimerPos * 5, 1);
				frameItem5:SetText(tableau.temps[index]);

				local sparkPosition = 150 - ((floor(GetTime()) - (tableau.TimeMax[index] - tableau.Time[index])) / tableau.Time[index]) * 150;
				if (sparkPosition < 1) then
					sparkPosition = 1;
				end
				frameItem4:SetPoint("CENTER", frameItem2, "LEFT", sparkPosition, 0);
				yPosition = yPosition - CryolysisConfig.SensListe * 11;
			end
		end
		if TimerTarget < 10 then
			for i = TimerTarget + 1, 10, 1 do
				local frameName = "CryolysisTarget"..i.."Text";
				local frameItem = getglobal(frameName);
				if frameItem:IsShown() then
					frameItem:Hide();
				end
			end
		end
	end
end

function Cryolysis_AddFrame(SpellTimer, TimerTable)
	for i = 1, table.getn(TimerTable), 1 do
		if not TimerTable[i] then
			TimerTable[i] = true;
			SpellTimer[table.getn(SpellTimer)].Gtimer = i;
			-- Displaying associated graphic timer
			if CryolysisConfig.Graphical then
				local elements = {"Text", "Bar", "Texture", "OutText"}
				for j = 1, 4, 1 do
					frameName = "CryolysisTimer"..i..elements[j];
					frameItem = getglobal(frameName);
					frameItem:Show();					
				end
			end
			break
		end
	end
	return SpellTimer, TimerTable;
end

function Cryolysis_RemoveFrame(Gtime, TimerTable)
	-- The graphic timer is hidden 
	local elements = {"Text", "Bar", "Texture", "OutText"}
	for j = 1, 4, 1 do
		frameName = "CryolysisTimer"..Gtime..elements[j];
		frameItem = getglobal(frameName);
		frameItem:Hide();
	end

	-- On déclare le timer graphique comme réutilisable
	TimerTable[Gtime] = false;
	
	return TimerTable;
end
