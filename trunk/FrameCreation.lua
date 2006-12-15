local _G = getfenv(0)

-- Most of this stuff is from Iriel's code, with renamed variables to better represent our situation.
-- portalAnchor is a hidden frame that the user never interacts with directly.  It's only purpose being to
-- store the current state information (from my understanding).  I don't really understand what any of these
-- attributes are actually doing though. :(  I assume you'd understand them better.
local portalAnchor = CreateFrame("Button", "CryoTestHeader", UIParent, "SecureStateHeaderTemplate")
portalAnchor:SetAttribute("statemap-anchor", "$input");
portalAnchor:SetAttribute("delaystatemap-anchor", "0");
portalAnchor:SetAttribute("delaytimemap-anchor", "0.5");
portalAnchor:SetAttribute("delayhovermap-anchor", "true");

do 
	-- "f" (a.k.a "mainPortalButton") is the main button that all the portal buttons come from.  You can clearly see
	-- that I give it a meaningful name after it is fully defined ;)
	local f = CreateFrame("Button", "CryoTestAnchor", UIParent, "SecureAnchorUpDownTemplate")
	f:EnableMouse(true)
	f:SetToplevel(true)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	
	f:SetWidth(34)
	f:SetHeight(34)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, -200)
	
	f:SetNormalTexture("Interface\\AddOns\\Cryolysis\\UI\\serenity")
	f:SetHighlightTexture("Interface\\AddOns\\Cryolysis\\UI\\serenity")
	
	-- This doesn't have anything to do with states, but this is how I'm going to be redo-ing all buttons
	-- in the future.  NormalTexture is just the circular outline.  I create a background texture and use
	-- one of the spell icons already programmed into WoW so that I don't have to find the icon, extract
	-- it, and change it's format just to package it in with my addons.  I make it smaller than the
	-- NormalTexture so that it looks like it's a circle, when really it's still a square.
	local t = f:CreateTexture(f:GetName().."Icon", "BACKGROUND")
	t:SetWidth(20)
	t:SetHeight(20)
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	t:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportShattrath")
	f.icon = t
	
	-- The HighlightTexture is identical to the normal texture.  Both are white in appearance.  This chunk
	-- changes the vertex color to a light blue so that it appears to be a blue texture instead of the regular
	-- white one.  Saves me from making yet another texture.
	t = f:GetHighlightTexture()
	t:SetVertexColor( 75/255, 216/255, 241/255 )
	f:SetHighlightTexture(t)
	f.highlight = t
	
	-- Ok, now here's where I start to get lost.  From my understanding, this is simply naming two seperate states
	-- for future reference.
	f:SetAttribute("onmouseupbutton", "mup");
	f:SetAttribute("onmousedownbutton", "mdn");

	-- These attributes are defined for "mdn" state?  But you probably could've figured that out
	-- on your own.
	f:SetAttribute("*anchorchild-mdn", portalAnchor);
	f:SetAttribute("*childofsx-mdn", 0);
	f:SetAttribute("*childofsy-mdn", 0);
	f:SetAttribute("*childpoint-mdn", "LEFT");
	f:SetAttribute("*childrelpoint-mdn", "RIGHT");
	f:SetAttribute("*childstate-mdn", "^mousedown");
	f:SetAttribute("*childreparent-mdn", "true");

	f:SetAttribute("*anchorchild-mup", portalAnchor);
	f:SetAttribute("*childstate-mup", "mouseup");
	f:SetAttribute("*childverify-mup", true)
	
	mainPortalButton = f
end
-- Setting the state to 0 by default...
portalAnchor:SetAttribute("state", 0)

local yofslist = ""
local textures = { "Spell_Arcane_TeleportIronForge", "Spell_Arcane_TeleportStormWind", "Spell_Arcane_TeleportDarnassus" }

-- These three frames are the 3 teleport buttons I created to test.  One for IF, one for SW, and one for Darnassus.
for i = 1, 3, 1 do
	local f = CreateFrame("Button", "CryoPortalButton"..i, UIParent, "SecureActionButtonTemplate")
	f:SetFrameStrata("HIGH")
	f:EnableMouse(true)
	f:SetToplevel(true)
	f:SetMovable(true)
	
	f:SetWidth(40)
	f:SetHeight(40)
	
	f:SetNormalTexture("Interface\\Icons\\"..textures[i])
	
	-- Set them as children to our hidden frame.
	portalAnchor:SetAttribute("addchild", f)
	-- Hide in state 0, show in anything else
	f:SetAttribute("showstates", "!0,*")
	-- This offsets the first button by 20 units to the right of the 'mainPortalButton' frame, and each
	-- additional portal button will show up 34 units below the one before it, creating a vertical column.
	f:SetAttribute("ofsx", 20)
	local yofs = -34 * (i - 1)
	f:SetAttribute("ofsy", yofs)
	
	-- I don't really understand any of these three lines.
	f:SetAttribute("anchorchild", portalAnchor)
	f:SetAttribute("childstate", (i + 1))
	f:SetAttribute("newstate", "0")
end

-- And I don't really understand any of these 5 lines.
portalAnchor:SetAttribute("statemap-anchor-mousedown", "1");
portalAnchor:SetAttribute("statemap-anchor-mouseup", "!0:");
portalAnchor:SetAttribute("delaystatemap-anchor-mouseup", "!0,*:0");
portalAnchor:SetAttribute("delaytimemap-anchor-mouseup", "0.5");
portalAnchor:SetAttribute("delayhovermap-anchor-mouseup", "true");