local _, addon = ...;

local menu = {};
addon.Menu = menu;

local menuBuilder;

function menu.Init()
	local lib = LibStub("Krowi_MenuBuilder-1.0");

	menuBuilder = lib:New({
		uniqueTag = addon.Metadata.Prefix .. "_RIGHT_CLICK_MENU_OPTIONS",
		callbacks = {
			OnCheckboxSelect = function(filters, keys)
				addon.Util.WriteNestedKeys(filters, keys, not menuBuilder:KeyIsTrue(filters, keys));
				addon.TemplateLDB:Update();
			end,
			OnRadioSelect = function(filters, keys, value)
				addon.Util.WriteNestedKeys(filters, keys, value);
				addon.TemplateLDB:Update();
			end
		}
	});
end

function menu.ShowPopup()
	menuBuilder:ShowPopup(function()
		local menuObj = menuBuilder:GetMenu();
		menu.CreateMenu(menuObj);
	end);
end

function menu.CreateMenu(menuObj)
	menuBuilder:CreateTitle(menuObj, addon.Metadata.Title .. " " .. addon.Metadata.Version);

	-- Examples
	menuBuilder:CreateDivider(menuObj);
	menuBuilder:CreateRadio(menuObj, addon.L["ExampleSetting"], KrowiBT_SavedData, {"ExampleSetting"}, "Example 1");
	menuBuilder:CreateCheckbox(menuObj, addon.L["ExampleSetting"], KrowiBT_SavedData, {"ExampleSetting"});

	-- Other menu items can be added here
end
