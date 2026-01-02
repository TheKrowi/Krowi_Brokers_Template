local addonName, addon = ...;

addon.L = LibStub(addon.Libs.AceLocale):GetLocale(addonName);

KrowiBT_SavedData = KrowiBT_SavedData or {
	ExampleSetting = true,
};

error([["Make sure to update your X-Prefix in the toc file to 'KrowiB*' to match the naming convention for Krowi Brokers addons. 
Remove this line after updating the toc file."]]);
error([["Make sure to update your X-Acronym in the toc file to 'KB*' to match the naming convention for Krowi Brokers addons. 
Remove this line after updating the toc file."]]);
error([["Make sure to update your SavedVariables in the toc file to 'KrowiB*_SavedData' to match the naming convention for Krowi Brokers addons. 
Remove this line after updating the toc file."]]);
error([["Make sure to set your X-Curse-Project-ID in the toc file. 
Remove this line after updating the toc file."]]);
error([["Make sure to set your X-Wago-ID in the toc file. 
Remove this line after updating the toc file."]]);

-- Helper functions

-- Main functions

function addon.GetDisplayText()
	return addon.L["Template"] .. ": " .. (KrowiBT_SavedData.ExampleSetting and addon.L["Enabled"] or addon.L["Disabled"]);
end

local function OnClick(self, button)
	if button == "LeftButton" then
		-- Add left-click behavior here
		print(addon.L["Left-Click Action"]);
		return;
	end

	if button ~= "RightButton" then
		return;
	end

	addon.Menu.ShowPopup();
end

local function OnEnter(self)
	addon.Tooltip.Show(self);
end

local function OnLeave(self)
	GameTooltip:Hide();
end

function addon.Init()
	addon.Menu.Init();
	addon.Tooltip.Init();

	local dataObject = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
		type = "data source",
		tocname = addonName,
		icon = "Interface\\Icons\\INV_Misc_QuestionMark",
		text = addon.L["Template"],
		category = "Information",
		OnEnter = OnEnter,
		OnLeave = OnLeave,
		OnClick = OnClick,
	});

	function dataObject:Update()
		self.text = addon.GetDisplayText();
	end

	dataObject:Update();

	addon.TemplateLDB = dataObject
end

local function OnEvent(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		addon.TemplateLDB:Update();
	end
end

local eventFrame = Krowi_Brokers_EventFrame or CreateFrame("Frame", "Krowi_Brokers_EventFrame");
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
eventFrame:SetScript("OnEvent", OnEvent);

addon.Init()