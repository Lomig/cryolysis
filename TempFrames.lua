-- This is a temporary file to give me plenty of space to write the lua to create the frames and switch them over from XML.
local _G = getfenv(0)

local LEFT = "ANCHOR_LEFT"
local RIGHT = "ANCHOR_RIGHT"

Cryo.frames = {}

function Cryo:CreateTimerButton()
	local f = CreateFrame("Button", "CryolysisSpellTimerButton", UIParent, "SecureActionButtonTemplate")
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f:RegisterForDrag("LeftButton")
	f:SetFrameStrata("MEDIUM")
	f:EnableMouse(true)
	f:SetMovable(true)
	
	f:SetWidth(34)
	f:SetHeight(34)
	f:SetPoint("CENTER", UIParent, "CENTER", 120, 340)
	
	f:SetNormalTexture( string.format(Cryo.textureDir, "SpellTimerButton-Normal") )
	f:SetHighlightTexture( string.format(Cryo.textureDir, "SpellTimerButton-Highlight") )
	
	local t = f:CreateFontString("CryolysisListSpells", "ARTWORK")
	t:SetFontObject(_G["GameFontNormalSmall"])
	t:SetJustifyH("LEFT")
	t:SetPoint("LEFT", f, "LEFT", 23, 0)
	
	f:SetScript("OnDragStart", function()
		self:OnDragStart(this)
	end)
	f:SetScript("OnDragStop", function()
		self:OnDragStop(this)
	end)
	f:SetScript("OnMouseUp", function()
		self:OnDragStop(this)
	end)
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "SpellTimer", AnchorSpellTimerTooltip)
	end)
	
	self.frames.timerButton = f
	
	f:Hide()
end

function Cryo:CreateMainButton()
	local f = CreateFrame("Button", "CryolysisButton", UIParent, "SecureActionButtonTemplate")
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	f:RegisterForDrag("LeftButton")
	f:SetFrameLevel(1)
	f:SetToplevel(true)
	f:EnableMouse(true)
	f:SetMovable(true)
	
	f:SetWidth(58)
	f:SetHeight(58)
	f:SetPoint("CENTER", UIParent, "CENTER", 0, -100)
	
	f:SetNormalTexture( string.format(self.textureDir, "Shard") )
	
	local t = f:CreateFontString("CryolysisShardCount", "ARTWORK")
	t:SetFontObject(_G["GameFontNormal"])
	t:SetTextColor(1.0, 1.0, 1.0, 1.0)
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	
	f:SetScript("OnDragStart", function()
		self:OnDragStart(this)
	end)
	f:SetScript("OnDragStop", function()
		self:OnDragStop(this)
	end)
	f:SetScript("OnMouseUp", function()
		self:OnDragStop(this)
	end)
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Main", LEFT)
	end)
	f:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	self.frames.main = f
end

local function newButton(name, normalTexture, highlightTexture, fontString, isMenu)
	local template
	if ( not isMenu ) then
		template = "SecureActionButtonTemplate"
	else
		template = "SecureAnchorUpDownTemplate"
	end
	local f = CreateFrame("Button", name, UIParent, template)
	f:RegisterForDrag("LeftButton")
	f:RegisterForClicks("AnyUp")
	f:SetMovable(true)
	
	f:SetWidth(34)
	f:SetHeight(34)
	
	if ( normalTexture ) then
		f:SetNormalTexture( string.format(Cryo.textureDir, normalTexture) )
	end
	if ( highlightTexture ) then
		f:SetHighlightTexture( string.format(Cryo.textureDir, highlightTexture) )
	end
	
	if ( not fontString ) then
		fontString = "$parentText"
	end
	local t = f:CreateFontString(fontString, "ARTWORK")
	t:SetFontObject(_G["GameFontNormal"])
	t:SetTextColor(1.0, 1.0, 1.0, 1.0)
	t:SetPoint("CENTER", f, "CENTER", 0, 0)
	f.text = t
	
	if ( isMenu ) then
		f.header = CreateFrame("Frame", isMenu, f, "SecureStateHeaderTemplate")
		f.header:Hide()
	end
	
	f:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	f:SetScript("OnDragStart", function()
		if ( not CryolysisLockServ ) then
			self:OnDragStart(f)
		end
	end)
	f:SetScript("OnDragStop", function()
		self:OnDragStop(f)
	end)
	f:SetScript("OnMouseUp", function()
		self:OnDragStop(f)
	end)
	
	f:Hide()
	
	return f
end

function Cryo:CreateButtons()
	local f = newButton("CryolysisLeftSpellButton", "Shard", "BaseMenu-02")
	f:SetScript("OnEnter", function()
		self:BuildSpellTooltip(this, "Left", LEFT)
	end)
	
	f = newButton("CryolysisEvocationButton", "EvocationButton-01", "BaseMenu-02", "CryolysisEvocationCooldown")
	f:SetScript("OnEnter", function()
		self:BuildSpellTooltip(this, "Evocation", LEFT)
	end)
	
	f = newButton("CryolysisRightSpellButton", "Shard", "BaseMenu-02")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Right", RIGHT)
	end)
	
	f = newButton("CryolysisDrinkButton", "DrinkButton-01", "BaseMenu-02", "CryolysisDrinkCount")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Drink", LEFT)
	end)
	
	f = newButton("CryolysisFoodButton", "FoodButton-01", "BaseMenu-02", "CryolysisFoodCount")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Food", LEFT)
	end)
	
	f = newButton("CryolysisMountButton", "MountButton-01", "BaseMenu-02")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Mount", RIGHT)
	end)
	
	f = newButton("CryolysisManaStoneButton", "ManastoneButton-01", "BaseMenu-02", "CryolysisManastoneCooldown", "CryolysisManaStoneMenu0")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Manastone", LEFT)
	end)
	
	f = newButton("CryolysisBuffMenuButton", "BuffMenuButton-01", "BaseMenu-02", nil, "CryolysisBuffMenu0")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Buff", LEFT)
	end)
	
	f = newButton("CryolysisPortalMenuButton", "PortalMenuButton-01", "BaseMenu-02", nil, "CryolysisPortalMenu0")
	f:SetScript("OnEnter", function()
		self:BuildTooltip(this, "Portal", RIGHT)
	end)
end

--[[
	<Button name="CryolysisPortalMenuButton" inherits="SecureAnchorUpDownTemplate" hidden="false" enableMouse="true"  toplevel="true" parent="UIParent" movable="true">
		<Size>
			<AbsDimension x="34" y="34"/>
		</Size>
		<Anchors>
			<Anchor point="CENTER" relativeTo="UIParent" relativePoint="CENTER">
				<Offset>
					<AbsDimension x="17" y="-100"/>
				</Offset>
			</Anchor>
		</Anchors>
		<Scripts>
			<OnLoad>
				this:RegisterForDrag("LeftButton");
				this:RegisterForClicks("LeftButtonUp", "MiddleButtonUp", "RightButtonUp");
				HideUIPanel(this);
			</OnLoad>
			<OnEnter>
				Cryo:BuildTooltip(this, "Portal", "ANCHOR_RIGHT");
			</OnEnter>
			<OnLeave>
				GameTooltip:Hide();
			</OnLeave>
			<OnDragStart>
				if not CryolysisLockServ then Cryo:OnDragStart(this); end
			</OnDragStart>
			<OnDragStop>
				Cryo:OnDragStop(this);
			</OnDragStop>
			<OnMouseUp>
				Cryo:OnDragStop(this);
			</OnMouseUp>
		</Scripts>
		<Frames>
			<Frame name="CryolysisPortalMenu0" inherits="SecureStateHeaderTemplate"/>
		</Frames>
		<NormalTexture file="Interface\AddOns\Cryolysis\UI\PortalMenuButton-01"/>
		<HighlightTexture file="Interface\AddOns\Cryolysis\UI\BaseMenu-02"/>
	</Button>
--]]

function Cryo:CreateAllFrames()
	self:CreateTimerButton()
	self:CreateMainButton()
	self:CreateButtons()
end

