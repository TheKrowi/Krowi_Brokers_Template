local _, addon = ...;

local tooltip = {};
addon.Tooltip = tooltip;

function tooltip.Init()
	-- Initialize tooltip if needed
end

function tooltip.Show(self)
	GameTooltip:SetOwner(self, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT");
	GameTooltip:AddLine(addon.Metadata.Title .. " " .. addon.Metadata.Version);
	GameTooltip_AddBlankLineToTooltip(GameTooltip);
	
	-- Other lines can be added here
	
	GameTooltip:Show();
end