if not TooltipDataProcessor.AddTooltipPostCall then return end

local UnitIsPlayer = UnitIsPlayer
local UnitHonorLevel = UnitHonorLevel
local UnitFactionGroup = UnitFactionGroup

local _G = _G
local HONOR_LEVEL_TOOLTIP = HONOR_LEVEL_TOOLTIP

local HONOR_LEVEL_LABEL = HONOR_LEVEL_TOOLTIP:gsub(" %%d", ":")

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
	if tooltip:IsForbidden() then return end
    if tooltip ~= GameTooltip then return end

    local _, unit = tooltip:GetUnit()
    
    if unit and UnitIsPlayer(unit) then
		local honorLevel = UnitHonorLevel(unit)
		local _, localizedFaction = UnitFactionGroup(unit)
		if honorLevel <= 0 or not localizedFaction then
            return
		end
        local numLines = tooltip:NumLines()
        for i = 2, numLines do
            local line = _G["GameTooltipTextLeft" .. i]
            if line then
                local lineText = line:GetText()
                if lineText and lineText:find(localizedFaction) then
                    line:SetText("")
                    line:Hide()
                    tooltip:AddDoubleLine(HONOR_LEVEL_LABEL, honorLevel, nil, nil, nil, 1, 1, 1)
                    break
                end
            end
        end
    end
end)