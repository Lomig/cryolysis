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

------------------------------------------------------------------------------------------------------
-- FONCTIONS D'INSERTION
------------------------------------------------------------------------------------------------------

-- La table des timers est l� pour �a !
function Cryolysis_InsertTimerParTable(IndexTable, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entr�e dans le tableau
	table.insert(SpellTimer,
		{
			Name = CRYOLYSIS_SPELL_TABLE[IndexTable].Name,
			Time = CRYOLYSIS_SPELL_TABLE[IndexTable].Length,
			TimeMax = math.floor(GetTime() + CRYOLYSIS_SPELL_TABLE[IndexTable].Length),
			Type = CRYOLYSIS_SPELL_TABLE[IndexTable].Type,
			Target = Target,
			TargetLevel = LevelTarget,
			Group = 0,
			Gtimer = nil
		});

	-- Association d'un timer graphique au timer
	SpellTimer, TimerTable = Cryolysis_AddFrame(SpellTimer, TimerTable);

	-- Tri des entr�es par type de sort
	Cryolysis_Tri(SpellTimer, "Type");
	
	-- Cr�ation des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Cryolysis_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;
end

-- Et pour ins�rer le timer de pierres
function Cryolysis_InsertTimerStone(Stone, start, duration, SpellGroup, SpellTimer, TimerTable)

	-- Insertion de l'entr�e dans le tableau
	if Stone == "Manastone" then
		table.insert(SpellTimer,
			{
				Name = CRYOLYSIS_COOLDOWN.Manastone,
				Time = 180,
				TimeMax = math.floor(GetTime() + 180),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Cryolysis_AddFrame(SpellTimer, TimerTable);
		
	elseif Stone == "Spellstone" then
		table.insert(SpellTimer,
			{
				Name = CRYOLYSIS_COOLDOWN.Spellstone,
				Time = 30,
				TimeMax = math.floor(GetTime() + 30),
				Type = 2,
				Target = "",
				TargetLevel = "",
				Group = 2,
				Gtimer = nil
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Cryolysis_AddFrame(SpellTimer, TimerTable);
		
	elseif Stone == "Soulstone" then
		table.insert(SpellTimer,
			{
				Name = CRYOLYSIS_SPELL_TABLE[11].Name,
				Time = math.floor(duration - GetTime() + start),
				TimeMax = math.floor(start + duration),
				Type = CRYOLYSIS_SPELL_TABLE[11].Type,
				Target = "???",
				TargetLevel = "",
				Group = 1,
				Gtimer = nil,
			});

		-- Association d'un timer graphique au timer
		SpellTimer, TimerTable = Cryolysis_AddFrame(SpellTimer, TimerTable);
	end

	-- Tri des entr�es par type de sort	
	Cryolysis_Tri(SpellTimer, "Type");

	-- Cr�ation des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Cryolysis_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;
end

-- Pour la cr�ation de timers personnels
function CryolysisTimerX(nom, duree, truc, Target, LevelTarget, SpellGroup, SpellTimer, TimerTable)
	
	table.insert(SpellTimer,
			{
				Name = nom,
				Time = duree,
				TimeMax = math.floor(GetTime() + duree),
				Type = truc,
				Target = Target,
				TargetLevel = LevelTarget,
				Group = 0,
				Gtimer = nil
			});

	-- Association d'un timer graphique au timer
	SpellTimer, TimerTable = Cryolysis_AddFrame(SpellTimer, TimerTable);

	-- Tri des entr�es par type de sort
	Cryolysis_Tri(SpellTimer, "Type");
	
	-- Cr�ation des groupes (noms des mobs) des timers
	SpellGroup, SpellTimer = Cryolysis_Parsing(SpellGroup, SpellTimer);

	return SpellGroup, SpellTimer, TimerTable;	
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS DE RETRAIT
------------------------------------------------------------------------------------------------------


-- Connaissant l'index du Timer dans la liste, on le supprime
function Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable)

		-- Suppression du timer graphique
		local Gtime = SpellTimer[index].Gtimer;
		TimerTable = Cryolysis_RemoveFrame(Gtime, TimerTable);
		
		-- On enl�ve le timer de la liste
		table.remove(SpellTimer, index);

	return SpellTimer, TimerTable;
end

-- Si on veut supprimer sp�cifiquement un Timer...
function Cryolysis_RetraitTimerParNom(name, SpellTimer, TimerTable)
	for index = 1, #(SpellTimer), 1 do
		if SpellTimer[index].Name == name then
			SpellTimer = Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
			break;
		end
	end
	return SpellTimer, TimerTable;
end

-- Fonction pour enlever les timers de combat lors de la regen
function Cryolysis_RetraitTimerCombat(SpellGroup, SpellTimer, TimerTable)
	for index=1, #(SpellTimer), 1 do
		if SpellTimer[index] then
			-- Si les cooldowns sont nominatifs, on enl�ve le nom
			if SpellTimer[index].Type == 3 then
				SpellTimer[index].Target = "";
				SpellTimer[index].TargetLevel = "";
			end
			-- Enlevage des timers de combat
			if ((SpellTimer[index].Type == 4) or (SpellTimer[index].Type == 5)) then
				SpellTimer = Cryolysis_RetraitTimerParIndex(index, SpellTimer, TimerTable);
			end
		end
	end

	if #(SpellGroup.Name) >= 4 then
		for index = 4, #(SpellGroup.Name), 1 do
			table.remove(SpellGroup.Name);
			table.remove(SpellGroup.SubName);
			table.remove(SpellGroup.Visible);
		end
	end
	return SpellGroup, SpellTimer, TimerTable;
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS BOOLEENNES
------------------------------------------------------------------------------------------------------

function Cryolysis_TimerExisteDeja(Nom, SpellTimer)
	for index = 1, #(SpellTimer), 1 do
		if SpellTimer[index].Name == Nom then
			return true;
		end
	end
	return false;
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS DE TRI
------------------------------------------------------------------------------------------------------

-- On d�finit les groupes de chaque Timer
function Cryolysis_Parsing(SpellGroup, SpellTimer)
	local GroupeOK = false;
	for index = 1, #(SpellTimer), 1 do
		local GroupeOK = false;
		for i = 1, #(SpellGroup.Name), 1 do
			if ((SpellTimer[index].Type == i) and (i <= 3)) or 
			   (SpellTimer[index].Target == SpellGroup.Name[i]
				and SpellTimer[index].TargetLevel == SpellGroup.SubName[i])
				then
				GroupeOK = true;
				SpellTimer[index].Group = i;
				break;
			end
		end
		-- Si le groupe n'existe pas, on en cr�e un nouveau
		if not GroupeOK then
			table.insert(SpellGroup.Name, SpellTimer[index].Target);
			table.insert(SpellGroup.SubName, SpellTimer[index].TargetLevel);
			table.insert(SpellGroup.Visible, false);
			SpellTimer[index].Group = #(SpellGroup.Name);
		end
	end
	
	 Cryolysis_Tri(SpellTimer, "Group");
	return SpellGroup, SpellTimer;
end

-- On trie les timers selon leur groupe
function Cryolysis_Tri(SpellTimer, clef)
	return table.sort(SpellTimer,
		function (SubTab1, SubTab2)
			return SubTab1[clef] < SubTab2[clef]
		end);
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS D'AFFICHAGE : CREATION DE LA CHAINE DE CARACTERE
------------------------------------------------------------------------------------------------------


function Cryolysis_DisplayTimer(display, index, SpellGroup, SpellTimer, GraphicalTimer, TimerTable)
	if not SpellTimer then
		return display, SpellGroup;
	end
	
	local minutes = 0;
	local seconds = 0;
	local affichage;
	
	-- Changement de la couleur suivant le temps restant	
	local percent = (math.floor(SpellTimer[index].TimeMax - math.floor(GetTime())) / SpellTimer[index].Time)*100;
	local color = CryolysisTimerColor(percent);
	
	if not SpellGroup.Visible[SpellTimer[index].Group]
		and SpellGroup.SubName[SpellTimer[index].Group] ~= nil
		and SpellGroup.Name[SpellTimer[index].Group] ~= nil then
		display = display.."<purple>-------------------------------\n"..SpellGroup.Name[SpellTimer[index].Group].." "..SpellGroup.SubName[SpellTimer[index].Group].."\n-------------------------------<close>\n";
		-- Cr�e le tableau qui servira aux timers graphiques
		table.insert(GraphicalTimer.texte, SpellGroup.Name[SpellTimer[index].Group].." "..SpellGroup.SubName[SpellTimer[index].Group]);
		table.insert(GraphicalTimer.TimeMax, 0);
		table.insert(GraphicalTimer.Time, 0);
		table.insert(GraphicalTimer.titre, true);
		table.insert(GraphicalTimer.temps, "");
		table.insert(GraphicalTimer.Gtimer, 0);
		SpellGroup.Visible[SpellTimer[index].Group] = true;
	end

	-- Mise en place d'un Chrono plut�t qu'un Compte � Rebours pour l'asservissement
	if SpellTimer[index].Name == CRYOLYSIS_SPELL_TABLE[10].Name then
		seconds = math.floor(GetTime()) - (SpellTimer[index].TimeMax - SpellTimer[index].Time);
	else
		seconds = SpellTimer[index].TimeMax - math.floor(GetTime());
	end
	minutes = math.floor(seconds/60);
	if (minutes > 0) then
		if (minutes > 9) then
			affichage = tostring(minutes)..":";
		else
			affichage = "0"..minutes..":"
		end
	else
		affichage = "0:";
	end
	seconds = math.fmod(seconds, 60);
	if (seconds > 9) then
		affichage = affichage..seconds
	else
		affichage = affichage.."0"..seconds
	end
	display = display.."<white>"..affichage.." - <close>";

	-- Cr�e le tableau qui servira aux timers graphiques
	if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == CRYOLYSIS_SPELL_TABLE[26].Name)
	and (SpellTimer[index].Target ~= "") then
		if CryolysisConfig.SpellTimerPos == 1 then
			affichage = affichage.." - "..SpellTimer[index].Target;
		else
			affichage = SpellTimer[index].Target.." - "..affichage;
		end
	end
	table.insert(GraphicalTimer.texte, SpellTimer[index].Name);
	table.insert(GraphicalTimer.TimeMax, SpellTimer[index].TimeMax);
	table.insert(GraphicalTimer.Time, SpellTimer[index].Time);
	table.insert(GraphicalTimer.titre, false);
	table.insert(GraphicalTimer.temps, affichage);
	table.insert(GraphicalTimer.Gtimer, SpellTimer[index].Gtimer);
	
	display = display..color..SpellTimer[index].Name.."<close><white>";
	if (SpellTimer[index].Type == 1 or SpellTimer[index].Name == CRYOLYSIS_SPELL_TABLE[26].Name)
		and (SpellTimer[index].Target ~= "")
		then
		display = display.." -SPEE "..SpellTimer[index].Target.."<close>\n";
	else
		display = display.."<close>\n";
	end
	-- Affichage des timers graphiques (si s�lectionn�s)
	if CryolysisConfig.Graphical then
		CryolysisAfficheTimer(GraphicalTimer, TimerTable);
	end

	return display, SpellGroup, GraphicalTimer, TimerTable;
end
Cryolysis_UpdateRevisions("CryolysisTimerFunction.lua", "$Rev$")
